#!/bin/bash -x
OPENSCAD=openscad

# number of fragments when rendering a circle 
FN=128

#rm -f assembly-drawing.png assembly.stl body.stl plunger.stl plunger_tip.stl syringe_holder.stl

$OPENSCAD -o $PWD/../stl/body.stl -Dmodel=1 -D\$fn=$FN $PWD/generate.scad
$OPENSCAD -o $PWD/../stl/syringe_holder.stl -Dmodel=2 -D\$fn=$FN $PWD/generate.scad
$OPENSCAD -o $PWD/../stl/plunger.stl -Dmodel=3 -D\$fn=$FN $PWD/generate.scad
$OPENSCAD -o $PWD/../stl/insert-practice.stl -Dmodel=4 -D\$fn=$FN $PWD/generate.scad
$OPENSCAD -o $PWD/../stl/cnc3018_adapter.stl -Dmodel=5 -D\$fn=$FN $PWD/generate.scad
$OPENSCAD -o $PWD/../stl/assembly.stl -Dmodel=10 -D\$fn=$FN $PWD/generate.scad
$OPENSCAD -o $PWD/../doc/assembly-drawing.png -Dcut=false -Dmodel=11 -D\$fn=$FN $PWD/generate.scad
#not truncated
