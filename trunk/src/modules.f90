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

MODULE mesh
IMPLICIT NONE
double precision, dimension(:), allocatable :: x,y,u
integer, dimension(:,:), allocatable :: tri,edg
integer :: numpts,numtri,numedg
END MODULE


MODULE inputs
IMPLICIT NONE
CHARACTER(LEN=90) :: mesh_name       ! Name of the mesh file
CHARACTER(LEN=90) :: out_file        ! Name of the .tec file to write
INTEGER :: tsmax = 1000              ! Max number of time steps to take
END MODULE

MODULE euler
IMPLICIT NONE
DOUBLE PRECISION, DIMENSION(:,:), ALLOCATABLE :: w   ! Conserved variables
END MODULE

MODULE rk4
IMPLICIT NONE
DOUBLE PRECISION, DIMENSION(5) :: Ark, Brk, eta
END MODULE


SUBROUTINE allocate_mesh
USE mesh
allocate(x(numpts))
allocate(y(numpts))
allocate(u(numpts))
allocate(tri(3,numtri))
allocate(edg(3,numedg))
END SUBROUTINE

SUBROUTINE allocate_euler
USE euler
USE mesh, ONLY: numtri 
IMPLICIT NONE
ALLOCATE(w(5,numtri))   ! rho,rhoU,rhoV,rhoH,P for each triangle
END SUBROUTINE

SUBROUTINE allocate_rk4
USE rk4
IMPLICIT NONE
Ark(1) = 0.0d0
Ark(2) = -6234157559845D0/12983515589748D0
Ark(3) = -6194124222391D0/4410992767914D0
Ark(4) = -31623096876824D0/15682348800105D0
Ark(5) = -12251185447671D0/11596622555746D0

Brk(1) = 494393426753D0/4806282396855D0
Brk(2) = 4047970641027D0/5463924506627D0
Brk(3) = 9795748752853D0/13190207949281D0
Brk(4) = 4009051133189D0/8539092990294D0
Brk(5) = 1348533437543D0/7166442652324D0
 
eta(1) = 494393426753/4806282396855
eta(2) = 4702696611523/9636871101405
eta(3) = 3614488396635/5249666457482
eta(4) = 9766892798963/10823461281321
eta(5) = 1.0d0

END SUBROUTINE
