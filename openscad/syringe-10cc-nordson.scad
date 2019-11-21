// Syringe specs

// 10 cc Nordson-EFD 7012007 with white piston 7012024
// XXX check data

syringe_model = 2;
syringe_volume = 10.0; // milliliter (or cc)
syringe_flange_dia = 29.97;
syringe_flange_thickness = 3.0;
syringe_ext_dia = 18.53;
syringe_int_dia = 15.53;
syringe_barrel_length = 90.68;
syringe_empty_length = 80.68;
syringe_luer_dia = 10.67;

/* The ubiquitous white piston in glue dispenser syringes */
module piston() {
    dx = 7.92;
    dz = 17.37;
   
    translate([0, 0, dz])
    rotate([90, 0, 0])
    translate([-dx, 0, -dx])
    mirror([0, 1, 0])
    import ("NORDSONEFD-7012024 PISTON O 10CC WH WIPER.STL"); // https://www.3dcontentcentral.com/Search.aspx?arg=7012024%20piston
}

// Plunger for 10cc pneumatic glue dispenser syringe. "US style"
// 10 cc Nordson-EFD 7012007 with piston 7012024

module plunger_body() {
    fit = 0.2; // tweak for printer. fit = 0 gives outline of rubber seal
    r1 = 1.45; // curvature of tip
    h1 = 6.00; // vertical offset r1 wrt. center sphere r2
    r2 = 6.30; // curvature of body
    h2 = 9.00; // height body.
    chamfer = 0.5; // chamfer at bottom

    // cross cut out in piston top
    h4 = 6.40; // cut-off wrt. center sphere r2
    h_cut = 8.0; // cut depth
    d_cut = 2.0; // diameter of central hole
    w_cut = 0.5; // cut width
    
    difference() {
        union() {
            // plunger top
            hull() {
                translate([0, 0, h1 + h2])
                sphere(r = r1 - fit);
                
                translate([0, 0, h2])
                sphere(r = r2 - fit);
            }
            // plunger cylindrical body
            translate([0, 0, chamfer])
            cylinder(r = r2 - fit, h = h2 - chamfer + eps2);
            // chamfer at bottom
            cylinder(r1 = r2 - fit - chamfer, r2 = r2 - fit, h = chamfer + eps2);
        }
        
        translate([0, 0, h2 - fit - eps1]) {
             // cut off top
            translate([0, 0, h4])
            cylinder(r = r2, h = h1);
            // cross cut out in plunger top. slightly wider at top than at bottom
            cylinder(d1 = d_cut + tight_fit, d2 = d_cut + clearance_fit, h = h4 + eps2);
            
            hull() {
                translate([0, 0, h4 + eps2])
                cube([w_cut + clearance_fit, 2 * r2, eps1], center = true);
                cube([w_cut + tight_fit, 2 * r2, eps1], center = true);
            }
            
            hull() {
                translate([0, 0, h4 + eps2])
                cube([2 * r2, w_cut + clearance_fit, eps1], center = true);
                cube([2 * r2, w_cut + tight_fit, eps1], center = true);
            }

        }
        
        // hole through plunger so we can remove rubber cap with a paperclip if it gets stuck
        cylinder(d = d_cut + tight_fit, h = h2 + h4 + eps2);
        
    }
}

// compare plunger with piston
if (0) {
    cutout() plunger_body();
    cutout() %piston();
}

// not truncated
