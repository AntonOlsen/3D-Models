// Tablet dimensions
// Acer Switch 11
tablet_x     = 313;	// Width in stand
tablet_y     =  12;   // Thickness of tablet
tablet_z     = 192;   // Height in stand

max_printbed = 150;	// Max comfortable printbed size, allow for perimeters

if (0) {
	tablet();
}

rotate( [0,90,0] )		// Lay it down so it can print in the strong direction
	difference() {
		holder();
		tablet();
	}

module holder() {
	difference() {

		// Combines a cube and a cylinder to round off the corners.
		minkowski() {
			// Base size of the cube of the holder
			cube( [tablet_x/3,tablet_y,tablet_z+5], center=true );
			// The cube above will grow by 2x the radius of the corner
			rotate([0,90,0])
				cylinder(r=5,h=1);
		}

		// Cut out face
		translate([0,-5,0])
			cube( [tablet_x/3+10,tablet_y+1,tablet_z-15], center=true );

		// Nail cutout
		translate([0,0,tablet_z/3])
			rotate( [-45,0,0] )
			scale([1.5,1,1])
				rotate( [0,45,0] )
					cube( [10,50,10], center=true );

		// Screw holes
		translate([0,0,tablet_z/3+10])
		rotate([0,90,90])
			cylinder( r=2, h=50, center=true );
		translate([0,0,-tablet_z/3+10])
		rotate([0,90,90])
			cylinder( r=2, h=50, center=true );
	}
}


// used to subtract from the circle
module tablet() {
	color( "red" )
	cube( [ tablet_x, tablet_y, tablet_z ], center=true );
}