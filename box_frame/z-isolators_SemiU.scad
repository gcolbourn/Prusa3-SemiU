include <configuration.scad>
use <bushing.scad>
use <inc/bearing-guide.scad>
use <inc/bearing_new.scad>
use <y-drivetrain.scad>

//cube_fillet([23, 10, 10], center = true,radius=1);
//vertical=[1, 1, 1, 1],);

height=16;
width=28;
length=37;
m5tom8dist=17;
m5_hole_r=3.1;
m5_hole_height=4.2;
m8_hole_r=5;
m5holedist=7.5;
m5_nut_trap_width=8.2;
x_platform_width=13;

module oval(w,h, heightofoval, center = false) {
  scale([1, h/w, 1]) cylinder(h=heightofoval, r=w, center=center);
};

module z_isolator_base(){
    
    difference(){
    cube_fillet([m5holedist*2,m5holedist*2+3,height],bottom=[3,3,3,3],radius=3);
    translate([m5holedist, m5holedist, 0]) cylinder(r=m5_hole_r,h=height);
    for ( i = [-1,1] ){
    translate([m5holedist,m5holedist/2,height/2+i*10/3]) cube([m5_nut_trap_width,m5holedist,m5_hole_height],center=true);
    translate([m5holedist,m5holedist+0.5,height/2+i*10/3]) rotate([0,0,30]) cylinder(r=4.7, h=m5_hole_height, center = true, $fn=6);};
}

difference(){
    translate([0, 0, 3]) cube_fillet([length-3,width,height-3],bottom=[3,3,3,3],radius=3);
    translate([m5holedist*2, 0, 0]) cube_fillet([length,width-x_platform_width,height],radius=3);
    translate([0, -3, 0]) cube([length,width-x_platform_width,height]);
    translate([0, width, 0]) rotate([0,90,0]) oval(w=height-3,h=width-2*(m8_hole_r+3), heightofoval=length);
    translate([length, width, 0]) rotate([90,0,0]) oval(w=length-2*m5holedist+0.5,h=height-3,heightofoval=length);
};

translate([length-10,width-m5holedist*2+2,height-3.2]) cube_fillet([10,width-m5holedist*2,3.2],radius=3);

}

mirror([0,0,1]){
z_isolator_base();
}

translate([0,-5,0])

mirror([0,1,0]){
mirror([0,0,1]){
    difference(){
        union(){
                z_isolator_base();
                translate([0, width-8, height-6]) cube_fillet([25,8,6],vertical=[2,2,0,4]);};
        translate([12.5, width, height-5]) rotate([0,0,90]) oval(w=10,h=10,heightofoval=3.5);
                };
        difference(){
               translate([12.5, width, height-5]) rotate([0,0,90]) oval(w=8,h=8,heightofoval=3.5);
            translate([0, width, height-5]) cube([25,10,10]);
            }
}
}
   