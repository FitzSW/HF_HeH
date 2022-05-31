program main
!

! call in other modules that are relevant
! use Gauss_Multiply
use constants
use gauss
use F_0
use integrals
use orbitals
use reader
use primitive
use Matrices
use diagonalizer
use diag
implicit none

! Needed functionalities:

! S, T, V_ne integrals
! Two electron integrals

! Matrix diagonalization
! Explicit functional forms of the basis functions

! get name of the geometry and basis file    
character*80 geom
character*80 basis


geom = "./Opt/heh_Bohr_geom.xyz"
basis = "./Basis_Set/adapted_STO-3G"


! The do-everything subroutine (pre-determined basis set)
call hf_main(geom,basis)

end program main

subroutine hf_main(geom,basis)
    use constants
    use gauss
    use F_0
    use integrals
    use orbitals
    use reader
    use primitive
    use Matrices
    use diagonalizer
    use diag
    implicit none

    ! input 
    character*80, intent(in) :: geom
    character*80, intent(in) :: basis

    ! intermediate
    type(contracted_gto), allocatable, dimension(:) :: orbs
    integer :: i, j, k, l ! A generic counter
    integer :: N ! Number of orbitals
    real, allocatable, dimension(:,:) :: S
    real, allocatable, dimension(:,:) :: X
    real, allocatable, dimension(:,:) :: X_herm
    real, allocatable, dimension(:,:) :: T
    real, allocatable, dimension(:,:) :: V1, V2
    real, allocatable, dimension(:,:) :: H_core
    real, allocatable, dimension(:,:) :: TE ! Two electron
    real, allocatable, dimension(:,:) :: F
    real, allocatable, dimension(:,:) :: F_prime
    real, allocatable, dimension(:,:) :: G
    real, allocatable, dimension(:,:) :: P
    real, allocatable, dimension(:,:) :: P_new
    real, allocatable, dimension(:,:) :: C
    real, allocatable, dimension(:,:) :: C_prime
    real, allocatable, dimension(:,:) :: C_new
    real, allocatable, dimension(:,:) :: Ep
    real, dimension(6,6,6,6) :: Tens

    ! Values for determining matrix convergence
    real    :: diff, conv
    integer :: cycle_num

    ! output (not returned by subroutine, but written to file)
    real         :: temp_energy
    real         :: electronic_energy
    real         :: dist
    real         :: nuclear_energy
    real         :: total_energy
    character*80 :: output_file
    character*80 :: S_out
    character*80 :: P_out
    character*80 :: JK

    real, dimension(3) :: R_c1, R_c2

    ! Dummy file for printing out de-bug matrices
    S_out = "S_out"
    P_out = "P_out"
    JK    = "JK"

    ! Set convergence tolerance
    conv = 1e-3

    call execute_command_line("rm -f temp_file_1")
    call execute_command_line("rm -f temp_file_2")
    call execute_command_line("rm -f temp_file_3")

    ! initialize the system - ie. read in the geometry and basis set. 
    ! The orbitals should be collected into  a vector (called 'orbs') of the 'contracted-
    ! gto' derived type
    call reader_sub(geom,basis,N,orbs)

    write(*,*) "checkpoint A"
    ! Calculate stored integrals
    ! (change this to whatever you'd like, its just a place holder)
    ! call stored_integrals(N,orbs,S,T,V_H,V_He,TE)

    ! allocate(S(N,N))
    call G_init(N,S)
    call G_init(N,T)
    call G_init(N,V1)
    call G_init(N,V2)
    ! allocate(T(N,N))
    ! allocate(V_tot(N,N))
    call Compute_Overlap(S)
    call Compute_Kinetic(T)

    
    R_c1 = (/0.0,0.0,1.4632/)
    R_c2 = (/0.0,0.0,0.0/)

    call Compute_Potential(V1,2.0,R_c2)
    call Compute_Potential(V2,1.0,R_c1)
    write(*,*) "V1"
    call matrix_printer(N, V1)
    write(*,*) "V2"
    call matrix_printer(N,V2)
    write(*,*) "checkpoint B"

    ! Allocate remaining matrices
    allocate(F(N,N))
    allocate(F_prime(N,N))
    allocate(C(N,N))
    allocate(C_new(N,N))
    allocate(C_prime(N,N))
    allocate(H_core(N,N))
    ! allocate(P(N,N))
    allocate(P_new(N,N))
    ! allocate(G(N,N))
    ! allocate(V_tot(N,N))
    ! allocate(T(N,N))
    allocate(Ep(N,N))

    write(*,*) "Starting Cycle: ", cycle_num
    cycle_num = cycle_num + 1

    ! Calculate the core Hamiltonian
    H_core = T + V1 + V2

    write(*,*) "H_core"
    call matrix_printer(N,H_core)

    ! Diagonalize S to obtain X

    write(*,*) "checkpoint C"
    call execute_command_line("rm -f S_out")
    call matrix_writer(N,S,S_out)

    ! allocate(X(N,N))
    call x_finder(N,S,X)
    write(*,*) "checkpoint D"

    ! Generate guess at density matrix - initial guess is G = zero
    ! and P = zero
    call G_init(N,P)
    call G_init(N,G) ! lives in the diagonalizer module
    goto 11

    10 continue ! use this as a checkpoint for the loop
    ! Calculate G matrix  (in loop) - want to skip this portion the first time, going 
    ! to labeled line 11

    !! use the subroutine that takes P and the two electron integrals to 
    !! find G

<<<<<<< HEAD
    ! call matrix_write(N,P,P_out)
    ! call execute_command_line("./JK_solver.py")
    ! call matrix_reader2(N,G,JK)
    ! call execute_command_line("rm -f JK")

    call Two_Tensor(Tens)

    call FORMG(Tens, G, P)

    write(*,*) "G"
    call matrix_printer(N,G)

=======
    call Compute_Tensor(Tens)
    call Compute_G(P,G,Tens)
>>>>>>> Test

    ! Find F = T + V + G
    11 continue
    F = H_core + G

    WRITE(*,*) "F"
    call matrix_printer(N,F)

    X(1,1) = 0.5870642
    X(2,1) = 0.5870642
    X(1,2) = 0.9541310
    X(2,2) = -0.9541310


    ! Transform the Fock matrix  to F'
    ! Check that using 'real' here is ok
    X_herm = TRANSPOSE(X)
    F_prime = real(matmul(X_herm,matmul(F,X)))

    write(*,*) "F_prime"
    call matrix_printer(N,F_prime)

    ! Diagonalize (find eigvecs, vals) F' to obtain C' and epsilon
    !call eigen_finder(N,F_prime,C_prime,Ep)

    call diagonalize(F_prime,C_prime,Ep)

    write(*,*) "C_prime"
    call matrix_printer(N,C_prime)

    write(*,*) "Ep"
    call matrix_printer(N,Ep)
        
    ! Find C = X C' 
    C = matmul(X,C_prime)

    write(*,*) "C"
    call matrix_printer(N,C)

    ! Form new density matrix P from C 
    do i = 1, N
        do j = 1, N
            ! Sum over only 1 occupied orbital
            ! warning: conjugate may be needed
            P_new(i,j) = 2 * C(i,1) * C(j,1)
        enddo
    enddo

    write(*,*) "P"
    call matrix_printer(N,P_new)

    ! Determine convergence - if not then go back to 10
    diff = abs(maxval(P_new - P))
    P = P_new
    if (diff > conv) then
        write(*,*) "Starting Cycle: ", cycle_num
        cycle_num = cycle_num + 1
        goto 10
    endif

    ! Print out the converged matrix  

    ! Calculate expectation value of electronic energy frim matrix values
    do i = 1, N
        do j = 1, N
            temp_energy = 0.5 * P(j,i) * (H_core(i,j) + F(i,j))
            electronic_energy = electronic_energy + temp_energy
        enddo
    enddo

    dist = norm2(orbs(1)%coords - orbs(N)%coords)
    nuclear_energy = 2.0 / dist

    total_energy = electronic_energy + nuclear_energy

    ! Find total energy (+ Nuc) and print output
    output_file = "hf_out.out"
    open(unit=10,file=output_file,status="unknown")

    write(10,*) "Converged Energy Values (Hartree):"
    ! check the formatting 
    write(10,*) "Electronic Energy: ", electronic_energy
    write(10,*) "Nuclear Rep. Energy: ", nuclear_energy
    write(10,*) "Total Energy: ", total_energy
    close(10)

end subroutine hf_main
