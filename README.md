# cybo

## Simple 2d unstructured CFD solver
Solves the Euler equations (inviscid + compressible) governing fluid flow around arbitrary 2d object 
using an unstructured grid comprised of triangles. Uses a low order finite volume method with scalar 
diffusion for shock capturing.

Source includes:
  - Simple FV solver
  - Mesh generation routines for Matlab (including setting boundary conditions)
  - Sample meshes and input files 
  
System Requirement:
  - Fortran 90 compiler
  - gmake (makefile included)
  - Matlab for pre-processing of your mesh (or use default meshes).
  - Visualization software-write out Tecplot format data for either Tecplot (commercial) or Visit (freely available at https://wci.llnl.gov/codes/visit/home.html) 
  
  
