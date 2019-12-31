 /*
 * New CNC 3018 z carriages for a paste dispenser, and for a nema8 OpenPNP pick and place. 
 *
 * Requires the following mechanical components:
 * 2 x LM8UU linear bearings 
 * 1 x CNC 3018 T8 anti-backlash nut
 * 
 * https://www.aliexpress.com/item/32848554378.html
 *
 */

include <param.scad>
include <NopSCADlib/lib.scad>
$fn = 128;

shaft_dist = 19.1 * 2; // distance between the two 8mm shaft centers.

// lm8uu linear bearing
lm8_length =  25.0;
lm8_dia = 15.0;

zcarriage_height = lm8_length + 2.5;
zcarriage_corner_radius = 15.0;
zcarriage_wall_thickness = 5.0;
zcarriage_y_offset = 38.5; // chosen so dispenser_body and zcarriage_body barely touch.

// cnc3018 anti-backlash nut
anti_backlash_nut1_dia = 22.0;
anti_backlash_nut1_length = 15.0;
anti_backlash_nut1_width = 10.0;
anti_backlash_nut2_dia = 14.0;
anti_backlash_nut2_length = 10.8;

dispenser_height = 6.0; // XXX check M3 inserts are not as tall. increase?

// nema8 with hollow shaft and rear shaft nipple end.
nema8_base_height = dispenser_height;
nema8_width1 = 20.0;
nema8_height1 = 30.0;
nema8_dia2 = 15.0;
nema8_height2 = 1.5;
nema8_dia3 = 5.0;
nema8_height3 = 20.0;

nema8_screw_spacing = 16.0;
nema8_screw_size = 2.2;

xmax = shaft_dist/2 + lm8_dia/2;
ymax = anti_backlash_nut1_dia/2;

x0 = xmax - zcarriage_corner_radius + zcarriage_wall_thickness;
y0 = ymax - zcarriage_corner_radius + zcarriage_wall_thickness;

/* 
 * cnc3018 z-carriage for paste dispenser.
 */

/* The cnc3018 z slide is two 8mm vertical shafts, spaced 38.2mm apart, with a 
 * T8 leadscrew in the middle. The z carriage is then two lm8uu linear slides, with a 
 * T8 anti-backlash nut in the middle.
 */
 
module cnc3018_dispenser_base_pattern() { 
    hull() {
        dispenser_base_pattern();
        translate([0, zcarriage_y_offset, 0])
        zcarriage_base_pattern();
    }
}

module cnc3018_dispenser_body() {
    hull() {
        dispenser_body();
        translate([0, zcarriage_y_offset, 0])
        zcarriage_body();
    }  
}

module cnc3018_dispenser_holes() {
    dispenser_holes();
    translate([0, zcarriage_y_offset, 0])
    zcarriage_holes();
}

 
module cnc3018_dispenser () {
    difference () {
        cnc3018_dispenser_body();
        cnc3018_dispenser_holes();
    } 
}

/* 
 * cnc3018 z-carriage for nema8 pick-and-place.
 */

module cnc3018_nema8_base_pattern() { 
    hull() {
        nema8_base_pattern();
        translate([0, zcarriage_y_offset, 0])
        zcarriage_base_pattern();
    }
}

module cnc3018_nema8_body() {
    hull() {
        nema8_body();
        translate([0, zcarriage_y_offset, 0])
        zcarriage_body();
    }  
}

module cnc3018_nema8_holes() {
    nema8_holes();
    translate([0, zcarriage_y_offset, 0])
    zcarriage_holes();
}
 
module cnc3018_nema8 () {
    difference () {
        cnc3018_nema8_body();
        cnc3018_nema8_holes();
    } 
}

/*
 * cnc3018 z-carriage for dual nema8
 */

module cnc3018_dual_nema8_base_pattern() { 
    hull() {
        translate([-shaft_dist/2, 0, 0])
        nema8_base_pattern();
        translate([shaft_dist/2, 0, 0])
        nema8_base_pattern();
        translate([0, zcarriage_y_offset, 0])
        zcarriage_base_pattern();
    }
}

module cnc3018_dual_nema8_body() {
    hull() {
        translate([-shaft_dist/2, 0, 0])
        nema8_body();
        translate([shaft_dist/2, 0, 0])
        nema8_body();
        translate([0, zcarriage_y_offset, 0])
        zcarriage_body();
    }  
}

module cnc3018_dual_nema8_holes() {
    translate([-shaft_dist/2, 0, 0])
    nema8_holes();
    translate([shaft_dist/2, 0, 0])
    nema8_holes();
    translate([0, zcarriage_y_offset, 0])
    zcarriage_holes();
}
 
module cnc3018_dual_nema8 () {
    difference () {
        cnc3018_dual_nema8_body();
        cnc3018_dual_nema8_holes();
    } 
}

/* dispenser */

module dispenser_base_pattern() {
    hull() {
        circle(d = stepper_width);
        circle (d = syringe_ext_dia);
        twice(stepper_screw_spacing) circle(d = stepper_screw_dia);
        twice(stepper_screw_spacing) {circle(r = washer_radius(M4_washer));}
    }
}

module dispenser_body() {
    linear_extrude(dispenser_height)
    offset(zcarriage_wall_thickness)
    dispenser_base_pattern(); 
}

