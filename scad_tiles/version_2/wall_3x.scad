thickness=8.5;
tilex=1;
tiley=6;
inch=25.4;
groove=1;


//wall
    difference()
    {
        translate([0,tiley*inch/2,thickness*1.5])cube([inch,tiley*inch,thickness*3],center=true);
        
        pocks=floor(rands(0,(tiley)*1,1)[0]);
        //pocks=0;
        //echo (pocks);
        for (ii=[0:pocks])
        {
            shapenum = floor(rands(0,16,1)[0])+1;
            echo(shapenum);
            angle=floor(rands(0,360,1)[0])+1;
            xx=-1*(thickness*2+inch/2)+((thickness*4+inch))*(rands(0,1,1)[0]); //total area is the top (inch/2) and the wall (2 thicknesses)
            yy=inch*(rands(0,tiley,1)[0]);
            zz1=(inch/2+thickness*3)-xx;  //pivot is going to be the total area, minus how far we've gone so far (xx)
            zz2=xx+(inch/2+thickness*3);
            translate([xx,yy,thickness*3])rotate([0,0,angle])blemish(shapenum);
            translate([inch/2,yy,zz1])rotate([0,90,0])rotate([0,0,angle])blemish(shapenum);
            translate([-inch/2,yy,zz2])rotate([0,-90,0])rotate([0,0,angle])blemish(shapenum);
        }
        for (ii=[0:2])//horizontal lines
        {
            translate([inch/2,tiley*inch/2,thickness*1+(ii*thickness)])rotate([0,45,0])cube([groove,tiley*inch*2,groove],center=true);
            
            translate([-inch/2,tiley*inch/2,thickness*1+(ii*thickness)])rotate([0,45,0])cube([groove,tiley*inch*2,groove],center=true);
            translate([0,0,thickness*1+(ii*thickness)])rotate([45,0,0])cube([inch*2,groove,groove],center=true);
            translate([0,inch*tiley,thickness*1+(ii*thickness)])rotate([45,0,0])cube([inch*2,groove,groove],center=true);
        }
        for (ii=[0:tiley])
            //middle row
        {
            translate([inch/2,inch*ii+inch/2,thickness+thickness*.5])rotate([0,0,45])cube([groove,groove,thickness],center=true);
            translate([-inch/2,inch*ii+inch/2,thickness+thickness*.5])rotate([0,0,45])cube([groove,groove,thickness],center=true);
        }
        for (ii=[0:tiley])
        {
            //top row
            translate([inch/2,inch*ii,thickness*2+thickness*.5])rotate([0,0,45])cube([groove,groove,thickness],center=true);
            translate([-inch/2,inch*ii,thickness*2+thickness*.5])rotate([0,0,45])cube([groove,groove,thickness],center=true);
        }
        for (ii=[0:tiley])
        {
            //top grooves
            translate([0,inch*ii,thickness*3])rotate([45,0,0])cube([inch*2,groove,groove],center=true);
        }

        translate([inch/2,tiley*inch/2,0])rotate([0,30,0])cube([groove,tiley*inch*2,groove*2],center=true);
        translate([-inch/2,tiley*inch/2,0])rotate([0,60,0])cube([groove*2,tiley*inch*2,groove],center=true);
        translate([tilex*inch/2,tiley*inch,0])rotate([60,0,0])cube([tilex*inch*2,groove*2,groove],center=true);
        translate([tilex*inch/2,0,0])rotate([30,0,0])cube([tilex*inch*2,groove,groove*2],center=true);
        
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