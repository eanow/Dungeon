include <libs.scad>;
use <corner_01_solid.scad>;

concave_final();
*convex_final();

module concave_final()
{
  intersection()
  {
    *import("concave_linear_solid_chipped_c.stl");
    concave_linear();
    translate([0,0,wall_height/2-ep+floor_thick])cube([1*3*basis,1*3*basis,wall_height],center=true);
  }

  intersection()
  {
    cube([1*3*basis,1*3*basis,2*(floor_thick)],center=true);
    difference()
    {
      concave_linear(1);
      linear_mag_holes(1);
      rotate([0,0,-90])translate([0,-basis,0])linear_mag_holes(1);
    }
  }
}

module convex_final()
{
  intersection()
  {
    *import("corner_01_convex_chipped_a.stl");
    convex_linear();
    translate([0,0,wall_height/2-ep+floor_thick])cube([1*3*basis,1*3*basis,wall_height],center=true);
  }

  intersection()
  {
    cube([1*3*basis,1*3*basis,2*(floor_thick)],center=true);
    difference()
    {
      convex_linear(1);
      linear_mag_holes(1);
      rotate([0,0,90])translate([0,-basis,0])linear_mag_holes(1);
    }
  }
}