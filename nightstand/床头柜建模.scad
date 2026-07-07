// ==============================================================================
// 2020铝型材床头柜 - 加工装配模型
// 单位：mm
//
// 目标：
// 1. 作为加工沟通模型，而不是单纯外观示意；
// 2. 明确型材下料、板件尺寸、孔位、滑轨、光轴座、调节脚和主要五金位置；
// 3. 所有关键尺寸都集中在参数区，方便按实际采购件微调。
//
// 注意：
// display_gap 只用于避免 OpenSCAD 导出 STL 时多个零件共面导致布尔歧义。
// 采购/加工尺寸以 *_cut_len、板件尺寸和本文件 echo 输出为准。
// ==============================================================================

$fn = 48;
eps = 0.02;
display_gap = 0.15;
explode_gap = 70;

// --- 总体尺寸 ---
cabinet_width  = 400;
cabinet_depth  = 400;
cabinet_height = 420;

// --- 型材与板材 ---
profile_size       = 20;   // 2020铝型材
profile_corner_r   = 1.5;  // 2020型材外角小圆角；用于让顶板外角匹配型材视觉
top_plate_thk      = 3;    // 顶部金属板；3mm更适合做M5沉头并保持板面平齐
top_plate_corner_r = profile_corner_r; // 顶板外角与型材外角一致，避免露出下方型材角
top_plate_edge_chamfer = 0.35; // 顶板只做轻微破边，不做过大的四周倒角
shelf_thk          = 18;   // 底层置物板
shelf_support_w    = 38;   // 底板槽内式承托片托面宽度
shelf_support_d    = 18;
shelf_support_thk  = 3;
shelf_support_lug_h= 8;
glass_thk          = 4;    // 长虹玻璃/亚克力
glass_slot_embed   = 5;    // 每边进入2020槽/U型胶条的有效深度
glass_install_clearance = 1; // 每边安装余量，避免板件过紧无法滑入
foot_height        = 30;

// --- 抽屉与滑轨 ---
drawer_front_w     = 356;
drawer_front_h     = 134;
drawer_front_thk   = 18;
drawer_box_h       = 112;
drawer_body_thk    = 12;
drawer_bottom_thk  = 6;
drawer_bottom_groove_depth = 6; // 底板四边进入抽屉盒板槽的深度
drawer_bottom_groove_lift  = 8; // 底板槽底距抽屉侧板下边，给滑轨螺丝和底边留肉
slide_len          = 350;
slide_travel       = slide_len; // 三节全拉出滑轨，按额定长度≈额定行程建模
drawer_box_depth   = slide_len; // 抽屉盒深度匹配滑轨长度，避免320盒体配300滑轨的非标悬伸
slide_h            = 35;
slide_thk          = 12;
slide_carrier_thk  = 3;    // 隐藏式金属承载条，固定在2020槽内，滑轨不打在亚克力上
slide_carrier_h    = 30;
slide_carrier_len  = 400;  // 一体式隐藏承载条；移到侧面型材槽位后不再与抽屉前脸/后板干涉
slide_mount_gap    = 0.5;
drawer_side_working_clearance = 2; // 每侧装配/调节余量；保证抽屉能从正面合轨推入
slide_bottom_clearance = 2; // 参考图为低位侧装，贴近抽屉盒底边
drawer_open_ratio  = 0; // 默认整柜为闭合状态；需要开启预览时改为0.35-1
render_target      = "assembly";
// 可选导出目标：
// "assembly"       整体装配预览
// "frame"          铝型材框架，接口按内置/盲连处理，不显示外露螺丝
// "top_plate"      顶部金属板、倒角外轮廓、预留沉头孔和平齐银色沉头螺丝
// "glass_panels"   三块长虹板/亚克力及嵌条
// "shelf"          底层嵌入式置物板和装配缝
// "guard_rails"    下层四面光轴护栏
// "drawer"         抽屉盒、前脸、拉手和活动滑轨
// "fixed_slides"   隐藏承载条和固定在承载条上的滑轨
// "drawer_install" 抽屉安装预览：框架+固定轨，抽屉带活动内轨从正面推入
// "drawer_closed"  抽屉完全关闭检查：前脸外表面与前侧铝型材外表面平齐
// "drawer_open"    抽屉完全打开检查：按滑轨额定全拉出行程
// "assembly_open"  完整床头柜，抽屉按350mm额定行程完全打开
// "exploded"       整柜主要零件和抽屉五面板爆炸图
// "feet"           四个调节脚

