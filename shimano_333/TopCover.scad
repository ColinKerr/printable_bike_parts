include <Chamfers-for-OpenSCAD/Chamfer.scad>;

$fn = 64;

module circle_text(text, size, height, radius, start_angle, char_spacing) {
    length = len(text);
    for(a=[0:length]) {
        rotate([0, 0, length / (2 * 10) - (a * char_spacing) + start_angle])
        translate([2 * radius, 0, 0])
        linear_extrude(height)
        rotate([0, 0, -90])
        text(text[a], size, font = "Liberation Mono:style=Bold", halign = "center", valign = "bottom", spacing = 1, direction = "ltr", $fn = 100);
    }
}

module create_shell (includeTab, chamfer) {
    hull() {
        hull () {
            translate([0,0,-7]){
                chamferCylinder(14, 20, 20, ch = 0, ch2 = chamfer);
            }
            translate([-28, -2, -7]) {
                chamferCube([28, 22, 14], chamfers = [[0,0,1,0],[0,0,0,0],[0,0,0,0]], ch = chamfer);
            }
        }
        if (includeTab) {
            translate([-38, 5, -7]) {
                chamferCube([10, 15, 14], chamfers = [[0,0,1,1],[0,0,0,0],[0,0,0,1]], ch = chamfer);
            }
        }
    }
}

module create_inner_support () {
    difference () {
        translate ([0, 0, 2]) {
            difference () {
                cylinder(3.5, 13.5, 16);
                translate ([0, 0, .5]) {
                    cylinder(1.4, 9.3, 9.3, center = true);
                    cube([30, 4.8, 1.4], center = true);
                }
            }
        }

    }
}

module create_skirt_cutout () {
    translate([-5, 0, -9]) {
        cube([30, 30, 10]);
    }
    translate([5, -20, -9]) {
        cube([30, 30, 10]);
    }
}

module create_cable_hole () {
    translate ([-27, 12, 1]) {
        rotate([0, -90, 0]) {
            cylinder(30, 2.95, 2.95);
            translate([0, 0, -3]){
                cylinder(50, 1, 1);
            }
            translate([-11, -0.75, -3]){
                cube([11, 1.5, 30]);
            }
        }
    }
}

module create_text () {
    translate([0, 0, 6.1]) {
        circle_text("321", 6, 1, 5, 70, 40);
    }
}

difference () {
    union () {
        difference () {
            create_shell(true, 1);
            translate ([0, 0, -1.5]) {
                scale ([0.9, 0.9, 1]) {
                    create_shell(false, 0);
                }
            }
        }
        create_inner_support();
    }
    // Create screw hole
    cylinder(30, 2.65, 2.65, center = true);
    
    create_skirt_cutout();
    create_cable_hole ();
    create_text();
}



