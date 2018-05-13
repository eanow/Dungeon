thickness=8.5;
roomx=2;
roomy=2;
inch=25.4;
groove=1;
ep=0.01;

difference()
{
    union()
    {
        difference()
        {
            union()
            {
                floor();
                wall();
            }
            floorgrid();
            wallgrid();
            cornerclean();
            for (ii=[0:1])
            {
                pock();
            }
        }
        backfill();
    }
    printable(); 
    translate([inch/2+inch,inch/2,0])door();
}




//%translate([inch/2+inch,inch/2,0])door();













module door()
{
    translate([0,-inch/2,thickness*2])cube([inch*2+ep,inch+ep,thickness*4+ep],center=true);
    translate([-inch,-inch/2,0])rotate([0,30,0])cube([groove,inch+.13,groove*2],center=true);
    translate([inch,-inch/2,0])rotate([0,60,0])cube([groove*2,inch+.13,groove],center=true);
    translate([0,0,0])rotate([30,0,0])cube([inch*2+.13,groove,groove*2],center=true);
    intersection()
    {
        translate([inch,-inch/2,0])rotate([0,60,0])cube([groove*2,inch*2,groove],center=true);
        translate([0,0,0])rotate([30,0,0])cube([inch*3+.13,groove,groove*2],center=true);
    }
    intersection()
    {
        translate([-inch,-inch/2,0])rotate([0,30,0])cube([groove,inch*2,groove*2],center=true);
        translate([0,0,0])rotate([30,0,0])cube([inch*3+.13,groove,groove*2],center=true);
    }
    //lines
    translate([-inch,-inch/4,thickness*1+(0*thickness)])rotate([0,45,0])cube([groove,inch,groove],center=true);
    translate([-inch,-inch/4,thickness*1+(1*thickness)])rotate([0,45,0])cube([groove,inch,groove],center=true);
    translate([-inch,-inch/4,thickness*1+(2*thickness)])rotate([0,45,0])cube([groove,inch,groove],center=true);
    
    //lines
    translate([inch,-inch/4,thickness*1+(0*thickness)])rotate([0,45,0])cube([groove,inch,groove],center=true);
    translate([inch,-inch/4,thickness*1+(1*thickness)])rotate([0,45,0])cube([groove,inch,groove],center=true);
    translate([inch,-inch/4,thickness*1+(2*thickness)])rotate([0,45,0])cube([groove,inch,groove],center=true);
    
    //verticals
    translate([-inch,-inch/2,thickness*1+thickness/2])rotate([0,0,45])cube([groove,groove,thickness],center=true);
    translate([inch,-inch/2,thickness*1+thickness/2])rotate([0,0,45])cube([groove,groove,thickness],center=true);
}



module backfill()
{
//backfill
//depth of picks is .5
fill=.7;
translate([roomx*inch/2+inch/2,roomy*inch/2+inch/2,thickness/2-fill/2])cube([(roomx+1)*inch,(roomy+1)*inch,thickness-fill],center=true);

translate([inch/4-fill/2,(roomy+1)*inch/2,(thickness)*1.5-fill/2])cube([inch/2-fill,(roomy+1)*inch,thickness*3-fill],center=true);
translate([(roomx+1)*inch-inch/4+fill/2,(roomy+1)*inch/2,(thickness)*1.5-fill/2])cube([inch/2-fill,(roomy+1)*inch,thickness*3-fill],center=true);

translate([(roomx+1)*inch/2,inch/4-fill/2,thickness*1.5-fill/2])cube([(roomx+1)*inch,inch/2-fill,thickness*3-fill],center=true);
translate([(roomx+1)*inch/2,(roomy+1)*inch-inch/4+fill/2,thickness*1.5-fill/2])cube([(roomx+1)*inch,inch/2-fill,thickness*3-fill],center=true);
}

module printable()
{
    //30 degree angles
    translate([(roomx+1)*inch,(roomy+1)*inch/2,0])rotate([0,30,0])cube([groove,(1+roomy)*inch*2,groove*2],center=true);
    translate([0,(roomy+1)*inch/2,0])rotate([0,60,0])cube([groove*2,(roomy+1)*inch*2,groove],center=true);
    translate([(roomx+1)*inch/2,(1+roomy)*inch,0])rotate([60,0,0])cube([(1+roomx)*inch*2,groove*2,groove],center=true);
    translate([(roomx+1)*inch/2,0,0])rotate([30,0,0])cube([(1+roomx)*inch*2,groove,groove*2],center=true);
}
module pock()
{
    shapenum = floor(rands(0,16,1)[0])+1;
    angle=floor(rands(0,360,1)[0])+1;
    //map to unfolded
    xx=(roomx*inch+thickness*4+inch)*(rands(0,1,1)[0]);
    echo(xx);
    //xx=roomx*inch+inch/2+thickness*4;
    yy=(roomy*inch+thickness*4+inch)*(rands(0,1,1)[0]);
    echo(yy);
    //yy=inch/2+thickness*4+roomy*inch;
    
