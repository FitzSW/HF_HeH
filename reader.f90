module reader
use orbitals
! A module to read in the geometry and basis set files
contains
!
subroutine reader(geom,basis,N,orbs)
    implicit none
    ! input 
    character*40, intent(in) :: geom
    character*40, intent(in) :: basis
    
    ! intermediate
    character*80, dimension(100) :: 

    ! output
    type(contracted_gto), allocatable, dimension(:) :: orbs
    integer :: N ! numer of orbs
    integer :: M ! length of the local contraction being read

    ! Needs to account for both the length of the csv file (in orbs)
    ! as well as the length of each orbital (contraction length) 

    open(unit=10,file=geom,status='unknown')
    open(unit=11,file=basis,status='unknown')





end subroutine reader 


end module reader
