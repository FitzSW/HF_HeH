program tester
    ! just a  file that will be deleted when done
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

end program tester
