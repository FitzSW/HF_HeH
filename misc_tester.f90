program tester
    ! just a  file that will be deleted when done
    use orbitals

    implicit none

    type(contracted_gto) :: A

    A%coords = [0.0,0.0,0.0]

    A = new_contraction(3)

    A%orb_type = "p"
    A%atom_name = "C"

    ! The angular momentum numbers
    A%contraction(1)%L = [1,0,0]
    A%contraction(2)%L = [0,1,0]
    A%contraction(3)%L = [0,0,1]

    ! coeff and exponents
    A%contraction(1)%coeff =  4.912920 
    A%contraction(1)%expo = 0.109931
    A%contraction(2)%coeff =  4.912920 
    A%contraction(2)%expo = 0.109931
    A%contraction(3)%coeff =  4.912920 
    A%contraction(3)%expo = 0.109931

    ! write out a test
    write (*,*) "Atom name for A: :", A%atom_name


end program tester
