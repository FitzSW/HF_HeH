program main
!

! call in other modules that are relevant
use orbitals
use Gauss_Multiply
use reader
use diagonalizer
implicit none

! Needed functionalities:

! S, T, V_ne integrals
! Two electron integrals

! Matrix diagonalization
! Explicit functional forms of the basis functions

! get name of the geometry and basis file    
character*80 geom
character*80 basis


call get_command_argument(1,geom)
call get_command_argument(2,basis)

! The do-everything subroutine (pre-determined basis set)
call hf_main(geom,basis)

end program main

subroutine hf_main(geom,basis)
    implicit none

    ! input 
    character*80, intent(in) :: geom
    character*80, intent(in) :: basis

    ! intermediate
    type(contracted_gto), allocatable, dimension(:) :: orbs
    integer :: i ! A generic counter
    integer :: N ! Number of orbitals
    real, allocatable, dimension(:,:) :: S
    real, allocatable, dimension(:,:) :: X
    real, allocatable, dimension(:,:) :: T
    real, allocatable, dimension(:,:) :: V
    real, allocatable, dimension(:,:) :: TE ! Two electron
    real, allocatable, dimension(:,:) :: F
    real, allocatable, dimension(:,:) :: F_prime
    real, allocatable, dimension(:,:) :: G
    real, allocatable, dimension(:,:) :: C
    real, allocatable, dimension(:,:) :: C_prime

    ! output (not returned by subroutine, but written to file)
    real         :: electronic_energy
    real         :: nuclear_energy
    real         :: total_energy
    character*80 :: output_file

    ! initialize the system - ie. read in the geometry and basis set. 
    ! The orbitals should be collected into  a vector (called 'orbs') of the 'contracted-
    ! gto' derived type
    call reader_sub(geom,basis,N,orbs)

    ! Calculate stored integrals
    ! (change this to whatever you'd like, its just a place holder)
    call stored_integrals(N,orbs,S,T,V,TE)

    ! Diagonalize S to obtain X
    call diagonalize(N,S,X)

    ! Generate guess at density matrix - initial guess is G = zero
    call G_init(N,G) ! lives in the diagonalizer module
    goto 11

    10 continue ! use this as a checkpoint for the loop
    ! Calculate G matrix  (in loop) - want to skip this portion the first time, going 
    ! to labeled line 11

    ! Find F = T + V + G
    11 continue

    ! Transform the Fock matrix  to F'

    ! Diagonalize F' to obtain C' and epsilon

    ! Find C = X C' 

    ! Form new density matrix P from C 

    ! Determine convergence - if not then go back to 10
    if (.true.) then
        goto 10
    endif

    ! Print out the converged matrix  

    ! Calculate expectation value of electronic energy frim matrix values

    ! Find total energy (+ Nuc) and print output
    output_file = "hf_out.out"
    open(unit=10,file=output_file,status="unknown")

    write(10,*) "Converged Energy Values (Hartree):"
    ! check the formatting 
    write(10,f10.5) "Electronic Energy: ", electronic_energy
    write(10,f10.f) "Nuclear Rep. Energy: ", nuclear_energy
    write(10,f10.5) "Total Energy: ", total_energy

end subroutine hf_main
