module subs
contains

! subroutine diag_tester()
!     use diagonalizer
!     implicit none
!     integer, intent(in)              :: N
!     real, dimension(N,N), intent(in) :: I 
!     real, dimension(N,N), intent(in) :: O


!     call diagonalize(N,I,O) 
! end subroutine diag_tester

subroutine gto_tester()
    use orbitals
    implicit none
    character(len=1) :: orb_type
    character(len=1) :: atom_name
    real, dimension(3) :: coords
    real, dimension(3) :: coeff_vec
    real, dimension(3) :: expo_vec
    integer :: M, i
    type(contracted_gto) :: A

    M = 3

    orb_type = "s"
    atom_name = "H"
    coords = [0.0,0.0,0.0]
    ! The first s on 6-31G Hydrogen
    coeff_vec = [0.1873113696D+02, 0.2825394365D+01, 0.6401216923D+00]
    expo_vec = [0.3349460434D-01, 0.2347269535D+00, 0.8137573261D+00]

    A = new_contraction(M,orb_type,atom_name,coords,coeff_vec,expo_vec)

    ! write out a test
    write (*,*) "Atom name for A: :", A%atom_name
    write (*,*) ""

    do i = 1, M
        write (*,*) "Coef: ", A%contraction(i)%coeff, " Exp: ",A%contraction(i)%expo
    enddo

end subroutine gto_tester

subroutine reader_test(N,orbs)
    use orbitals
    use reader
    implicit none

    character*40 :: geom, basis
    type(contracted_gto), allocatable, dimension(:) :: orbs
    integer :: N

    geom = "./Opt/heh_geom.xyz"
    basis = "./Basis_Set/adapted_6-311G"

    call reader_sub(geom,basis,N,orbs)


end subroutine reader_test
end module subs

program tester
    ! just a  file that will be deleted when done
    use orbitals
    use reader
    use subs
    use diagonalizer

    implicit none

    ! call gto_tester()

    integer                                       :: N
    type(contracted_gto),allocatable,dimension(:) :: orbs
    real, dimension(2,2)                          :: O
    real, dimension(2,2)                          :: I
    real, dimension(2,2)                          :: E

    ! call reader_test(N,orbs)
    ! call orbitals_printer(N,orbs)
    N = 2
    ! allocate(O(2,2))
    I = reshape((/ -2.4397, -0.5158, -0.5158, -1.5387 /),shape(I))
    call eigen_finder(N,I,O,E)

    write(*,*) "did not crash"


end program tester
