include <libs.scad>;

//floor
*round(2);
*diagonal(3,4);
square_floor(6,6);

//import("AS_full.stl");


module square_floor(xsize,ysize)
{
  difference()
  {
    floor_plate(xsize,ysize);
    grids(xsize,ysize);
  }
}
module diagonal(xsize,ysize)
{
  intersection()
  {
    difference()
    {
      floor_plate(xsize,ysize);
      grids(xsize,ysize);
    }
    translate([0,0,floor_thick/2])hull()
    {
      //we want a slanted portion, so we'll hull two thin slivers that reach to the length
      cube([2*xsize*basis-bevel*2*sqrt(2),ep,floor_thick],center=true);
      cube([2*xsize*basis,ep,floor_thick-bevel*2],center=true);
      cube([ep,2*ysize*basis-bevel*2*sqrt(2),floor_thick],center=true);
      cube([ep,2*ysize*basis,floor_thick-bevel*2],center=true);
    }
    translate([0,0,floor_thick/2])cube([xsize*2*basis-bevel*2,ysize*2*basis-bevel*2,floor_thick],center=true);
  }
}
module round(radius)
{
  intersection()
  {
    difference()
    {
      floor_plate(radius,radius);
      grids(radius,radius);
    }
    hull()
    {
      translate([0,0,bevel])cylinder(r=radius*basis,h=floor_thick-bevel*2,$fn=200);
      cylinder(r=radius*basis-bevel,h=floor_thick,$fn=200);
    }
  }
}
