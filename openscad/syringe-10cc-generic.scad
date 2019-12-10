// 10cc "Mechanic" solder paste/flux syringe.
//include <param.scad>

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
    h2 = 2.5;
    r3 = 4.36/2;

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
    h_cutout = 3.0;
    d_cutout = 4.5;
    w_cutout = 0.55;
    z_cutout = 16.5 - h_cutout;
    
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

if (0) {
    projection(cut = true)
    rotate([0, 90, 0])
    rotate([0, 0, 45])
    plunger_body();
}
  
//plunger_section();
//plunger_rotate_extrude();
//plunger_cutout();
//plunger_body();
 
// not truncated 
