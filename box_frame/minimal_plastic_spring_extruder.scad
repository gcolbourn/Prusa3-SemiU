include<spring4.scad>

motor_shaft_radius = 2.5;
drive_gear_radius = 4.5;//Mk8
bearing_radius = 6.5;//624ZZ
drive_gear_slot_depth = 1;
drive_gear_bottom_shaft_height = 1.5;
filament_diameter = 3;
spring_stretch = 0.75;
spring_offset = 2.75;
vertical_offset_for_rotation = 0.5;
finger_width = 20;
motor_width = 40;

length = drive_gear_radius - drive_gear_slot_depth + filament_diameter - spring_stretch + bearing_radius;
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

module spring1() {translate([drive_gear_radius,spring_offset,0])spring4(length-drive_gear_radius, number_of_wiggles, angle, width, height, $fn=resolution);};

difference(){spring1();cylinder(r=drive_gear_radius,h=height,$fn=resolution);};
difference(){mirror([0,1,0]){spring1();};cylinder(r=drive_gear_radius,h=height,$fn=resolution);};

translate([length,0,0]){cylinder(r=3,h=height+vertical_offset_for_rotation,$fn=resolution);}
translate([length,0,height+0.5]){cylinder(r=2,h=5,$fn=resolution);}
translate([length+3,0,height/2]){cube([10,7.5,height],center=true);}

NEMA17_mount_height = height-drive_gear_bottom_shaft_height+vertical_offset_for_rotation;
ring(5,2.7,NEMA17_mount_height,$fn=resolution);
difference(){translate([0,0,NEMA17_mount_height/2]){cube([8,12,NEMA17_mount_height],center=true);};cylinder(r=2.7,h=NEMA17_mount_height,$fn=resolution);};

translate([motor_width/2+finger_width/2,0,0]){ring(finger_width/2+3,finger_width/2,height,$fn=resolution);}


