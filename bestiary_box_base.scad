
bevel=1;
base_t=3.2;
base_r=3*25.4/2;
gap=2.5;
lip_t=9.5;
lip_w=1.2;
lip_base=10;
ep=0.01;
wiggle=.4;

round=.5;
$fs=1;
$fa=1;


//base plate
translate([0,0,base_t/2])hull()
{
  cylinder(r=base_r, h=base_t-bevel*2,center=true);
  cylinder(r=base_r-bevel, h=base_t, center=true);
}

difference()
{
  hull()
  {
    translate([0,0,lip_t])cube([base_r*2-bevel*2,lip_w*2+gap,ep],center=true);
    translate([0,0,base_t/2])cube([base_r*2-bevel*2,lip_base,ep],center=true);
  }
  //center cut
  hull()
  {
    translate([0,-wiggle,0])cube([ep,gap,lip_t*3],center=true);
    translate([-base_r,wiggle,0])cube([ep,gap,lip_t*3],center=true);
  }
  hull()
  {
    translate([0,-wiggle,0])cube([ep,gap,lip_t*3],center=true);
    translate([base_r,wiggle,0])cube([ep,gap,lip_t*3],center=true);
  }
  //edge bevel
  translate([base_r-bevel,0,0])rotate([0,0,45])cube([(gap+bevel*2)/sqrt(2),(gap+bevel*2)/sqrt(2),lip_t*3],center=true);
  translate([-(base_r-bevel),0,0])rotate([0,0,45])cube([(gap+bevel*2)/sqrt(2),(gap+bevel*2)/sqrt(2),lip_t*3],center=true);
  //top bevel
  translate([0,0,lip_t])rotate([45,0,0])cube([base_r*3,(gap+bevel*2)/sqrt(2),(gap+bevel*2)/sqrt(2)],center=true);
}

*difference()
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
*translate([base_r*.75,gap/2,4])cylinder(r1=.4,r2=0.01,h=6,center=true,$fn=4);
*translate([base_r*.75,-gap/2,4])cylinder(r1=.4,r2=0.01,h=6,center=true,$fn=4);
*translate([-base_r*.75,-gap/2,4])cylinder(r1=.4,r2=0.01,h=6,center=true,$fn=4);
*translate([-base_r*.75,gap/2,4])cylinder(r1=.4,r2=0.01,h=6,center=true,$fn=4);