// --- 五金参数 ---
rod_d              = 8;
rail_support_w     = 18;
rail_support_h     = 18;
rail_support_d     = 12;
rod_support_inset  = 13.5;
handle_spacing     = 96;
handle_width       = 128;
handle_rod_d       = 8;
handle_standoff    = 28;
drawer_front_fix_x = 112;  // 抽屉前脸内侧4点可调固定，先调缝再锁紧
drawer_front_fix_z = 34;
drawer_front_fix_head_d = 9;
drawer_front_slot_w = 5;
drawer_front_slot_h = 14;
top_hole_d         = 5.5;  // 当前按M5沉头螺钉预留；若改M6需同步孔径
top_csk_d          = 10.5;
top_csk_depth      = 2.5;  // M5 90度沉头按约2.5mm深度建模，适配3mm板
top_socket_d       = 3.2;
glass_rib_step     = 7;
glass_rib_w        = 0.55;
glass_rib_depth    = 0.7;

// --- 派生尺寸 ---
post_x = cabinet_width/2 - profile_size/2;
post_y = cabinet_depth/2 - profile_size/2;

top_plate_z0     = cabinet_height - top_plate_thk;
frame_bottom_z   = foot_height;
pillar_cut_len   = top_plate_z0 - frame_bottom_z;
beam_x_cut_len   = cabinet_width - 2*profile_size;
beam_y_cut_len   = cabinet_depth - 2*profile_size;
drawer_box_w     = beam_x_cut_len - 2*(slide_thk + drawer_side_working_clearance);

top_beam_z       = top_plate_z0 - profile_size/2;
drawer_bay_h     = 140;
middle_beam_z    = top_beam_z - profile_size - drawer_bay_h;
bottom_beam_z    = frame_bottom_z + profile_size/2;

upper_open_top_z    = top_beam_z - profile_size/2;
upper_open_bottom_z = middle_beam_z + profile_size/2;
upper_open_h        = upper_open_top_z - upper_open_bottom_z;

glass_side_panel_len = beam_y_cut_len + 2*(glass_slot_embed - glass_install_clearance);
glass_back_panel_len = beam_x_cut_len - 8;
glass_panel_h     = upper_open_h + 2*(glass_slot_embed - glass_install_clearance);
glass_z           = (upper_open_top_z + upper_open_bottom_z) / 2;
glass_side_x      = post_x;
glass_back_y      = post_y - profile_size/2 - glass_thk/2 - 0.5;

shelf_size        = beam_x_cut_len - 4;
shelf_top_z       = bottom_beam_z + profile_size/2 - display_gap;
shelf_z           = shelf_top_z - shelf_thk/2;
shelf_bottom_z    = shelf_z - shelf_thk/2;
guard_rail_z      = shelf_top_z + 28;
guard_side_x      = post_x - profile_size/2 - rod_d/2 - display_gap;
guard_front_y     = -(post_y - profile_size/2 - rod_d/2 - display_gap);
guard_back_y      =  (post_y - profile_size/2 - rod_d/2 - display_gap);

drawer_z                = glass_z;
front_profile_outer_y   = -cabinet_depth/2;
drawer_rear_inner_limit_y = post_y - profile_size/2;
drawer_front_flush_inset= 0; // 0=抽屉前脸外表面与前侧铝型材外表面平齐
drawer_front_y_closed   = front_profile_outer_y + drawer_front_flush_inset + drawer_front_thk/2;
drawer_box_y_closed     = drawer_front_y_closed + drawer_front_thk/2 + drawer_box_depth/2;
drawer_inner_front_y     = drawer_box_y_closed - drawer_box_depth/2 + drawer_body_thk/2;
drawer_open_y           = -slide_travel * drawer_open_ratio;
drawer_full_open_y      = -slide_travel;
slide_center_y_closed   = -cabinet_depth/2 + profile_size + slide_len/2;
slide_carrier_x         = post_x - profile_size/2 + slide_carrier_thk/2;
slide_carrier_center_y  = 0;
slide_fixed_x           = slide_carrier_x - slide_carrier_thk/2 - slide_mount_gap - slide_thk/2;
drawer_box_bottom_z     = drawer_z - drawer_box_h/2;
slide_moving_y_closed   = slide_center_y_closed;
slide_z                 = drawer_box_bottom_z + slide_h/2 + slide_bottom_clearance;
drawer_front_outer_y_closed = drawer_front_y_closed - drawer_front_thk/2;
drawer_back_y_closed    = drawer_box_y_closed + drawer_box_depth/2;
drawer_back_clearance_closed = drawer_rear_inner_limit_y - drawer_back_y_closed;
drawer_bottom_clearance = drawer_box_bottom_z - upper_open_bottom_z;
drawer_inner_panel_w    = drawer_box_w - 2*drawer_body_thk;
drawer_bottom_w         = drawer_inner_panel_w + 2*drawer_bottom_groove_depth;
drawer_bottom_depth     = drawer_box_depth - 2*drawer_body_thk + 2*drawer_bottom_groove_depth;
drawer_bottom_z         = drawer_box_bottom_z + drawer_bottom_groove_lift + drawer_bottom_thk/2;

