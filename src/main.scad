$fn = 100;

include <helpers.scad>;

// NOTE: all measurements in this file are in millimeters!

// --------------------------
// ----- Tray Settings -----
// --------------------------

// tray width (size in the x-dimension)
tray_width = 698;

// tray height (size in the y-dimension)
tray_height = 240;

// tray thickness, only relevant for the preview in OpenScad, since the output is a 2D DXF for lasercutting
tray_thickness = 3;

// the "roundness" of the corners
corner_radius = 14;

// --------------------------
// ----- Screw Settings -----
// --------------------------

// diameter of the screw hole, note that this does not take the head of the screw into account
// the wells for countersunk screws are not modelled and need to be drilled manually if desired
screw_hole_diameter = 4.8; // M5, but cut slightly smaller to compensate for laser cutter kerf

// horizontal distance between the four mounting screws
screw_distance_horizontal = 78;

// vertical distance between the four mounting screws
screw_distance_vertical = 101.6;

// the distance between the top of the tray, and the top mounting screws (measured from top edge of tray to center of topmost screwhole)
screw_cluster_distance_from_top = 24;

// by default the mounting screws are horizontally centered on the tray, change this to shift them left or right
// provide a negative value to shift the holes left (creating more space to the right of the mounting holes)
// provide a positive value to shift the holes right (creating more space to the left of the mounting holes)
// set this to 0 to keep the mounting holes centered
screw_cluster_offset_horizontal = -70;

// --------------------------
// ----- Implementation -----
// --------------------------

{
    screw_cluster_x = (tray_width/2) - (screw_distance_horizontal/2) + screw_cluster_offset_horizontal;
    screw_cluster_y = tray_height - screw_cluster_distance_from_top - screw_distance_vertical;
    projection() {
        difference() {
            tray(tray_width, tray_height, tray_thickness, corner_radius);
            translate([screw_cluster_x, screw_cluster_y, 0]) {
                mounting_holes(screw_hole_diameter, screw_distance_horizontal, screw_distance_vertical);
            }
        }
    }
}



module tray(tray_width, tray_height, tray_thickness, corner_radius) {
    wood() rounded_plate(tray_width, tray_height, tray_thickness, corner_radius);
}

module mounting_holes(hole_diameter, distance_horizontal, distance_vertical) {
    hole_height = 10;
    union() {
        cylinder(d=screw_hole_diameter, h=hole_height, center=true);
        translate([distance_horizontal, 0, 0]) cylinder(d=hole_diameter, h=hole_height, center=true);
        translate([0, distance_vertical, 0]) cylinder(d=hole_diameter, h=hole_height, center=true);
        translate([distance_horizontal, distance_vertical, 0]) cylinder(d=hole_diameter, h=hole_height, center=true);
    }
}
