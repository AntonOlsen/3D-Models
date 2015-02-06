// Tablet dimensions
tablet_x     = 313;     // Width in stand
tablet_y     =  11.5;   // Thickness of tablet
tablet_z     = 198;     // Height in stand

tablet_angle = 25;      // Angle of tablet in stand

circle_od = tablet_z  * 0.75;	// TODO: Use geometry to calc this
circle_id = circle_od * 0.9;
circle_h  = tablet_y * 2.5;

circle_sides = 5;
$fn=circle_sides;

//	tablet();

difference() {
	circle();
	tablet();
}

module circle() {
	translate( [0, -circle_od/4, circle_h/2] )
	rotate([0,0,-(360/circle_sides)/4])			// Useful for 5 sides only
	difference() {
		cylinder(r=circle_od/2, h=circle_h, center=true);
		cylinder(r=circle_id/2, h=circle_h+1, center=true);
	}
}

// used to subtract from the base
// includes USB and power plugs as well as a channel and hole for the wires
module tablet() {
	translate( [0,0,circle_h/3] )		// Lift the tablet 1/3 of the stand
		rotate( [tablet_angle,0,0] )	// Tip the tablet back
			translate( [0,0,tablet_z/2] )
				cube( [ tablet_x, tablet_y, tablet_z ], center=true );
}








