MODULE Primitive

        IMPLICIT NONE

        !Load in necessary modules

        USE constants

        USE oribtals

        USE reader

        USE integrals


CONTAINS


        FUNCTION Overlap(i,j)

                IMPLICIT NONE

                INTEGER, intent(in) :: i,j

                REAL :: alpha_a, alpha_b, answer, O

                REAL, dim(3) :: R_a, R_b

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)

                
                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = !exponential(i)
                alpha_b = !exponential(j)

                R_a = !position(i)
                R_b = !position(j)

                !Finally, compute the value of the overlap integral for those two orbitals 
                CALL Overlap(alpha_a,alpha_b,R_a,R_b, O)
                
                answer = O



        FUNCTION Kinetic(i,j)

                IMPLICIT NONE

                INTEGER, intent(in) :: i,j

                REAL :: alpha_a, alpha_b, answer, K

                REAL, dim(3) :: R_a, R_b

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)

                
                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = !exponential(i)
                alpha_b = !exponential(j)

                R_a = !position(i)
                R_b = !position(j)

                !Finally, compute the value of the kinetic integral for those two orbitals 
                CALL Kinetic(alpha_a,alpha_b,R_a,R_b, K)
                
                answer = K

        
         FUNCTION Potential(i,j, atom)

                IMPLICIT NONE

                INTEGER, intent(in) :: i,j

                CHARACTER*2, intent(in) :: atom

                REAL :: alpha_a, alpha_b, answer, Z_c, V

                REAL, dim(3) :: R_a, R_b, R_c

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)

                
                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = !exponential(i)
                alpha_b = !exponential(j)

                R_a = !position(i)
                R_b = !position(j)


                !For potential integral, will need the atomic number and center of desired atom

                R_c =
                Z_c = 

                !Finally, compute the value of the potential integral for those two orbitals 
                CALL Potential(alpha_a,alpha_b,R_a,R_b, R_c, Z_c, V)
                
                answer = V
                


        FUNCTION Two_Electron(i,j,k,l)

                IMPLICIT NONE

                INTEGER, intent(in) :: i,j,k,l

                REAL :: alpha_a, alpha_b, alpha_c, alpha_d, answer, TE

                REAL, dim(3) :: R_a, R_b, R_c, R_d

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)

                
                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = !exponential(i)
                alpha_b = !exponential(j)
                alpha_c = !exponential(k)
                alpha_d = !exponential(l)

                R_a = !position(i)
                R_b = !position(j)
                R_c = !position(k)
                R_d = !poisiton(l)

                !Finally, compute the value of the two electron integral for those two orbitals 
                CALL TWO_ELECTRON(alpha_a,alpha_b,alpha_c,alpha_d,R_a,R_b,R_c,R_d, TE)
                
                answer = TE

