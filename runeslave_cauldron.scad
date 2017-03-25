
ss=.7;

difference()
{
    translate([0,0,25])import("cauldron.stl");
    
    intersection()
    {
    scale(1.035)translate([0,0,25])import("cauldron.stl");
    translate([0,-10,0])rotate([90,0,0])scale([.5,.5,5])import("sihedron.stl");
    }
    intersection()
    {
        scale(1.035)translate([0,0,25])import("cauldron.stl");
        union()
        {
        rotate([0,0,60])translate([0,-10,-5])rotate([90,180,0])scale([ss,ss,5])import("runes/rune1.stl");
        rotate([0,0,60+15])translate([0,-10,-5])rotate([90,180,0])scale([ss,ss,5])import("runes/rune2.stl");
        rotate([0,0,60-15])translate([0,-10,-5])rotate([90,180,0])scale([ss,ss,5])import("runes/rune3.stl");
        }
    }

    intersection()
    {
    scale(1.035)translate([0,0,25])import("cauldron.stl");
    rotate([0,0,120])translate([0,-10,0])rotate([90,0,0])scale([.5,.5,5])import("sihedron.stl");
    }

    intersection()
    {
        scale(1.035)translate([0,0,25])import("cauldron.stl");
        union()
        {
        rotate([0,0,120])rotate([0,0,60+15])translate([0,-10,-5])rotate([90,180,0])scale([ss,ss,5])import("runes/rune5.stl");
        rotate([0,0,120])rotate([0,0,60-15])translate([0,-10,-5])rotate([90,180,0])scale([ss,ss,5])import("runes/rune6.stl");
        rotate([0,0,120])rotate([0,0,60])translate([0,-10,-5])rotate([90,180,0])scale([ss,ss,5])import("runes/rune4.stl");
        }
    }

    intersection()
    {
    scale(1.035)translate([0,0,25])import("cauldron.stl");
    rotate([0,0,-120])translate([0,-10,0])rotate([90,0,0])scale([.5,.5,5])import("sihedron.stl");
    }

    intersection()
    {
        scale(1.035)translate([0,0,25])import("cauldron.stl");
        union()
        {
            rotate([0,0,-120])rotate([0,0,60])translate([0,-10,-5])rotate([90,180,0])scale([ss,ss,5])import("runes/rune7.stl");
        rotate([0,0,-120])rotate([0,0,60+15])translate([0,-10,-5])rotate([90,180,0])scale([ss,ss,5])import("runes/rune1.stl");
            rotate([0,0,-120])rotate([0,0,60-15])translate([0,-10,-5])rotate([90,180,0])scale([ss,ss,5])import("runes/rune5.stl");
        }
    
    }

}

