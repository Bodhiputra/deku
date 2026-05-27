const BRAND_SLUG = 'finecoustic';
const ACTIVE_SKUS = ['FBS1', 'FBS2'];

let state = { ops: null, shopify: null };

const sum = (arr, fn) => arr.reduce((a, x) => a + fn(x), 0);

function getUnknownQty(ops, sku) {
  const fromUnknown = ops.unknown_stock?.find(u => u.sku === sku)?.qty;
  if (fromUnknown != null) return fromUnknown;
  return ops.inventory_discrepancy?.find(d => d.sku === sku)?.unaccounted || 0;
}

function getManualQty(ops, sku, warehouse) {
  return ops.inventory_manual?.find(i => i.sku === sku && i.warehouse === warehouse)?.qty ?? null;
}

function setManualQty(ops, sku, warehouse, qty) {
  ops.inventory_manual = ops.inventory_manual || [];
  const row = ops.inventory_manual.find(i => i.sku === sku && i.warehouse === warehouse);
  const today = new Date().toISOString().slice(0, 10);
  if (row) {
    row.qty = qty;
    row.as_of = today;
  } else {
    ops.inventory_manual.push({ sku, warehouse, qty, as_of: today, notes: '' });
  }
}

function setUnknownQty(ops, sku, qty) {
  ops.unknown_stock = ops.unknown_stock || [];
  const row = ops.unknown_stock.find(u => u.sku === sku);
  const today = new Date().toISOString().slice(0, 10);
  if (row) {
    row.qty = qty;
    row.as_of = today;
  } else {
    ops.unknown_stock.push({ sku, qty, warehouse: 'dongguan', as_of: today, notes: 'Destination unknown' });
  }
  syncDiscrepancy(ops, sku);
}

function syncDiscrepancy(ops, sku) {
  const m = calcMetrics(ops).metrics[sku];
  ops.inventory_discrepancy = ops.inventory_discrepancy || [];
  let row = ops.inventory_discrepancy.find(d => d.sku === sku);
  if (!row) {
    row = { sku, as_of: new Date().toISOString().slice(0, 10) };
    ops.inventory_discrepancy.push(row);
  }
  row.calculated_remaining = m.calculated;
  row.physical_remaining = m.remaining;
  row.unaccounted = m.unknown;
  row.notes = m.unknown > 0 ? 'Unknown destination — not in B2B or personal records' : '';
}

async function loadData() {
  let ops;
  try {
    const res = await fetch(`/api/brands/${BRAND_SLUG}`);
    if (res.ok) ops = await res.json();
  } catch (_) {}

  if (!ops) {
    const res = await fetch(`brands/${BRAND_SLUG}/ops-data.json`);
    if (!res.ok) throw new Error('Failed to load ops data — run: node ops-hub/server.mjs');
    ops = await res.json();
  }

  let shopify = null;
  try {
    const s = await fetch(`brands/${BRAND_SLUG}/shopify-snapshot.json`);
    if (s.ok) shopify = await s.json();
  } catch (_) {}

  return { ops, shopify };
}

