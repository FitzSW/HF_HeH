module reader
use orbitals
! A module to read in the geometry and basis set files
contains
!
subroutine reader_sub(geom,basis,N,orbs)
    implicit none
    ! input 
    character*40, intent(in) :: geom
    character*40, intent(in) :: basis
    
    ! intermediate
    integer                                :: n_atoms, n_orbs
    integer                                :: i, j, k ! counters
    character*80                           :: dummy_string
    real                                   :: dummy_real
    real, allocatable, dimension(:,:)      :: total_coords
    character*2, allocatable, dimension(:) :: atom_names
    character*2                            :: local_atom_name
    character*2                            :: local_orb_type
    real, allocatable, dimension(:)        :: local_coeff_vec
    real, allocatable, dimension(:)        :: local_expo_vec
    type(contracted_gto)                   :: local_orbital
    ! number of orbitals on current atom
    integer                                :: loc_N 
    ! local contraction length
    integer                                :: loc_M 
    integer                                :: orbital_index


    ! output
    type(contracted_gto), allocatable, dimension(:) :: orbs
    ! numer of orbs
    integer                                         :: N 
    ! length of the local contraction being read
    integer                                         :: M 

    ! Needs to account for both the length of the csv file (in orbs)
    ! as well as the length of each orbital (contraction length) 

    open(unit=10,file=geom,access='sequential',status='unknown')
    ! open(unit=11,file=basis,access='sequential',status='unknown')

    ! first read in the geometry
    read (10,*) n_atoms
    allocate(total_coords(n_atoms,3))
    allocate(atom_names(n_atoms))
    ! read in the comment line
    read (10,*) dummy_string

    ! read in the atoms
    do  i = 1, n_atoms
        read(10,*) atom_names(i), total_coords(i,1), & 
            total_coords(i,2), total_coords(i,3)
    enddo

    ! print out as a test
    ! do i = 1, n_atoms
    !     write(*,*) atom_names(i), total_coords(i,1), & 
    !         total_coords(i,2), total_coords(i,3)
    ! enddo
    
    ! Now we have the atom names and coordinates!
    open(unit=11,file=basis,access="sequential",status="unknown")
    read (11,*)  n_orbs ! 6
    N = n_orbs

    ! allocate the orbital vector
    allocate(orbs(n_orbs))

    orbital_index = 1

    do i = 1, n_atoms
        read(11,*) dummy_string ! ****
        read(11,*) local_atom_name, loc_N ! H    3

        ! In this loop you make and allocate each of the contractions
        do j = 1, loc_N
            read(11,*) local_orb_type, loc_M, dummy_real ! S 3 1.00
            allocate(local_coeff_vec(loc_M))
            allocate(local_expo_vec(loc_M))

            do k = 1, loc_M
                read(11,*) local_coeff_vec(k), local_expo_vec(k)
            enddo

            local_orbital = new_contraction(loc_M, &
                local_orb_type, &
                local_atom_name, &
                ! BEWARE: This would not work if more than 
                ! one atom of the same elemet is present
                ! (does not apply for HeH+)
                total_coords(i,:), &
                local_coeff_vec, &
                local_expo_vec)

            deallocate(local_coeff_vec)
            deallocate(local_expo_vec)

            orbs(orbital_index) = local_orbital
            orbital_index = orbital_index + 1

        enddo
    enddo

    close(10)
    close(11)

end subroutine reader_sub 


end module reader
