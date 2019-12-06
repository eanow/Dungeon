include <libs.scad>;

//wall
*linear_wall(4);
*round_wall(2);
corner_wall(6);
*shim_wall(2);
*import("finalized_stl/square_floor/floor_square_2x2_a.stl");

module shim_wall(size)
{
  translate([-wall_width/2,size*basis/2,floor_thick/2])hull()
  {
    cube([wall_width,basis*size-bevel*2,floor_thick-bevel*2],center=true);
    cube([wall_width-bevel*2,basis*size,floor_thick-bevel*2],center=true);
    cube([wall_width-bevel*2,basis*size-bevel*2,floor_thick],center=true);
  }
}


module linear_wall_base(size, height=wall_height)
{
    translate([-wall_width/2,size*basis/2,height/2])hull()
    {
        cube([wall_width-bevel*2,size*basis,height-bevel*2],center=true);
        cube([wall_width-bevel*2,size*basis-bevel*2,height],center=true);
        cube([wall_width,size*basis-bevel*2,height-bevel*2],center=true);
    }
}

module round_wall_base(size)
{
    difference()
    {
        hull()
        {
            translate([0,0,bevel])cylinder(r=size*basis+wall_width,h=wall_height-bevel*2);
            cylinder(r=size*basis+wall_width-bevel,h=wall_height);
        }
        cylinder(r=size*basis,h=wall_height);
        translate([0,0,-ep])cylinder(r1=size*basis+bevel,r2=size*basis,h=bevel);
        translate([0,0,wall_height-bevel+ep])cylinder(r2=size*basis+bevel,r1=size*basis,h=bevel);
    }
}

module linear_brick_grids(size)
{
    //one for each wall level, horizontal
    brick_h=(wall_height-floor_thick)/wall_layers;
    for (ii=[0:wall_layers-1])
    {
        translate([0,size*basis/2,floor_thick+ii*brick_h])rotate([0,45,0])cube([wall_groove*sqrt(2),size*basis*2,wall_groove*sqrt(2)],center=true);
    }
    //vertical
    //one above floor is off by half, then even, then off
    for (ii=[1:1:wall_layers])
    {
        for(jj=[0:.5:size+1])
        {
            translate([0,jj*basis-(ii%6)*basis/6,floor_thick+ii*brick_h-brick_h/2])rotate([0,0,45])cube([wall_groove*sqrt(2),wall_groove*sqrt(2),brick_h],center=true);
        }
    }
}

module round_brick_grids(size)
{
    brick_h=(wall_height-floor_thick)/wall_layers;
    //horizontal
    for (ii=[0:wall_layers-1])
    {
        translate([0,0,floor_thick+ii*brick_h])hull()
        {
            cylinder(r=basis*size+wall_groove,h=ep,center=true);
            cylinder(r=basis*size,h=wall_groove*2,center=true);
        }
    }
    //vertical
    //vertical should be shifted each layer
    for (ii=[1:1:wall_layers])
    {
        for(jj=[0:30/size:120])
        {
            rotate([0,0,jj+(ii%6)*(10/size)])translate([basis*size,0,floor_thick+ii*brick_h-brick_h/2])rotate([0,0,45])cube([wall_groove*sqrt(2),wall_groove*sqrt(2),brick_h],center=true);
        }
    }
}

module round_wall(size)
{
    xx=basis*size+wall_width;
    yy=basis*size+wall_width;
    zz=wall_height;
    difference()
    {
        intersection()
        {
            round_wall_base(size);
            translate([.5*(basis*size+wall_width),.5*(basis*size+wall_width),wall_height/2])hull()
            {
                cube([xx-bevel*2,yy,zz-bevel*2],center=true);
                cube([xx-bevel*2,yy-bevel*2,zz],center=true);
                cube([xx,yy-bevel*2,zz-bevel*2],center=true);
            }
        }
        hull()
        {
            cube([basis*size*2+bevel*2,ep,zz*3],center=true);
            cube([ep,basis*size*2+bevel*2,zz*3],center=true);
        }
        round_brick_grids(size);
    }
}

module linear_wall(size)
{
    difference()
    {
        linear_wall_base(size);
        linear_brick_grids(size);
        *translate([-wall_width,0,0])linear_brick_grids(size);
    }
}

module corner_wall(size)
{
  intersection()
  {
    linear_wall(size);
    //45 degree slope so we can do inside corners
    translate([0,0,0])hull()
    {
      //beveling
      translate([0,0,-ep])linear_extrude(wall_height+ep*2)offset(delta=-bevel)hull()
      {
        translate([0,basis*0.5*size])square([ep,basis*size-wall_tol*2],center=true);
        translate([-wall_width,basis*0.5*size])square([ep,basis*size-wall_tol*2-wall_width*2],center=true);
      }
      translate([0,0,bevel])linear_extrude(wall_height-bevel*2)hull()
      {
        translate([0,basis*0.5*size])square([ep,basis*size-wall_tol*2],center=true);
        translate([-wall_width,basis*0.5*size])square([ep,basis*size-wall_tol*2-wall_width*2],center=true);
      }
    }
  }
}