    //floor mapping
    floorx=xx-thickness*2;
    floory=yy-thickness*2;
    //floor
    translate([floorx,floory,thickness])rotate([0,0,angle])blemish(shapenum);
    //yaxis near
    
    yy1=yy-thickness*2;
    xx1=xx;
    intersection()
    {
        translate([xx1,yy1,thickness*3])rotate([0,0,angle])blemish(shapenum);
        translate([inch/4,roomy*inch/2+inch/2,thickness*2])cube([inch/2,roomy*inch,thickness*4],center=true);
    }
    //yaxis near wall
    yy2=yy-thickness*2;
    xx2=xx-inch/2;
    intersection()
    {
        translate([inch/2,0,thickness*3])rotate([0,90,0])translate([xx2,yy2,0])rotate([0,0,angle])blemish(shapenum);
        translate([inch/4,roomy*inch/2+inch/2,thickness*2])cube([inch,roomy*inch,thickness*4],center=true);
    }
    //edge near far y
    yy3=yy-thickness*2;
    xx3=xx-thickness*4;
    intersection()
    {
        translate([xx3,yy3,thickness*3])rotate([0,0,angle])blemish(shapenum);
        //translate([xx3,yy3,thickness*3])rotate([0,0,angle])cylinder(r=5,h=2,center=true);
        translate([(roomx+1)*inch-inch/4,roomy*inch/2+inch/2,thickness*2])cube([inch/2,roomy*inch,thickness*4],center=true);
    }
    //yaxis far wall
    yy4=yy-thickness*2;
    xx4=xx-(roomx)*inch-thickness*4-inch/2;
    intersection()
    {
        translate([(roomx+1)*inch-inch/2,0,thickness*3])rotate([0,-90,0])translate([xx4,yy4,0])rotate([0,0,angle])blemish(shapenum);
        //translate([(roomx+1)*inch-inch/2,0,thickness*3])rotate([0,-90,0])translate([xx4,yy4,0])rotate([0,0,angle])cylinder(r=5,h=2,center=true);
        translate([(roomx+1)*inch-inch/4,roomy*inch/2+inch/2,thickness*2])cube([inch,roomy*inch,thickness*4],center=true);
    }
    
    //near x axis
    yy5=yy;
    xx5=xx-thickness*2;
    intersection()
    {
        translate([xx5,yy5,thickness*3])rotate([0,0,angle])blemish(shapenum);
        translate([roomx*inch/2+inch/2,inch/4,thickness*2])cube([roomx*inch,inch/2,thickness*4],center=true);
    }
    yy6=yy-inch/2;
    xx6=xx-thickness*2;
    intersection()
    {
        translate([0,inch/2,thickness*3])rotate([270,0,0])translate([xx6,yy6,0])rotate([0,0,angle])blemish(shapenum);
        translate([roomx*inch/2+inch/2,inch/4,thickness*2])cube([roomx*inch,inch,thickness*4],center=true);
    }
    //far x axis
    yy7=yy-thickness*4;
    xx7=xx-thickness*2;
    intersection()
    {
        translate([xx7,yy7,thickness*3])rotate([0,0,angle])blemish(shapenum);
        translate([roomy*inch/2+inch/2,(roomy+1)*inch-inch/4,thickness*2])cube([roomx*inch,inch/2,thickness*4],center=true);
    }
    yy8=yy-(roomy)*inch-thickness*4-inch/2;
    xx8=xx-thickness*2;
    intersection()
    {
        translate([0,(roomx+1)*inch-inch/2,thickness*3])rotate([-270,0,0])translate([xx8,yy8,0])rotate([0,0,angle])blemish(shapenum);
        
        translate([roomx*inch/2+inch/2,(roomx+1)*inch-inch/4,thickness*2])cube([roomx*inch,inch,thickness*4],center=true);
    }
}

module floor()
{
    translate([roomx*inch/2+inch/2,roomy*inch/2+inch/2,thickness/2])cube([(roomx+1)*inch,(roomy+1)*inch,thickness],center=true);
}
module wall()
{
    translate([inch/4,(roomy+1)*inch/2,thickness*1.5])cube([inch/2,(roomy+1)*inch,thickness*3],center=true);
    translate([(roomx+1)*inch-inch/4,(roomy+1)*inch/2,thickness*1.5])cube([inch/2,(roomy+1)*inch,thickness*3],center=true);
    
