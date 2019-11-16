include <param.scad>
include <util.scad>
include <assembly.scad>
include <insert-practice.scad>

model = 10; // overridden in generate.sh
if (model == 1)
    body();
else if (model == 2)
    syringe_holder();
else if (model == 3)
    plunger();
else if (model == 4)
    insert_practice();
else if (model == 10)
    assembly();
else if (model == 11) {
    $vpd=700;
    $vpr=[90, 0, 90];
    $vpt=[0, 0, 0];
    assembly();
    };

// not truncated
