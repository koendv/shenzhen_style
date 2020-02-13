include <param.scad>
include <util.scad>
include <NopSCADlib/lib.scad>

/*
 * body
 */

module base_pattern() {
    offset(r = 1.0)
    hull() {
        circle(d = stepper_width);
        twice() {circle (d = stepper_length - stepper_screw_spacing);}
        // make sure there is min_wall_thickness around stepper, syringe and standoffs.
        offset(r = min_wall_thickness) {
            circle (d = stepper_bottom_dia);
            circle (d = syringe_ext_dia);
            twice() circle(d = stepper_screw_dia);
        }
    };
}

module screw_holes () {
    twice() {circle(r = screw_clearance_radius(M4_cap_screw));}
}

module body() {
    hole_dia = max(stepper_bottom_dia, syringe_int_dia) + 2 * clearance_fit;

    difference() {
        linear_extrude(height = body_height, convexity = 10) {
            difference() {
                base_pattern();
                screw_holes ();
            }
        }

        translate([-stepper_length/2, -(syringe_flange_width+2.0)/2, -eps1])
        cube([stepper_length, syringe_flange_width+2.0, syringe_flange_thickness-0.5+eps2]);

        translate([0, 0, -eps1])
        cylinder(d = hole_dia, h = body_height + eps2);
    }
}

module screw_heads () {
    screw_head_dia = 2 * stepper_screw_dia + 1; // valid washer size for M2, M2.5, M3, M3.5, M4.
    twice() {cylinder(d = screw_head_dia, h = syringe_holder_total_height);}
}

/*
 * syringe holder for hand-held version
 */

module syringe_holder() {
    difference() {
        hull() {
            linear_extrude(height = syringe_holder_base_height)
            base_pattern();
            linear_extrude(height = syringe_holder_total_height)
            circle(d = syringe_ext_dia + 2 * clearance_fit + 2 * min_wall_thickness);
        }
        translate([0, 0, -syringe_holder_total_height/2]) {
            cylinder(d = syringe_ext_dia + 2 * clearance_fit, h = 2 * syringe_holder_total_height);
            // holes for screws
            twice() {cylinder(r = screw_clearance_radius(M4_cap_screw), h = 2 * syringe_holder_total_height);}
        }
        // holes for screw heads and washers
        translate([0, 0, syringe_holder_base_height])
        screw_heads();
        // chamfer
        d_chamfer = syringe_ext_dia + 2 * clearance_fit + 2 * chamfer;
        translate([0, 0, -eps1])
        cylinder ( d1 = d_chamfer, d2 = 0, h = d_chamfer/2 + eps2);
    }
}

/*
 * 42mm adapter for mounting on cnc3018
 * Connect Robotdigg NC35-byz-120 stepper to controller board extruder E0 (M4).
 */

cnc_adapter_total_height = cnc_zcarriage_h1+syringe_holder_base_height+syringe_holder_total_height+eps2;

module cnc3018_adapter() {
    difference() {
        cnc3018_adapter_body();
        cnc3018_adapter_holes();
    }
}

module cnc3018_adapter_body() {
    translate([0, 0, -eps1])
    cylinder(d = cnc_zcarriage_dia1, h = cnc_zcarriage_h1+eps2);

    // retaining lip, avoid adapter falling through
    lip = 1.2;
    translate([0, 0, cnc_zcarriage_h1-lip-eps1])
    cylinder(d = cnc_zcarriage_dia1+2*lip, h = lip+eps2);

    hull() {
        translate([0, 0, syringe_holder_total_height+cnc_zcarriage_h1-eps1])
        linear_extrude(height = syringe_holder_base_height)
        base_pattern();

        translate([0, 0, cnc_zcarriage_h1-eps1])
        cylinder(d = cnc_zcarriage_dia1+2*lip, h = eps1);
    }
}

module cnc3018_adapter_holes() {

    // syringe body
    translate([0, 0, -eps2])
    cylinder(d = syringe_ext_dia + 2 * clearance_fit, h = cnc_adapter_total_height);

    // M4 screws
    translate([0, 0, -eps1])
    twice() {cylinder(r = screw_clearance_radius(M4_cap_screw), h = cnc_adapter_total_height);}

    // M4 hex socket cap and washer
    screw_head_dia = 2 * stepper_screw_dia + 1; // valid washer size for M2, M2.5, M3, M3.5, M4.

    translate([0, 0, -eps2])
    twice() {cylinder(d = screw_head_dia, h = cnc_adapter_total_height-syringe_holder_base_height+eps2);}

    translate([-screw_head_dia/2, stepper_screw_spacing/2, -eps2])
    cube([screw_head_dia, stepper_width, cnc_adapter_total_height-syringe_holder_base_height+eps2]);

    mirror([0, 1, 0])
    translate([-screw_head_dia/2, stepper_screw_spacing/2, -eps2])
    cube([screw_head_dia, stepper_width, cnc_adapter_total_height-syringe_holder_base_height+eps2]);

    translate([syringe_ext_dia/2+(cnc_zcarriage_dia1-syringe_ext_dia)/4, 0, -eps2])
    mirror([0, 1, 0])
    rotate([0, 0, -90])
    small_text(str(cnc_zcarriage_dia1));

}

module small_text(txt) {
    linear_extrude(0.4) text(txt, size = 6, halign = "center", valign = "center");
}

if (0) {
    cutout()
    body();

    translate([0, 0, -10])
    mirror([0, 0, 1])
    syringe_holder();
}

//body();
//syringe_holder();
//cnc3018_adapter();

// not truncated