echo(str("CUT 2020 vertical posts: ", pillar_cut_len, "mm x 4"));
echo(str("CUT 2020 horizontal beams X/Y: ", beam_x_cut_len, "mm x 12"));
echo(str("CUT stainless/aluminum top plate: ", cabinet_width, " x ", cabinet_depth, " x ", top_plate_thk, "mm, R", top_plate_corner_r, " corners, C", top_plate_edge_chamfer, " light edge break, M5 countersunk holes at +/-", post_x, "mm"));
echo(str("CUT bottom shelf: ", shelf_size, " x ", shelf_size, " x ", shelf_thk, "mm x 1, inset flush with lower 2020 frame top"));
echo(str("CUT side glass/acrylic: ", glass_side_panel_len, " x ", glass_panel_h, " x ", glass_thk, "mm x 2"));
echo(str("CUT back glass/acrylic: ", glass_back_panel_len, " x ", glass_panel_h, " x ", glass_thk, "mm x 1"));
echo(str("CUT drawer front: ", drawer_front_w, " x ", drawer_front_h, " x ", drawer_front_thk, "mm x 1"));
echo(str("CUT drawer sides: ", drawer_box_depth, " x ", drawer_box_h, " x ", drawer_body_thk, "mm x 2"));
echo(str("CUT drawer inner front: ", drawer_inner_panel_w, " x ", drawer_box_h, " x ", drawer_body_thk, "mm x 1, slotted holes for adjustable decorative front"));
echo(str("CUT drawer back: ", drawer_inner_panel_w, " x ", drawer_box_h, " x ", drawer_body_thk, "mm x 1"));
echo(str("CUT drawer bottom: ", drawer_bottom_w, " x ", drawer_bottom_depth, " x ", drawer_bottom_thk, "mm x 1, four edges enter ", drawer_bottom_groove_depth, "mm grooves"));
echo(str("CUT slide carrier bars: ", slide_carrier_len, " x ", slide_carrier_h, " x ", slide_carrier_thk, "mm x 2, M5 end holes and M4 tapped slide holes"));
echo(str("CHECK drawer closed: front face Y=", drawer_front_outer_y_closed, "mm, front profile outer Y=", front_profile_outer_y, "mm"));
echo(str("CHECK drawer rear clearance closed: ", drawer_back_clearance_closed, "mm"));
echo(str("CHECK drawer bottom clearance above opening lower profile: ", drawer_bottom_clearance, "mm"));
echo(str("CHECK drawer full open travel: ", slide_travel, "mm, drawer box depth: ", drawer_box_depth, "mm"));

// --- 颜色 ---
color_profile  = [0.72, 0.72, 0.68];
color_slot     = [0.18, 0.18, 0.18];
color_wood     = [0.78, 0.56, 0.32];
color_wood_dark= [0.52, 0.30, 0.14];
color_metal    = [0.78, 0.78, 0.76];
color_screw_silver = [0.86, 0.86, 0.82];
color_socket   = [0.06, 0.06, 0.06];
color_hardware = [0.02, 0.02, 0.02];
color_glass    = [0.78, 0.80, 0.76, 0.28];
color_glass_rib= [0.95, 0.95, 0.90, 0.38];

// ==============================================================================
// 基础几何
// ==============================================================================

module cyl_x(length, d) {
    rotate([0, 90, 0]) cylinder(h=length, d=d, center=true);
}

module cyl_y(length, d) {
    rotate([90, 0, 0]) cylinder(h=length, d=d, center=true);
}

module profile_core(length) {
    linear_extrude(height=length - 2*display_gap, center=true, convexity=8)
    difference() {
        rounded_rect_2d(profile_size, profile_size, profile_corner_r);
        circle(d=5.2);
        // 浅槽用于标识2020槽位，不用贯穿槽，避免把型材分裂成多个实体。
        translate([0,  profile_size/2 - 1.2]) square([6.2, 2.4], center=true);
        translate([0, -profile_size/2 + 1.2]) square([6.2, 2.4], center=true);
        translate([ profile_size/2 - 1.2, 0]) square([2.4, 6.2], center=true);
        translate([-profile_size/2 + 1.2, 0]) square([2.4, 6.2], center=true);
    }
}

module rounded_rect_2d(w, d, r) {
    offset(r=r)
        square([w - 2*r, d - 2*r], center=true);
}

