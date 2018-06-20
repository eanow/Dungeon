include <libs.scad>;
use <wall_01_solid.scad>;
//wall
*linear_wall(4);
*round_wall(2);
*linear_final(2);
round_final(2);
*import("floor_02_round_solid_final.stl");

*round_mag_holes(2);
*round_wall_holes(2);

module linear_final(size)
{
    intersection()
    {
        import("wall_linear_02_chipped_a.stl");
        translate([0,0,wall_height/2-ep+floor_thick])cube([size*3*basis,size*3*basis,wall_height],center=true);
    }

    intersection()
    {
        cube([size*3*basis,size*3*basis,2*(floor_thick)],center=true);
        difference()
        {
            linear_wall(size);
            linear_mag_holes(size);
            //linear_openlocks(size,size);
        }
    }
}

module round_final(size)
{
    *intersection()
    {
        import("wall_round_02_solid.stl");
        translate([0,0,wall_height/2-1-ep+floor_thick])cube([size*3*basis,size*3*basis,wall_height],center=true);
    }

    //intersection()
    {
        *cube([size*3*basis,size*3*basis,2*(floor_thick)],center=true);
        difference()
        {
            round_wall(size);
            round_wall_holes(size);
            //round_wall_openlocks(size,size);
        }
    }
}