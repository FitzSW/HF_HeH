module orbitals
! This is a module to help make the orbitals 
! more concretely expressed for the purposes of coding
implicit none

type primitive_gto
    ! momentum numbers will vary across a p orb contraction
    integer, dimension(3) :: L   ! angular momentum
    ! the coefficients and expoents will vary
    real :: coeff
    real :: expo
end type primitive_gto

type contracted_gto
    character(len=1) :: orb_type
    character(len=1) :: atom_name
    real, dimension(3) :: coords ! coordinates
    ! length of the contraction (P orbitals will have 3N as s orbitals)
    integer :: M 
    type(primitive_gto), allocatable, dimension(:) :: contraction
end type contracted_gto

contains
!
function new_contraction(M)!,orb_type,atom_name,coords,coeff_vec,expo_vec)
    implicit none
    integer, intent(in) :: M
    type(contracted_gto) :: new_contraction
    allocate(new_contraction%contraction(M))
    new_contraction%M = M
end function new_contraction


end module orbitals
