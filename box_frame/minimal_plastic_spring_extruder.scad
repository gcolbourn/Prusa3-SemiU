include<spring4.scad>

//NEMA17
motor_width = 40;
motor_mount_hole_spacing = 31;
motor_mount_screw_radius = 3.2/2;//M3
motor_inner_circle_radius = 11;
motor_outer_circle_radius = 15;
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

//E3D v6 hot end
hot_end_radius = 8;
height = hot_end_radius - bearing_height/2;

//misc.
spring_offset = 2.75;
vertical_offset_for_rotation = 0.5;
finger_width = 20;

spring_length = drive_gear_radius - drive_gear_slot_depth + filament_diameter - spring_stretch + bearing_outer_radius;

number_of_wiggles = 3;
// The portion of the circle that appears in each wiggle
angle = 220; // [180:360]
// The width of the band of material
width = 1.5;
//height = 3.5;
spring_height = height;
// Circles are n-gons.  Choose n
resolution = 100;

echo("spring length = ",spring_length);
echo("spring height = ",spring_height);
echo("(filament) height = ",height);

//spring4(length, number_of_wiggles, angle, width, height, $fn=resolution);

//difference(){
//import("mini.stl");
//translate([0,7,0]){cube([25,10,5]);};};

//spring4(length, number_of_wiggles, angle, width, height, $fn=resolution);

//springs

module spring1() {translate([drive_gear_radius,spring_offset,0])spring4(spring_length-drive_gear_radius, number_of_wiggles, angle, width, spring_height, $fn=resolution);};

difference(){spring1();cylinder(r=drive_gear_radius,h=height,$fn=resolution);};
difference(){mirror([0,1,0]){spring1();};cylinder(r=drive_gear_radius,h=height,$fn=resolution);};

//bearing mount

translate([spring_length,0,0]){cylinder(r=3,h=height+vertical_offset_for_rotation,$fn=resolution);}
translate([spring_length,0,height+vertical_offset_for_rotation]){cylinder(r=bearing_inner_radius,h=bearing_height,$fn=resolution);}

module centre_circle() {translate([0,0,-NEMA17_mount_height])ring(motor_inner_circle_radius+1,0,NEMA17_mount_height,$fn=resolution);};

difference(){translate([spring_length+3,0,(height-motor_centre_circle_height_from_square)/2]){cube([10,7.5,height+motor_centre_circle_height_from_square],center=true);};centre_circle();};

//motor/drive gear mount 

NEMA17_mount_height = height-drive_gear_bottom_shaft_height+vertical_offset_for_rotation;
ring(5,motor_shaft_radius+0.2,NEMA17_mount_height,$fn=resolution);
difference(){translate([0,0,NEMA17_mount_height/2]){cube([8,12,NEMA17_mount_height],center=true);};cylinder(r=2.7,h=NEMA17_mount_height,$fn=resolution);};

//finger ring pull

translate([motor_width/2+finger_width/2,0,-motor_centre_circle_height_from_square]){ring(finger_width/2+3,finger_width/2,height+motor_centre_circle_height_from_square,$fn=resolution);}

//motor shroud

//arc_of_ring(outer, inner, h, angle /* must be 180 <= angle <= 360 */)
rotate([0,0,90])arc_of_ring(motor_outer_circle_radius,5,NEMA17_mount_height,250,$fn=resolution);
difference(){
translate([0,0,-motor_centre_circle_height_from_square/2])cube([motor_width,motor_width,motor_centre_circle_height_from_square],center=true);
union(){
//union(){
translate([motor_width/4,0,-motor_centre_circle_height_from_square/2])cube([motor_width/2,12,motor_centre_circle_height_from_square],center=true);
centre_circle();
translate([motor_width-10,0,-NEMA17_mount_height])cylinder(r=finger_width/2+5,h=NEMA17_mount_height,$fn=resolution);
translate([motor_mount_hole_spacing/2,motor_mount_hole_spacing/2,-NEMA17_mount_height])cylinder(r=motor_mount_screw_radius,h=NEMA17_mount_height,$fn=resolution);
translate([motor_mount_hole_spacing/2,-motor_mount_hole_spacing/2,-NEMA17_mount_height])cylinder(r=motor_mount_screw_radius,h=NEMA17_mount_height,$fn=resolution);
translate([-motor_mount_hole_spacing/2,motor_mount_hole_spacing/2,-NEMA17_mount_height])cylinder(r=motor_mount_screw_radius,h=NEMA17_mount_height,$fn=resolution);
translate([-motor_mount_hole_spacing/2,-motor_mount_hole_spacing/2,-NEMA17_mount_height])cylinder(r=motor_mount_screw_radius,h=NEMA17_mount_height,$fn=resolution);
};};
