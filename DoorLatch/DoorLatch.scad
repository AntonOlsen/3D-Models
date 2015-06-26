// Distance between knobs, inside and outside.
dist_in   = 55;
dist_out  = 90;
diameter = 20;

hole_d = diameter;

echo ( diameter);

lock_x = dist_out + diameter*2; // Outside distance plus 2x knob diameter
lock_y = diameter*1.75;         // Almost twice as tall as the hole diameter
lock_z = 4;                      // Thickness of the lock.

difference() {

	minkowski() {
		cube ([ lock_x, lock_y, lock_z ], center=true );    // Draw a cube
        cylinder( r=4, h=0.1, center=true );                // Round the corners
	}

    for (x = [-1, 1] ) {                       // Make two of these
        translate( [ x*dist_in/2, 0, 0] )       // Move each one in opposite directions
        union() {
            hull() {
                for( offset = [5,0] )                                // Make 2 of these
                    translate( [ x*hole_d/2 + x*offset, 0, 0 ] )    // Move one hole left/right of center and the other 5 more mm 
                        cylinder( r=hole_d/2, h=lock_z+1, center=true ); 
            }
        
            translate( [ x*diameter/2, -lock_y/2, 0] )               // Move the slot just left or right of center
                cube( [ hole_d, lock_y, lock_z+2], center=true );   // Slot to slip over the knob.
        }
    }
}

//cube( [90, 20, 20], center=true );