    translate([(roomx+1)*inch/2,inch/4,thickness*1.5])cube([(roomx+1)*inch,inch/2,thickness*3],center=true);
    translate([(roomx+1)*inch/2,(roomy+1)*inch-inch/4,thickness*1.5])cube([(roomx+1)*inch,inch/2,thickness*3],center=true);
}
module floorgrid()
{
    for (ii=[0:roomx])
    {
        translate([ii*inch+inch/2,roomy*inch/2+inch/2,thickness])rotate([0,45,0])cube([groove,roomy*inch,groove],center=true);
    }
    for (ii=[0:roomy])
    {
        translate([roomx*inch/2+inch/2,ii*inch+inch/2,thickness])rotate([45,0,0])cube([roomx*inch,groove,groove],center=true);
    }
}
module wallgrid()
{
    //horizontal lines, y
    translate([inch/2,roomy*inch/2+inch/2,thickness*1+(0*thickness)])horyline();
    translate([inch/2,roomy*inch/2+inch/2,thickness*1+(1*thickness)])horyline();

    //horizontal lines, far y
    translate([roomx*inch+inch/2,roomy*inch/2+inch/2,thickness*1+(0*thickness)])horyline();
    translate([roomx*inch+inch/2,roomy*inch/2+inch/2,thickness*1+(1*thickness)])horyline();

    //horizontal lines, x
    translate([roomx*inch/2+inch/2,inch/2,thickness*1+(0*thickness)])horxling();
    translate([roomx*inch/2+inch/2,inch/2,thickness*1+(1*thickness)])horxling();

    //horizontal lines, far x
    translate([roomx*inch/2+inch/2,roomx*inch+inch/2,thickness*1+(0*thickness)])horxling();
    translate([roomx*inch/2+inch/2,roomx*inch+inch/2,thickness*1+(1*thickness)])horxling();
    

    for (ii=[0:roomx])
    {
        translate([ii*inch+inch/2,roomy*inch/2+inch/2,thickness*1+(2*thickness)])rotate([0,45,0])cube([groove,roomy*inch*2,groove],center=true); 
    }
    for (ii=[0:roomy])
    {
        translate([roomx*inch/2+inch/2,ii*inch+inch/2,thickness*1+(2*thickness)])rotate([45,0,0])cube([roomx*inch*2,groove,groove],center=true);
    }
    
    for (ii=[0:roomx])
    {
        translate([ii*inch,0,thickness*2])vertline();
        translate([ii*inch,roomy*inch,thickness*2])vertline();
    }
    for (ii=[0:roomy])
    {
        translate([0,ii*inch,thickness*2])vertline();
        translate([roomx*inch,ii*inch,thickness*2])vertline();
    }
    
    for (ii=[1:roomx])
    {
        translate([ii*inch-inch/2,0,thickness*1])vertline();
        translate([ii*inch-inch/2,roomy*inch,thickness*1])vertline();
    }
    for (ii=[1:roomy])
    {
        translate([0,ii*inch-inch/2,thickness*1])vertline();
        translate([roomx*inch,ii*inch-inch/2,thickness*1])vertline();
    }
}
module horxling()
{
    rotate([45,0,0])cube([roomx*inch,groove,groove],center=true);
}
module horyline()
{
    rotate([0,45,0])cube([groove,roomy*inch,groove],center=true);
}
module wallcorner()
{
    intersection()
    {
        rotate([45,0,0])cube([2*groove,groove,groove],center=true);
        rotate([0,45,0])cube([groove,2*groove,groove],center=true);
    }
}
module cornerclean()
{
    translate([inch/2,inch/2,thickness])wallcorner();
    translate([inch/2,inch/2,2*thickness])wallcorner();
    translate([roomx*inch+inch/2,inch/2,thickness])wallcorner();
    translate([roomx*inch+inch/2,inch/2,2*thickness])wallcorner();
    translate([roomx*inch+inch/2,roomy*inch+inch/2,thickness])wallcorner();
    translate([roomx*inch+inch/2,roomy*inch+inch/2,2*thickness])wallcorner();
    translate([inch/2,roomy*inch+inch/2,thickness])wallcorner();
    translate([inch/2,roomy*inch+inch/2,2*thickness])wallcorner();
}
module vertline()
{
    translate([inch/2,inch/2,thickness/2])rotate([0,0,45])cube([groove,groove,thickness],center=true);
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