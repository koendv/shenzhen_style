include <param.scad>
include <util.scad>
include <NopSCADlib/lib.scad>

// body
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
    difference() {
        linear_extrude(height = body_height, convexity = 10) {
            difference() {
                base_pattern();
                screw_holes ();
            }
        }
        
        // XXX check clearance fit on everything
        // holes in body for stepper motor and plunger
        // hole for stepper motor
        stepper_bottom_dia_with_clearance = stepper_bottom_dia + 2 * clearance_fit;
        syringe_int_dia_with_clearance = syringe_int_dia + 2 * clearance_fit;
        syringe_ext_dia_with_clearance = syringe_ext_dia + 2 * clearance_fit;
        translate([0, 0, body_height - stepper_bottom_height])
        cylinder(d = stepper_bottom_dia_with_clearance, h = stepper_bottom_height + eps2);
        // hole for plunger
        translate([0, 0, -eps1])
        cylinder(d = syringe_int_dia_with_clearance, h = body_height - stepper_bottom_height + eps2);
        // internal chamfer at 45 degree
        dia_diff = stepper_bottom_dia_with_clearance - syringe_int_dia_with_clearance;
        // if syringe_int_dia is smaller than stepper_bottom_dia
        translate([0, 0, body_height - stepper_bottom_height - dia_diff/2])
        cylinder (d1 = syringe_int_dia_with_clearance, d2 = stepper_bottom_dia_with_clearance, h = dia_diff/2 + eps1);
        // if syringe_int_dia is bigger than stepper_bottom_dia
        translate([0, 0, body_height - stepper_bottom_height])
        cylinder (d1 = syringe_int_dia_with_clearance, d2 = stepper_bottom_dia_with_clearance, h = -dia_diff/2 - eps1); 
        // chamfer at bottom
        d_chamfer = syringe_int_dia_with_clearance + 2 * chamfer; 
        translate([0, 0, -eps1])
        cylinder ( d1 = d_chamfer, d2 = 0, h = d_chamfer/2 + eps2);
    }
}

module screw_heads () {
    screw_head_dia = 2 * stepper_screw_dia + 1; // valid washer size for M2, M2.5, M3, M3.5, M4.
    twice() {cylinder(d = screw_head_dia, h = syringe_holder_total_height);}           
}

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

if (0) {
    cutout()
    body();
    
    translate([0, 0, -10])
    mirror([0, 0, 1])
    syringe_holder();
}
  
//body();
//syringe_holder();

// not truncated
