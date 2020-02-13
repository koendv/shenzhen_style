/*
 * Assembly drawing
 */
 
include <param.scad>
include <body.scad>
include <motor.scad>
include <plunger.scad>
include <syringe.scad>

include <NopSCADlib/lib.scad>
$fn=64;
cut = false;
show_syringe_contents = false;

// valid values for position: 0 ... 1. 
// realistic values for position: 0.2 ... 0.90
module assembly(position = 0.5, cnc3018=false) {
    
    //body
    cutout(cut)
    body();
    
    // linear stepper
    translate([0, 0, body_height])
    color("silver")
    cutout(cut)
    motor();
    
    // top M4 screws
    translate([0, 0, body_height + stepper_base_thickness])
    color("silver")
    twice() nut(M4_nut);
    
    // syringe
    translate([0, 0, -syringe_barrel_length + syringe_flange_thickness])
    rotate([0,0,90])
    syringe(model_contents = show_syringe_contents);
    
    if (cnc3018) {
        // mount as cnc 3018 spindle
        translate([0, 0, -cnc_adapter_total_height])
        cnc3018_adapter();
    } else {
        // syringe holder
        translate([0, 0, -eps2])
        mirror([0, 0, 1])
        cutout(cut)
        syringe_holder();
    }
   
    // bottom M4 screws
    translate([0, 0, - syringe_holder_base_height])
    color("silver")
    mirror([0, 0, 1])
    twice() screw(M4_cap_screw, 25);
 
    // leadscrew position
    leadscrew_position = max(min(position, 1.0), 0.0); // constrain to values between 0.0 and 1.0
    leadscrew_pos = stepper_base_thickness + stepper_height - leadscrew_length * position;
    //echo ("leadscrew position:", leadscrew_pos);
    
    // plunger, leadscrew
    translate([0, 0, leadscrew_pos]) {
        
        // leadscrew
        color("navy")
        leadscrew();
        
        // plunger
        cutout(cut)
        translate([0, 0, leadscrew_tip_length]) {
            color("SaddleBrown")
            insert(F1BM3); // M3 threaded knurled brass insert
            mirror([0,0,1])
            plunger();
        }
    }
}

// linear interpolation
function map_value(x, in_min, in_max, out_min, out_max) = (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;

// for use with "animation" menu item
module animation() {
    syringe_top = 0.21;
    syringe_bottom = 0.92;
    rotate([0, -90, 0])
    if ($t < 0.5) {
        assembly(map_value($t, 0.0, 0.5, syringe_top, syringe_bottom)); 
        }
    else {
        assembly(map_value($t, 0.5, 1.0, syringe_bottom, syringe_top)); 
        }
} 

//assembly();
//assembly(position = 0.21); // piston at syringe top
//assembly(position = 0.92); // piston at syringe bottom
//assembly(cnc3018=true, position = 0.70); // mounted in cnc3018

//animation();

//not truncated
