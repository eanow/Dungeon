floor_thick=8.5;
tilex=2;
tiley=2;
basis=25.4;
groove=.6;
bevel=.8;

damage=1;
damage_w=.15;
layer_t=.2;
ep=0.01;
print_wall=1.2;

magnet_r=6/2;

//floor

module floor_plate()
{
    translate([tilex*basis/2,tiley*basis/2,floor_thick/2])hull()
    {
        cube([tilex*basis-bevel*2,tiley*basis-bevel*2,floor_thick],center=true);
        cube([tilex*basis-bevel*2,tiley*basis,floor_thick-bevel*2],center=true);
        cube([tilex*basis,tiley*basis-bevel*2,floor_thick-bevel*2],center=true);
    }
}
module grids()
{
    for (ii=[0:tilex])
    {
        translate([ii*basis,tiley*basis/2,floor_thick])rotate([0,45,0])cube([groove*sqrt(2),tiley*basis*2,groove*sqrt(2)],center=true);
    }
    for (ii=[0:tiley])
    {
        translate([tilex*basis/2,ii*basis,floor_thick])rotate([45,0,0])cube([tilex*basis*2,groove*sqrt(2),groove*sqrt(2)],center=true);
    }
}
module mag_holes()
{
    for (ii=[0:tilex-1])
    {
        translate([ii*basis+basis*.5,magnet_r+print_wall,1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        translate([ii*basis+basis*.5,basis*tiley-(magnet_r+print_wall),1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        //witness holes
        translate([ii*basis+basis*.5,magnet_r+print_wall,1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
        translate([ii*basis+basis*.5,basis*tiley-(magnet_r+print_wall),1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
    }
    for (ii=[0:tiley-1])
    {
        translate([magnet_r+print_wall,ii*basis+basis*.5,1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        translate([basis*tilex-(magnet_r+print_wall),ii*basis+basis*.5,1])cylinder(r=magnet_r,h=magnet_r*2,$fn=16);
        //witness holes
        translate([magnet_r+print_wall,ii*basis+basis*.5,1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
        translate([basis*tilex-(magnet_r+print_wall),ii*basis+basis*.5,1])cylinder(r=.9,h=floor_thick,center=true,$fn=16);
    }
}
difference()
{
    floor_plate();
    
    if (damage>0)
    {
        for (ii=[1:damage])
        {
            shapenum = floor(rands(0,16,1)[0])+1;
            angle=floor(rands(0,360,1)[0])+1;
            xx=basis*(rands(0,tilex,1)[0]);
            yy=basis*(rands(0,tiley,1)[0]);
            translate([xx,yy,0])rotate([0,0,angle])translate([0,0,floor_thick])blemish(shapenum);
        }
    }
    grids();
    mag_holes();
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