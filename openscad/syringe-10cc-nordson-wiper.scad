// Syringe specs

// Plunger for 10cc pneumatic glue dispenser syringe. "US style"

syringe_volume = 10.0; // ml (or cc)
syringe_flange_dia = 30.35;
syringe_flange_thickness = 3.57;
syringe_ext_dia = 19.05;
syringe_int_dia = 16.27;
syringe_barrel_length = 91.20;
syringe_empty_length = 82.25; // 73.2 mm max. plunger movement
syringe_luer_dia = 11.13;

/* The ubiquitous white piston in glue dispenser syringes */

module plunger_section() {
    x0=0;y0=7.00;
    x1=9.14;y1=0.69;r1=5.66;
    x2=15.018;y2=2.34;
    hull() {
        translate([x0,0]) square(size=[eps1, 2 * y0], center=true);
        translate([x1,y1]) circle(r=r1);
        translate([x1,-y1]) circle(r=r1);
        translate([x2,0]) square(size=[eps1, 2 * y2], center=true);
    }
}

module plunger_cut() {
    d_cut = 2.0;
    w_cut = 0.5;
    x1_cut = 8.17879;
    y1_cut = 3.12939;
    x2_cut = 11.169;
    y2_cut = 5.22316;
    x3_cut = x2_cut;
    y3_cut = 5.97977;
    x4_cut = 17.0;
    y4_cut = y3_cut;
    poly_cut = [[x1_cut, y1_cut], [x2_cut, y2_cut], [x3_cut, y3_cut], [x4_cut, y4_cut], 
    [x4_cut, -y4_cut], [x3_cut, -y3_cut], [x2_cut, -y2_cut], [x1_cut, -y1_cut]];
    
    rotate([0, -90, 0])
    linear_extrude(height = w_cut + clearance_fit, convexity = 10, center = true)
    polygon(poly_cut);
    
    rotate([0, -90, 90])
    linear_extrude(height = w_cut + clearance_fit, convexity = 10, center = true)
    polygon(poly_cut);
    
    translate([0, 0, x1_cut])
    cylinder(d = d_cut + clearance_fit, h = x4_cut - x1_cut);
}

module plunger_body() {
    printer_tweak=0.2;
    max_size=100.0;
    difference() {
        rotate_extrude(convexity=10)
        rotate([0, 0, 90])
        intersection() {
            offset(-printer_tweak) {
                plunger_section();
                mirror([1, 0, 0]) plunger_section();
            }
            square(max_size);
        }
        plunger_cut();
    }
}

//plunger_body();
// not truncated
