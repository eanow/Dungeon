inch=25.4;
round=2;
thick=2;
module shell()
{
    minkowski()
    {
        translate([0,-(inch+thick)/2,2.5/2*inch])cube([3.5*inch,1.5*inch-thick,2.5*inch],center=true);
        sphere(r=round,$fn=20);
    }
}
module reserve()
{
    xx=(3.5*inch)-thick*2;
    yy=(1.5*inch)-thick*2;
    zz=(1.5*inch)-thick*2;
    translate([0,-(2.5*inch)/2+yy/2,0])difference()
    {
        translate([0,0,zz/2+thick])cube([xx,yy,zz],center=true);
        rotate([-45,0,0])translate([0,0,-zz/2])cube([xx+1,2*yy,zz*.7],center=true);
    }
    translate([0,-(2.5*inch)/2+yy/2-thick*2,0])translate([0,0,zz/2+thick+.15*inch])cube([xx,yy,zz-.3*inch],center=true);
}
module pool()
{
    xx=((3.5*inch)-thick*2)/2-thick/2;
    yy=(1.5*inch)-thick*2;
    zz=(1.5*inch)-thick*2;
    translate([xx/2+thick/2,0,0]){
    translate([0,-(2.5*inch)/2+yy/2,0])difference()
    {
        translate([0,0,zz/2+thick])cube([xx,yy,zz],center=true);
        rotate([-45,0,0])translate([0,0,-zz/2])cube([xx+1,2*yy,zz*.7],center=true);
    }
    translate([0,-(2.5*inch)/2+yy/2-thick*2,0])translate([0,0,zz/2+thick+.15*inch])cube([xx,yy,zz-.3*inch],center=true);}
}

difference()
{
    shell();
    reserve();
    translate([0,0,(1.5*inch-thick)])pool();
    mirror([1,0,0])translate([0,0,(1.5*inch-thick)])pool();
}

