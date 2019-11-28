// 5cc Chip Quik solder paste/flux syringe.

syringe_volume = 5.0; // ml (or cc)
syringe_flange_dia = 31.6;
syringe_flange_thickness = 3.5;
syringe_ext_dia = 14.5;
syringe_int_dia = 12.8;
syringe_barrel_length = 67.0;
syringe_empty_length = 60.0;
syringe_luer_dia = 10.35;

module torus(r_maj, r_min) {
    rotate_extrude()
    translate([r_maj, 0])
    circle(r = r_min);
}

// Piston for 5cc Chip Quik solder paste/flux syringe. 

module plunger_body() {
    r2 = 2.50;  // curvature of tip
    h1 = 15.0;  // height body
    r1 = 12.0/2;
    chamfer = 0.5; // chamfer at bottom

    hull() {
        // plunger top
        translate([0, 0, h1 - r2])
        hull()
        torus(r_maj = r1-r2, r_min = r2 - tweak);
        
        // plunger cylindrical body
        translate([0, 0, chamfer])
        cylinder(r = r1 - tweak, h = h1 - r2 - chamfer + eps2);
        cylinder(r1 = r1 - tweak - chamfer, r2 = r1 - tweak, h = chamfer + eps2);
    }
}

plunger_body();
// not truncated 
