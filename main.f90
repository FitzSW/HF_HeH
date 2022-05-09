program main
!

! call in other modules that are relevant

implicit none

! Needed functionalities:

! S, T, V_ne integrals
! Two electron integrals

! Matrix diagonalization
! Explicit functional forms of the basis functions

! get name of the geometry file    
character*40 geom


call get_command_argument(1,geom)


! The do-everything subroutine (pre-determined basis set)
call hf_main(geom)

end program main

subroutine hf_main(geom)
    implicit none
    character(len=1), dimension(4) :: atoms
    real, dimension(4,3) :: coords
    integer :: i

    atoms(1) = "C"
    do i = 2, 5
        atoms(i) = "H"
    enddo

    ! Calculate stored integrals

    ! Diagonalize S to obtain X

    ! Generate guess at density matrix

    ! Calculate G matrix 

    ! Find F = T + V + G

    ! Transform the Fock matrix  to F'

    ! Diagonalize F' to obtain C' and epsilon

    ! Find C = X C' 

    ! Form new density matrix P from C 

    ! Determine convergence

    ! Repeat or print out the converged matrix  

    ! Calculate expectation value of electronic energy

    ! Find total energy (+ Nuc) and print output

end subroutine hf_main
