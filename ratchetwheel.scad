$fa=2;
$fs=.2;
text_size=4.8;

module arc(rr,tt)
{
    rad=rr*1.41421;
    rotate(45,[0,0,1])translate([rad,0])difference()
    {
        circle(r=rad);
        circle(r=rad-tt);
        translate([rad*2,0])square([rad*4,rad*4],center=true);
        translate([0,-rad*2])square([rad*4,rad*4],center=true);
    }
}
module ratchet(rr,tt,count,hh,del)
{
    difference()
    {
        union()
        {
            linear_extrude(height=hh-del)
            {
                for (ii=[0:count-1])
                {
                    rotate(ii*(360/count),[0,0,1])arc(rr,tt);
                }
            }
            cylinder(r1=5,r2=5,h=hh);
        }
        
        translate([0,0,-1])cylinder(r1=2.2,r2=2.2,h=4);
    }
}
module pawl(rr,tt,bb,hh,ghh,grr,del)
{
    linear_extrude(height=hh)
    {
        difference()
        {
            circle(r=rr+tt);
            circle(r=rr);
        }
        for(ii=[1:50])
        {
            rotate(ii*(360/50),[0,0,1])translate([rr,0,0])circle(r=bb);
        }
    }
    translate([0,0,-(1-.01)])cylinder(r1=rr+tt,r2=rr+tt,h=1);
    cylinder(r1=2,r2=2,h=i_h-.2);
    //grab bits
    translate([0,0,-0.001])difference()
    {
        translate([0,0,hh])cylinder(r1=rr+tt,r2=rr+tt-.5,h=ghh+.5);
        cylinder(r1=rr+.01,r2=rr+.01,h=2*hh+ghh);
        translate([0,0,hh-.005])cylinder(r1=grr+.1,r2=rr,h=.1+ghh+.01);
        //translate([100,0,0])cube([200,200,50],center=true);
        for (ii=[0:4])
        {
            rotate((ii)*360/-5)translate([-rr-tt+3.2,0,hh+ghh+.5-.3])scale(1)linear_extrude(hh)text(text = str(ii), font = "Liberation Sans", size = text_size, halign = "center", valign = "center");
        }
        for (ii=[0:4])
        {
            rotate((ii)*360/-5)translate([rr,0,0])cube([rr*2,rr/1.2,8*hh+8*ghh],center=true);
        }
    }
    cylinder(r1=5,r2=5,h=del);
}
module plate(rr,hh,rr2)
{
    difference()
    {
        cylinder(r1=rr,r2=rr2,h=hh);
        //numbers 0 to 9
        for (ii=[0:9:9])
        {
            rotate((ii-4.5)*360/50)translate([-rr+5.9,0,hh-.3])
            union()
            {
                scale(1)linear_extrude(hh)text(text = str(ii), font = "Liberation Sans", size = text_size, halign = "center", valign = "center");
                translate([-3,0,hh/2])cube([1,1,hh],center=true);
            }
        }
        translate([rr/2,0,-hh/10])cylinder(r1=rr*.1,r2=rr*.2,h=hh*1.2);
        translate([rr/2,0,-hh/10])cylinder(r1=rr*.15,r2=rr*.15,h=hh*1.2);
    }
}
i_h=2.5;
lid_h=1;
inside_r=25.2;
lid_r=26.3;
hub=6;
//translate([0,0,.3])ratchet(12.5,.6,5,i_h-.3,.3);
pawl(inside_r,hub,1,i_h,lid_h,lid_r,.3);
//translate([0,0,i_h])plate(lid_r,lid_h,inside_r);


     


