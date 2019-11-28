// 10cc "Mechanic" solder paste/flux syringe.
//include <param.scad>

syringe_volume = 10.0; // ml (or cc)
syringe_flange_dia = 28.0;
syringe_flange_thickness = 1.9;
syringe_ext_dia = 16.2;
syringe_int_dia = 14.4;
syringe_barrel_length = 106.0;
syringe_empty_length = 95.2;
syringe_luer_dia = 10.35; // check

// Piston for 10cc solder paste/flux syringe. 

module plunger_section() {
    
    chamfer = 0.5; // chamfer at bottom
    r0 = 7.0;
    h0 = 6.0;
    r1 = 7.0;
    h1 = 7.0;
    r2 = r1 - clearance_fit;
    h2 = 2.0;
    r3 = 5.0;

    hull() {
        translate([h0+h1+h2, 0]) square(size=[eps1, r3]);
        translate([h0+h1, 0]) square(size=[eps1, r2]);
        translate([h0, 0]) square(size=[eps1, r1]);
        translate([chamfer, 0]) square(size=[eps1, r0]);
        square(size=[eps1, r0 - chamfer]);
    }

}

module plunger_body() {
    max_size = 100.0;
    rotate_extrude(convexity = 10) // rotate extrude piston section to 3d body
    rotate([0, 0, 90])
    intersection() {
        square(max_size);
        offset(-tweak) // shrink plunger_section for fdm printer tolerance
        union() {
            plunger_section();
            mirror([0, 1, 0])
            plunger_section();
            mirror([1, 0, 0])
            plunger_section();
            mirror([0, 1, 0])
            mirror([1, 0, 0])
            plunger_section();
        }
    }
}

//plunger_body();
// not truncated 
