// 5 cc Nordson-EFD 7012010 with piston 7017807 with wiper

syringe_volume = 5.0; // ml (or cc)
syringe_flange_dia = 28.58;
syringe_flange_thickness = 3.8;
syringe_ext_dia = 15.05;
syringe_int_dia = 13.20;
syringe_barrel_length = 70.35;
syringe_empty_length = 61.25; // max. piston movement 53.50
syringe_luer_dia = 11.14;

module plunger_body() {
        
    r1 = syringe_int_dia/2 - clearance_fit;
    r2 = 5.73246 - tweak;
    h1 = 7.0;
     
    translate([0, 0, h1 - tweak - eps1])
    rotate_extrude()
    difference() {
    offset(-tweak)
        polygon([[5.73246, 0.0], [5.10922,7.0264], [2.30638,8.45819], [-2.30638,8.45819], [-5.10922,7.0264], [-5.73246, 0.0]]);
        square([10, 10]);
    }

    cylinder(r1 = r1, r2 = r2, h = h1 + eps1);
    
}

//plunger_body();
// not truncated
 
