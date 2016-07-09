thickness=8.5;
tilex=3;
tiley=3;
inch=25.4;
groove=1;

difference()
{
    translate([tilex*inch/2,tiley*inch/2,thickness/2])cube([tilex*inch,tiley*inch,thickness],center=true);
    pocks=floor(tilex*tiley/3);
    for (ii=[1:pocks])
    {
        blemish();
    }
    for (ii=[0:tilex])
    {
        translate([ii*inch,tiley*inch/2,thickness])rotate([0,45,0])cube([groove,tiley*inch*2,groove],center=true);
    }
    for (ii=[0:tiley])
    {
        translate([tilex*inch/2,ii*inch,thickness])rotate([45,0,0])cube([tilex*inch*2,groove,groove],center=true);
    }
    translate([tilex*inch,tiley*inch/2,0])rotate([0,30,0])cube([groove,tiley*inch*2,groove*2],center=true);
    translate([0,tiley*inch/2,0])rotate([0,60,0])cube([groove*2,tiley*inch*2,groove],center=true);
    translate([tilex*inch/2,tiley*inch,0])rotate([60,0,0])cube([tilex*inch*2,groove*2,groove],center=true);
    translate([tilex*inch/2,0,0])rotate([30,0,0])cube([tilex*inch*2,groove,groove*2],center=true);
}

//blemish();
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
module blemish()
{
    shapenum = floor(rands(0,16,1)[0])+1;
    angle=floor(rands(0,360,1)[0])+1;
    xx=inch*(rands(0,tilex,1)[0]);
    yy=inch*(rands(0,tiley,1)[0]);
    translate([xx,yy,0])rotate([0,0,angle])translate([0,0,thickness])
    {
        translate([0,0,-.5])linear_extrude(height=.101)selectshape(shapenum);
        translate([0,0,-.4])linear_extrude(height=.101)minkowski(){selectshape(shapenum); circle(r=.1);}
        translate([0,0,-.3])linear_extrude(height=.101)minkowski(){selectshape(shapenum); circle(r=.2);}
        translate([0,0,-.2])linear_extrude(height=.101)minkowski(){selectshape(shapenum); circle(r=.3);}
        translate([0,0,-.1])linear_extrude(height=.101)minkowski(){selectshape(shapenum); circle(r=.4);}
    }
}
module shape01()
{
    translate([-3,-2])scale(.8)import("shape001.dxf");
}
module shape02()
{
    translate([-3,-2])scale(.8)import("shape002.dxf");
}
module shape03()
{
    translate([-3,-2,0])scale(.8)import("shape003.dxf");
}
module shape04()
{
    translate([-14,-18,0])scale(.8)import("shape004.dxf");
}
module shape05()
{
    translate([-13,-10,0])scale(.8)import("shape005.dxf");
}
module shape06()
{
    translate([-2,-4,0])scale(.32)import("shape006.dxf");
}
module shape07()
{
    translate([-9,-9,0])scale(.3)import("shape007.dxf");
}
module shape08()
{
    translate([-6,-12,0])scale(.6)import("shape008.dxf");
}
module shape09()
{
    translate([-2,-2,0])scale(.2)import("shape009.dxf");
}
module shape10()
{
    translate([-1,-3,0])scale(.1)import("shape010.dxf");
}
module shape11()
{
    translate([-2,-4,0])scale(.3)import("shape011.dxf");
}
module shape12()
{
    translate([-6,-2,0])scale(.6)import("shape012.dxf");
}
module shape13()
{
    translate([-9,-14,0])scale(.7)import("shape013.dxf");
}
module shape14()
{
    translate([-0.5,-1,0])scale(.1)import("shape014.dxf");
}
module shape15()
{
    translate([-.5,-.5,0])scale(.1)import("shape015.dxf");
}
module shape16()
{
    translate([-6,-6,0])scale(.5)import("shape016.dxf");
}