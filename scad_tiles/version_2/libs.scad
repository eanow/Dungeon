/* set values */
//bottom thickness, total
floor_thick=10.6;
//line cuts, depth from top of bottom
floor_depth=1.6;
//square basis (inch)
basis=25.4;
//width scale for grid 45 degree edges
groove=1.2;
//width of the floor grid lines
floor_cut=1;
//bottom side bevel
bevel=.8;
//layer thickness
layer_t=.2;
//line width
line_w=.4;
//small value
ep=0.01;
//how much wall to put around the magnets
print_wall=.7;
//magnet
magnet_r=6/2;
//wall width
wall_width=(magnet_r*2+print_wall*2);
//how many layers of bricks
wall_layers=5;
//height of wall, short
wall_height=1*basis+floor_thick;
//brick grooves in wall
wall_groove=.6;
//easy lock removal
removal_h=6.2;
removal_w=7;
removal_setback=8;
$fs=1;
$fa=1;
//slope wall
wall_tol=.2;
//interior walls
interior_thick=2*(1.2+wall_groove);
//door
door_height=wall_height-3-floor_thick;
door_h_tol=.6;
door_w_tol=.4;
dual_door_width=2*basis-2*(wall_width);
door_pin_r=1.75/2+.2;
door_deco_inset=.3;
hinge_t=.8;
//steps
step_up=2.8;

module floor_plate(xsize,ysize)
{
    translate([xsize*basis/2,ysize*basis/2,floor_thick/2])hull()
    {
        cube([xsize*basis-bevel*2,ysize*basis-bevel*2,floor_thick],center=true);
        cube([xsize*basis-bevel*2,ysize*basis,floor_thick-bevel*2],center=true);
        cube([xsize*basis,ysize*basis-bevel*2,floor_thick-bevel*2],center=true);
    }
}

module grids(xsize,ysize)
{
    for (ii=[0:xsize])
    {
        translate([ii*basis,ysize*basis/2,floor_thick])rotate([0,45,0])cube([groove*sqrt(2),ysize*basis*2,groove*sqrt(2)],center=true);
        translate([ii*basis,ysize*basis/2,floor_thick-floor_depth/2])rotate([0,0,0])cube([floor_cut,ysize*basis*2,floor_depth],center=true);
    }
    for (ii=[0:ysize])
    {
        translate([xsize*basis/2,ii*basis,floor_thick])rotate([45,0,0])cube([xsize*basis*2,groove*sqrt(2),groove*sqrt(2)],center=true);
        translate([xsize*basis/2,ii*basis,floor_thick-floor_depth/2])rotate([0,0,0])cube([xsize*basis*2,floor_cut,floor_depth],center=true);
    }
}

/*
 * Openlock connection bay
 */
