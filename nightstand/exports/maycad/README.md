# Windows / MayCAD 检查文件说明

## 优先打开

- `bed_desk_assembly_closed_350.3mf`：完整床头柜，默认抽屉完全关闭。
- `bed_desk_assembly_closed_350.stl`：完整床头柜 STL 备份。
- `bed_desk_assembly_open_350.3mf`：完整床头柜，抽屉按350mm额定行程完全打开。
- `bed_desk_assembly_open_350.stl`：抽屉完全打开总装 STL 备份。
- `bed_desk_exploded_350.3mf`：整柜主要零件和抽屉五面板爆炸图。
- `bed_desk_exploded_350.stl`：爆炸图 STL 备份。
- `bed_desk_exploded_350.scad`：爆炸图独立 OpenSCAD 源文件，直接打开即可看到爆炸图。

## 抽屉检查

- `bed_desk_drawer_closed_350.stl`：抽屉完全关闭检查。
- `bed_desk_drawer_open_350.stl`：抽屉按 350mm 全拉出滑轨完全打开检查，只包含框架、固定轨和抽屉运动件。

## 顶板检查

- `bed_desk_top_plate_3mm.stl`：3mm 顶部金属板、M5 沉头孔、R1.5 外角和 C0.35 轻微破边。

## 当前关键尺寸

- 外形：400 x 400 x 420mm。
- 顶板：400 x 400 x 3mm。
- 2020 立柱：387mm x 4。
- 2020 横梁：360mm x 12。
- 抽屉滑轨：350mm 可拆内轨三节滑轨。
- 抽屉盒：332mm 宽 x 350mm 深 x 112mm 高。
- 抽屉盒结构：左右侧板 + 内前板 + 背板 + 底板，装饰前脸最后可调固定。
- 上层长虹板/亚克力：左右侧板 368 x 148 x 4mm，后侧板 352 x 148 x 4mm，按入槽尺寸和滑轨避让尺寸下料。
- 滑轨隐藏承载条：400 x 30 x 3mm x2；固定轨锁在承载条上，承载条前后端锁入2020立柱槽。
- 抽屉完全关闭：前脸外表面与前侧铝型材外表面平齐。
- 抽屉关闭后后方余量：约 12mm。
- 抽屉底板：320 x 338 x 6mm，四边进入6mm槽，槽底距抽屉侧板下边8mm。
- 抽屉底部结构余量：约 14mm。

## 注意

这些导出文件用于 Windows 端检查空间、外观和装配干涉。正式下料仍以 `../../床头柜加工清单.md` 和 `../../床头柜建模.scad` 为准。
