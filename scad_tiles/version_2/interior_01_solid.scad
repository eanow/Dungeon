include <libs.scad>;
use <wall_01_solid.scad>;
use <floor_01_solid.scad>;

*long_mid();
*short_mid();
*tee();
*plus();
corner();

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
