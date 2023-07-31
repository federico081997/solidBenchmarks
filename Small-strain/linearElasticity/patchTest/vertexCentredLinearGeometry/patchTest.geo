// Average mesh spacing
dx = 1;

//Cell multiplier
cn = 1;

//Thickness
d = 0.1;

// Points
Point(1) = {0, 0, 0, dx};
Point(2) = {3.5, 0, 0, dx};
Point(3) = {2.5, 3.5, 0, dx};
Point(4) = {0, 3, 0, dx};
Point(5) = {1, 1.2, 0, dx};
Point(6) = {2, 1, 0, dx};
Point(7) = {2, 1.8, 0, dx};
Point(8) = {1, 2, 0, dx};

// Lines
Line(1) = {4, 8};
Line(2) = {8, 5};
Line(3) = {5, 1};
Line(4) = {1, 4};
Line(5) = {1, 2};
Line(6) = {2, 3};
Line(7) = {3, 4};
Line(8) = {8, 7};
Line(9) = {7, 3};
Line(10) = {7, 6};
Line(11) = {6, 2};
Line(12) = {6, 5};

//Surfaces
Curve Loop(1) = {12, -2, 8, 10};
Plane Surface(1) = {1};
Curve Loop(2) = {3, 5, -11, 12};
Plane Surface(2) = {2};
Curve Loop(3) = {11, 6, -9, 10};
Plane Surface(3) = {3};
Curve Loop(4) = {9, 7, 1, 8};
Plane Surface(4) = {4};
Curve Loop(5) = {3, 4, 1, 2};
Plane Surface(5) = {5};

// Create volume by extrusion
Extrude {0, 0, d} {
  Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5};   
  Layers{cn};
  Recombine;
}

//Physical groups
Physical Surface("boundary") = {47, 113, 91, 69};
Physical Volume("internal") = {2, 1, 5, 4, 3};