module chamfered_top_plate_blank() {
    hull() {
        translate([0, 0, -top_plate_thk/2 + eps/2])
            linear_extrude(height=eps, center=true, convexity=8)
                rounded_rect_2d(cabinet_width, cabinet_depth, top_plate_corner_r);
        translate([0, 0, top_plate_thk/2 - eps/2])
            linear_extrude(height=eps, center=true, convexity=8)
                rounded_rect_2d(
                    cabinet_width - 2*top_plate_edge_chamfer,
                    cabinet_depth - 2*top_plate_edge_chamfer,
                    top_plate_corner_r - top_plate_edge_chamfer
                );
    }
}

module alu_profile(length, axis="Z") {
    color(color_profile)
    if (axis == "X") {
        rotate([0, 90, 0]) profile_core(length);
    } else if (axis == "Y") {
        rotate([90, 0, 0]) profile_core(length);
    } else {
        profile_core(length);
    }
}

module countersunk_top_plate() {
    color(color_metal)
    translate([0, 0, top_plate_z0 + top_plate_thk/2])
    difference() {
        chamfered_top_plate_blank();
        for (x = [-post_x, post_x]) {
            for (y = [-post_y, post_y]) {
                translate([x, y, 0])
                    cylinder(h=top_plate_thk + 2*eps, d=top_hole_d, center=true);
                translate([x, y, top_plate_thk/2 - top_csk_depth])
                    cylinder(h=top_csk_depth + eps, d1=top_hole_d, d2=top_csk_d, center=false);
            }
        }
    }

    for (x = [-post_x, post_x]) {
        for (y = [-post_y, post_y]) {
            color(color_screw_silver)
            translate([x, y, top_plate_z0 + top_plate_thk - top_csk_depth])
                cylinder(h=top_csk_depth, d1=top_hole_d*0.9, d2=top_csk_d*0.95, center=false);
            color(color_socket)
            translate([x, y, top_plate_z0 + top_plate_thk + 0.01])
                cylinder(h=0.04, d=top_socket_d, center=true, $fn=6);
        }
    }
}

// ==============================================================================
// 框架、板件、固定件
// ==============================================================================

module frame_profiles() {
    for (x = [-post_x, post_x]) {
        for (y = [-post_y, post_y]) {
            translate([x, y, frame_bottom_z + pillar_cut_len/2])
                alu_profile(pillar_cut_len, "Z");
        }
    }

    for (z = [bottom_beam_z, middle_beam_z, top_beam_z]) {
        for (y = [-post_y, post_y]) {
            translate([0, y, z])
                alu_profile(beam_x_cut_len, "X");
        }
        for (x = [-post_x, post_x]) {
            translate([x, 0, z])
                alu_profile(beam_y_cut_len, "Y");
        }
    }
}

module frame_profiles_exploded() {
    for (x = [-post_x, post_x]) {
        for (y = [-post_y, post_y]) {
            translate([x + sign(x)*22, y + sign(y)*22, frame_bottom_z + pillar_cut_len/2])
                alu_profile(pillar_cut_len, "Z");
        }
    }

    z_offsets = [-36, 0, 36];
    for (i = [0:2]) {
        z = [bottom_beam_z, middle_beam_z, top_beam_z][i];
        zoff = z_offsets[i];
        for (y = [-post_y, post_y]) {
            translate([0, y + sign(y)*34, z + zoff])
                alu_profile(beam_x_cut_len, "X");
        }
        for (x = [-post_x, post_x]) {
            translate([x + sign(x)*34, 0, z + zoff])
                alu_profile(beam_y_cut_len, "Y");
        }
    }
}

module ribbed_glass_panel(length, height, axis="Y", face_sign=1) {
    color(color_glass) {
        if (axis == "Y") {
            cube([glass_thk, length, height], center=true);
        } else {
            cube([length, glass_thk, height], center=true);
        }
    }

    color(color_glass_rib) {
        if (axis == "Y") {
            for (p = [-length/2 + glass_rib_step : glass_rib_step : length/2 - glass_rib_step]) {
                translate([face_sign * (glass_thk/2 + glass_rib_depth/2 + display_gap), p, 0])
                    cube([glass_rib_depth, glass_rib_w, height - 4], center=true);
            }
        } else {
            for (p = [-length/2 + glass_rib_step : glass_rib_step : length/2 - glass_rib_step]) {
                translate([p, face_sign * (glass_thk/2 + glass_rib_depth/2 + display_gap), 0])
                    cube([glass_rib_w, glass_rib_depth, height - 4], center=true);
            }
        }
    }
}

