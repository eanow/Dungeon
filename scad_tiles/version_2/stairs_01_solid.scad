include <libs.scad>;
use <floor_01_solid.scad>;
use <wall_01_solid.scad>;

open_ascending_stair(1,4);
*translate([basis*2,0,0])open_descending_stair(1,3);
*linear_wall(4);

module open_ascending_stair(width,steps)
{
  for(aa=[1:steps])
  {
    translate([0,basis*(aa-1),step_up*(aa-1)])square_floor(width,steps-(aa-1));
  }
}
module open_descending_stair(width,steps)
{
  for(aa=[1:steps])
  {
    intersection()
    {
      translate([0,0,-step_up*(aa-1)])square_floor(width,aa);
      square_floor(width,steps);
    }
  }
}