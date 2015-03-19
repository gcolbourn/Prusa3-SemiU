include <configuration.scad>
use <bushing.scad>
use <inc/bearing-guide.scad>
use <inc/bearing_new.scad>
use <y-drivetrain.scad>

//cube_fillet([23, 10, 10], center = true,radius=1);
//vertical=[1, 1, 1, 1],);

height=20;
width=18;
endstop_position=28;
endstop_height=11.5;
length=32;
m5tom8dist=17.3;
m5_hole_r=2.8;
m5_hole_height=4.15; // Ooznest = 4
m8_hole_r=4.4; // Ooznest = 4.5
m5holedist=7.5;
m5_nut_trap_width=8.2; // Ooznest = 8
x_platform_width=13;

module oval(w,h, heightofoval, center = false) {
  scale([1, h/w, 1]) cylinder(h=heightofoval, r=w, center=center);
};

module z_isolator_base(){
    
    difference(){
    cube_fillet([m5holedist*2,m5holedist*2+3,height],bottom=[3,3,3,3],radius=3);
    translate([m5holedist, m5holedist, 0]) cylinder(r=m5_hole_r,h=height,$fn=32);
    for ( i = [-1,1] ){
    translate([m5holedist,m5holedist/2,height/2+i*5.5]) cube([m5_nut_trap_width,m5holedist,m5_hole_height],center=true);
    translate([m5holedist,m5holedist+0.5,height/2+i*5.5]) rotate([0,0,30]) cylinder(r=4.9, h=m5_hole_height, center = true, $fn=6);};
}

difference(){
    translate([0, 0, 0]) cube_fillet([length-3,width,height],bottom=[3,3,3,3],radius=3);
    //translate([m5holedist*2, 0, 0]) cube_fillet([length,width-x_platform_width,height],radius=3);
    //translate([0, -3, 0]) cube([length,width-x_platform_width,height]);
    //translate([0, width, -3]) rotate([0,90,0]) oval(w=height,h=width-2*(m5holedist), heightofoval=length);
    translate([length, width, -3]) rotate([90,0,0]) oval(w=length-2*m5holedist+3,h=height,heightofoval=length);
        translate([m5holedist, m5holedist, 0]) cylinder(r=m5_hole_r,h=height,$fn=32);
    for ( i = [-1,1] ){
    translate([m5holedist,m5holedist/2,height/2+i*5.5]) cube([m5_nut_trap_width,m5holedist,m5_hole_height],center=true);
    translate([m5holedist,m5holedist+0.5,height/2+i*5.5]) rotate([0,0,30]) cylinder(r=4.9, h=m5_hole_height, center = true, $fn=6);};
    //m8 rod guide
    translate([m5holedist+m5tom8dist,m5holedist,0]) cylinder(r=m8_hole_r,h=height);
    translate([m5holedist+m5tom8dist,m5holedist-m8_hole_r,0]) cube([width,m8_hole_r*2,height]);
    translate([m5holedist+m5tom8dist+m8_hole_r ,m5holedist-m8_hole_r*2,0]) cube([width,m8_hole_r*2,height]);

};

//translate([length-10,width-m5holedist*2+2,height-3.2]) cube_fillet([10,width-m5holedist*2,3.2],radius=3);

}

mirror([0,0,1]){
            union(){
                    z_isolator_base();
                    for ( i = [-1,1] ){
                                    translate([m5holedist,m5holedist,height/2+i*5.5-m5_hole_height/2-0.1]) 
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
    //endstop block
            //cable tie mount
                //translate([0, width-8, height-6]) cube_fillet([25,8,6],vertical=[2,2,0,4]); 
            //m3x10 mount
                translate([0, endstop_position-endstop_height, height-endstop_height]) cube_fillet([27,10,endstop_height],vertical=[2,2,2,2]);
                for ( i = [-1,1] ){
                                    translate([m5holedist,m5holedist,height/2+i*5.5-m5_hole_height/2-0.1]) 
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
        translate([4+i*19, endstop_position, (height-endstop_height)+2]) rotate([90,0,0]) cylinder(r=1.4,h=10,$fn=32);
    };
    translate([0,width+10,height-endstop_height+2.7]) rotate([50,0,0]) cube([27,20,20]);
    }
}
}
   