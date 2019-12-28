// Syringe specs
// 10 cc Nordson-EFD 7012007 with white piston 7012024

syringe_volume = 10.0; // ml (or cc)
syringe_flange_dia = 30.35;
syringe_flange_thickness = 3.57;
syringe_ext_dia = 19.05;
syringe_int_dia = 16.27;
syringe_barrel_length = 91.20;
syringe_empty_length = 82.25; // 73.2 mm max. plunger movement
syringe_luer_dia = 11.13;

module plunger_section() {
    x0=16.1465;y0=1.34576;x1=13.7661;y1=4.28534;
    x2=9.29141;y2=0.54265;r2=5.83660;
    x3=8.96191; y3=8.46136; r3=2.08663;
    y4=7.10665;
    x5=0.48099; y5=8.02211; r5=1.05385;
    x6=1.5; // base height

    translate([x6,0]) {
        intersection() {
            hull() {
                translate([x0, 0])
                square(size=[eps1, 2*y0], center = true);
                translate([x2, y2])
                circle(r = r2);
                square(size=[x3, y3-r3]);
                }
            square(size=[x0, y4]);
        }   
        
        difference() {
            square(size=[x3, y4]);    
            translate([x3, y3]) circle(r = r3);
            translate([x5, y5]) circle(r = r5);
        }
    }
    square([x6+eps1, y4]);
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

//plunger_section();
//plunger_body();
// not truncated
