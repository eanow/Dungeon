
floor_thick=10.6;
floor_depth=2;
//tilex=2;
//tiley=2;
basis=25.4;
groove=1;
floor_cut=.6;
bevel=.8;

damage=0;
damage_w=.15;
layer_t=.2;
ep=0.01;
print_wall=1.2;

magnet_r=6/2;

//floor
round(2);
*square(2,2);
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
module square_mag_holes(xsize,ysize)
{
    for (ii=[0:xsize-1])
    {
        translate([ii*basis+basis*.5,magnet_r+print_wall,1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        translate([ii*basis+basis*.5,basis*ysize-(magnet_r+print_wall),1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        //witness holes
        translate([ii*basis+basis*.5,magnet_r+print_wall,1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
        translate([ii*basis+basis*.5,basis*ysize-(magnet_r+print_wall),1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
    }
    for (ii=[0:ysize-1])
    {
        translate([magnet_r+print_wall,ii*basis+basis*.5,1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        translate([basis*xsize-(magnet_r+print_wall),ii*basis+basis*.5,1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        //witness holes
        translate([magnet_r+print_wall,ii*basis+basis*.5,1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
        translate([basis*xsize-(magnet_r+print_wall),ii*basis+basis*.5,1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
    }
}
module round_mag_holes(radius)
{
    //flat sides
    for (ii=[0:radius-1])
    {
        translate([ii*basis+basis*.5,magnet_r+print_wall,1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);

        //witness holes
        translate([ii*basis+basis*.5,magnet_r+print_wall,1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);

    }
    for (ii=[0:radius-1])
    {
        translate([magnet_r+print_wall,ii*basis+basis*.5,1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);

        //witness holes
        translate([magnet_r+print_wall,ii*basis+basis*.5,1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);

    }
    //round edges
    
    offset=sqrt((basis*radius*basis*radius)-(basis*basis/4))-magnet_r-print_wall;
    //near y axis
    translate([basis/2,offset,1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
    //witness holes
    translate([basis/2,offset,1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
    //near x axis
    translate([offset,basis/2,1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
    //witness holes
    translate([offset,basis/2,1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
}
module square(xsize,ysize)
{
    difference()
    {
        floor_plate(xsize,ysize);
        
        if (damage>0)
        {
            for (ii=[1:damage])
            {
                shapenum = floor(rands(0,16,1)[0])+1;
                angle=floor(rands(0,360,1)[0])+1;
                xx=basis*(rands(0,xsize,1)[0]);
                yy=basis*(rands(0,ysize,1)[0]);
                translate([xx,yy,0])rotate([0,0,angle])translate([0,0,floor_thick])blemish(shapenum);
            }
        }
        grids(xsize,ysize);
        square_mag_holes(xsize,ysize);
    }
}
module round(radius)
{
    intersection()
    {
        difference()
        {
            floor_plate(radius,radius);
            
            if (damage>0)
            {
                for (ii=[1:damage])
                {
                    shapenum = floor(rands(0,16,1)[0])+1;
                    angle=floor(rands(0,360,1)[0])+1;
                    xx=basis*(rands(0,radius,1)[0]);
                    yy=basis*(rands(0,radius,1)[0]);
                    translate([xx,yy,0])rotate([0,0,angle])translate([0,0,floor_thick])blemish(shapenum);
                }
            }
            grids(radius,radius);
            #round_mag_holes(radius);
        }
        hull()
        {
            translate([0,0,bevel])cylinder(r=radius*basis,h=floor_thick-bevel*2,$fn=200);
            cylinder(r=radius*basis-bevel,h=floor_thick,$fn=200);
        }
    }
}



module selectshape(shapenum)
{
    
    if (shapenum==1){ shape01(); }
    if (shapenum==2){ shape02(); }
    if (shapenum==3){ shape03(); }
    if (shapenum==4){ shape04(); }
    if (shapenum==5){ shape05(); }
    if (shapenum==6){ shape06(); }
    if (shapenum==7){ shape07(); }
    if (shapenum==8){ shape08(); }
    if (shapenum==9){ shape09(); }
    if (shapenum==10){ shape10(); }
    if (shapenum==11){ shape11(); }
    if (shapenum==12){ shape12(); }
    if (shapenum==13){ shape13(); }
    if (shapenum==14){ shape14(); }
    if (shapenum==15){ shape15(); }
    if (shapenum==16){ shape16(); }
}
module blemish(shapenum)
{
    $fn=20;
    translate([0,0,-5*layer_t])linear_extrude(height=layer_t+ep)selectshape(shapenum);
    translate([0,0,-4*layer_t])linear_extrude(height=layer_t+ep)offset(r=damage_w*1)selectshape(shapenum);
    translate([0,0,-3*layer_t])linear_extrude(height=layer_t+ep)offset(r=damage_w*2)selectshape(shapenum);
    translate([0,0,-2*layer_t])linear_extrude(height=layer_t+ep)offset(r=damage_w*3)selectshape(shapenum);
    translate([0,0,-1*layer_t])linear_extrude(height=layer_t+ep)offset(r=damage_w*4)selectshape(shapenum);
}
module shape01()
{
    translate([-3,-2])scale(.8)import("blemish/shape001.dxf");
}
module shape02()
{
    translate([-3,-2])scale(.8)import("blemish/shape002.dxf");
}
module shape03()
{
    translate([-3,-2,0])scale(.8)import("blemish/shape003.dxf");
}
module shape04()
{
    translate([-14,-18,0])scale(.8)import("blemish/shape004.dxf");
}
module shape05()
{
    translate([-13,-10,0])scale(.8)import("blemish/shape005.dxf");
}
module shape06()
{
    translate([-2,-4,0])scale(.32)import("blemish/shape006.dxf");
}
module shape07()
{
    translate([-9,-9,0])scale(.3)import("blemish/shape007.dxf");
}
module shape08()
{
    translate([-6,-12,0])scale(.6)import("blemish/shape008.dxf");
}
module shape09()
{
    translate([-2,-2,0])scale(.2)import("blemish/shape009.dxf");
}
module shape10()
{
    translate([-1,-3,0])scale(.1)import("blemish/shape010.dxf");
}
module shape11()
{
    translate([-2,-4,0])scale(.3)import("blemish/shape011.dxf");
}
module shape12()
{
    translate([-6,-2,0])scale(.6)import("blemish/shape012.dxf");
}
module shape13()
{
    translate([-9,-14,0])scale(.7)import("blemish/shape013.dxf");
}
module shape14()
{
    translate([-0.5,-1,0])scale(.1)import("blemish/shape014.dxf");
}
module shape15()
{
    translate([-.5,-.5,0])scale(.1)import("blemish/shape015.dxf");
}
module shape16()
{
    translate([-6,-6,0])scale(.5)import("blemish/shape016.dxf");
}