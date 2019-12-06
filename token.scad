chit_t=1;
inch=25.4;
ep=0.01;
bevel=.6;

module chit()
{
    rad=2;
    hull()
    {
        //top and bottom
        linear_extrude(chit_t)minkowski()
        {
            circle(r=inch/2-rad*2,$fn=6);
            circle(r=rad-chit_t/2,$fn=30);
        }
        //midline
        translate([0,0,chit_t/2-ep/2])linear_extrude(ep)minkowski()
        {
            circle(r=inch/2-rad*2,$fn=6);
            circle(r=rad,$fn=30);
        }
    }
}

//chit();
peg_t=6.3; //thickness of the peg, how wide in profile
peg_w=17.6;  //width of peg, side facing the user
peg_l=71.5; //length of peg
spring_t=1; //how much of a inset for the spring non-squaredness
axle=17.4; //distance between notch and center of spring
notch=2; //width of the notch
peg_tail=2; //thickness at the back
spring_r=6.5/2; //spring radius
//rotate([0,90,90])import("clothespeg.stl");
module clothespin()
{
    mirror([0,-1,0])difference()
    {
        hull()
        {
            translate([0,0,bevel])linear_extrude(spring_t+peg_w-bevel*2)cpin_pos();
            linear_extrude(spring_t+peg_w)offset(delta=-bevel)cpin_pos();
        }
        translate([0,0,-.5])linear_extrude(spring_t+peg_w+1)cpin_neg_a();
        hull()
        {
            translate([0,0,bevel])linear_extrude(ep)cpin_neg_a();
            translate([0,0,-ep])linear_extrude(ep)offset(delta=bevel)cpin_neg_a();
        }
        hull()
        {
            translate([0,0,spring_t+peg_w-bevel])linear_extrude(ep)cpin_neg_a();
            translate([0,0,spring_t+peg_w])linear_extrude(ep)offset(delta=bevel)cpin_neg_a();
        }
        translate([0,0,-.5])linear_extrude(spring_t+peg_w+1)cpin_neg_b();
        hull()
        {
            translate([0,0,bevel])linear_extrude(ep)cpin_neg_b();
            translate([0,0,-ep])linear_extrude(ep)offset(delta=bevel)cpin_neg_b();
        }
        hull()
        {
            translate([0,0,spring_t+peg_w-bevel])linear_extrude(ep)cpin_neg_b();
            translate([0,0,spring_t+peg_w])linear_extrude(ep)offset(delta=bevel)cpin_neg_b();
        }
        //translate([axle/2+spring_r/2,peg_t-.5,peg_w+spring_t])cylinder(r=spring_r+.5,h=spring_t*2+ep,$fn=30,center=true);
    }
}
module cpin_pos()
{
    //put the spring and notch such that they are the middle
    //tail_l is the distance from spring to the tail
    tail_l=peg_l/2-axle/2;
    //base_l is the length of the part where the peg touches itself
    base_l=peg_l-tail_l-peg_t;
    difference()
    {
        hull()
        {
            translate([0,peg_tail/2])square([peg_l,peg_tail],center=true);
            translate([-base_l/2+peg_t,peg_t-peg_tail/2])square([base_l,peg_tail],center=true);
        }
    }
}
module cpin_neg_a()
{
    //put the spring and notch such that they are the middle
    //tail_l is the distance from spring to the tail
    tail_l=peg_l/2-axle/2;
    //base_l is the length of the part where the peg touches itself
    base_l=peg_l-tail_l-peg_t;
    
        translate([axle/2,peg_t])circle(r=spring_r,$fn=30);
 
    
}
module cpin_neg_b()
{
    //put the spring and notch such that they are the middle
    //tail_l is the distance from spring to the tail
    tail_l=peg_l/2-axle/2;
    //base_l is the length of the part where the peg touches itself
    base_l=peg_l-tail_l-peg_t;


        translate([-axle/2,0])square([notch,notch*2],center=true);

}

clothespin();