module glass_panel_edges(length, height, axis="Y") {
    // 真实装配里板边由型材槽/U型胶条/压片收住，模型只显示被遮住的压边。
    color(color_profile) {
        if (axis == "Y") {
            translate([0, 0,  height/2 + 1.5 + display_gap]) cube([5, length, 3], center=true);
            translate([0, 0, -height/2 - 1.5 - display_gap]) cube([5, length, 3], center=true);
            translate([0,  length/2 + 1.5 + display_gap, 0]) cube([5, 3, height], center=true);
            translate([0, -length/2 - 1.5 - display_gap, 0]) cube([5, 3, height], center=true);
        } else {
            translate([0, 0,  height/2 + 1.5 + display_gap]) cube([length, 5, 3], center=true);
            translate([0, 0, -height/2 - 1.5 - display_gap]) cube([length, 5, 3], center=true);
            translate([ length/2 + 1.5 + display_gap, 0, 0]) cube([3, 5, height], center=true);
            translate([-length/2 - 1.5 - display_gap, 0, 0]) cube([3, 5, height], center=true);
        }
    }
}

module upper_glass_panels() {
    translate([-glass_side_x, 0, glass_z]) {
        ribbed_glass_panel(glass_side_panel_len, glass_panel_h, "Y", -1);
        glass_panel_edges(glass_side_panel_len, glass_panel_h, "Y");
    }
    translate([ glass_side_x, 0, glass_z]) {
        ribbed_glass_panel(glass_side_panel_len, glass_panel_h, "Y", 1);
        glass_panel_edges(glass_side_panel_len, glass_panel_h, "Y");
    }
    translate([0, glass_back_y, glass_z]) {
        ribbed_glass_panel(glass_back_panel_len, glass_panel_h, "X", 1);
        glass_panel_edges(glass_back_panel_len, glass_panel_h, "X");
    }
}

module upper_glass_panels_exploded() {
    translate([-glass_side_x - explode_gap, 0, glass_z]) {
        ribbed_glass_panel(glass_side_panel_len, glass_panel_h, "Y", -1);
        glass_panel_edges(glass_side_panel_len, glass_panel_h, "Y");
    }
    translate([ glass_side_x + explode_gap, 0, glass_z]) {
        ribbed_glass_panel(glass_side_panel_len, glass_panel_h, "Y", 1);
        glass_panel_edges(glass_side_panel_len, glass_panel_h, "Y");
    }
    translate([0, glass_back_y + explode_gap, glass_z]) {
        ribbed_glass_panel(glass_back_panel_len, glass_panel_h, "X", 1);
        glass_panel_edges(glass_back_panel_len, glass_panel_h, "X");
    }
}

module bottom_shelf() {
    color(color_wood)
    translate([0, 0, shelf_z])
        cube([shelf_size, shelf_size, shelf_thk], center=true);

    // 底板嵌入底层2020内框，顶面与型材上表面齐平；黑色细线表示装配缝。
    color(color_slot) {
        translate([0, -shelf_size/2 - 0.6, shelf_top_z + 0.03])
            cube([shelf_size, 0.8, 0.06], center=true);
        translate([0, shelf_size/2 + 0.6, shelf_top_z + 0.03])
            cube([shelf_size, 0.8, 0.06], center=true);
        translate([-shelf_size/2 - 0.6, 0, shelf_top_z + 0.03])
            cube([0.8, shelf_size, 0.06], center=true);
        translate([shelf_size/2 + 0.6, 0, shelf_top_z + 0.03])
            cube([0.8, shelf_size, 0.06], center=true);
    }

    // 四处2020槽内式底部托片：承重托片嵌在型材槽里，水平托住木板下表面。
    for (x = [-shelf_size/4, shelf_size/4]) {
        shelf_support_tab(x, -1);
        shelf_support_tab(x, 1);
    }
}

module shelf_support_tab(x, y_sign) {
    tab_y = y_sign * (shelf_size/2 - shelf_support_d/2 - 6);
    lug_y = y_sign * (shelf_size/2 + 2.2);
    tab_z = shelf_bottom_z - shelf_support_thk/2 - display_gap;
    lug_z = shelf_bottom_z + shelf_support_lug_h/2 - display_gap;

    color(color_metal)
    union() {
        translate([x, tab_y, tab_z])
            cube([shelf_support_w, shelf_support_d, shelf_support_thk], center=true);
        translate([x, lug_y, lug_z])
            cube([shelf_support_w, 3, shelf_support_lug_h], center=true);
    }

    color(color_socket)
    translate([x, tab_y, tab_z + shelf_support_thk/2 + 0.03])
        cylinder(h=0.08, d=5, center=true);
}

// ==============================================================================
// 光轴护栏
// ==============================================================================

