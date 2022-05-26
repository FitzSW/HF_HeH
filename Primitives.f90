MODULE Primitive

        IMPLICIT NONE

        !Load in necessary modules

        USE constants

        USE orbitals

        USE reader

        USE integrals



!-----------------------------------------------------------------------------------------------------------
! These functions will take the index of two (or four) gaussian contractions - mu,nu (lamda,sigma)
! They will then take the sub index for a certain primitive in each of these contractions - noted by i,j,k,l
! And then compute the integral for these two primitives
!------------------------------------------------------------------------------------------------------------

CONTAINS


        FUNCTION Overlap_Prim(mu, nu, i,j)


                IMPLICIT NONE

                INTEGER, intent(in) :: i,j

                REAL :: alpha_a, alpha_b, answer, O, coeff_a, coeff_b

                REAL, dimension(3) :: R_a, R_b

                REAL, allocatable :: contraction_a, contraction_b

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)

                !Pull contraction

                contraction_a = orbs(mu)%contraction

                contract_b = orbs(nu)%contraction

                
                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = contraction_a(i)%expo
                alpha_b = contraction_b(j)%expo

                R_a = orbs(mu)%coords
                R_b = orbs(nu)%coords
                
                coeff_a = contraction_a(i)%coeff
                coeff_b = contraction_b(j)%coeff


                !Finally, compute the value of the overlap integral for those two orbitals 
                CALL Overlap(alpha_a,alpha_b,R_a,R_b, O)
                
                answer = O * coeff_a * coeff_b
        END FUNCTION


        FUNCTION Kinetic_Prim(mu, nu, i,j)

                IMPLICIT NONE

                INTEGER, intent(in) :: i,j

                REAL :: alpha_a, alpha_b, answer, K, coeff_a, coeff_b

                REAL, dim(3) :: R_a, R_b

                REAL, allocatable :: contraction_a, contraction_b

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)

                !Pull contractions

                contraction_a = orbs(mu)%contraction
                contraction_b = orbs(nu)%contraction

                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = contraction_a(i)%expo
                alpha_b = contraction_b(j)%expo

                R_a = orbs(mu)%coords
                R_b = orbs(nu)%coords

                coeff_a = contraction_a(i)%coeff
                coeff_b = contraction_b(j)%coeff

                !Finally, compute the value of the kinetic integral for those two orbitals 
                CALL Kinetic(alpha_a,alpha_b,R_a,R_b, K)
                
                answer = K * coeff_a * coeff_b
                
         END FUNCTION

        
         FUNCTION Potential_Prim(mu, nu, i,j, atom)

                IMPLICIT NONE

                INTEGER, intent(in) :: i,j

                CHARACTER*2, intent(in) :: atom

                REAL :: alpha_a, alpha_b, answer, Z_c, V, coeff_a, coeff_b

                REAL, dim(3) :: R_a, R_b, R_c

                REAL, allocatable :: contraction_a, contraction_b

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)

                !Pull contractions

                contraction_a = orbs(mu)%contraction

                contraction_b = orbs(nu)%contraction

                
                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = contraction_a(i)%expo
                alpha_b = contraction_b(j)%expo

                R_a = orbs(mu)%coords
                R_b = orbs(nu)%coords

                coeff_a = contraction_a(i)%coeff
                coeff_b = contraction_b(j)%coeff


                !For potential integral, will need the atomic number and center of desired atom

                IF (atom.eq."H+") THEN

                        Z_c = 1.0

                        R_c = (\0.0, 0.0, -0.517427\)

                ELSE IF (atom.eq."He") THEN

                        Z_c = 2.0

                        R_c = (\0.0, 0.0, 0.258713\)

                END If

                !Finally, compute the value of the potential integral for those two orbitals 
                CALL Potential(alpha_a,alpha_b,R_a,R_b, R_c, Z_c, V)
                
                answer = V * coeff_a * coeff_b
                
        END FUNCTION
                


        FUNCTION Two_Electron_Prim(mu,nu,lambda,sigma,i,j,k,l)

                IMPLICIT NONE

                INTEGER, intent(in) :: i,j,k,l

                REAL :: alpha_a, alpha_b, alpha_c, alpha_d, answer, TE, coeff_a, coeff_b, coeff_c, coeff_d

                REAL, dim(3) :: R_a, R_b, R_c, R_d

                REAL, allocatable :: contraction_a, contraction_b, contraction_c, contraction_d

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)

                !pull contractions

                contraction_a = orbs(mu)%contraction
                contraction_b = orbs(nu)%contraction
                contraction_c = orbs(lambda)%contraction
                contraction_d = orbs(sigma)%contraction

                
                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = contraction_a%expo(i)
                alpha_b = contraction_b%expo(j)
                alpha_c = contraction_c%expo(k)
                alpha_d = contraction_d%expo(l)

                R_a = orbs(mu)%coords
                R_b = orbs(nu)%coords
                R_c = orbs(lambda)%coords
                R_d = orbs(sigma)%coords

                coeff_a = contraction_a%coeff(i)
                coeff_b = contraction_b%coeff(j)
                coeff_c = contraction_c%coeff(k)
                coeff_d = contraction_d%coeff(l)


                !Finally, compute the value of the two electron integral for those two orbitals 
                CALL TWO_ELECTRON(alpha_a,alpha_b,alpha_c,alpha_d,R_a,R_b,R_c,R_d, TE)
                
                answer = TE * coeff_a * coeff_b * coeff_c * coeff_d

        END FUNCTION
END MODULE
