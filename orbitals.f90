module orbitals
! This is a module to help make the orbitals 
! more concretely expressed for the purposes of coding
implicit none

type primitive_gto
    ! the coefficients and expoents will vary
    ! Only for s - type orbitals, does not mention 
    ! angular momentum
    real :: coeff
    real :: expo
end type primitive_gto

type contracted_gto
    character(len=1) :: orb_type
    character(len=1) :: atom_name
    real, dimension(3) :: coords ! coordinates
    ! length of the contraction 
    integer :: M 
    ! The total number of primitives in the contraction
    type(primitive_gto), allocatable, dimension(:) :: contraction
end type contracted_gto

contains
!
function new_contraction(M,orb_type,atom_name,coords,coeff_vec,expo_vec)
    implicit none
    integer, intent(in) :: M
    character(len=1), intent(in) :: orb_type ! should all be s
    character(len=1), intent(in) :: atom_name
    real, dimension(3), intent(in) :: coords
    ! do these need to be allocatable?
    real, dimension(M),intent(in) :: coeff_vec
    real, dimension(M),intent(in) :: expo_vec

    integer :: i

    type(contracted_gto) :: new_contraction


    allocate(new_contraction%contraction(M))
    new_contraction%M = M
    new_contraction%orb_type = orb_type
    new_contraction%atom_name = atom_name
    new_contraction%coords = coords

    ! call coefficient_expo_maker(new_contraction,coeff_vec,expo_vec)

    do i = 1, M
        new_contraction%contraction(i)%coeff = coeff_vec(i)
        new_contraction%contraction(i)%expo = expo_vec(i)
    enddo

end function new_contraction


end module orbitals
