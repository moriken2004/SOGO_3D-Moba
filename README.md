# 立体4目並べ Sogo 3D · 4×4×4

3D Connect Four (4×4×4) with two themes: 通常 (wood + brass) and 人工藻場 (artificial-reef cages on a kelp seabed). Single self-contained HTML + small asset folder.

## Run

The page uses `fetch()` and an ES-module importmap, so it must be served over HTTP, not opened with `file://`.

From this folder, with Python 3:

```sh
python3 -m http.server 8000
```

Then open <http://127.0.0.1:8000/sogo3d.html> in any modern browser (tested on Safari).

The Three.js library is loaded from the unpkg CDN — no install step.

## Folder layout

```
sogo3d.html              the entire game (≈ 3000 lines, vanilla JS + Three.js)
assets/
  UUV.stl                patrol drone mesh
  concrete_*.jpg         PBR maps for the cage rubble + board base (Poly Haven, CC0)
  rock_06_*.jpg          PBR maps for the seabed rocks (Poly Haven, CC0)
  sand_*.jpg             PBR maps for the seabed (Poly Haven, CC0)
  iso_panel.png          tide-pool / kelp panel backdrop for the seaweed title screen
  crab_full.png          hermit crab photo cut-out (out)
  crab_tuck.png          hermit crab photo cut-out (withdrawn into shell)
  fish/fish_1..5.png     5 lateral fish photo cut-outs
                         (1: メバル, 2: アジ, 3: クロダイ, 4: タカベ, 5: イトヨリダイ)
```

All asset paths in `sogo3d.html` are relative (`assets/…`), so renaming the parent folder is safe as long as `assets/` stays next to `sogo3d.html`.

## Credits

- Concrete / rock / sand PBR maps: [Poly Haven](https://polyhaven.com/) (CC0)
- Hermit crab and fish photo cut-outs: user-supplied, processed locally with
  [rembg](https://github.com/danielgatis/rembg) (ISNet-General-Use matting).
- 3D rendering: [Three.js 0.160.0](https://threejs.org/) via the unpkg CDN.
