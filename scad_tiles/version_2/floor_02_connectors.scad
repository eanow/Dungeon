include <libs.scad>;
use <floor_01_solid.scad>;

//floor
*round_final(2);
*square_final(2,2);
diagonal_final(2,2);

module square_final(xsize,ysize)
{
  intersection()
  {
    import("finalized_stl/floor_square_2x2_b.stl");
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
    cube([xsize*3*basis,ysize*3*basis,2*(floor_thick-floor_depth-ep)],center=true);
    difference()
    {
      diagonal(xsize,ysize);
      square_mag_holes(xsize,ysize);
      square_openlocks(xsize,ysize);
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

