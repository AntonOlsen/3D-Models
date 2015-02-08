platform_thickness = 10;
platform_h=9;

inset = 6;

cone_height=3.0;
m3_washer_width=0.55;
m3_screw_head_dia = 5.5;
m3_screw_head_h = 2.3;
m3_nut_width = 2.3;
ball_collar_width = 8.1;
cutout = ball_collar_width + 2*m3_washer_width + 2*cone_height; 

//myplatform();


$fn=16;


// One side. Use for carriage, or rotate 3x for platform
module oneside() {
	difference() {
	union() {

		// One bar with cutout
		difference() {
			translate( [0,-27,platform_h/2] )
				cube( [76,14,platform_h], center=true );

			translate( [ -28,-46, -.25 ] )
			minkowski() {
				cube([56,16.5, (platform_h/2)+.5]);
				cylinder(r=4,h=(platform_h/2)+.5);
			}


//			translate( [-22,-34,0] )
//				cylinder( r=10, h=platform_h+10, center=true );
//			translate( [22,-34,0] )
//				cylinder( r=10, h=platform_h+10, center=true );

//			translate( [0,-29,platform_h/2] )
//				cube( [40,10,platform_h+1], center=true );
		}



	   // Bolt Cylinders
		translate( [ 35,-34, platform_h/2] )
			rotate( [0,90,0] )
				cylinder( r=(platform_h/2), h=6, center=true );
		translate( [-35,-34, platform_h/2] )
			rotate( [0,90,0] )
				cylinder( r=(platform_h/2), h=6, center=true );

	   // Bolt Cones
		translate( [ 31,-34, platform_h/2] )
			rotate( [0,-90,0] )
				cylinder( r1=(platform_h/2), r2=(platform_h/2)-1, h=4, center=true );
		translate( [-31,-34, platform_h/2] )
			rotate( [0,90,0] )
				cylinder( r1=(platform_h/2), r2=(platform_h/2)-1, h=4, center=true );
	}

	// Subtract all this from one side.
	union() {
		// Bore the hole for the bolts
		translate([-45,-34, platform_h/2])
			rotate( [0,90,0] )
			cylinder( r=1.5, h=99 );
	}
	}
}



module mycenter() {
	// Large center hollow cylinder
	difference() {
		translate( [0,0,platform_h/2] )
			cylinder( r=30, h=platform_h, center=true );
		translate( [0,0,platform_h/2] )
			cylinder( r=20, h=platform_h+.5, center=true );
	}
}


module myplatform() {
	for (z = [0,120,240] ) {
		rotate( [0,0,z] )
			difference() {
			union() {
				// One side bar with cutout, cones, and bolt hole		
				oneside();
				mycenter();

				// Corner cylinders
				translate( [-38,-22,0] )
					cylinder( r=6, h=platform_h );

				// Corner cylinders
				translate( [-27,-16,0] )
					cylinder( r=9, h=platform_h );
			}

			// Everything we cut out of the oneside
			union() {
				// Corner cylinders, outer
				translate( [-38,-22,-0.1] )
					cylinder( r=4, h=platform_h+2 );
				translate( [ 38,-22,-0.1] )
					cylinder( r=4, h=platform_h+2 );

				// Corner cylinders, inner
				translate( [-27,-16,-0.1] )
					cylinder( r=6, h=platform_h+2 );
				// Corner cylinders
				translate( [ 27,-16,-0.1] )
					cylinder( r=6, h=platform_h+2 );

				// Hotend mounting holes
				for ( a = [0,60,120,180,240,300] ) {
					rotate( [0,0,a+30] )
					translate( [0,-25,0] )
						cylinder( r=2, h=99, center=true );
				}

				// Drillium holes
				for ( a = [0,60,120,180,240,300] ) {
					rotate( [0,0,a] )
					translate( [0,-25,0] )
						cylinder( r=4, h=99, center=true );
				}

			}
			}

	}
}




//translate( [0,0,10] )
//	myplatform();

//oneside();
