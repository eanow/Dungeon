
base_t=3.2;
base_r=2*25.4/2;
gap=2.5;
round=.5;
$fs=1;
$fa=1;
difference()
{
minkowski()
{
    union(){
        translate([0,0,round])cylinder(r=base_r-round,h=base_t-round*2);

        difference()
        {
            translate([0,0,base_t-round])scale([1,1.2,3.2])rotate([45,0,0])rotate([0,90,0])cube([5,5,base_r*1.8],center=true);
            cube([base_r*2,gap+round*2,40],center=true);
            translate([0,0,-9])cube([100,100,20],center=true);
        }
    }
    sphere(r=round,$fn=50);
}
translate([0,0,-(3-.2)])cube([100,100,6],center=true);
}
translate([base_r*.75,gap/2,4])cylinder(r1=.4,r2=0.01,h=6,center=true,$fn=4);
translate([base_r*.75,-gap/2,4])cylinder(r1=.4,r2=0.01,h=6,center=true,$fn=4);
translate([-base_r*.75,-gap/2,4])cylinder(r1=.4,r2=0.01,h=6,center=true,$fn=4);
translate([-base_r*.75,gap/2,4])cylinder(r1=.4,r2=0.01,h=6,center=true,$fn=4);