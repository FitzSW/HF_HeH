module orbitals
! This is a module to help make the orbitals 
! more concretely expressed for the purposes of coding
implicit none

type point
    real, dimension(3) :: r
end type point

type ang_mom
    integer, dimension(3) :: L
end type ang_mom

type primtive_gto
    ! momentum numbers will vary across a p orb contraction
    type(ang_mom) :: AM
    ! the coefficients and expoents will vary
    real :: coeff
    real :: expo
end type primtive_gto

type contracted_gto
    character(len=1) :: orb_type
    character(len=1) :: atom_name
    type(point) :: coords
    integer :: M ! length of the contraction
    type(primitive_gto), dimension(M) :: contraction
end type contracted_gto

end module orbitals
