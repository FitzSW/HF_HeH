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
    character(len=2) :: atom_name
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
    character(len=2), intent(in) :: atom_name
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


    do i = 1, M
        new_contraction%contraction(i)%coeff = coeff_vec(i)
        new_contraction%contraction(i)%expo = expo_vec(i)
    enddo

end function new_contraction

subroutine orbitals_printer(N,orbs)
    implicit none
    integer :: N
    type(contracted_gto), dimension(N) :: orbs
    integer :: i

    write(*,*) "Printing ", N, "orbitals..."
    do i = 1, N
        write(*,*) "Oribtal: ", i
        call single_orb_printer(orbs(i))
    enddo
end subroutine orbitals_printer

subroutine single_orb_printer(orb)
    implicit none
    type(contracted_gto) :: orb
    integer :: M, i

    M =  orb%M

    write(*,*) "Atom: ", orb%atom_name
    write(*,*) "Orb Type: ", orb%orb_type
    write(*,*) "Coords: ", orb%coords
    write(*,*) "  Coeffs           Exponents"

    do i = 1, M
        write(*,*) orb%contraction(i)%coeff, &
                   orb%contraction(i)%expo
    enddo
    write(*,*) ""
    write(*,*) ""

    end subroutine single_orb_printer


end module orbitals
