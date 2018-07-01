include <libs.scad>;
use <wall_01_solid.scad>;
use <floor_01_solid.scad>;
use <interior_01_solid.scad>;


interior_final();

module interior_final()
{
  intersection()
  {
    *import("interior_0202_corner.stl");
    plus();
    translate([0,0,wall_height+floor_thick-ep])cube([2*3*basis,2*3*basis,(wall_height+floor_depth)*2],center=true);
  }

  intersection()
  {
    cube([2*3*basis,2*3*basis,2*(floor_thick-floor_depth-ep)],center=true);
    difference()
    {
      square_floor(2,2);
      square_mag_holes(2,2);
      square_openlocks(2,2);
    }
  }
}
