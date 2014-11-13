include<spring4.scad>

motor_shaft_radius = 2.5;
drive_gear_radius = 4.5;
//Mk8
bearing_radius = 6.5;
//624ZZ
gear_slot_depth = 1;
filament_diameter = 3;
spring_stretch = 0.5;
spring_offset = 5.5;
finger_width = 20;
motor_width = 40;

length = drive_gear_radius - gear_slot_depth + filament_diameter - spring_stretch + bearing_radius;
//length=4.5-1.5+3-0.5+6.5;
echo("length = ",length);

//length = 10;
number_of_wiggles = 3;
// The portion of the circle that appears in each wiggle
angle = 220; // [180:360]
// The width of the band of material
width = 1.5;
height = 3.5;
// Circles are n-gons.  Choose n
resolution = 100;

//spring4(length, number_of_wiggles, angle, width, height, $fn=resolution);

//difference(){
//import("mini.stl");
//translate([0,7,0]){cube([25,10,5]);};};

//spring4(length, number_of_wiggles, angle, width, height, $fn=resolution);

module spring1() {translate([4.5,0,0])spring4(length-4.5, number_of_wiggles, angle, width, height, $fn=resolution);};

difference(){spring1();translate([0,-2.75,height-2]){cylinder(r=4.5,h=height,$fn=resolution);};};
difference(){translate([0,-spring_offset,0])mirror([0,1,0]){spring1();};
	translate([0,-spring_offset/2,height-2]){cylinder(r=4.5,h=height,$fn=resolution);};};

translate([length,-spring_offset/2,0]){cylinder(r=3,h=height+0.5,$fn=resolution);}
translate([length,-spring_offset/2,height+0.5]){cylinder(r=2,h=5,$fn=resolution);}
translate([length-2.1,-6.5,0]){cube([10,7.5,height]);}

translate([0,-2.75,0]){ring(5,2.7,height-2,$fn=resolution);}
difference(){translate([-4,-8.75,0]){cube([8,12,height-2]);};translate([0,-spring_offset/2,0]){cylinder(r=2.7,h=height-2,$fn=resolution);};};

translate([motor_width/2+finger_width/2,-spring_offset/2,0]){ring(finger_width/2+3,finger_width/2,height,$fn=resolution);}