module openlock_chamber(buffer=0) {
    translate([-buffer,-7,1.4]) cube([2+buffer,7*2,4.4]);
    hull() {
        translate([0,-6,1.4]) cube([2,6*2,4.4]);
        translate([3+0.01,-5,1.4]) cube([2,5*2,4.4]);
    }
    translate([5,-5,1.4]) cube([8,5*2,4.4]);
    translate([7.55,-5.25,1.4]) cube([6,5.5*2,4.4]);
}
module square_openlocks(xsize,ysize)
{
    //left side
    if (ysize>1)
    {
        for(aa=[1:ysize-1])
        {
            translate([0,aa*basis,0])openlock_chamber(1);
        }
        *translate([removal_w/2+removal_setback,basis*(ysize)*.5,removal_h/2-ep])cube([removal_w,basis*(ysize)-removal_setback*2,removal_h],center=true);
        //right side
        for(aa=[1:ysize-1])
        {
            translate([xsize*basis,aa*basis,0])rotate([0,0,180])openlock_chamber(1);
        }
        *translate([(basis*xsize)-(removal_w/2+removal_setback),basis*(ysize)*.5,removal_h/2-ep])cube([removal_w,basis*(ysize)-removal_setback*2,removal_h],center=true);
    }
    if (xsize>1)
    {
        //front side
        for(aa=[1:xsize-1])
        {
            translate([aa*basis,0,0])rotate([0,0,90])openlock_chamber(1);
        }
        *translate([basis*(xsize)*.5,removal_w/2+removal_setback,removal_h/2-ep])cube([basis*(xsize)-removal_setback*2,removal_w,removal_h],center=true);
        //back side
        for(aa=[1:xsize-1])
        {
            translate([aa*basis,ysize*basis,0])rotate([0,0,270])openlock_chamber(1);
        }
        *translate([basis*(xsize)*.5,(ysize*basis)-(removal_w/2+removal_setback),removal_h/2-ep])cube([basis*(xsize)-removal_setback*2,removal_w,removal_h],center=true);
    }
}
module linear_openlocks(size)
{
    //left side
    if (size>1)
    {
        for(aa=[1:size-1])
        {
            translate([0,aa*basis,0])rotate([0,0,180])openlock_chamber(1);
        }
    }
}
module round_openlocks(size)
{
    if (size>1)
    {
        rotate([0,0,45])translate([size*basis,0,0])rotate([0,0,180])openlock_chamber(1);
    }
    //left side
    if (size>1)
    {
        for(aa=[1:size-1])
        {
            translate([0,aa*basis,0])openlock_chamber(1);
        }
        
    }
    if (size>1)
    {
        //front side
        for(aa=[1:size-1])
        {
            translate([aa*basis,0,0])rotate([0,0,90])openlock_chamber(1);
        }
        
    }
}
module round_wall_openlocks(size)
{
    if (size>1)
    {
        rotate([0,0,45])translate([size*basis,0,0])openlock_chamber(1);
    }
}
*diagonal_mag_holes(2,2);
module diagonal_mag_holes(xsize,ysize)
{
//flat sides
  for (ii=[0:xsize-1])
  {
    translate([ii*basis+basis*.5,magnet_r+print_wall,1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);

    //witness holes
    translate([ii*basis+basis*.5,magnet_r+print_wall,1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);

  }
  for (ii=[0:ysize-1])
  {
    translate([magnet_r+print_wall,ii*basis+basis*.5,1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);

    //witness holes
    translate([magnet_r+print_wall,ii*basis+basis*.5,1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);

  }
  //diagonal edge
  if ((xsize==2)&&(ysize==2))
  {
    translate([basis/2,2*basis-basis/2-magnet_r,0])
    {
      cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
    }
  }
}
*%hull()
{
  square([4*basis,ep],center=true);
  square([ep,4*basis],center=true);
}
module square_mag_holes(xsize,ysize)
{
    for (ii=[0:xsize-1])
    {
        translate([ii*basis+basis*.5,magnet_r+print_wall,1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        translate([ii*basis+basis*.5,basis*ysize-(magnet_r+print_wall),1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        //witness holes
        translate([ii*basis+basis*.5,magnet_r+print_wall,1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
        translate([ii*basis+basis*.5,basis*ysize-(magnet_r+print_wall),1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
    }
    for (ii=[0:ysize-1])
    {
        translate([magnet_r+print_wall,ii*basis+basis*.5,1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        translate([basis*xsize-(magnet_r+print_wall),ii*basis+basis*.5,1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        //witness holes
        translate([magnet_r+print_wall,ii*basis+basis*.5,1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
        translate([basis*xsize-(magnet_r+print_wall),ii*basis+basis*.5,1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
    }
}
module linear_mag_holes(size)
{
    for (ii=[0:size-1])
    {
        translate([-magnet_r-print_wall,ii*basis+basis*.5,1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        
        //witness holes
        translate([-magnet_r-print_wall,ii*basis+basis*.5,1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
        
    }
}
module round_wall_holes(radius)
{
    //round edges
    
    offset=sqrt((basis*radius*basis*radius)-(basis*basis/4))+magnet_r+print_wall;
    //near y axis
    translate([basis/2,offset,1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
    //witness holes
    translate([basis/2,offset,1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
    //near x axis
    translate([offset,basis/2,1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
    //witness holes
    translate([offset,basis/2,1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
}
module round_mag_holes(radius)
{
    //flat sides
    for (ii=[0:radius-1])
    {
        translate([ii*basis+basis*.5,magnet_r+print_wall,1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);

        //witness holes
        translate([ii*basis+basis*.5,magnet_r+print_wall,1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);

    }
    for (ii=[0:radius-1])
    {
        translate([magnet_r+print_wall,ii*basis+basis*.5,1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);

        //witness holes
        translate([magnet_r+print_wall,ii*basis+basis*.5,1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);

    }
    //round edges
    
    offset=sqrt((basis*radius*basis*radius)-(basis*basis/4))-magnet_r-print_wall;
    //near y axis
    translate([basis/2,offset,1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
    //witness holes
    translate([basis/2,offset,1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
    //near x axis
    translate([offset,basis/2,1])rotate([0,0,360/32])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
    //witness holes
    translate([offset,basis/2,1])rotate([0,0,360/32])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
}