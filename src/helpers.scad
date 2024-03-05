module rgb(r, g, b, a = 1) {
	color([r/255, g/255, b/255], a) children();
}

module silver() { rgb(250, 250, 250) children(); }
module aluminum() { rgb(205, 205, 205) children(); }
module white() { rgb(255, 255, 255) children(); }
module black() { rgb(0, 0, 0) children(); }
module yellow() { rgb(255, 255, 0) children(); }
module blue() { rgb(0, 0, 255) children(); }
module wood() { rgb(240, 200, 150) children(); }

// helper for square plate with rounded corners
module rounded_plate(length, width, height, corner_radius) {
	hull(){
		translate([corner_radius, corner_radius, height/2]) cylinder(r=corner_radius, h=height, center=true);
		translate([length - corner_radius, corner_radius, height/2]) cylinder(r=corner_radius, h=height, center=true);
		translate([corner_radius, width - corner_radius, height/2]) cylinder(r=corner_radius, h=height, center=true);
		translate([length - corner_radius, width - corner_radius, height/2]) cylinder(r=corner_radius, h=height, center=true);
	}
}