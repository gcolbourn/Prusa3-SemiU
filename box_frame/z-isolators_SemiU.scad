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
m5tom8dist=17.3;
m5_hole_r=3.1;
m5_hole_height=4.2;
m8_hole_r=4.2;
m5holedist=7.5;
m5_nut_trap_width=8.5;
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
    translate([m5holedist,m5holedist+0.5,height/2+i*10/3]) rotate([0,0,30]) cylinder(r=4.9, h=m5_hole_height, center = true, $fn=6);};
}

difference(){
    translate([0, 0, 3]) cube_fillet([length-3,width,height-3],bottom=[3,3,3,3],radius=3);
    //translate([m5holedist*2, 0, 0]) cube_fillet([length,width-x_platform_width,height],radius=3);
    //translate([0, -3, 0]) cube([length,width-x_platform_width,height]);
    translate([0, width, 0]) rotate([0,90,0]) oval(w=height-3,h=width-2*(m5holedist), heightofoval=length);
    translate([length, width, 0]) rotate([90,0,0]) oval(w=length-2*m5holedist+3,h=height-3,heightofoval=length);
        translate([m5holedist, m5holedist, 0]) cylinder(r=m5_hole_r,h=height);
    for ( i = [-1,1] ){
    translate([m5holedist,m5holedist/2,height/2+i*10/3]) cube([m5_nut_trap_width,m5holedist,m5_hole_height],center=true);
    translate([m5holedist,m5holedist+0.5,height/2+i*10/3]) rotate([0,0,30]) cylinder(r=4.9, h=m5_hole_height, center = true, $fn=6);};
    //m8 rod guide
    translate([m5holedist+m5tom8dist,m5holedist,0]) cylinder(r=m8_hole_r,h=height);
    translate([m5holedist+m5tom8dist,m5holedist-m8_hole_r,0]) cube([width,m8_hole_r*2,height]);
    translate([m5holedist+m5tom8dist+m8_hole_r/2 ,m5holedist-m8_hole_r*2,0]) cube([width,m8_hole_r*2,height]);

};

//translate([length-10,width-m5holedist*2+2,height-3.2]) cube_fillet([10,width-m5holedist*2,3.2],radius=3);

}

mirror([0,0,1]){
            union(){
                    z_isolator_base();
                    for ( i = [-1,1] ){
                                    translate([m5holedist,m5holedist,height/2+i*10/3-m5_hole_height/2-0.1]) 
                                    cube([m5_nut_trap_width,m5holedist*2,0.2],center=true);
                                  };
                     };
}

translate([0,-5,0])

mirror([0,1,0]){
mirror([0,0,1]){
    difference(){
        union(){
                z_isolator_base();
 //               translate([0, width-8, height-6]) cube_fillet([25,8,6],vertical=[2,2,0,4]); //cable tie mount
                translate([0, width-10, height-6]) cube_fillet([27,10,6],vertical=[2,2,0,12]); //m3x10 mount
                for ( i = [-1,1] ){
                                    translate([m5holedist,m5holedist,height/2+i*10/3-m5_hole_height/2-0.1]) 
                                    cube([m5_nut_trap_width,m5holedist*2,0.2],center=true);
                                  };
    };
    //cable tie endstop mount
//        translate([12.5, width, height-5.25]) rotate([0,0,90]) oval(w=10,h=10,heightofoval=3);
//                };
//        difference(){
//               translate([12.5, width, height-5.25]) rotate([0,0,90]) oval(w=8.5,h=8.5,heightofoval=3);
//            translate([0, width, height-5.25]) cube([25,10,10]);
    //M3x10 endstop mount
    for ( i = [0,1] ){
        translate([4+i*19, width, height-5.25+0.2+1.4]) rotate([90,0,0]) cylinder(r=1.4,h=10,$fn=32);
    }
            }
}
}
   