include <libs.scad>;
use <wall_01_solid.scad>;
use <floor_01_solid.scad>;

*long_mid();
*short_mid();
*tee();
*plus();
*corner();

door();


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


module door()
{
//floor
  square_floor(2,2);
  translate([wall_width/2+basis,0,-ep])difference()
  {
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
  }
}

module long_mid()
{
  //floor
  square_floor(2,2);
  //thin interior wall
  translate([basis,0,0])intersection()
  {
    translate([interior_thick/2,0,0])linear_wall(2);
    mirror([-1,0,0])translate([interior_thick/2,0,0])linear_wall(2);
  }
    
}
module short_mid()
{
  //floor
  square_floor(2,2);
  //thin interior wall
  translate([basis,0,0])intersection()
  {
    translate([interior_thick/2,0,0])linear_wall(1);
    mirror([-1,0,0])translate([interior_thick/2,0,0])linear_wall(1);
  }
    
}
module tee()
{
  //floor
  square_floor(2,2);
  //thin interior wall
  translate([basis,0,0])intersection()
  {
    translate([interior_thick/2,0,0])linear_wall(2);
    mirror([-1,0,0])translate([interior_thick/2,0,0])linear_wall(2);
  }
  rotate([0,0,90])translate([basis,-basis,0])intersection()
  {
    translate([interior_thick/2,0,0])linear_wall(1);
    mirror([-1,0,0])translate([interior_thick/2,0,0])linear_wall(1);
  }
    
}
module plus()
{
  //floor
  square_floor(2,2);
  //thin interior wall
  translate([basis,0,0])intersection()
  {
    translate([interior_thick/2,0,0])linear_wall(2);
    mirror([-1,0,0])translate([interior_thick/2,0,0])linear_wall(2);
  }
  rotate([0,0,90])translate([basis,-2*basis,0])intersection()
  {
    translate([interior_thick/2,0,0])linear_wall(2);
    mirror([-1,0,0])translate([interior_thick/2,0,0])linear_wall(2);
  }
    
}
module corner()
{
  //floor
  square_floor(2,2);
  //thin interior wall
  translate([basis,0,0])intersection()
  {
    translate([interior_thick/2,0,0])linear_wall(1);
    mirror([-1,0,0])translate([interior_thick/2,0,0])linear_wall(1);
  }
  rotate([0,0,90])translate([basis,-basis,0])intersection()
  {
    translate([interior_thick/2,0,0])linear_wall(1);
    mirror([-1,0,0])translate([interior_thick/2,0,0])linear_wall(1);
  }
  intersection()
  {
    translate([basis,0,0])intersection()
    {
      translate([interior_thick/2,0,0])linear_wall(1+.5*interior_thick/basis);
      mirror([-1,0,0])translate([interior_thick/2,0,0])linear_wall(1+.5*interior_thick/basis);
    }
    translate([0,basis,0])rotate([0,0,-90])intersection()
    {
      translate([interior_thick/2,0,0])linear_wall(1+.5*interior_thick/basis);
      mirror([-1,0,0])translate([interior_thick/2,0,0])linear_wall(1+.5*interior_thick/basis);
    }
  }
  //1+.5*interior_thick/basis
    
}
