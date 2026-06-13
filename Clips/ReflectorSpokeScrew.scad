include <Chamfers-for-OpenSCAD/Chamfer.scad>;

$fn = 256;

difference() {
    union() {
        cylinder(h=11, d=9.5);
        difference() {
            cylinder(h=3, d=13);
            cut_wedge();
            translate([3,-2.5,1])
                rotate([90,0,90])
                    ridges();
            translate([-3,2.5,1])
                rotate([90,0,270])
                    ridges();
        }

    }
    translate([-1.5,-7,-0.1]) // main vertical cut
        chamferCube([3,14,6.1], chamfers = [[0,0,0,0],[0,1,1,0],[0,0,0,0]], ch = 0.7);
    translate([-1,-5,9.1]) // top screwdriver cut
        cube([2,10,2]);
    translate([0,-8.9,4])
        chamferCube([10, 10, 2], chamfers = [[0,1,1,0],[0,0,0,0],[0,0,0,0]], ch = 0.7);
    translate([-10,-1.1,4])
        chamferCube([10, 10, 2], chamfers = [[1,0,0,1],[0,0,0,0],[0,0,0,0]], ch = 0.7);
    rotate([0,0,17])
        translate([-7, 3.85, -1]) // Flat side
            cube([14,2,14]);
}

//cut_wedge();


module wedge() {
    translate([0,0,-0.1]){
        linear_extrude(height = 3.2) {
            polygon([[0,0],[12,7],[12,10],[-12,10],[-12,7]]);
        }
        linear_extrude(height = 3.2) {
            polygon([[0,0],[-12,-7],[-12,-10],[12,-10],[12,-7]]);
        }
    }
}

module cut_wedge() {
    translate([0,0,-0.05]){
        linear_extrude(height = 3.2) {
            polygon([[0,0],[3,3],[7,2.3],[12,7],[12,10],[-12,10],[-12,7],[-7,2.3],[-3,3]]);
        }
        linear_extrude(height = 3.2) {
            polygon([[0,0],[-12,-7],[-12,-10],[12,-10],[12,-7]]);
        }
    }
}

module ridges() {
    linear_extrude(height= 5) {
        polygon([[-1,0],[1,0.8],[1,0.2],
                 [3,1],[3,0.4],[6,1.4],
                 [6,4],[-1,6],[-1,0.7]]);
    }
}