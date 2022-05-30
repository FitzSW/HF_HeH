MODULE Primitive


        !Load in necessary modules

        USE constants

        USE orbitals

        USE reader

        USE integrals

        IMPLICIT NONE



!-----------------------------------------------------------------------------------------------------------
! These functions will take the index of two (or four) gaussian contractions - mu,nu (lamda,sigma)
! They will then take the sub index for a certain primitive in each of these contractions - noted by i,j,k,l
! And then compute the integral for these two primitives
!------------------------------------------------------------------------------------------------------------

CONTAINS


        FUNCTION Overlap_Prim(mu, nu, i,j) result(answer)


                IMPLICIT NONE

                INTEGER, intent(in) :: i,j, mu, nu

                REAL :: alpha_a, alpha_b, answer, O, coeff_a, coeff_b

                REAL, dimension(3) :: R_a, R_b

                REAL, allocatable :: contraction_a, contraction_b

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_Bohr_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)
                
                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = orbs(mu)%contraction(i)%expo
                alpha_b = orbs(nu)%contraction(j)%expo

                R_a = orbs(mu)%coords
                R_b = orbs(nu)%coords
                
                coeff_a = orbs(mu)%contraction(i)%coeff
                coeff_b = orbs(nu)%contraction(j)%coeff
               
                !Finally, compute the value of the overlap integral for those two orbitals 
                CALL Overlap(alpha_a,alpha_b,R_a,R_b, O)
                
                answer = O * coeff_a * coeff_b
        END FUNCTION


        FUNCTION Kinetic_Prim(mu, nu, i,j) result(answer)

                IMPLICIT NONE

                INTEGER, intent(in) :: i,j, mu, nu

                REAL :: alpha_a, alpha_b, answer, K, coeff_a, coeff_b

                REAL, dimension(3) :: R_a, R_b

                REAL, allocatable :: contraction_a, contraction_b

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_Bohr_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)

                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = orbs(mu)%contraction(i)%expo
                alpha_b = orbs(nu)%contraction(j)%expo

                R_a = orbs(mu)%coords
                R_b = orbs(nu)%coords

                coeff_a = orbs(mu)%contraction(i)%coeff
                coeff_b = orbs(nu)%contraction(j)%coeff

                !Finally, compute the value of the kinetic integral for those two orbitals 
                CALL Kinetic(alpha_a,alpha_b,R_a,R_b, K)
                
                answer = K * coeff_a * coeff_b
                
         END FUNCTION

        
         FUNCTION Potential_Prim(mu, nu, i,j, atom) result(answer)

                IMPLICIT NONE

                INTEGER, intent(in) :: i,j, mu,nu

                CHARACTER*2, intent(in) :: atom

                REAL :: alpha_a, alpha_b, answer, Z_c, V, coeff_a, coeff_b

                REAL, dimension(3) :: R_a, R_b, R_c

                REAL, allocatable :: contraction_a, contraction_b

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_Bohr_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)

                
                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = orbs(mu)%contraction(i)%expo
                alpha_b = orbs(nu)%contraction(j)%expo

                R_a = orbs(mu)%coords
                R_b = orbs(nu)%coords

                coeff_a = orbs(mu)%contraction(i)%coeff
                coeff_b = orbs(nu)%contraction(j)%coeff


                !For potential integral, will need the atomic number and center of desired atom

                IF (atom.eq."H+") THEN

                        Z_c = 1.0

                        R_c = (/0.0, 0.0, 0.0/)

                ELSE IF (atom.eq."He") THEN

                        Z_c = 2.0

                        R_c = (/0.0, 0.0, 1.4666919288/)

                END If

                !Finally, compute the value of the potential integral for those two orbitals 
                CALL Potential(alpha_a,alpha_b,R_a,R_b, R_c, Z_c, V)
                
                answer = V * coeff_a * coeff_b
                
        END FUNCTION
                


        FUNCTION Two_Electron_Prim(mu,nu,lambda,sigma,i,j,k,l) result(answer)

                IMPLICIT NONE

                INTEGER, intent(in) :: i,j,k,l, mu, nu, lambda, sigma

                REAL :: alpha_a, alpha_b, alpha_c, alpha_d, answer, TE, coeff_a, coeff_b, coeff_c, coeff_d

                REAL, dimension(3) :: R_a, R_b, R_c, R_d

                REAL, allocatable :: contraction_a, contraction_b, contraction_c, contraction_d

                INTEGER :: N

                CHARACTER*40 :: geom, basis

                type(contracted_gto), allocatable, dimension(:) :: orbs

                !First, load in geometry and basis set        
                geom = "./Opt/heh_Bohr_geom.xyz"
                basis = "./Basis_Set/adapted_6-311G"
                
                CALL reader_sub(geom,basis,N,orbs)

                
                !Then, assign values based on the desired primitive gaussian multiplication

                alpha_a = orbs(mu)%contraction(i)%expo
                alpha_b = orbs(nu)%contraction(j)%expo
                alpha_c = orbs(lambda)%contraction(k)%expo
                alpha_d = orbs(sigma)%contraction(l)%expo

                R_a = orbs(mu)%coords
                R_b = orbs(nu)%coords
                R_c = orbs(lambda)%coords
                R_d = orbs(sigma)%coords

                coeff_a = orbs(mu)%contraction(i)%coeff
                coeff_b = orbs(nu)%contraction(j)%coeff
                coeff_c = orbs(lambda)%contraction(k)%coeff
                coeff_d = orbs(sigma)%contraction(l)%coeff


                !Finally, compute the value of the two electron integral for those two orbitals 
                CALL TWO_ELECTRON(alpha_a,alpha_b,alpha_c,alpha_d,R_a,R_b,R_c,R_d, TE)
                
                answer = TE * coeff_a * coeff_b * coeff_c * coeff_d

        END FUNCTION

subroutine TE(W,orbs,i,j,k,l)
    implicit none
    integer, intent(in)                  :: N, i, j, k, l
    type(contracted_gto), dimension(N,N) :: orbs
    real                                 :: W
    type(contracted_gto)                 :: A, B, C, D
    real                                 :: alpha, beta, gamm, delta
    integer                              :: M1, M2, M3, M4


end subroutine TE



    





END MODULE
