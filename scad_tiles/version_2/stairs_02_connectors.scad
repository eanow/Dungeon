include <libs.scad>;
use <floor_01_solid.scad>;
use <wall_01_solid.scad>;
use <stairs_01_solid.scad>;

//open_ascending_final(1,4);
open_descending_final(1,3);

module open_ascending_final(width,steps)
{
  intersection()
  {
    import("stairs_up.stl");
    translate([0,0,50+floor_thick-floor_depth-ep])cube([width*3*basis,steps*3*basis,100],center=true);
  }

  intersection()
  {
    cube([width*3*basis,steps*3*basis,2*(floor_thick-floor_depth-ep)],center=true);
    difference()
    {
      square_floor(width,steps);
      square_mag_holes(width,steps);
      square_openlocks(width,steps);
    }
  }
}

module open_descending_final(width,steps)
{
  difference()
  {
    open_descending_stair(width,steps);
    square_mag_holes(width,1);
    square_openlocks(width,1);
  }
}