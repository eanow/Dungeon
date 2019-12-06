include <libs.scad>;
use <wall_01_solid.scad>;
use <wall_02_connectors.scad>;
use <floor_01_solid.scad>;

//floor
*round_final(2);
square_final(6,6);
*diagonal_final(3,4);
*translate([3*basis,0,0])rotate([0,0,90-53.1301024])mirror([1,0,0])corner_final(5);
module square_final(xsize,ysize)
{
  intersection()
  {
    import("floor_0606_b.stl");
    translate([0,0,floor_thick-ep])cube([xsize*3*basis,ysize*3*basis,floor_depth*2],center=true);
  }

  intersection()
  {
    cube([xsize*3*basis,ysize*3*basis,2*(floor_thick-floor_depth-ep)],center=true);
    difference()
    {
      square_floor(xsize,ysize);
      square_mag_holes(xsize,ysize);
      square_openlocks(xsize,ysize);
    }
  }
}
module diagonal_final(xsize,ysize)
{
  intersection()
  {
    import("diag_345_c.stl");
    translate([0,0,floor_thick-ep])cube([xsize*3*basis,ysize*3*basis,floor_depth*2],center=true);
  }
  intersection()
  {
    cube([xsize*3*basis,ysize*3*basis,2*(floor_thick-floor_depth-ep)],center=true);
    difference()
    {
      diagonal(xsize,ysize);
      square_mag_holes(xsize,ysize);
      square_openlocks(xsize,ysize);
      translate([3*basis,0,0])rotate([0,0,90-53.1301024])translate([0,1*basis,0])linear_mag_holes(3);
    }
  }
}
module round_final(radius)
{
  intersection()
  {
    import("floor_02_round_solid_chipped_d.stl");
    translate([0,0,floor_thick-ep])cube([radius*3*basis,radius*3*basis,floor_depth*2],center=true);
  }

  intersection()
  {
    cube([radius*3*basis,radius*3*basis,2*(floor_thick-floor_depth-ep)],center=true);
    difference()
    {
      round(radius);
      round_mag_holes(radius);
      round_openlocks(radius);
    }
  }
}

