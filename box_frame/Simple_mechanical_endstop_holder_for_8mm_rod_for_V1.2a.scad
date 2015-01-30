rodDiameter = 8;
mainWall = 4;
height = 10;
endstopSpacing = 19;
endstopSpacing2 = 11;

module mainCurve(rod = 8, wall = 4, h = 10) {
	extra = 0.5;
	curveWall = wall - extra;
	innerRad = rod/2;
	outerRad = (innerRad + curveWall);
	difference() {
		union() {
			cylinder(h=h, r = outerRad, $fn=50);
			translate([-outerRad,0,0]) cube([2*outerRad,outerRad,h]);
		}
		translate([0,0,-0.1]) cylinder(h=(h+0.2), r = innerRad, $fn=30);
		translate([-innerRad+extra, 0, -0.1]) cube([rod-2*extra, outerRad+0.1, (h+0.2)]);
	}
}

module leg(length = 32, thickness = 4, h = 10) {
	wallThickness = thickness - 0.5;
	cube([thickness, length, h]);
	translate([thickness/2, length, 0]) cylinder(h=h, r=(thickness/2), $fn=20);
}

module m3withTolerance(length = 30) {
	union() {
		cube([2,3.5,6], center=true);
		rotate([60,0,0]) cube([2.1,3.5,6], center=true);
		rotate([120,0,0]) cube([2.1,3.5,6], center=true);
//		rotate([0, 90, 180]) cylinder(h = length + 0.1, r = 1.6, $fn= 20);
		rotate([0, 90, 0])cylinder(h = length + 0.1, r = 1.6, $fn= 20);
	}
}

module mainBody(wall = 4, rod = 8, h = 10) {
	wallThickness = wall - 0.5;
	innerRadius = rod/2;
	outerRadius = (innerRadius + wallThickness);
	shortLeg = rod/2 + 8;
	longLeg = shortLeg + 12 + endstopSpacing;
	
	difference() {
		//the body of the holder
		union() {
			mainCurve(rod, wall, h);
			
			translate([outerRadius - wall, outerRadius,0]) 
				leg(longLeg - outerRadius, wall, h);
			
			translate([-outerRadius,outerRadius,0])
				leg(shortLeg - outerRadius, wall, h);
		}
		//holes for m3 screws with spaces for nuts
		color([1,0,0]) {
//			translate([outerRadius,shortLeg - 5,height - 5])
//				m3withTolerance(outerRadius*2);
//
//			translate([outerRadius,shortLeg - 5,height - 5])
//		union() {
//		cube([2,3.5,6], center=true);
//		rotate([60,0,0]) cube([2.1,3.5,6], center=true);
//		rotate([120,0,0]) cube([2.1,3.5,6], center=true);
//		rotate([0, 90, 180]) cylinder(h = 30 + 0.1, r = 1.6, $fn= 20);}
			translate([outerRadius,shortLeg - 5,height - 5])
				m3withTolerance(outerRadius*2);
			translate([outerRadius - mainWall*2 + 1 - rodDiameter,shortLeg - 5,height - 5])
				m3withTolerance(outerRadius*2);
		
//			translate([outerRadius,longLeg - 4,height - 5])
//				m3withTolerance(outerRadius*2);
//			translate([outerRadius,longLeg - 4 - endstopSpacing,height - 5])
//				m3withTolerance(outerRadius*2);
//			translate([outerRadius,longLeg - 4 - endstopSpacing2,height - 5])
//				m3withTolerance(outerRadius*2);

			translate([innerRadius - 0.5,longLeg - 4,height - 5])
				m3withTolerance(outerRadius*2);
			translate([innerRadius - 0.5,longLeg - 4 - endstopSpacing,height - 5])
				m3withTolerance(outerRadius*2);
			translate([innerRadius - 0.5,longLeg - 4 - endstopSpacing2,height - 5])
				m3withTolerance(outerRadius*2);
		}
	}
}

mainBody(mainWall, rodDiameter, height);