async function saveData(ops) {
  ops.meta = ops.meta || {};
  ops.meta.updated_at = new Date().toISOString();
  const res = await fetch(`/api/brands/${BRAND_SLUG}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(ops),
  });
  if (!res.ok) {
    const err = await res.json().catch(() => ({}));
    throw new Error(err.error || 'Save failed — use node ops-hub/server.mjs');
  }
  return res.json();
}

function calcMetrics(ops) {
  const metrics = {};

  for (const sku of ACTIVE_SKUS) {
    const initial = ops.initial_stock.find(s => s.sku === sku)?.qty || 0;
    const b2b = sum(ops.b2b_allocations.filter(a => a.sku === sku), a => a.qty);
    const internal = sum(ops.internal_use.filter(a => a.sku === sku), a => a.qty);
    const unknown = getUnknownQty(ops, sku);
    const manual = getManualQty(ops, sku, 'dongguan');
    const calculated = initial - b2b - internal;
    const remaining = manual ?? (calculated - unknown);
    metrics[sku] = { initial, b2b, internal, unknown, calculated, manual, remaining };
  }

  return {
    skus: ACTIVE_SKUS,
    metrics,
    b2bTotal: sum(ops.b2b_allocations, a => a.qty),
    partnerCount: ops.b2b_partners.length,
    unknownTotal: sum(ACTIVE_SKUS, sku => metrics[sku].unknown),
  };
}

function shopifyQty(shopify, ops, sku) {
  const sync = shopify?.inventory?.find(i => i.sku === sku)?.available;
  if (sync != null) return sync;
  return getManualQty(ops, sku, 'shopify') ?? '—';
}

function renderAll() {
  const { ops, shopify } = state;
  const metrics = calcMetrics(ops);
  renderKPIs(metrics);
  renderStockLedger(ops, shopify, metrics);
  renderB2BSummary(ops);
  renderInventoryTable(ops, shopify, metrics);
  renderInventoryEditor(ops, metrics);
  renderB2BTable(ops);
  renderProductsTable(ops);
  renderShopifyStatus(shopify, ops, metrics);
  document.getElementById('brand-name').textContent = ops.meta.brand;
  document.getElementById('updated-at').textContent = `Updated ${ops.meta.updated_at?.slice(0, 10) || '—'}`;
}

function renderKPIs(metrics) {
  const fbs1 = metrics.metrics.FBS1;
  const fbs2 = metrics.metrics.FBS2;
  const unknownNote = metrics.unknownTotal > 0
    ? `${metrics.unknownTotal} units unaccounted — review ledger`
    : 'All units accounted for';

  document.getElementById('kpi-grid').innerHTML = `
    <div class="kpi kpi-primary"><label>Dongguan on hand</label><strong>${fbs1.remaining + fbs2.remaining}</strong><span>FBS1 ${fbs1.remaining} · FBS2 ${fbs2.remaining}</span></div>
    <div class="kpi"><label>B2B sold</label><strong>${metrics.b2bTotal}</strong><span>${metrics.partnerCount} distributors · FBS1 ${fbs1.b2b} · FBS2 ${fbs2.b2b}</span></div>
    <div class="kpi"><label>Produced (total)</label><strong>${fbs1.initial + fbs2.initial}</strong><span>FBS1 ${fbs1.initial} · FBS2 ${fbs2.initial}</span></div>
    <div class="kpi ${metrics.unknownTotal > 0 ? 'kpi-alert' : 'kpi-ok'}"><label>Data gap</label><strong>${metrics.unknownTotal}</strong><span>${unknownNote}</span></div>
  `;
}

function renderStockLedger(ops, shopify, metrics) {
  const m = ops.stock_milestones?.[0];
  const milestone = m
    ? `<div class="callout" role="note"><span class="callout-icon" aria-hidden="true">↳</span><span>After wave 1 only, Dongguan held FBS1 ${m.dongguan.FBS1} and FBS2 ${m.dongguan.FBS2} — useful when reconciling wave 2 shipments.</span></div>`
    : '';

  const rows = ACTIVE_SKUS.map(sku => {
    const x = metrics.metrics[sku];
    const shop = shopifyQty(shopify, ops, sku);
    const unknownCell = x.unknown > 0
      ? `<td class="num out gap col-group-out">−${x.unknown}</td>`
      : `<td class="num out col-group-out">—</td>`;
    return `<tr>
      <td><strong>${sku}</strong></td>
      <td class="num">${x.initial}</td>
      <td class="num out col-group-out">−${x.b2b}</td>
      <td class="num out">−${x.internal}</td>
      ${unknownCell}
      <td class="num strong positive">${x.remaining}</td>
      <td class="num">${shop}</td>
    </tr>`;
  }).join('');

  const totals = ACTIVE_SKUS.reduce(
    (t, sku) => {
      const x = metrics.metrics[sku];
      t.initial += x.initial;
      t.b2b += x.b2b;
      t.internal += x.internal;
      t.unknown += x.unknown;
      t.remaining += x.remaining;
      return t;
    },
    { initial: 0, b2b: 0, internal: 0, unknown: 0, remaining: 0 }
  );

  document.getElementById('stock-ledger').innerHTML = `
    ${milestone}
    <div class="table-scroll">
      <table class="data-table">
        <thead>
          <tr>
            <th>SKU</th>
            <th class="num">Produced</th>
            <th class="num col-group-out">B2B</th>
            <th class="num">Personal</th>
            <th class="num col-group-out">Unknown</th>
            <th class="num">Dongguan</th>
            <th class="num">Shopify</th>
          </tr>
        </thead>
        <tbody>${rows}</tbody>
        <tfoot>
          <tr>
            <td>Total</td>
            <td class="num">${totals.initial}</td>
            <td class="num out col-group-out">−${totals.b2b}</td>
            <td class="num out">−${totals.internal}</td>
            <td class="num out col-group-out">${totals.unknown > 0 ? '−' + totals.unknown : '—'}</td>
            <td class="num strong positive">${totals.remaining}</td>
            <td class="num">—</td>
          </tr>
        </tfoot>
      </table>
    </div>`;
}

function renderB2BSummary(ops) {
  const byCountry = {};

  for (const p of ops.b2b_partners) {
    if (!byCountry[p.country]) {
      byCountry[p.country] = { country: p.country, fbs1: 0, fbs2: 0, partners: [] };
    }
    const fbs1 = sum(ops.b2b_allocations.filter(a => a.partner_code === p.code && a.sku === 'FBS1'), a => a.qty);
    const fbs2 = sum(ops.b2b_allocations.filter(a => a.partner_code === p.code && a.sku === 'FBS2'), a => a.qty);
    byCountry[p.country].fbs1 += fbs1;
    byCountry[p.country].fbs2 += fbs2;
    if (fbs1 + fbs2 > 0) byCountry[p.country].partners.push(p.code);
  }

  const rows = Object.values(byCountry)
    .sort((a, b) => b.fbs1 + b.fbs2 - (a.fbs1 + a.fbs2))
    .map(r => `<tr>
      <td>${r.country}</td>
      <td class="num">${r.fbs1}</td>
      <td class="num">${r.fbs2}</td>
      <td class="num strong">${r.fbs1 + r.fbs2}</td>
      <td class="muted-cell">${r.partners.join(', ')}</td>
    </tr>`)
    .join('');

  document.getElementById('b2b-summary').innerHTML = `
    <div class="table-scroll">
      <table class="data-table">
        <thead>
          <tr>
            <th>Country</th>
            <th class="num">FBS1</th>
            <th class="num">FBS2</th>
            <th class="num">Total</th>
            <th>Partners</th>
          </tr>
        </thead>
        <tbody>${rows}</tbody>
      </table>
    </div>
    <p class="editor-hint">Partner-level detail on the B2B tab.</p>`;
}

function renderInventoryTable(ops, shopify, metrics) {
  const rows = ACTIVE_SKUS.map(sku => {
    const m = metrics.metrics[sku];
    const shop = shopifyQty(shopify, ops, sku);
    const gapClass = m.unknown > 0 ? 'gap' : '';
    return `<tr>
      <td><strong>${sku}</strong></td>
      <td class="num strong positive">${m.remaining}</td>
      <td class="num ${gapClass}">${m.unknown || '—'}</td>
      <td class="num">${shop}</td>
    </tr>`;
  }).join('');

  document.getElementById('inventory-table').innerHTML = `
    <div class="table-scroll">
      <table class="data-table">
        <thead><tr><th>SKU</th><th class="num">Dongguan</th><th class="num">Unknown gap</th><th class="num">Shopify</th></tr></thead>
        <tbody>${rows}</tbody>
      </table>
    </div>`;
}

function renderInventoryEditor(ops, metrics) {
  const el = document.getElementById('inventory-editor');
  el.innerHTML = `
    <p class="editor-hint">Update counts here. Ask Koji for B2B order changes.</p>
    <div class="editor-grid">
      ${ACTIVE_SKUS.map(sku => {
        const m = metrics.metrics[sku];
        const shop = getManualQty(ops, sku, 'shopify') ?? 0;
        return `
          <fieldset class="editor-card">
            <legend>${sku}</legend>
            <label>Dongguan on hand<input type="number" min="0" data-field="dongguan" data-sku="${sku}" value="${m.remaining}"></label>
            <label>Unknown (untracked)<input type="number" min="0" data-field="unknown" data-sku="${sku}" value="${m.unknown}"></label>
            <label>Shopify stock<input type="number" min="0" data-field="shopify" data-sku="${sku}" value="${shop}"></label>
          </fieldset>`;
      }).join('')}
    </div>
    <button type="button" class="btn-save" id="btn-save-inventory">Save changes</button>
    <p id="save-status" class="save-status" aria-live="polite"></p>
  `;

  document.getElementById('btn-save-inventory').addEventListener('click', async () => {
    const status = document.getElementById('save-status');
    status.textContent = 'Saving…';
    status.className = 'save-status';

    for (const sku of ACTIVE_SKUS) {
      const dg = el.querySelector(`[data-field="dongguan"][data-sku="${sku}"]`);
      const un = el.querySelector(`[data-field="unknown"][data-sku="${sku}"]`);
      const sh = el.querySelector(`[data-field="shopify"][data-sku="${sku}"]`);
      setManualQty(state.ops, sku, 'dongguan', Number(dg.value));
      setUnknownQty(state.ops, sku, Number(un.value));
      setManualQty(state.ops, sku, 'shopify', Number(sh.value));
    }

    try {
      await saveData(state.ops);
      state.ops = (await loadData()).ops;
      renderAll();
      status.textContent = 'Saved.';
      status.className = 'save-status ok';
    } catch (e) {
      status.textContent = e.message;
      status.className = 'save-status err';
    }
  });
}

function renderB2BTable(ops) {
  const batchLabel = (code) => {
    const b = ops.b2b_allocations.find(a => a.partner_code === code)?.batch;
    if (b === 1) return '<span class="tag tag-wave-1">Wave 1</span>';
    if (b === 2) return '<span class="tag tag-wave-2">Wave 2</span>';
    return '—';
  };
  const rows = ops.b2b_partners
    .map(p => {
      const fbs1 = sum(ops.b2b_allocations.filter(a => a.partner_code === p.code && a.sku === 'FBS1'), a => a.qty);
      const fbs2 = sum(ops.b2b_allocations.filter(a => a.partner_code === p.code && a.sku === 'FBS2'), a => a.qty);
      return { p, fbs1, fbs2, total: fbs1 + fbs2 };
    })
    .sort((a, b) => b.total - a.total)
    .map(({ p, fbs1, fbs2, total }) => `<tr>
      <td><strong>${p.code}</strong></td>
      <td>${p.name}</td>
      <td>${p.country}</td>
      <td>${batchLabel(p.code)}</td>
      <td class="num">${fbs1}</td>
      <td class="num">${fbs2}</td>
      <td class="num strong">${total}</td>
    </tr>`)
    .join('');

  document.getElementById('b2b-table').innerHTML = `
    <div class="table-scroll">
      <table class="data-table">
        <thead><tr><th>Code</th><th>Partner</th><th>Country</th><th>Order</th><th class="num">FBS1</th><th class="num">FBS2</th><th class="num">Total</th></tr></thead>
        <tbody>${rows}</tbody>
      </table>
    </div>`;
}

function renderProductsTable(ops) {
  const active = ops.products.filter(p => p.status === 'active');
  const legacy = ops.products.filter(p => p.status !== 'active');

  const row = p => `
    <tr>
      <td><strong>${p.sku}</strong></td>
      <td>${p.name}</td>
      <td class="num">${p.d2c_price_usd != null ? '$' + p.d2c_price_usd.toFixed(2) : '—'}</td>
    </tr>`;

  document.getElementById('products-table').innerHTML = `
    <h3 class="table-section">Launch products</h3>
    <div class="table-scroll">
      <table class="data-table">
        <thead><tr><th>SKU</th><th>Name</th><th class="num">D2C price</th></tr></thead>
        <tbody>${active.map(row).join('')}</tbody>
      </table>
    </div>
    ${legacy.length ? `
      <h3 class="table-section">Legacy (not in focus)</h3>
      <div class="table-scroll">
        <table class="data-table data-table-muted">
          <thead><tr><th>SKU</th><th>Name</th><th class="num">D2C price</th></tr></thead>
          <tbody>${legacy.map(row).join('')}</tbody>
        </table>
      </div>` : ''}`;
}

function renderShopifyStatus(shopify, ops, metrics) {
  const el = document.getElementById('shopify-status');
  const rows = ACTIVE_SKUS.map(sku => {
    const shop = shopifyQty(shopify, ops, sku);
    return `<tr><td>${sku}</td><td class="num">${shop}</td></tr>`;
  }).join('');

  const syncLine = shopify
    ? `<p class="editor-hint">Last synced: ${shopify.meta.synced_at?.slice(0, 19).replace('T', ' ') || '—'}</p>`
    : `<p class="editor-hint">Not synced — counts from manual entry. Run: <code>node ops-hub/sync/shopify-pull.mjs finecoustic</code></p>`;

  el.innerHTML = `
    ${syncLine}
    <div class="table-scroll">
      <table class="data-table">
        <thead><tr><th>SKU</th><th class="num">Shopify stock</th></tr></thead>
        <tbody>${rows}</tbody>
      </table>
    </div>
    <p class="editor-hint">Edit counts on the Inventory tab, or sync from Shopify Admin.</p>`;
}

function setupTheme() {
  const btn = document.getElementById('theme-toggle');
  const icon = btn.querySelector('.theme-toggle-icon');
  const label = btn.querySelector('.theme-toggle-label');

  function apply(theme) {
    const dark = theme === 'dark';
    if (dark) {
      document.documentElement.setAttribute('data-theme', 'dark');
      icon.textContent = '☾';
      label.textContent = 'Dark';
      btn.setAttribute('aria-label', 'Switch to light mode');
    } else {
      document.documentElement.removeAttribute('data-theme');
      icon.textContent = '☀';
      label.textContent = 'Light';
      btn.setAttribute('aria-label', 'Switch to dark mode');
    }
    localStorage.setItem('ops-hub-theme', dark ? 'dark' : 'light');
  }

  const saved = localStorage.getItem('ops-hub-theme');
  const initial = saved || (matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
  apply(initial);

  btn.addEventListener('click', () => {
    const dark = document.documentElement.getAttribute('data-theme') === 'dark';
    apply(dark ? 'light' : 'dark');
  });
}

function setupNav() {
  const titles = {
    overview: ['Overview', 'Stock, sales, and gaps — numbers you can act on'],
    inventory: ['Inventory', 'Compare warehouses and update counts'],
    b2b: ['B2B Partners', 'Every distributor, wave, and allocation'],
    products: ['Products', 'Launch SKUs and D2C pricing'],
    d2c: ['D2C / Shopify', 'Online store inventory — manual or synced'],
  };

  document.querySelectorAll('.nav').forEach(btn => {
    btn.addEventListener('click', () => {
      const view = btn.dataset.view;
      document.querySelectorAll('.nav').forEach(b => {
        b.classList.remove('active');
        b.removeAttribute('aria-current');
      });
      document.querySelectorAll('.view').forEach(v => v.classList.remove('active'));
      btn.classList.add('active');
      btn.setAttribute('aria-current', 'page');
      document.getElementById(`view-${view}`).classList.add('active');
      const [t, s] = titles[view];
      document.getElementById('view-title').textContent = t;
      document.getElementById('view-subtitle').textContent = s;
    });
  });
}

async function main() {
  setupTheme();
  setupNav();
  try {
    const data = await loadData();
    state = data;
    renderAll();
  } catch (e) {
    document.querySelector('.main').innerHTML = `<div class="empty-state">
      Could not load ops data.<br><br>
      <code>node ops-hub/server.mjs</code><br><br>${e.message}
    </div>`;
  }
}

main();
