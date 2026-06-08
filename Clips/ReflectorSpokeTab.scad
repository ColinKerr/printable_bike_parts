include <Chamfers-for-OpenSCAD/Chamfer.scad>;

$fn = 256;

chamfer = 1;

difference() {
    hull(){
        chamferCylinder(5, 4.5, 4.5, 0, chamfer);
        translate([-4.5,0,0]){
            chamferCube([9,6.5,5], chamfers = [[0,0,1,0],[0,1,1,0],[0,0,1,1]], ch = chamfer);
        }
    }
    translate([0,0,-0.5]) cylinder(h=6, d=3.8);
    translate([0,0,-0.01])cylinder(h=0.3, d1=4.3, d2=3.8);
    rotate([90,0,90]) 
        translate([3.9,0.4,-5]) {
            cylinder(h=10, d=2);
            translate([-1,-2,0])
                cube([2,2,10]);
            }
}