module slot_rod_connector(axis="X", end_sign=1) {
    color(color_metal)
    if (axis == "X") {
        union() {
            difference() {
                cube([rail_support_w, rail_support_d, rail_support_h], center=true);
                cyl_x(rail_support_d + 2*eps, rod_d + 0.5);
            }
            translate([end_sign * 8, 0, 0])
                cube([4, 11, 11], center=true);
            translate([end_sign * 11.5, 0, 0])
                cube([3, 14, 6], center=true);
        }
    } else {
        union() {
            difference() {
                cube([rail_support_d, rail_support_w, rail_support_h], center=true);
                cyl_y(rail_support_d + 2*eps, rod_d + 0.5);
            }
            translate([0, end_sign * 8, 0])
                cube([11, 4, 11], center=true);
            translate([0, end_sign * 11.5, 0])
                cube([14, 3, 6], center=true);
        }
    }

    color(color_socket)
    if (axis == "X") {
        translate([0, -rail_support_d/2 - 0.02, 0])
            rotate([90, 0, 0])
            cylinder(h=0.08, d=4, center=true);
    } else {
        translate([-rail_support_d/2 - 0.02, 0, 0])
            rotate([0, 90, 0])
            cylinder(h=0.08, d=4, center=true);
    }
}

module shaft_support(axis="X", end_sign=1) {
    // 2020槽内式通用8mm圆杆夹：外侧是圆杆夹，背面带T槽舌片/滑块。
    slot_rod_connector(axis, end_sign);
}

module rod_with_supports_x(y, z) {
    color(color_metal)
    translate([0, y, z])
        cyl_x(beam_x_cut_len, rod_d);

    translate([-beam_x_cut_len/2 + rod_support_inset, y, z]) shaft_support("X", -1);
    translate([ beam_x_cut_len/2 - rod_support_inset, y, z]) shaft_support("X", 1);
}

module rod_with_supports_y(x, z) {
    color(color_metal)
    translate([x, 0, z])
        cyl_y(beam_y_cut_len, rod_d);

    translate([x, -beam_y_cut_len/2 + rod_support_inset, z]) shaft_support("Y", -1);
    translate([x,  beam_y_cut_len/2 - rod_support_inset, z]) shaft_support("Y", 1);
}

module lower_guard_rails() {
    rod_with_supports_y(-guard_side_x, guard_rail_z);
    rod_with_supports_y( guard_side_x, guard_rail_z);
    rod_with_supports_x( guard_back_y, guard_rail_z);
    rod_with_supports_x( guard_front_y, guard_rail_z);
}

// ==============================================================================
// 调节脚
// ==============================================================================

module adjustable_foot() {
    color(color_hardware)
    translate([0, 0, 4])
        cylinder(h=8, d=28, center=true);
    color(color_metal)
    translate([0, 0, 19])
        cylinder(h=22, d=6, center=true);
    color(color_metal)
    translate([0, 0, 29])
        cylinder(h=4, d=16, center=true);
}

module feet() {
    for (x = [-post_x, post_x]) {
        for (y = [-post_y, post_y]) {
            translate([x, y, 0]) adjustable_foot();
        }
    }
}

// ==============================================================================
// 抽屉与滑轨
// ==============================================================================

module slide_rail(sign=1, moving=false) {
    rail_color = moving ? [0.10, 0.10, 0.10] : [0.18, 0.18, 0.18];
    mount_face_sign = moving ? sign : -sign; // 固定轨螺丝头朝柜内，活动内轨先在抽屉外侧装好
    color(rail_color)
    cube([slide_thk, slide_len, slide_h], center=true);

    color(color_metal)
    translate([mount_face_sign * (slide_thk/2 + 0.4), 0, 0])
        cube([1.2, slide_len - 16, 5], center=true);

    color(color_hardware)
    for (yoff = [-120, -45, 45, 120]) {
        translate([mount_face_sign * (slide_thk/2 + 0.9), yoff, 0])
        rotate([0, 90, 0])
            cylinder(h=1.2, d=5, center=true);
    }

    if (moving) {
        color([0.75, 0.75, 0.58])
        translate([mount_face_sign * (slide_thk/2 + 1.0), -slide_len/2 + 34, slide_h/2 - 7])
            cube([1.2, 18, 5], center=true);
    }
}

module slide_carrier_bar(sign=1) {
    // 隐藏承载条：先用T型滑块/M5固定到2020槽，滑轨固定轨再从抽屉口方向锁到承载条上。
    color(color_metal)
    cube([slide_carrier_thk, slide_carrier_len, slide_carrier_h], center=true);

    // 两端用M5锁入前后立柱T槽；竖向双孔便于微调后锁紧。
    color(color_socket)
    for (yoff = [-190, 190]) {
        for (zoff = [-8, 8]) {
            translate([-sign * (slide_carrier_thk/2 + 0.03), yoff, zoff])
            rotate([0, 90, 0])
                cylinder(h=0.08, d=5.5, center=true);
        }
    }

