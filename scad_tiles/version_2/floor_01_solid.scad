include <libs.scad>;

//floor
round(2);

*square(4,4);

//import("AS_full.stl");


module square(xsize,ysize)
{
    difference()
    {
        floor_plate(xsize,ysize);
        
        grids(xsize,ysize);
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
