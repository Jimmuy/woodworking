# Woodworking

Personal woodworking and small fabrication project archive.

This repository is used to keep project reference photos, design notes, CAD/OpenSCAD models, fabrication checklists, exported review files, and assembly planning documents.

## Projects

### `nightstand/`

Aluminum-profile nightstand / bedside cabinet project.

Contents:

- `床头柜建模.scad` - OpenSCAD parametric machining and assembly model.
- `床头柜加工清单.md` - fabrication dimensions, hardware BOM, original-list comparison, and assembly feasibility review.
- `Nightstand1.jpg` - `Nightstand5.jpg` - redacted reference photos used for visual and construction details.
- `exports/maycad/` - Windows / MayCAD review exports and notes.
- `exports/maycad/bed_desk_assembly_closed_350.3mf` - preferred complete assembly review file.
- `exports/maycad/bed_desk_assembly_closed_350.stl` - complete assembly STL backup.
- `exports/maycad/bed_desk_drawer_closed_350.stl` - drawer fully-closed state check.
- `exports/maycad/bed_desk_drawer_open_350.stl` - drawer fully-open state check.
- `exports/maycad/bed_desk_top_plate_3mm.stl` - top metal plate check.
- `exports/maycad/README.md` - export-file usage notes.

Current nightstand design baseline:

- Overall size: 400 x 400 x 420 mm.
- Frame: 2020 aluminum extrusion.
- Top plate: 400 x 400 x 3 mm, M5 countersunk holes.
- Drawer slides: 350 mm detachable-inner-rail three-section slides.
- Drawer box: 326 mm wide x 350 mm deep x 112 mm high.

## Conventions

- Keep one project per top-level folder.
- Put reusable models, cut lists, reference photos, and export files under that project folder.
- Redact personal IDs, account names, or watermarks from reference photos before committing.
- Treat generated exports as review/check files; fabrication dimensions should be verified against the source model and project BOM.
