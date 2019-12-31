include <param.scad>
include <util.scad>

/* 
 * Adapter plate to join a "Raspberry Pi 4" micro-computer to the cnc3018 y rails.
 */


board_thickness = 2.5;
beam_width = 9.0;

cnc3018_y = 85.5; // center distance between cnc3018 y rails
cnc3018_pillar_dia = 9.0; 
cnc3018_pillar_height = 3.0; 
cnc3018_screw_dia = 4.3;

raspi_width = 56.0;
raspi_height = 85.0;

raspi_x = 49.0;
raspi_y = 58.0;

raspi_y_offset = cnc3018_pillar_dia;

raspi_screw_dia = 2.7;
raspi_pillar_dia = 6.0;
raspi_pillar_height = cnc3018_pillar_height + 4.0;

module cnc3018_raspberrypi() {
    difference() {
        cnc3018_raspberrypi_body();
        cnc3018_raspberrypi_holes();
    }
    
    translate([0, raspi_y_offset + raspi_y/2, board_thickness])
    rotate([0, 0, 90])
    small_text("cnc3018 raspi");
}

module small_text(txt) {
    linear_extrude(0.5) text(txt, size = 6, halign = "center", valign = "center");
}

module cnc3018_raspberrypi_body() {
    linear_extrude(raspi_pillar_height) offset(r = raspi_pillar_dia/2) raspi_pillars();
    linear_extrude(cnc3018_pillar_height) offset(cnc3018_pillar_dia/2) cnc3018_pillars();
    cnc3018_raspberrypi_base();
}

module cnc3018_raspberrypi_holes() {
    translate([0, 0, -eps1]) {
        linear_extrude(raspi_pillar_height + eps2) offset(raspi_screw_dia/2) raspi_pillars();
        linear_extrude(cnc3018_pillar_height + eps2) offset(cnc3018_screw_dia/2) cnc3018_pillars();
    }
}

module cnc3018_raspberrypi_base() {
    beam([0, 0], [raspi_x, 0]);
    beam([raspi_x, 0], [raspi_x, cnc3018_y]);
    beam([raspi_x, cnc3018_y], [0, cnc3018_y]);
    beam([0, cnc3018_y], [0, 0]);
    //beam([0, raspi_y_offset], [raspi_x, raspi_y_offset]);
    beam([raspi_x, raspi_y_offset], [0, raspi_y + raspi_y_offset]);
    beam([0, raspi_y + raspi_y_offset], [raspi_x, raspi_y + raspi_y_offset]);
}

module beam(x, y) {
    hull() {
        translate(x)
        cylinder(d = beam_width, h = board_thickness);
        translate(y)
        cylinder(d = beam_width, h = board_thickness);
    }
}
    
module raspi_pillars() {
    translate([0, raspi_y_offset]) {
        dot([0, 0]);
        dot([raspi_x, 0]);
        dot([0, raspi_y]);
        dot([raspi_x, raspi_y]);
    }
}

module cnc3018_pillars() {
    dot([0, 0]);
    dot([raspi_x, 0]);
    dot([0, cnc3018_y]);
    dot([raspi_x, cnc3018_y]);
}

module  dot(x) {
    translate(x) circle(r = eps1);
}

if (1) {
    cnc3018_raspberrypi();
}

// not truncated
