/* practicing placing threaded inserts using a solder iron */

include <param.scad>;
include <threaded-insert.scad>;

h1=8;
h2=10;
w=16;
screw_length = 6.0;

d = 4.5;

module m3_inserts() {
    translate([d, d, -eps1]) m3_threaded_insert(screw_length);
    translate([w-d, d, -eps1]) m3_threaded_insert(screw_length);
    translate([d, w-d, -eps1]) m3_threaded_insert(screw_length);
    translate([w-d, w-d, -eps1]) m3_threaded_insert(screw_length);
}

module block() {
  difference() {
    cube([w, w, h2]);
    m3_inserts();
      
    translate([-5, -5, 0])
    rotate([0, 0, 45])
    cube([w, w, 2*w], center=true);
  }
}

module insert_practice() {
  translate([0, 0, h2]) mirror ([0, 0, 1]) block();
}


//insert_practice();

// not truncated
