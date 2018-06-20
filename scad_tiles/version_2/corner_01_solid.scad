include <libs.scad>;
use <wall_01_solid.scad>;

convex_linear();
//concave_linear();
module convex_linear()
{
  difference()
  {
    intersection()
    {
      //two sides meeting
      union()
      {
        translate([0,-basis,0])linear_wall_base(2);
        rotate([0,0,90])translate([0,-basis,0])linear_wall_base(2);
      }
      //cut down the part that sticks out the back
      translate([basis-wall_width*basis,basis-wall_width*basis,wall_height/2])hull()
      {
        cube([2*basis-bevel*2,2*basis-bevel*2,wall_height],center=true);
        cube([2*basis-bevel*2,2*basis,wall_height-bevel*2],center=true);
        cube([2*basis,2*basis-bevel*2,wall_height-bevel*2],center=true);
      }
    }
    
    
      intersection()
      {
        linear_brick_grids(1);
        translate([-wall_groove,0,0])cube([2*basis,2*basis,wall_height]);
        
      }
      intersection()
      {
        rotate([0,0,90])translate([0,-basis,0])linear_brick_grids(1);
        translate([0,-wall_groove,0])cube([2*basis,2*basis,wall_height]);
      }
      intersection()
      {
        linear_brick_grids(1);
        rotate([0,0,90])translate([0,-basis,0])linear_brick_grids(1);
      }
    
  }
}

module concave_linear()
{
  difference()
  {
    //two sides meeting
    union()
    {
      translate([0,0,0])linear_wall_base(1);
      rotate([0,0,-90])translate([0,-basis,0])linear_wall_base(1);
    }
    //apply brick pattern
    linear_brick_grids(1);
    rotate([0,0,-90])translate([0,-basis,0])linear_brick_grids(1);
  }
}