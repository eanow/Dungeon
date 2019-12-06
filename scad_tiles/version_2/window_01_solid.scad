include <libs.scad>;
use <wall_01_solid.scad>;

linear_window(1);

module linear_window(size)
{
  brick_h=(wall_height-floor_thick)/wall_layers;
  window_h=brick_h*(wall_layers-2);
  difference()
  {
    linear_wall_base(size,wall_height);
    linear_brick_grids(size);
    translate([-wall_width,0,0])linear_brick_grids(size);
    translate([-wall_width/2,size*basis/2,floor_thick+window_h/2+brick_h])cube([wall_width*2,window_w,window_h],center=true);
    //bevel
    translate([0,size*basis/2,floor_thick+window_h/2+brick_h])hull()
    {
      translate([-wall_groove/2,0,0])cube([wall_groove,window_w,window_h],center=true);
      cube([ep,window_w+wall_groove*2,window_h+wall_groove*2],center=true);
    }
    translate([-wall_width,size*basis/2,floor_thick+window_h/2+brick_h])hull()
    {
      translate([+wall_groove/2,0,0])cube([wall_groove,window_w,window_h],center=true);
      cube([ep,window_w+wall_groove*2,window_h+wall_groove*2],center=true);
    }
    linear_mag_holes(size);
  }
  //window edge
  /*difference()
  {
    translate([-wall_width/2,size*basis/2,floor_thick+window_h/2+brick_h])cube([wall_width,window_edge,window_h],center=true);
  }*/
}