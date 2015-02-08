// Tablet dimensions
// Samsung Galaxy Note 3
tablet_x     = 155;   // Width
tablet_y     =  11;   // Thickness of tablet
tablet_z     =  82;   // Height in stand

// Acer Switch 11
tablet_x     = 313;	// Width in stand
tablet_y     =  12;   // Thickness of tablet
tablet_z     = 198;   // Height in stand

// Kindle Paperwhite
tablet_x     = 120;	// Width in stand
tablet_y     =   9;   // Thickness of tablet
tablet_z     = 170;   // Height in stand

tablet_angle = 25;    // Angle of tablet in stand

max_printbed = 150;	// Max comfortable printbed size, allow for perimeters

// Make the circle roughly equal to the base of a right triangle with 
// a hypotenuse of tablet_z and angle a of tabler_angle
calculated_od = (tablet_z / sin(90)) * sin( 90-tablet_angle);
minimum_od = tablet_x;

circle_od = min( calculated_od, max_printbed, minimum_od );
echo( tmp_od );

circle_id = min( circle_od * 0.95, circle_od-4 );  // No thinner than 4mm
circle_h  = min( tablet_z  / 6,    25);            // No taller than 1 inch 

circle_sides = 5;
$fn=circle_sides;

if (0) {
	tablet();
}

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

// used to subtract from the circle
module tablet() {
	translate( [0,0,circle_h/2.5] )	// Lift the tablet 1/3 of the stand
		rotate( [tablet_angle,0,0] )	// Tip the tablet back
			translate( [0,0,tablet_z/2] )
				cube( [ tablet_x, tablet_y, tablet_z ], center=true );
}








