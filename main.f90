program main
!

! call in other modules that are relevant
use orbitals
use Gauss_Multiply
use reader

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
    real, allocatable, dimension(:,:) :: F
    real, allocatable, dimension(:,:) :: F_prime
    real, allocatable, dimension(:,:) :: G
    real, allocatable, dimension(:,:) :: C
    real, allocatable, dimension(:,:) :: C_prime
    real, allocatable, dimension(:,:,:) :: integrals ! A list of matrices

    ! output (not returned by subroutine, but written to file)
    real :: electronic_energy
    real :: nuclear_energy
    real :: total_energy
    character*80 :: output_file

    ! initialize the system - ie. read in the geometry and basis set. 
    ! The orbitals should be collected into  a vector (called 'orbs') of the 'contracted-
    ! gto' derived type
    call reader_sub(geom,basis,N,orbs)

    ! Calculate stored integrals
    call stored_integrals(N,orbs,integrals)

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
    output_file = "hf_out.out"
    open(unit=10,file=output_file,status="unknown")

    write(10,*) "Converged Energy Values (Hartree):"
    ! check the formatting 
    write(10,f10.5) "Electronic Energy: ", electronic_energy
    write(10,f10.f) "Nuclear Rep. Energy: ", nuclear_energy
    write(10,f10.5) "Total Energy: ", total_energy

end subroutine hf_main
