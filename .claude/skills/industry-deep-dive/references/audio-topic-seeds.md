# Audio Product Topic Seeds

Optional starting points when the owner asks *"what should Senku learn about?"* — not a mandatory checklist.

## Product types (`products/`)

- Portable Bluetooth speakers (mono, stereo pair, party mode)
- True wireless earbuds (TWS) — stem, stemless, open-ear
- Over-ear / on-ear wireless headphones
- On-ear clip / pin / C-shaped open-ear
- Bone conduction / air conduction open-ear
- Smart audio glasses / frames with speakers
- Desktop / computer speakers (active, passive)
- Bookshelf / monitor speakers
- Soundbars and TV audio
- Smart speakers (voice assistant integrated)
- Portable DACs / headphone amps
- USB-C / Lightning audio adapters
- Unique industrial shapes (Marshall-style, cylindrical, triangular, wearable)

## Components & materials (`topics/`)

### Drivers
- Dynamic (moving coil) — sizes, materials (paper, metal, composite)
- Balanced armature (BA) — multi-BA arrays
- Planar magnetic / electrostatic (where relevant to category)
- Passive radiators vs ported enclosures vs sealed
- Full-range vs multi-driver crossover (speakers, soundbars)

### Chipsets & electronics
- Bluetooth SoCs: Qualcomm (QCC series), BES, Actions, Airoha, Realtek, JL
- Codec support: SBC, AAC, aptX (Classic/HD/Lossless), LDAC, LC3 (LE Audio)
- DSP and EQ tuning in consumer products
- Amplifier topology (Class D in portable)
- Battery management, USB-C PD, wireless charging coils
- Microphone arrays, beamforming, ENC/cVC noise cancellation

### Materials & construction
- Enclosure plastics (ABS, PC, TPU), metal grills, fabric wraps
- IP rating construction (gaskets, mesh, membrane)
- Magnet types (neodymium grades)
- Cable / connector standards (USB-C, 3.5mm TRRS)

### Acoustic & specs literacy
- Frequency response — what the curve means vs marketing
- Sensitivity (dB SPL/mW or /V), impedance (Ω)
- THD, SNR, latency (gaming/TWS)
- Battery capacity (mAh/Wh) vs claimed runtime — test conditions matter
- Bluetooth range and version tradeoffs
- Mono vs stereo pairing, multipoint, TWS master/slave

## Brand overlay (`brand-overlay.md` + `products/`)

- Map each SKU to category terms (e.g. FBS → portable BT speaker)
- Factory doc fields: driver size, battery, IP, chipset, BOM highlights
- Internal codenames vs consumer names

Build only what the brand actually needs.
