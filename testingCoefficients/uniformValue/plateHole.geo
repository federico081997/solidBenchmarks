// Average mesh spacing
dx = .1000000000;

// Plate size
L = 2;

// Out of plane depth
d = 2;

//Cell number across each curve
cn = 4;

// Points
Point(1) = {0, 0, 0, dx};
Point(2) = {L, 0, 0, dx};
Point(3) = {0, L, 0, dx};
Point(4) = {L, L, 0, dx};

// Lines
Line(1) = {3, 1};
Line(2) = {1, 2};
Line(3) = {2, 4};
Line(4) = {4, 3};

// Surface
Curve Loop(1) = {4, 1, 2, 3};
Plane Surface(1) = {1};

//Mesh quadrilaterals
Transfinite Curve {2, 4, 1, 3} = 3 Using Progression 1;
Transfinite Surface {1};
Recombine Surface{1};

// Create volume by extrusion
Extrude {0, 0, d} {
  Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; 
  Layers{2};
  Recombine;
}

Physical Surface("down") = {21};
Physical Surface("right") = {25};
Physical Surface("up") = {13};
Physical Surface("left") = {17};
Physical Volume("internalVolume") = {1};
Physical Surface("top") = {26};
Physical Surface("bottom") = {1};