    // 中段孔位用于固定滑轨外轨，螺丝从抽屉口方向操作。
    color(color_socket)
    for (yoff = [-120, -45, 45, 120]) {
        translate([-sign * (slide_carrier_thk/2 + 0.03), yoff + slide_center_y_closed - slide_carrier_center_y, 0])
        rotate([0, 90, 0])
            cylinder(h=0.08, d=4.5, center=true);
    }
}

module fixed_slides() {
    for (sign = [-1, 1]) {
        translate([sign*slide_carrier_x, slide_carrier_center_y, slide_z])
            slide_carrier_bar(sign);
        translate([sign*slide_fixed_x, slide_center_y_closed, slide_z])
            slide_rail(sign, false);
    }
}

module fixed_slides_exploded() {
    for (side = [-1, 1]) {
        translate([side*(slide_carrier_x + 34), slide_carrier_center_y, slide_z])
            slide_carrier_bar(side);
        translate([side*(slide_fixed_x + 18), slide_center_y_closed, slide_z])
            slide_rail(side, false);
    }
}

module drawer_front_panel() {
    color(color_wood)
    difference() {
        cube([drawer_front_w, drawer_front_thk, drawer_front_h], center=true);
        for (x = [-handle_spacing/2, handle_spacing/2]) {
            translate([x, 0, 0])
                cyl_y(drawer_front_thk + 2*eps, 4.5);
        }
    }
}

module drawer_handle() {
    color(color_metal) {
        translate([0, -handle_standoff, 0])
            cyl_x(handle_width, handle_rod_d);
        for (x = [-handle_spacing/2, handle_spacing/2]) {
            translate([x, -handle_standoff/2, 0])
                cyl_y(handle_standoff, handle_rod_d);
        }
    }
}

module drawer_box_parts() {
    color(color_wood_dark) {
        translate([-drawer_box_w/2 + drawer_body_thk/2, drawer_box_y_closed, drawer_z])
            cube([drawer_body_thk, drawer_box_depth, drawer_box_h], center=true);
        translate([ drawer_box_w/2 - drawer_body_thk/2, drawer_box_y_closed, drawer_z])
            cube([drawer_body_thk, drawer_box_depth, drawer_box_h], center=true);
        translate([0, drawer_inner_front_y, drawer_z])
            cube([drawer_inner_panel_w, drawer_body_thk, drawer_box_h], center=true);
        translate([0, drawer_box_y_closed + drawer_box_depth/2 - drawer_body_thk/2, drawer_z])
            cube([drawer_inner_panel_w, drawer_body_thk, drawer_box_h], center=true);
        translate([0, drawer_box_y_closed, drawer_bottom_z])
            cube([drawer_bottom_w, drawer_bottom_depth, drawer_bottom_thk], center=true);
    }
}

module drawer_front_fixing_hardware() {
    inner_y = drawer_inner_front_y + drawer_body_thk/2 + 0.12;

    for (x = [-drawer_front_fix_x, drawer_front_fix_x]) {
        for (z = [drawer_z - drawer_front_fix_z, drawer_z + drawer_front_fix_z]) {
            color(color_metal)
            translate([x, inner_y, z])
            rotate([90, 0, 0])
                cylinder(h=0.35, d=drawer_front_fix_head_d, center=true);

            // 竖向长孔/大垫片表达：前脸最后装，便于调左右缝和上下缝。
            color(color_socket)
            translate([x, inner_y + 0.2, z])
                cube([drawer_front_slot_w, 0.08, drawer_front_slot_h], center=true);
        }
    }
}

module drawer_box_fasteners() {
    screw_z_top = drawer_z + drawer_box_h/2 - 18;
    screw_z_bottom = drawer_z - drawer_box_h/2 + 18;
    front_y = drawer_inner_front_y;
    back_y = drawer_box_y_closed + drawer_box_depth/2 - drawer_body_thk/2;
    bottom_z = drawer_bottom_z + drawer_bottom_thk/2 + 0.08;

    // 内前板/背板与左右侧板连接螺丝。
    color(color_socket)
    for (panel_y = [front_y, back_y]) {
        for (x = [-drawer_box_w/2 - 0.05, drawer_box_w/2 + 0.05]) {
            for (z = [screw_z_bottom, screw_z_top]) {
                translate([x, panel_y, z])
                rotate([0, 90, 0])
                    cylinder(h=0.08, d=4.2, center=true);
            }
        }
    }

    // 底板四边入槽承托；这里只示意背板下沿2颗可选限位螺丝，不作为主要承重。
    color(color_socket)
    for (x = [-80, 80]) {
        translate([x, back_y - drawer_body_thk/2 - 18, bottom_z])
            cylinder(h=0.08, d=3.2, center=true);
    }
}

