//frame
thick=3.5;
bead=12;
rod=66.5;
ep=0.01;
$fa=1;
$fs=1;
rc=6; //rods
module frame()
{
    difference()
    {
        //main body
        //translate([0,-bead/2-thick/2,5])cube([rod+thick+2*bead,4*bead+thick*3+thick*3,15],center=true);
        translate([0,-(rc*(bead+thick/2)+thick*4)/2,5])cube([rod+thick+2*bead,rc*(bead+thick/2)+thick*4,15],center=true);
        //inner space
        //translate([0,-bead/2-thick/2,5])cube([rod-thick,4*bead+thick*3+thick,20],center=true);
        translate([0,-(rc*(bead+thick/2)+thick*4)/2,5])cube([rod-thick,rc*(bead+thick/2)+thick*2,20],center=true);
        //rods
        for (rody=[1:rc])
        {
            translate([0,-rody*(bead+thick/2),ep])rod_slot();
        }
        //translate([0,(bead+thick/2),ep])rod_slot();
        //translate([0,-(bead+thick/2),ep])rod_slot();
        //translate([0,-2*(bead+thick/2),ep])rod_slot();
        //identifiers
        /*translate([-(rod/2+thick*2-1.5),0,9.5])rotate([0,0,-90])linear_extrude(5)text("2",valign="center",halign="center",font="Liberation Sans:style=Bold");
        translate([-(rod/2+thick*2-1.5),(bead+thick/2),9.5])rotate([0,0,-90])linear_extrude(5)text("1",valign="center",halign="center",font="Liberation Sans:style=Bold");
        translate([-(rod/2+thick*2-1.5),-(bead+thick/2),9.5])rotate([0,0,-90])linear_extrude(5)text("3",valign="center",halign="center",font="Liberation Sans:style=Bold");
        translate([-(rod/2+thick*2-1.5),-2*(bead+thick/2),9.5])rotate([0,0,-90])linear_extrude(5)text("H",valign="center",halign="center",font="Liberation Sans:style=Bold");
        */
        //insert slots
        for (rody=[1:rc])
        {
            translate([rod/2+bead,-rody*(bead+thick/2),9.5+1.5])insert_slot();
        }
        for (rody=[1:rc])
        {
            translate([-(rod/2+bead),-rody*(bead+thick/2),9.5+1.5])insert_slot();
        }
        //translate([rod/2+bead,0,9.5+1.5])insert_slot();
        //translate([rod/2+bead,(bead+thick/2),9.5+1.5])insert_slot();
        //translate([rod/2+bead,-1*(bead+thick/2),9.5+1.5])insert_slot();
        //translate([rod/2+bead,-2*(bead+thick/2),9.5+1.5])insert_slot();
    }
}
//bead keeper
translate([-(rod/2-thick-5),-(rc*(bead+thick/2)+thick*4)/2,(8/2)-2.5])cube([thick,rc*(bead+thick/2),8],center=true);
translate([(rod/2-thick-5),-(rc*(bead+thick/2)+thick*4)/2,(8/2)-2.5])cube([thick,rc*(bead+thick/2),8],center=true);
//insert();
module insert()
{
    inset=.2;
    hull()
    {
        cube([bead,bead-inset,ep],center=true);
        translate([0,0,1.5-.2])cube([bead,bead-1.5-inset,ep],center=true);
    }
}
module rod_slot()
{
    translate([0,0,10-thick/2])cube([rod+.4,thick+.2,thick+.2],center=true);
}
module insert_slot()
{
    hull()
    {
        cube([bead*2,bead,ep],center=true);
        translate([0,0,1.5])cube([bead*2,bead-1.5,ep],center=true);
    }
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
            translate([0,0,-ep])cylinder(r1=bead/2,r2=bead/2-.5,h=thick/2,center=true);
            translate([0,0,-(thick/2)])cylinder(r2=bead/2,r1=bead/2-.5,h=thick/2,center=true);
        }
        cylinder(r=(thick+1)/2,h=thick*4,center=true,$fn=24);
    }
}
//bead();

//rod();
frame();
//split frame
module split_frame()
{
    difference()
    {
        translate([0,0,5])cube([rod+thick,bead+thick*2+thick*3,15],center=true);
        translate([0,0,5])cube([rod-thick,bead+thick*2+thick,20],center=true);
        translate([0,0,ep])rod_slot();
    }
    //inner
    difference()
    {
        translate([thick/2,0,5])cube([thick,bead+thick*5,15],center=true);
        translate([0,0,ep])rod_slot();
    }
}

//split_frame();
