include <libs.scad>;
use <floor_01_solid.scad>;

//floor
round_final(2);
*square_final(4,4);

module square_final(xsize,ysize)
{
    intersection()
    {
        import("floor_solid_4x4_chipped_b.stl");
        translate([0,0,floor_thick-ep])cube([xsize*3*basis,ysize*3*basis,floor_depth*2],center=true);
    }

    intersection()
    {
        cube([xsize*3*basis,ysize*3*basis,2*(floor_thick-floor_depth-ep)],center=true);
        difference()
        {
            square(xsize,ysize);
            square_mag_holes(xsize,ysize);
            square_openlocks(xsize,ysize);
        }
    }
}
module round_final(radius)
{
    intersection()
    {
        import("floor_02_round_solid.stl");
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

