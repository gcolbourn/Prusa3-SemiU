include<spring4.scad>

//NEMA17
motor_width = 40;
motor_centre_circle_radius = 22;
motor_centre_circle_height_from_square = 2;
motor_shaft_radius = 2.5;

//Mk8
drive_gear_radius = 4.5;
drive_gear_slot_depth = 1;
drive_gear_bottom_shaft_height = 1.5;

//624ZZ
bearing_outer_radius = 6.5;
bearing_inner_radius = 2;
bearing_height = 5;

//filament
filament_diameter = 3;
spring_stretch = 0.75;

//misc.
spring_offset = 2.75;
vertical_offset_for_rotation = 0.5;
finger_width = 20;

length = drive_gear_radius - drive_gear_slot_depth + filament_diameter - spring_stretch + bearing_outer_radius;

echo("(spring) length = ",length);

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

module spring1() {translate([drive_gear_radius,spring_offset,0])spring4(length-drive_gear_radius, number_of_wiggles, angle, width, height, $fn=resolution);};

difference(){spring1();cylinder(r=drive_gear_radius,h=height,$fn=resolution);};
difference(){mirror([0,1,0]){spring1();};cylinder(r=drive_gear_radius,h=height,$fn=resolution);};

translate([length,0,0]){cylinder(r=3,h=height+vertical_offset_for_rotation,$fn=resolution);}
translate([length,0,height+vertical_offset_for_rotation]){cylinder(r=bearing_inner_radius,h=bearing_height,$fn=resolution);}
translate([length+3,0,height/2]){cube([10,7.5,height],center=true);}

NEMA17_mount_height = height-drive_gear_bottom_shaft_height+vertical_offset_for_rotation;
ring(5,motor_shaft_radius+0.2,NEMA17_mount_height,$fn=resolution);
difference(){translate([0,0,NEMA17_mount_height/2]){cube([8,12,NEMA17_mount_height],center=true);};cylinder(r=2.7,h=NEMA17_mount_height,$fn=resolution);};

translate([motor_width/2+finger_width/2,0,0]){ring(finger_width/2+3,finger_width/2,height,$fn=resolution);}


