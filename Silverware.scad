// The silverware STLs could use some cleaning up.  They are not symmetrical.  They could be smoother.
// licensed under the Creative Commons - Attribution - Non-Commercial license.

wall = 4;
height = 40;
scale = 0.7464;
flw = 31.28; 
fsw = 29.19;
slw = 42.59;
ssw = 38.69;
uw = 59.58;
lengthFront = 259.14;
lengthBack = 210.2;
width = 249;
fnn = 5; // fnn is the number of faces on curves.  Use 5 for design. Use 200 or more for long render time final stl.

FirstTray(height);
SecondTray(height);
ThirdTray(height);
FourthTray(height);

module FirstTray(h)
{
    difference(){
        SilverwareTray(height);
            translate([75,wall,wall])
                color("yellow")
                    RoundedCube(size = [40, 134.08-wall + 80, height + 10], center = false,radius = 7,fn=fnn);
    }
}

module SilverwareTray(h){
    difference(){
        SilverwareBox(h);
        Silverware(h);
    } 
    Knives(height);
}

module Knives(h){
    knives = [[width,lengthFront+2*wall,height+wall,wall],[97.98, 28.1, 51.46]];
    difference(){
    translate([133.57,0,0])
        rotate([0,0,90])
            bin(knives);
    translate([wall,97.98+wall,wall])
        color("black")
            cube([187.64, wall, h+wall +10]);
    }
}

module Silverware(h)
{
    cutOutHeight = 24.5 - wall;
    cutOutLength = 105.98 - wall;
    boxHeight = 204.14 + 2 * wall;
    ForkLarge(wall, 121.65 + 4*wall, wall, h+1);
    ForkSmall(wall, 89.9 + 3*wall, wall, h+1);
    SpoonLarge(wall, 39.57 + 2*wall, wall, h+1);
    SpoonSmall(wall, 0 + wall, wall, h+1);

    translate([boxHeight - cutOutHeight,0,wall])
        color("yellow")
            cube([cutOutHeight, cutOutLength, h+wall +10]);
}

module SilverwareBox(h)
{
    cutOutHeight = 24.5 - wall;
    cutOutLength = 105.98 - wall;
    boxHeight = 204.14 + 2 * wall;
    color("green")
        cube([boxHeight, 122.08 + 4*wall, h+wall]);
}

module ForkLarge(x,y,z,h)
{
    color("blue")
        {
            scale([scale,scale,1])
            {
                translate([x-0.33,y-0.333,z])
                    linear_extrude(height = h)
                        import("Svg/fork large.svg");
            }
        }
}

module ForkSmall(x,y,z,h)
{
    color("red")
        {
            scale([scale,scale,1])
            {
                translate([x-0.34,y-0.335,z])
                    linear_extrude(height = h)
                        import("Svg/fork small.svg");
            }
        }
}

module SpoonLarge(x,y,z,h)
{
    color("blue")
        {
            scale([scale,scale,1])
            {
                translate([x-0.33,y-0.333,z])
                    linear_extrude(height = h)
                        import("Svg/spoon large.svg");
            }
        }
}

module SpoonSmall(x,y,z,h)
{
    color("red")
        {
            scale([scale,scale,1])
            {
                translate([x-0.34,y-0.339,z])
                    linear_extrude(height = h)
                        import("Svg/spoon small.svg");
            }
        }
}

module SecondTray(h){
    translate([0,260,0])
    {
        difference()
        {
            translate([wall,wall,0])
                color("yellow")
                    cube([251.591+10, 59.58, h+wall ]);
        {  
            translate([-2.99+wall,-76.06+wall,wall])
                Utensil(wall, 89.9 + 3*wall, 0, h+1);
                translate([65,wall,wall])
                        RoundedCube(size = [70, 59, height + 10], center = false,radius = 7,fn=fnn);
        } 
        }

        knives = [[width,lengthFront+2*wall,height+wall,wall],[59.58, 56.5, 56.5]];
        difference(){
        translate([133.57,0,0])
            rotate([0,0,90])
                bin(knives);
        }
        translate([127.57,2*56.5+59.58+4*wall,0])
                cube([wall, 56.5, h+wall ]);
    }
}

module Utensil(x,y,z,h)
{
    color("blue")
        {
            scale([scale,scale,1])
            {
                translate([x-6.15,y-4.47,z])
                    linear_extrude(height = h)
                        import("Svg/utensil.svg");
            }
        }
}

module ThirdTray(h){
    stick = 25; 
    chopStick = [[width,stick,h+wall,wall],[0]];
    organizer = [[width,lengthBack-21,h+wall,wall],[75, 70]];

    translate([280,0,0])
    difference()
    {
        boxWithChopsticks(h);
        translate([177,103,wall])
            RoundedCube(size = [20, 30, height + 10], center = false,radius = 7,fn=fnn);
    }
}

