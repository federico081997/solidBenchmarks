// Average mesh spacing
dx = 0.1;

// Inner radius
r1 = 0.01;

//Outer radius
r2 = 0.02;

// Out of plane depth and width
d = 0.005;

//Cell number across each curve
cn = 2;

// Points
Point(1) = {0, 0, 0, dx};
Point(2) = {r1, 0, 0, dx};
Point(3) = {r2, 0, 0, dx};
Point(4) = {0, r2, 0, dx};
Point(5) = {0, r1, 0, dx};

// Lines
Line(1) = {2, 3};
Line(2) = {5, 4};
Circle(3) = {5, 1, 2};
Circle(4) = {4, 1, 3};

//Surface
Curve Loop(1) = {2, 4, -1, -3};
Plane Surface(1) = {1};

//Force mapped meshing (triangles)
Transfinite Curve {2, 1} = cn*3 Using Progression 1;
Transfinite Curve {3, 4} = cn*6 Using Progression 1;
Transfinite Surface {1};

// Create volume by extrusion
Extrude {0, 0, d} {
  Surface{1}; 
  Layers{1};
  Recombine;
}

Physical Surface("hole") = {25};
Physical Surface("symmPlanes") = {21, 13};
Physical Surface("tractionFree") = {17};
Physical Surface("frontAndBack") = {26, 1};
Physical Volume("internal") = {1};
