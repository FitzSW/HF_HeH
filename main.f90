program main
!

! call in other modules that are relevant

implicit none

! Needed functionalities:

! S, T, V_ne integrals
! Two electron integrals

! Matrix diagonalization
! Explicit functional forms of the basis functions


call hf_main()


end program main

subroutine hf_main()
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