module boxWithChopsticks(h){
    stick = 25; 
    chopStick = [[width,stick,h+wall,wall],[0]];
    organizer = [[width,lengthBack-21,h+wall,wall],[75, 70]];

    color("green")
        translate([197.7,0,0])
            rotate([0,0,90])
                bin(chopStick);
    translate([94.6,0,0])
        rotate([0,0,90])
            bin(organizer);
}

module FourthTray(h){
    organizer = [[width,lengthBack,h+wall,wall],[51, 38, 38, 38]];

    translate([280,260,0])
    {
        difference()
        { 
        translate([209/2,0,0])
            rotate([0,0,90])
                bin(organizer);

        translate([65,30+wall,wall])
                RoundedCube(size = [50, 140, height + 10], center = false,radius = 7,fn=fnn);
        }
        translate([3.4 + 70,185,wall])
                cube([wall, 60, h ]);
    }
}

module bin(in){
    d = in[0];
    l = d[0];
    w = d[1];
    h = d[2];
    wall = d[3];
    dv = getDividers(l,wall,in[1]);
    numDv = len(dv);
    dvSpace = add(sumlist(dv),wall);
    totCompart = dvSpace[numDv]-(numDv*wall+wall);
    totWall = numDv*wall+wall;
    totLen = totCompart + totWall;
    spaceLeftOver = hasDividers(dv[0],l,totLen,wall);
    difference(){
        outerShell(l,w,h);
        insideShells(numDv,dv,w,h,wall,dvSpace,spaceLeftOver); 
    }
}

module outerShell(l,w,h){
    translate([0,-w/2]) 
        cube([l,w,h]);
}

module insideShells(numDv,dv,w,h,wall,dvSpace,spaceLeftOver) {
    for(i = [0:numDv-1]){
        insideShell(dv[i],w,h,wall,dvSpace[i]);
    }
    if (spaceLeftOver>0){
        insideShell(spaceLeftOver,w,h,wall,offset(dv,dvSpace,numDv,wall));
    }
}

module insideShell(l,w,h,wall,dvSpace) {
    iw = w - wall * 2; 
    translate([dvSpace,-iw/2,wall])
        cube([l, iw, h]);
}

function compartmentString(a,c,e) = str("Compartment ",a+1," Length=",c[a]," Positioned at=",e[a],"mm");
function sumlist(l, al=[0], i=0, t=0) = i>=len(l) ? al : sumlist(l, concat(al, [t+l[i]]), i+1, t+l[i] );
function add(l,n) = [for (i = [0:len(l)-1]) l[i]+n+n*i];
function hasDividers(c,l,allIn,wall) = c>0?l - allIn - wall : l - allIn;
function offset(c,e,numC,wall) = c[0]>0 ?  e[numC-1]+c[numC-1]+wall:wall;
function equalBins(l,w,n) = [for(i = [1 : n]) (l-((n+2)*w))/(n+1)];
function getDividers(l,wall,c) = (c[0] == true) ? equalBins(l,wall,c[1]): c; 

module RoundedCube(size = [1, 1, 1], center = false,radius = 0.5,fn=10)
{
    obj_translate = (center == true) ?  [0, 0, 0] : [ (size[0] / 2), (size[1] / 2), (size[2] / 2) ];
    translate(v = obj_translate) {
            hull(){
                cube([size[0]-radius-radius,size[1]-radius-radius,size[2]],center=true);
                cube([size[0]-radius-radius,size[1],size[2]-radius-radius],center=true);
                cube([size[0],size[1]-radius-radius,size[2]-radius-radius],center=true);
            
                translate ([size[0]/2-radius,size[1]/2-radius,size[2]/2-radius])
                sphere(r = radius,$fn = fn);
                translate ([-size[0]/2+radius,size[1]/2-radius,size[2]/2-radius])
                sphere(r = radius,$fn = fn);
                translate ([-size[0]/2+radius,-size[1]/2+radius,size[2]/2-radius])
                sphere(r = radius,$fn = fn);
                translate ([size[0]/2-radius,-size[1]/2+radius,size[2]/2-radius])
                sphere(r = radius,$fn = fn);
            
                translate ([size[0]/2-radius,size[1]/2-radius,-size[2]/2+radius])
                sphere(r = radius,$fn = fn);
                translate ([-size[0]/2+radius,size[1]/2-radius,-size[2]/2+radius])
                sphere(r = radius,$fn = fn);
                translate ([-size[0]/2+radius,-size[1]/2+radius,-size[2]/2+radius])
                sphere(r = radius,$fn = fn);
                translate ([size[0]/2-radius,-size[1]/2+radius,-size[2]/2+radius])
                sphere(r = radius,$fn = fn);
            }
        }
}