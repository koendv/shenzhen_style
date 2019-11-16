include <param.scad>
include <util.scad>
include <threaded-insert.scad>
include <NopSCADlib/lib.scad>

// M3 threaded insert for plunger.
module plunger_hole() {
    translate([0, 0, -eps1])
    m3_threaded_insert(6.0);
}
 
module plunger() {
    union() {
        difference() {
            plunger_body();
            plunger_hole();
        }
    }
}

//cutout() plunger();
// not truncated 
