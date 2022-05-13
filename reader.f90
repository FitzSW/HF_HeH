module reader
use orbitals
! A module to read in the geometry and basis set files
contains
!
subroutine reader(geom,basis,orbs)
    implicit none
    ! input 
    character*40, intent(in) :: geom
    character*40, intent(in) :: basis
    
    ! intermediate

    ! output
    type(contracted_gto), allocatable, dimension(:) :: orbs



end subroutine reader 



end module reader
