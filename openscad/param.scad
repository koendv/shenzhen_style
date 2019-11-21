// process variables

clearance_fit = 0.5;
tight_fit = 0.2;
min_wall_thickness = 2.0; // minimum desired wall thickness, conservative value
chamfer = 0.5;

// general variables
//$fn = 128; // high resolution for rendering
$fn = 32; // low resolution when designing
eps1 = 0.001; // "epsilon", small value to avoid collisions
eps2 = 2 * eps1;

// Choose syringe model
//include <syringe-10cc-bd.scad>;
include <syringe-10cc-nordson.scad>;

// Choose canstack stepper model
// Robotdigg NC35-BYZ-120
// https://www.robotdigg.com/product/1147/12V-35-captive-or-non-captive-linear-pm-stepper-motor
include <stepper-robotdigg-35-byz.scad>

// body dimensions
body_height = 15.0;

// syringe holder
syringe_holder_base_height = 3.0;
syringe_holder_total_height = 6.0;

// not truncated
