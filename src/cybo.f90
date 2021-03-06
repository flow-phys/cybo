!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!        /\        CYBO-Unstuctured Euler Solver  !!!
!!!       /  \                                      !!!
!!!      /    \      Chris M. Yu & Britton J. Olson !!!
!!!     /______\     Department on Aero/Astro       !!!
!!!    /\      /\    Stanford University            !!!
!!!   /  \    /  \   Spring 2010                    !!!
!!!  /    \  /    \                                 !!! 
!!! /______\/______\                                !!!
!!!                                                 !!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!             

PROGRAM cybo
USE inputs
USE mesh
IMPLICIT NONE
NAMELIST /INPUT/ mesh_name,out_file,tsmax,mach,out_freq,dt_fix
CHARACTER(len=90) :: inputFile
INTEGER :: funit

! Check to make sure an input file was given
IF (iargc() .EQ. 0) STOP 'Usage: ./cybo inputfile'
CALL GETARG(1,inputFile)

! Read in namelist file and use to read in grid and setup
! arrays for the solver
funit=11
OPEN(UNIT=funit,FILE=TRIM(inputFile),FORM='FORMATTED',STATUS='OLD')
  READ(UNIT=funit,NML=INPUT)
CLOSE(funit)

! Read in a mesh file for calculation
CALL read_mesh

! Initialize the flow field
CALL init_field

! Solve the euler equations
CALL solver


END PROGRAM


SUBROUTINE init_field
USE euler
USE mesh
USE inputs
IMPLICIT NONE
DOUBLE PRECISION :: u_in,v_in,P_in,rho_in

CALL allocate_euler

rho_in = 1.4d0
P_in = 1.0d0
u_in = mach * sqrt( P_in*gamma/rho_in)
v_in = 0.0d0

inlet(1) = rho_in
inlet(2) = rho_in*u_in
inlet(3) = rho_in*v_in
inlet(4) = p_in

!rho = rho_in + rho_in*3*exp( -((x-.5)**2 + (y-.5)**2)/0.01 ) ! Gauss
!p = p_in + p_in*.2*(1.0 + tanh( -((x-.5)**2 + (y-.5)**2)/0.01 )) ! Gauss
rho = rho_in !p
rhou = rho_in*u_in
rhov = rho_in*v_in
p = P_in

rhoE = P / gm1  + rho*(u_in**2.0 + v_in**2.0) / 2.0d0 

CALL get_pressure


END SUBROUTINE
 
