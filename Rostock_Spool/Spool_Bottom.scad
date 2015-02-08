$fn=32;

// top
// wide  = 42
// thick = 5.8

rail_w = 42;
rail_h = 5.8;

// Push Plastics: 50mm
// Others: 38mm


spool_hub_id = 80;
spool_hub_h  = 30;

bearing_od = 23;
bearing_id = 8;
bearing_h =  7;

base_clearance = 20; // Bottom of bearing to clip bar


cone_h  = base_clearance + (cone_center_h*2);


module semicircle() {
	difference() {
		cylinder( r=(rail_h/2)+4, h=20, center=true );
		cylinder( r=(rail_h/2),   h=22, center=true );
		translate( [ 0, (rail_h), 0 ] )
			cube( [ rail_h*4, rail_h*2, 22 ], center=true);
	}
}


module ess() {
	translate( [rail_h/2+2,0,0] )
		semicircle();
	translate( [rail_h*2+2,-3,0] )
		rotate( [0,0,180] )
			semicircle();
}


module clip() {
	translate( [0,-rail_w/2,0] )
		union() {
			ess();
			translate( [0,rail_w/2,0] )
				cube( [4,rail_w,20], center=true );
			translate( [0,rail_w,0] )
				rotate( [180,0,0] )
					ess();
		}
}


module SpoolBase() {
	clip();
	// Bearing pin
	translate( [-(base_clearance+bearing_h)/2,0,0] )
		rotate( [0,90,0] )
			cylinder( r=3.8, h=base_clearance+bearing_h, center=true );
	// Center base pin
	translate( [-base_clearance/2,0,0] )
		rotate( [0,90,0] )
			cylinder( r=6, h=base_clearance, center=true );
	// support
	translate( [-(base_clearance+bearing_h)/2,0,-5])
		cube( [base_clearance+bearing_h,1,10], center=true );
}

//rotate( [0,90,0] )
//	SpoolBase();




module spindle_bar( l_id=1, l_h=1, lip=0 ) {

	difference() {
		union() {
			intersection() {
				// Center Bar
				translate( [-base_clearance-bearing_h,0,0] )
					cube( [bearing_h, spool_hub_id, 20], center=true );

				// Constrain the bar to the diameter of the spool_hub
				rotate( [0,90,0] )
					cylinder( r=spool_hub_id/2, h=99, center=true );
			}

			intersection() {
				translate( [-base_clearance-(bearing_h/2)-1,0,0] )
					cube( [bearing_h/4, spool_hub_id*lip+10, 20], center=true );
				rotate( [0,90,0] )
					cylinder( r=(spool_hub_id*lip)/2, h=99, center=true );
			}
		}

		// Large Cutout - OD of Bearing
		translate( [-base_clearance-(bearing_h/2),0,0] )
			rotate( [0,90,0] )
				cylinder( r=((bearing_od/2)+0.05)*l_id, h=bearing_h*l_h, center=true );

		// Small Cutout - So top of shaft doesn't rub on bar
		translate( [-base_clearance-bearing_h,0,0] )
			rotate( [0,90,0] )
				cylinder( r=(bearing_id/2)+0.25, h=bearing_h*2, center=true );
	}
}

translate( [ -base_clearance-(bearing_h/2)+4, (bearing_od/2)+2.5, 0 ] )
	cube( [15,3,20], center=true );
translate( [ -base_clearance-(bearing_h/2)+4, -(bearing_od/2)-2.5, 0 ] )
	cube( [15,3,20], center=true );
//	rotate( [180,0,0] )		
//		ess();
//translate( [ -base_clearance-(bearing_h/2)-4, -(bearing_od/2+2), 0 ] )
//	rotate( [0,0,0] )
//		ess();

spindle_bar();
translate( [base_clearance-(bearing_h/2),0,0] )
	spindle_bar(l_id=0.66, l_h=4, lip=1.3);
