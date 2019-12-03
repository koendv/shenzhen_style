// 10cc "Mechanic" solder paste/flux syringe.
//include <param.scad>

// generic syringe dimensions from syringe.csv

syringe_volume = 10.0; // ml (or cc)
syringe_flange_dia = 34.1;
syringe_flange_thickness = 3.25;
syringe_ext_dia = 18.4;
syringe_int_dia = 15.5;
syringe_barrel_length = 91.2;
syringe_empty_length = 77.5;
syringe_luer_dia = 10.40;

// Piston for 10cc solder paste/flux syringe. 

module plunger_section() {
    
    chamfer = 0.5; // chamfer at bottom
    r0 = syringe_int_dia/2 - clearance_fit;   // radius at base. 
    h0 = 6.0;
    r1 = 7.0;
    h1 = 8.0;
    r2 = 12.60/2;
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

module plunger_rotate_extrude() {
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

module plunger_cutout() {
    h_cutout = 2.75;
    d_cutout = 5.0;
    w_cutout = 0.5;
    z_cutout = 16.0 - h_cutout;
    
    translate([0, 0, z_cutout])
    linear_extrude(height = h_cutout + eps2)
    offset (tweak) {
        circle(d = d_cutout);
        square(size = [syringe_ext_dia, w_cutout], center = true);
        square(size = [w_cutout, syringe_ext_dia], center = true);
    }
}

module plunger_body() {

    difference() {
        plunger_rotate_extrude();
        plunger_cutout();
    }
}

//plunger_section();
//plunger_rotate_extrude();
//plunger_cutout();
//plunger_body();
// not truncated 
