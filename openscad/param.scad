// process variables

clearance_fit = 0.4;      // approx. 2 x layer z height
tight_fit = 0.2;          // approx. half clearance fit
tweak=0.2;                // tweak for fdm printer with 0.4mm nozzle
tweak_insert=0.2;         // tweak threaded insert hole to compensate for printer tolerance. bigger value = bigger hole.
min_wall_thickness = 2.0; // minimum desired wall thickness, conservative value
chamfer = 0.5;            // chamfer to avoid fdm elephant's foot

// general variables
//$fn = 128; // high resolution for rendering
$fn = 32; // low resolution when designing
eps1 = 0.001; // "epsilon", small value to avoid collisions
eps2 = 2 * eps1;

// Choose syringe model
include <syringe-10cc-generic.scad>;
//include <syringe-10cc-bd.scad>;
//include <syringe-10cc-nordson-wiper.scad>;

// Choose canstack stepper model
// Robotdigg NC35-BYZ-120
// https://www.robotdigg.com/product/1147/12V-35-captive-or-non-captive-linear-pm-stepper-motor
include <stepper-robotdigg-35-byz.scad>

// body dimensions
body_height = 15.0;

// syringe holder
syringe_holder_base_height = 3.0;
syringe_holder_total_height = 6.0;

// adapter for cnc3018
cnc_zcarriage_dia1 = 45.0; // diameter of spindle hole. Common values: 45mm, 52mm.
cnc_zcarriage_h1 = 40.0;   // height

// not truncated
