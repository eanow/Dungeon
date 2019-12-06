include <libs.scad>;
use <wall_01_solid.scad>;
use <floor_01_solid.scad>;

dual_doorway_wall();

*half_door();
module linear_door_grid(size)
{
  //one for each wall level, horizontal
  brick_h=(doorway_height-floor_thick)/door_layers;
  for (ii=[0:door_layers-1])
  {
    translate([0,size*basis/2,floor_thick+ii*brick_h])rotate([0,45,0])cube([wall_groove*sqrt(2),size*basis*2,wall_groove*sqrt(2)],center=true);
  }
  //vertical
  //one above floor is off by half, then even, then off
  for (ii=[1:1:door_layers])
  {
    for(jj=[0:.5:size+1])
    {
      translate([0,jj*basis-(ii%6)*basis/6,floor_thick+ii*brick_h-brick_h/2])rotate([0,0,45])cube([wall_groove*sqrt(2),wall_groove*sqrt(2),brick_h],center=true);
    }
  }
}
module dual_doorway_wall()
{
  difference()
  {
    echo(wall_height);
    echo(doorway_height);
    linear_wall_base(2,doorway_height);
    //door cutaway
    translate([-wall_width/2,basis*1,door_height/2+floor_thick])cube([wall_width*2,dual_door_width,door_height],center=true);
    linear_door_grid(2);
    translate([-wall_width,0,0])linear_door_grid(2);
    //bevel
    translate([0,basis*1,door_height/2+floor_thick])hull()
    {
      translate([-wall_groove/2,0,0])cube([wall_groove,dual_door_width,door_height],center=true);
      cube([ep,dual_door_width+wall_groove*2,door_height+wall_groove*2],center=true);
    }
    translate([-wall_width,basis*1,door_height/2+floor_thick])hull()
    {
      translate([wall_groove/2,0,0])cube([wall_groove,dual_door_width,door_height],center=true);
      cube([ep,dual_door_width+wall_groove*2,door_height+wall_groove*2],center=true);
    }
    //hinge
    for(aa=[-1:2:1])translate([-wall_width/2,basis*1-aa*(dual_door_width/2-door_pin_r-hinge_t),1+magnet_r*2+1])cylinder(r=door_pin_r,h=doorway_height,$fn=20);
      //magnet
    linear_mag_holes(2);
  }
  //supports
  support_space=dual_door_width/4;
  for(aa=[-1:1:1])
  {
    translate([-wall_width/2,basis+support_space*aa,door_height/2+floor_thick])cube([wall_width-bevel*2,line_w*2-layer_t,door_height],center=true);
    translate([-wall_width/2,basis+support_space*aa,door_height/2+floor_thick])hull()
    {
      cube([wall_width-bevel*2,line_w*2-layer_t,door_height-1],center=true);
      cube([wall_width-bevel*2,line_w*2-layer_t+bevel*2,door_height-1-bevel*2],center=true);
    }
  }
  //hole single layer bridging
  translate([-wall_width/2,basis,layer_t/2+floor_thick+door_height])cube([wall_width-bevel*2,dual_door_width,layer_t],center=true);
}
module door_panel()
{
  panel_w=dual_door_width/2-door_w_tol-hinge_t-door_pin_r;
  difference()
  {
    union()
    {
      translate([0,panel_w/2,0])hull()
      {
        cube([door_pin_r*2+hinge_t*2-bevel*2,panel_w,door_height-door_h_tol],center=true);
        cube([door_pin_r*2+hinge_t*2,panel_w,door_height-door_h_tol-bevel*2],center=true);
        //cube([door_pin_r*2+hinge_t*2,panel_w,door_height-door_h_tol],center=true);
      }
      cylinder(r=door_pin_r+hinge_t,h=door_height-door_h_tol,center=true,$fn=20);
    }
    cylinder(r=door_pin_r,h=door_height,center=true,$fn=20);
  }
}
module half_door()
{
  difference()
  {
    door_panel();
    door_decor();
  }
}
module door_decor()
{
  wood_windows();
  intersection()
  {
    translate([door_deco_inset/2,0,0])wood_windows();
    wood_grain();
  }
  intersection()
  {
    translate([-door_deco_inset/2,0,0])wood_windows();
    wood_grain();
  }
}
//door_decor();
module wood_windows()
{
  //6 panels
  bar_w=1;
  panel_t=door_pin_r*2+hinge_t*2;
  
  panel_w=dual_door_width/2-door_w_tol-hinge_t-door_pin_r;
  inset_w=(panel_w-bar_w*3)/2;
  inset_h=(door_height-door_h_tol-bar_w*4)/3;
  for(aa=[-.5:1:.5])
  {
    for(bb=[-1:1:1])
    {
      for(cc=[-1:2:1])
      {
        translate([cc*panel_t/2,panel_w/2+aa*(inset_w+bar_w),bb*(inset_h+bar_w)])cube([door_deco_inset*2,inset_w,inset_h],center=true);
      }
    }
  }
}
module wood_grain()
{
  translate([0,dual_door_width/4,0])scale([1,.5,.5*doorway_height/wall_height])rotate([0,0,90])rotate([90,0,0])translate([0,0,-5])linear_extrude(10)import("wood.dxf");
}