module moving_slides() {
    for (sign = [-1, 1]) {
        translate([sign*(drawer_box_w/2 + slide_thk/2 + 0.5), slide_moving_y_closed, slide_z])
            slide_rail(sign, true);
    }
}

module drawer_box_parts_exploded() {
    color(color_wood_dark) {
        translate([-drawer_box_w/2 + drawer_body_thk/2 - explode_gap, drawer_box_y_closed, drawer_z])
            cube([drawer_body_thk, drawer_box_depth, drawer_box_h], center=true);
        translate([ drawer_box_w/2 - drawer_body_thk/2 + explode_gap, drawer_box_y_closed, drawer_z])
            cube([drawer_body_thk, drawer_box_depth, drawer_box_h], center=true);
        translate([0, drawer_inner_front_y - explode_gap, drawer_z])
            cube([drawer_inner_panel_w, drawer_body_thk, drawer_box_h], center=true);
        translate([0, drawer_box_y_closed + drawer_box_depth/2 - drawer_body_thk/2 + explode_gap, drawer_z])
            cube([drawer_inner_panel_w, drawer_body_thk, drawer_box_h], center=true);
        translate([0, drawer_box_y_closed, drawer_bottom_z - 45])
            cube([drawer_bottom_w, drawer_bottom_depth, drawer_bottom_thk], center=true);
    }
}

module moving_slides_exploded() {
    for (side = [-1, 1]) {
        translate([side*(drawer_box_w/2 + slide_thk/2 + 0.5 + 42), slide_moving_y_closed, slide_z])
            slide_rail(side, true);
    }
}

module drawer_assembly(y_offset=drawer_open_y) {
    translate([0, y_offset, 0]) {
        translate([0, drawer_front_y_closed, drawer_z]) {
            drawer_front_panel();
            translate([0, -drawer_front_thk/2 - 2, 0]) drawer_handle();
        }
        drawer_box_parts();
        drawer_front_fixing_hardware();
        drawer_box_fasteners();
        moving_slides();
    }
}

module drawer_assembly_exploded(y_offset=drawer_full_open_y) {
    translate([0, y_offset, 0]) {
        translate([0, drawer_front_y_closed - explode_gap, drawer_z]) {
            drawer_front_panel();
            translate([0, -drawer_front_thk/2 - 32, 0]) drawer_handle();
        }
        drawer_box_parts_exploded();
        moving_slides_exploded();
    }
}

module drawer_installation_preview() {
    frame_profiles();
    fixed_slides();
    drawer_assembly(-slide_travel * 0.85);
}

module drawer_full_open_check() {
    frame_profiles();
    fixed_slides();
    drawer_assembly(drawer_full_open_y);
}

module drawer_closed_check() {
    frame_profiles();
    fixed_slides();
    drawer_assembly(0);
}

// ==============================================================================
// 总装
// ==============================================================================

module bed_side_cabinet() {
    feet();
    frame_profiles();
    countersunk_top_plate();
    upper_glass_panels();
    bottom_shelf();
    lower_guard_rails();
    fixed_slides();
    drawer_assembly();
}

module bed_side_cabinet_open() {
    feet();
    frame_profiles();
    countersunk_top_plate();
    upper_glass_panels();
    bottom_shelf();
    lower_guard_rails();
    fixed_slides();
    drawer_assembly(drawer_full_open_y);
}

module bed_side_cabinet_exploded() {
    translate([0, 0, -72]) feet();
    frame_profiles_exploded();
    translate([0, 0, 96]) countersunk_top_plate();
    upper_glass_panels_exploded();
    translate([0, 0, -54]) bottom_shelf();
    translate([0, -70, -22]) lower_guard_rails();
    fixed_slides_exploded();
    translate([0, -72, 0]) drawer_assembly_exploded(drawer_full_open_y);
}

if (render_target == "frame") {
    frame_profiles();
} else if (render_target == "top_plate") {
    countersunk_top_plate();
} else if (render_target == "glass_panels") {
    upper_glass_panels();
} else if (render_target == "shelf") {
    bottom_shelf();
} else if (render_target == "guard_rails") {
    lower_guard_rails();
} else if (render_target == "drawer") {
    drawer_assembly();
} else if (render_target == "fixed_slides") {
    fixed_slides();
} else if (render_target == "drawer_install") {
    drawer_installation_preview();
} else if (render_target == "drawer_open") {
    drawer_full_open_check();
} else if (render_target == "drawer_closed") {
    drawer_closed_check();
} else if (render_target == "assembly_open") {
    bed_side_cabinet_open();
} else if (render_target == "exploded") {
    bed_side_cabinet_exploded();
} else if (render_target == "feet") {
    feet();
} else {
    bed_side_cabinet();
}
