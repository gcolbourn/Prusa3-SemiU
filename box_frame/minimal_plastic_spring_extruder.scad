include<spring4.scad>

//NEMA17
motor_width = 40;
motor_mount_hole_spacing = 31;
motor_mount_screw_radius = 3.2/2;//M3
motor_mount_screw_head_radius = 2.75;//M3
motor_inner_circle_radius = 11;
motor_outer_circle_radius = 15;
motor_centre_circle_height_from_square = 2;
motor_shaft_radius = 2.5;

//Mk8
drive_gear_radius = 4.5;
drive_gear_slot_depth = 1;
drive_gear_teeth_depth = 0.25;
drive_gear_slot_width = 4.5;
drive_gear_bottom_shaft_height = 1.5;

//624ZZ
bearing_outer_radius = 6.5;
bearing_inner_radius = 2;
bearing_height = 5;

//filament
filament_diameter = 3;
spring_stretch = 0.5;

//E3D v6 hot end
hot_end_radius = 8;
hot_end_inner_radius = 6;
hot_end_top_lip = 3.75;
hot_end_inner_gap = 6;
hot_end_mount_height = 12.75;
hot_end_mount_wall_width = 4;
hot_end_mount_above_semicircle = 3;
gap_between_hot_end_and_bearing = 1;

cable_tie_hole_width = 3.5;
cable_tie_hole_depth = 1.5;
cable_tie_hole_wall_thickness = 1.5;


filament_height = hot_end_radius;
NEMA17_mount_height = filament_height-drive_gear_bottom_shaft_height-drive_gear_slot_width/2;

//dust box
dustbox_width = 12;
dustbox_height = 2*(filament_height-NEMA17_mount_height);
dustbox_wall_thickness=1.5;
dustbox_above_motor=2;

//misc.
spring_offset = 2.75;
vertical_offset_for_rotation = 0.5;
finger_width = 20;
filament_guide_above_motor=6;

filament_x = drive_gear_radius - drive_gear_slot_depth  - drive_gear_teeth_depth + filament_diameter/2;
spring_length = filament_x + filament_diameter/2 - spring_stretch + bearing_outer_radius;

number_of_wiggles = 3;
// The portion of the circle that appears in each wiggle
angle = 220; // [180:360]
// The width of the band of material
width = 1.5;
//height = 3.5;
spring_height = 5;
// Circles are n-gons.  Choose n
resolution = 20;

echo("spring length = ",spring_length);
echo("spring height = ",spring_height);
echo("filament height = ",filament_height);
echo("filament x position = ",filament_x);
//spring4(length, number_of_wiggles, angle, width, height, $fn=resolution);

//difference(){
//import("mini.stl");
//translate([0,7,0]){cube([25,10,5]);};};

//spring4(length, number_of_wiggles, angle, width, height, $fn=resolution);

//springs

module spring1() {translate([drive_gear_radius,spring_offset,0])spring4(spring_length-drive_gear_radius, number_of_wiggles, angle, width, spring_height, $fn=resolution);};

difference(){spring1();cylinder(r=drive_gear_radius,h=spring_height,$fn=resolution);};
difference(){mirror([0,1,0]){spring1();};cylinder(r=drive_gear_radius,h=spring_height,$fn=resolution);};

//bearing mount

translate([spring_length,0,0]){cylinder(r=3,h=filament_height-bearing_height/2,$fn=resolution);}
translate([spring_length,0,filament_height-bearing_height/2]){cylinder(r=bearing_inner_radius,h=bearing_height,$fn=resolution);}

module centre_circle() {translate([0,0,-NEMA17_mount_height])ring(motor_inner_circle_radius+1,0,NEMA17_mount_height,$fn=resolution);};

difference(){translate([spring_length+3,0,(spring_height-motor_centre_circle_height_from_square)/2]){cube([10,7.5,spring_height+motor_centre_circle_height_from_square],center=true);};centre_circle();};

//motor/drive gear mount 

ring(5,motor_shaft_radius+0.2,NEMA17_mount_height,$fn=resolution);
difference(){translate([0,0,NEMA17_mount_height/2]){cube([8,15,NEMA17_mount_height],center=true);};cylinder(r=2.7,h=NEMA17_mount_height,$fn=resolution);};

//finger ring pull

translate([motor_width/2+finger_width/2,0,-motor_centre_circle_height_from_square]){ring(finger_width/2+3,finger_width/2,spring_height+motor_centre_circle_height_from_square,$fn=resolution);}

//motor shroud

//arc_of_ring(outer, inner, h, angle /* must be 180 <= angle <= 360 */)
rotate([0,0,65])arc_of_ring(motor_outer_circle_radius,drive_gear_radius,NEMA17_mount_height,195,$fn=resolution);
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