module dispenser_holes() {
    translate([0, 0, -eps1]) {
        twice(stepper_screw_spacing) cylinder(r = screw_clearance_radius(M4_cap_screw), h = zcarriage_height + eps2);
        translate([0, 0, dispenser_height]) 
        twice(stepper_screw_spacing) {
            //cylinder(r = washer_radius(M4_washer), h = zcarriage_height + eps2);
            hole_radius = nut_trap_radius(M4_nut, horizontal = false);
            hole_dia = 2 * hole_radius;
            
            cylinder(r = hole_radius, h = zcarriage_height + eps2, $fn = 6);	;
            
            translate([-hole_dia/2, -2 * hole_dia, 0])
            cube([hole_dia, 2 * hole_dia, zcarriage_height + eps2]);
        }
        syringe_hole_dia = syringe_ext_dia + 2 * clearance_fit;
        cylinder(d = syringe_hole_dia, h = zcarriage_height + eps2);
        translate([-syringe_hole_dia/2, - 2 * syringe_hole_dia, dispenser_height])
        cube([syringe_hole_dia, 2 * syringe_hole_dia, zcarriage_height + eps2]);
    }
}

/*
 * nema8 stepper for pick-and-place.
 * nema8 size 20mm hollow shaft stepper motor, rear shaft nipple end.
 * https://www.robotdigg.com/product/43/Nema8-Hollow-Shaft-Stepper-Motor
 */

module nema8_base_pattern() {
    square(size = nema8_width1, center = true);
}

module nema8_body() {
    linear_extrude(nema8_base_height)
    offset(dispenser_height)
    nema8_base_pattern();
}

module nema8_holes() {
    translate([0, 0, -eps1]) {
        //translate([0, 0, nema8_base_height - nema8_height2 + eps1])
        //cylinder(h = nema8_height2 + clearance_fit, d = nema8_dia2 + tight_fit);
        cylinder(h = nema8_base_height + clearance_fit, d = nema8_dia2 + tight_fit);
 
        // holes for screws
        washer_dia = 2 * washer_radius(M2_washer) + tight_fit;
        nema8_screw_holes(nema8_screw_size + clearance_fit);
        
        // hole for shaft
        cylinder(h = nema8_height3 + clearance_fit, d = nema8_dia3 + 2 * clearance_fit);

        // holes for screw head
        // XXX translate([0, 0, dispenser_height]) nema8_screw_holes(washer_dia);
        
        // cutout
        translate([0, 0, dispenser_height]) hull() nema8_screw_holes(washer_dia + 2);
        
    } 
}

module nema8_screw_holes(hole_dia) {
    screw_x = nema8_screw_spacing/2;
    
    translate([screw_x, screw_x, 0]) cylinder(h = zcarriage_height + eps2, d = hole_dia);
    translate([screw_x, -screw_x, 0]) cylinder(h = zcarriage_height + eps2, d = hole_dia);
    translate([-screw_x, screw_x, 0]) cylinder(h = zcarriage_height + eps2, d = hole_dia);
    translate([-screw_x, -screw_x, 0]) cylinder(h = zcarriage_height + eps2, d = hole_dia);
}

/* cnc3018 z-carriage */

module zcarriage_base_pattern() {
    hull() {
        twice(shaft_dist) circle(d = lm8_dia);
        circle(d = anti_backlash_nut1_dia);
    }
}

module zcarriage_body() {
    linear_extrude(zcarriage_height)
    offset(zcarriage_wall_thickness)
    zcarriage_base_pattern(); 
}

module zcarriage_holes() {
    translate([0, 0, -eps2]) {
        twice(shaft_dist) cylinder(h = zcarriage_height + 2 * eps2, d = lm8_dia + tight_fit);
        translate([0, 0, zcarriage_height + 2 * eps2])
        mirror([0, 0, 1])
        anti_backlash_nut();
    }
}

// custom CNC 3018 T8 anti-backlash nut
// https://www.aliexpress.com/item/32848554378.html
// "DIY CNC 3018 exclusive 3D Printer Parts T8 Anti Backlash Spring Loaded Nut Elimination Gap Nut for 10mm"

module anti_backlash_nut() {
    // XXX check +2 +4
    
    // large nut
    nut1_dia = anti_backlash_nut1_dia + 2 * clearance_fit;
    nut1_width = anti_backlash_nut1_width + 2 * clearance_fit;
    nut1_height = zcarriage_height + eps2;
    
    translate([0, 0, anti_backlash_nut2_length])
    intersection() {
        cylinder(h = nut1_height, d = nut1_dia);
        translate([-nut1_width/2, -nut1_dia/2, 0])
        cube([nut1_width, nut1_dia, nut1_height]);
        union() {
            translate([0, 0, nut1_dia/2])
            cylinder(d = nut1_dia, h = nut1_height);
            cylinder(d1 = eps1, d2 = nut1_dia, h = nut1_dia/2 + eps1);
        }
    }
   
    // small nut
    cylinder(h = nut1_height + eps1, d = anti_backlash_nut2_dia + tight_fit);  
}

/* utility */

module twice(offset) {
    translate([-offset/2, 0, 0]) children();
    translate([offset/2, 0, 0]) children();
}

/* uncomment one */

/* mount for a single Robotdigg NC35-BYZ-120 12V 35mm non-captive linear stepper motor;
 * this gives you a cheap automatic glue, oil or solder paste dispenser. */
//cnc3018_dispenser();

/* mount for single nema8 stepper */
//cnc3018_nema8();

/* mount for dual nema8 stepper */
cnc3018_dual_nema8();

// not truncated