// PRUSA iteration3
// X carriage
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// Separación a 30mm los agujeros de montaje


include <inc/xcarr-configuration.scad>
use <inc/xcarr-bearing.scad>

//separación de los agujeros para extrusor (24mm o 30mm)
//disth = 30;
disth = 17.1;

//desplazamiento para centrar la correa (de polea de 20mm a una de 12mm son 4mm de diferencia en radio)
//desp = -4;
desp = -2.5;


//Movimiento de los agujeros de montaje para pasar por encima de la correa
//pos = 11;
pos = -2;

module x_carriage_base(){
 // Small bearing holder
 translate([-33/2,+2,0]) rotate([0,0,90]) horizontal_bearing_base(1);
 //hull(){
     // Long bearing holder
     translate([-33/2,x_rod_distance+2,0]) rotate([0,0,90]) horizontal_bearing_base(2);
     // Belt holder base
//     translate([-36-4,20,0]) cube([39+8,16-desp,17]);
     translate([-36-4,20-1,0]) cube([39+8,16-desp+1,17]);
   // }
     // Base plate
 translate([-38,-11.5,0]) cube([39+4,68,7+1.5]);

}

module x_carriage_beltcut(){
 // Cut in the middle for belt
 translate([-2.5-16.5+1,19+desp,7]) cube([4.5,13,15]);
 // Cut clearing space for the belt
 translate([-39,5,7]) cube([50,14,15]);
 // Belt slit
 translate([-50,21.5+10+desp,6]) cube([67,1,15]);
 // Smooth entrance
 translate([-56,21.5+10+desp,14]) rotate([45,0,0]) cube([67,15,15]);
 // Teeth cuts
 for ( i = [0 : 33] ){
   translate([25-i*belt_tooth_distance,21.5+8+desp,6+1.5]) cube([1.7,3,15]);
 }
}

module x_carriage_holes(){
 // Small bearing holder holes cutter
  translate([-33/2,2,0]) rotate([0,0,90]) horizontal_bearing_holes(1);
 // Long bearing holder holes cutter
  translate([-33/2,x_rod_distance+2,0]) rotate([0,0,90]) horizontal_bearing_holes(2);
  // Extruder mounting holes
//  translate([-16.5+disth/2,24+pos,-1])cylinder(r=1.7, h=20, $fn=32);
//  translate([-16.5+disth/2,24+pos,10])cylinder(r=3.3, h=20, $fn=6); 
//  translate([-16.5-disth/2,24+pos,-1])cylinder(r=1.7, h=20, $fn=32);
//  translate([-16.5-disth/2,24+pos,10])cylinder(r=3.3, h=20, $fn=6); 	
  translate([-16.5+disth/2,24+pos,-1])cylinder(r=2.7, h=20, $fn=32);
  translate([-16.5+disth/2,24+pos,7])cylinder(r=4.6, h=20, $fn=6); 
  translate([-16.5-disth/2,24+pos,-1])cylinder(r=2.7, h=20, $fn=32);
  translate([-16.5-disth/2,24+pos,7])cylinder(r=4.6, h=20, $fn=6); 	
}

module x_carriage_fancy(){
 // Top right corner
 translate([13.5,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,45]) translate([0,-15,0]) cube([30,30,20]);
 // Bottom right corner
 translate([0,5,0]) translate([0,-11.5,-1]) rotate([0,0,-45]) translate([0,-15,0]) cube([30,30,20]);

 // middle ĺeft corner
// translate([-33,5,0]) translate([0,-11.5,-1]) rotate([0,0,-135]) translate([0,15,0]) cube([100,100,20]);
 // middle right corner
// translate([0,5,0]) translate([0,-11.5,-1]) rotate([0,0,-45]) translate([0,-45,0]) cube([30,30,20]);

 // Bottom ĺeft corner
 translate([-33,5,0]) translate([0,-11.5,-1]) rotate([0,0,-135]) translate([0,-15,0]) cube([30,30,20]);
 // Top left corner
 translate([-33-13.5,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,135]) translate([0,-15,0]) cube([30,30,20]);	
}

// Final part
module x_carriage(){
 difference(){
  x_carriage_base();
  x_carriage_beltcut();
  x_carriage_holes();
  x_carriage_fancy();
 }
}

x_carriage();
