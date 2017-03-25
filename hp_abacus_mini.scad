//frame
thick=3;
bead=12;
rod=54.5;
ep=0.01;
$fa=1;
$fs=1;
module frame()
{
    difference()
    {
        translate([0,0,5])cube([rod+thick,3*bead+thick*2+thick*3,15],center=true);
        translate([0,0,5])cube([rod-thick,3*bead+thick*2+thick,20],center=true);
        translate([0,0,ep])rod_slot();
        translate([0,(bead+thick/2),ep])rod_slot();
        translate([0,-(bead+thick/2),ep])rod_slot();
    }
}
module rod_slot()
{
    translate([0,0,10-thick/2])cube([rod+.4,thick+.2,thick+.2],center=true);
}

module rod()
{
    difference()
    {
        rotate([0,90,0])cylinder(r=(thick+.4)/2,h=rod,center=true,$fn=24);
        translate([0,0,(thick-.1)])cube([rod*2,thick*4,thick],center=true);
        translate([0,0,-(thick-.1)])cube([rod*2,thick*4,thick],center=true);
    }
}
module bead()
{
    translate([0,0,thick/4])difference()
    {
        union()
        {
            translate([0,0,-ep])cylinder(r1=bead/2,r2=bead/2-1,h=thick/2,center=true);
            translate([0,0,-(thick/2)])cylinder(r2=bead/2,r1=bead/2-1,h=thick/2,center=true);
        }
        cylinder(r=(thick+1)/2,h=thick*4,center=true,$fn=24);
    }
}
bead();

//rod();
//frame();
//split frame
module split_frame()
{
    difference()
    {
        translate([0,0,5])cube([rod+thick,bead+thick*2+thick*2,12],center=true);
        translate([0,0,5])cube([rod-thick,bead+thick*2+thick*0,20],center=true);
        translate([0,0,ep])rod_slot();
    }
    //inner
    difference()
    {
        translate([thick/2,0,5])cube([thick,bead+thick*4,12],center=true);
        translate([0,0,ep])rod_slot();
    }
}

//split_frame();
