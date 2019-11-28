// Syringe specs
    
// 10 ml BD luer lok
syringe_volume = 10.0; // milliliter (or cc)
syringe_flange_dia = 28.0;
syringe_flange_thickness = 1.9;
syringe_ext_dia = 16.2;
syringe_int_dia = 14.4;
syringe_barrel_length = 106.0;
syringe_empty_length = 95.2;
syringe_luer_dia = 9.3; // more or less

/* 
 * Plunger for BD 10cc "Luer Lok". Plunger fits in black rubber seal.
 * Note plunger has an M3 threaded knurled brass insert.
 */
 
module plunger_body() {
    plunger_dia0 = 12.0;
    plunger_h0 = 0.5;
    
    plunger_dia1 = 13.0;
    plunger_h1 = 8.0;     

    plunger_dia2 = 13.0;  
    plunger_h2 = 4.5;
    
    plunger_dia3 = 8.5;
    plunger_h3 = 1.0;
    
    plunger_dia4 = 8.5;
    plunger_h4 = 0.75; // 69 degree overhang  
    
    plunger_dia5 = 12.5;
    plunger_h5 = 1.6;
    
    plunger_dia6 = 12.5;
    plunger_h6 = 1.4;
    
    plunger_dia7 = 5.0;

    cylinder(d1 = plunger_dia0, d2 = plunger_dia1, h = plunger_h0 + eps1);

    translate([0, 0, plunger_h0]) 
    cylinder(d1 = plunger_dia1, d2 = plunger_dia2, h = plunger_h1 + eps1);

    translate([0, 0, plunger_h0+plunger_h1]) 
    cylinder(d1 = plunger_dia2, d2 = plunger_dia3, h = plunger_h2 + eps1);    
    
    translate([0, 0, plunger_h0+plunger_h1+plunger_h2]) 
    cylinder(d1 = plunger_dia3, d2 = plunger_dia4, h = plunger_h3 + eps1);
    
    translate([0, 0, plunger_h0+plunger_h1+plunger_h2+plunger_h3]) 
    cylinder(d1 = plunger_dia4, d2 = plunger_dia5, h = plunger_h4 + eps1);
    
    translate([0, 0, plunger_h0+plunger_h1+plunger_h2+plunger_h3+plunger_h4]) 
    cylinder(d1 = plunger_dia5, d2 = plunger_dia6, h = plunger_h5 + eps1);    
 
    translate([0, 0, plunger_h0+plunger_h1+plunger_h2+plunger_h3+plunger_h4+plunger_h5]) 
    cylinder(d1 = plunger_dia6, d2 = plunger_dia7, h = plunger_h6 + eps1);

}

// not truncated
