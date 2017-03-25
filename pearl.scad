$fs=1;
$fa=2;

difference()
{
    union()
    {
        intersection()
        {
            cylinder(r=20,h=3,center=true);
            sphere(r=20,center=true);
        }
        difference()
        {
            intersection()
            {
                cylinder(r=26,h=3,center=true);
                sphere(r=26,center=true);
            }
            sphere(r=20.5,center=true);
        }
    }
    rotate([90,0,0])cylinder(r=.5,h=60,center=true,$fn=4);
}
translate([-11,0,1.49])scale([1,1,1])letterP();
translate([11,0,1.49])scale([1,1,1])letterP();
translate([0,0,1.49])scale([1.1,1.1,1])number1();
module letterP()
{
    rad=30;
    intersection()
    {
        linear_extrude(height=10)minkowski()
        {
            text("P",font="purisa:style=Bold",valign="center", halign="center");
            circle(r=.2,$fn=20);
        }
        translate([0,0,-(rad-1)])sphere(r=rad);
    }
}

module number1()
{
    rad=30;
    intersection()
    {
        linear_extrude(height=10)minkowski()
        {
            text("4",font="purisa:style=Bold",valign="center", halign="center");
            circle(r=.2,$fn=20);
        }
        translate([0,0,-(rad-1)])sphere(r=rad);
    }
}