//module filament_x(y) {translate([drive_gear_radius+filament_diameter/2,0,0])y};
//filament
translate([filament_x,0,filament_height])
rotate([90,0,0])cylinder(r=filament_diameter/2,h=2*motor_width,$fn=resolution,center=true);

////filment guide
difference(){
	union(){
	translate([filament_x,motor_width/2+filament_guide_above_motor,filament_height])
	rotate([90,0,0])cylinder(r=2+filament_diameter/1.8,h=motor_width/2-bearing_outer_radius+filament_guide_above_motor,$fn=resolution);
	translate([filament_x-(2+filament_diameter/1.8),bearing_outer_radius,0])
	cube([2*(2+filament_diameter/1.8),motor_width/2-bearing_outer_radius+filament_guide_above_motor,filament_height]);};
translate([filament_x,motor_width,filament_height])
rotate([90,0,0])
cylinder(r=filament_diameter/1.8,h=2*motor_width,$fn=resolution);
//dust box
translate([filament_x,motor_width/2-dustbox_width/2+dustbox_above_motor,filament_height])
cube([dustbox_width-dustbox_wall_thickness*2,dustbox_width-dustbox_wall_thickness*2,dustbox_height],center=true);
};
translate([filament_x,motor_width/2-dustbox_width/2+dustbox_above_motor,filament_height])
difference(){
cube([dustbox_width,dustbox_width,dustbox_height],center=true);
cube([dustbox_width-dustbox_wall_thickness*2,dustbox_width-dustbox_wall_thickness*2,dustbox_height],center=true);};

translate([filament_x,motor_width/2-dustbox_width/2+dustbox_above_motor,NEMA17_mount_height/2])
cube([dustbox_width,dustbox_width,NEMA17_mount_height],center=true);

translate([filament_x,motor_width/2+dustbox_above_motor/2,-motor_centre_circle_height_from_square/2])cube([dustbox_width,dustbox_above_motor,motor_centre_circle_height_from_square],center=true);
translate([filament_x,motor_width/2+filament_guide_above_motor/2,-motor_centre_circle_height_from_square/2])cube([2*(2+filament_diameter/1.8),filament_guide_above_motor,motor_centre_circle_height_from_square],center=true);


//hot end mount (1 block take away 6 cylinders)
difference(){

//main block
translate([filament_x-(hot_end_radius+0.2+hot_end_mount_wall_width),-motor_width/2,0])
cube([2*(hot_end_radius+0.2)+hot_end_mount_wall_width*2,motor_width/2-bearing_outer_radius-1,2*filament_height]);
		
		//stuff to take away
		union(){

		//top cube
		translate([filament_x-(hot_end_radius+0.2+hot_end_mount_wall_width),-motor_width/2,filament_height+hot_end_mount_above_semicircle])
		cube([2*(hot_end_radius+0.2)+hot_end_mount_wall_width*2,motor_width/2-bearing_outer_radius-1,50]);
		
		//tip lip cylinder
		translate([filament_x,-bearing_outer_radius-gap_between_hot_end_and_bearing+0.2,filament_height])
		rotate([90,0,0])
		cylinder(r=hot_end_radius+0.2,h=hot_end_top_lip,$fn=resolution);

		//central cylinder
		translate([filament_x,-bearing_outer_radius-gap_between_hot_end_and_bearing-(hot_end_inner_gap)/2,filament_height])
		rotate([90,0,0])
		cylinder(r=hot_end_inner_radius+0.2,h=hot_end_inner_gap+1,$fn=resolution);

		//bottom lip cylinder
		translate([filament_x,-bearing_outer_radius-gap_between_hot_end_and_bearing-hot_end_top_lip-(hot_end_inner_gap-0.2),filament_height])
		rotate([90,0,0])
		cylinder(r=hot_end_radius+0.2,h=motor_width/2-hot_end_top_lip-hot_end_inner_gap+2,$fn=resolution);		

		//cable tie hole
		translate([filament_x,-bearing_outer_radius - gap_between_hot_end_and_bearing - hot_end_top_lip - (hot_end_inner_gap-cable_tie_hole_width)/2 + 0.2,filament_height])
		rotate([90,0,0])
		ring(hot_end_inner_radius+cable_tie_hole_wall_thickness+cable_tie_hole_depth,hot_end_inner_radius+cable_tie_hole_wall_thickness,cable_tie_hole_width,$fn=resolution);
		
		//mount screw hole
		translate([motor_mount_hole_spacing/2,-motor_mount_hole_spacing/2,0])
		cylinder(r=motor_mount_screw_head_radius,h=filament_height+hot_end_mount_above_semicircle,$fn=resolution);

};
};

//cylinder(r=motor_inner_circle_radius,h=2,$fn=resolution);
