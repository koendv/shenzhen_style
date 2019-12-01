include <param.scad>;
 
/* knurled threaded insert. can be printed upside down. */ 
 
module threaded_insert(insert_top_dia, insert_bottom_dia, insert_length, taper_angle /* degrees*/,screw_hole_dia, screw_hole_length) {
    // in blind holes, screw hole is at least 0.75mm longer than insert length.
    added_length = 0.75;
    new_insert_length = insert_length + added_length;
    
    // hole for insert proper
    translate([0, 0, -eps1])
    cylinder(d = insert_bottom_dia, h = new_insert_length + eps2);
    
    // tapered hole
    translate([0, 0, -eps1])
    intersection() {
        cylinder(d = insert_top_dia, h = new_insert_length + eps2);
        cone_height = insert_top_dia/2 * tan(90.0-taper_angle/2.0);
        cylinder(d1 = insert_top_dia, d2 = 0, h = cone_height + eps2);
    }
    
    // cone with 45 degree slope allows fdm printing even when upside-down
    translate([0, 0, new_insert_length])
    cylinder(d1 = insert_bottom_dia, d2 = eps1, h = insert_bottom_dia/2);
    
    // screw hole.
    
    min_screw_hole_length = max(screw_hole_length, insert_length + 1.0);
    translate([0, 0, -eps1])
    cylinder(d = screw_hole_dia, h = min_screw_hole_length + eps2); 
    // cone with 45 degree slope allows fdm printing even when upside-down
    translate([0, 0, min_screw_hole_length])
    cylinder(d1 = screw_hole_dia, d2 = eps1, h = screw_hole_dia/2.0);
}


/* hole for M3 threaded knurled brass insert. Can be printed upside down.
  The optional parameter is the length of the screw */

module m3_threaded_insert(length = 0.0) {
    // to adapt this code to a new threaded insert:
    // measure insert top diameter, bottom diameter, and insert length with a caliper.
    // adjust insert_top_dia, insert_bottom_dia, and insert_length in the code.
    
    // Insert models. Uncomment one.
    
    // Chinese no-name M3 x D5.0 x L6.0
    // https://www.aliexpress.com/item/32842432056.html
    // https://www.aliexpress.com/item/4000232858343.html
    // check insert top diameter, bottom diameter, and insert length with a caliper before using.
    threaded_insert(insert_top_dia = 5.0 + tweak_insert, insert_bottom_dia = 4.0 + tweak_insert, insert_length = 6.0, taper_angle = 8.0, screw_hole_dia = 3.5, screw_hole_length = length);

    // Mc-Master 94180A333
    // https://www.mcmaster.com/94180a333
    // E-Z LOK DV-M30-TH
    // https://www.amazon.com/initeq-M3-0-5-Threaded-Inserts-Printing/dp/B077CGVS7Y
    //threaded_insert(insert_top_dia = 5.6 + tweak_insert, insert_bottom_dia = 4.8 + tweak_insert, insert_length = 6.4, taper_angle = 8.0, screw_hole_dia = 3.5, screw_hole_length = length);
    
}

//m3_threaded_insert();
//m3_threaded_insert(length = 10.0);

// not truncated
