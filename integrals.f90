MODULE integrals


! --------------------------------------------------------------------------------------
! Computes initial values of molecular integrals necessary for HF procedure
! S is the overlap matrix
! H = T + V, where T is the kinetic energy matrix and V is the nuclear attraction matrix
! TWO-ELECTRON is the two electron integral matrix
! --------------------------------------------------------------------------------------
  

          !import necessary modules
          USE constants, only :: PI_16
          
          USE Gauss_Multiply

          IMPLICIT NONE

          REAL, DIMENSION(N,N) :: S, H, TWO_ELECTRON
          !N here will be the size of the matrices based on basis set
          !maybe 16x16

  





CONTAINS
        
        !--------------------------------
        SUBROUTINE Overlap(alpha_a,alpha_b, R_a, R_b,O)

            IMPLICIT NONE

            REAL, intent(in) :: alpha_a, alpha_b
            REAL, dimension(3), intent(in) :: R_a, R_b
            REAL, intent(out) :: O
            
            REAL :: konstant, p
            REAL, dimension(3) :: R_p
            
            Call Gauss_Multiply(alpha_a, alpha_b, R_a, R_b, konstant, R_p, p)
            
            O = (PI_16/p)**(3/2) * konstant

        END SUBROUTINE
        !--------------------------------
        SUBROUTINE Kinetic(alpha_a,alpha_b, R_a, R_b, K)

            IMPLICIT NONE

            REAL, intent(in) :: alpha_a, alpha_b
            REAL, dimension(3), intent(in) :: R_a, R_b
            REAL, intent(out) :: K
            
            REAL :: konstant, p, pref
            REAL, dimension(3) :: R_p, vec_new
            
            Call Gauss_Multiply(alpha_a, alpha_b, R_a, R_b, konstant, R_p, p)
            
            vec_new = R_a - R_b
            
            pref = (alpha_a*alpha_b/p)*(3-(2*alpha_a*alpha_b/p)*DOT_PRODUCT(vec_new, vec_new))
            
            K = pref * (PI_16/p)**(3/2) * konstant

        END SUBROUTINE
        !--------------------------------
        SUBROUTINE Potential(alpha_a,alpha_b, R_a, R_b, R_c, Z_c, V)
        !Between two GTOs and the nucleus of either H or He
        !R_c is the center of this nucleus, Z_c is the nuclear charge 
        !The final nuclear attraction matrix will be evaluated over all GTO pairs for the two nuclei

            IMPLICIT NONE

            REAL, intent(in) :: alpha_a, alpha_b, Z_c
            REAL, dimension(3), intent(in) :: R_a, R_b, R_c
            REAL, intent(out) :: V
            
            REAL :: konstant, p
            REAL, dimension(3) :: R_p, vec_new
            
            CALL Gauss_Multiply(alpha_a, alpha_b, R_a, R_b, konstant, R_p, p)
            
            !Szabo and Ostlund don't mention these two cases, but another report I found does, so I will include them just in case
            !To be clear, Szabo and Ostlund just includes the R_p != R_c case
            
            IF (R_p.eq.R_c) THEN
            
            V = 
            
            ELSE IF (R_p.ne.R_c) THEN
            
            V = 
            
            
            
            

        END SUBROUTINE
        !--------------------------------
        SUBROUTINE TWO_ELECTRON(alpha_a,alpha_b, alpha_c, alpha_d, R_a, R_b, R_c, R_d, TE)
            IMPLICIT NONE

            REAL, intent(in) :: alpha_a,alpha_b, alpha_c, alpha_d
            REAL, dimension(3), intent(in) :: R_a, R_b, R_c, R_d
            REAL, intent(out) :: TE
            
            REAL :: konstant_p, konstant_q, p, q
            REAL, dimension(3) :: R_p, R_q, vec_new1, vec_new2
            !R_p is combined center of Gauss Product a,b; R_q is combined center of gauss product, c,d
            
            !multiply a,b
            CALL Gauss_Multiply(alpha_a, alpha_b, R_a, R_b, konstant_p, R_p, p)
            !multiply c,d
            CALL Gauus_Multiply(alpha_c, alpha_d, R_c, R_d, konstant_q, R_q, q)
            
            !There are two possible results for this integral based on if R_p and R_q are equal
            
            IF (R_p.eq.R_q) THEN
            
              !case one
            
            ELSE IF (R_p.ne.R_q) THEN
            
              !case two
            
            
         
            

        END SUBROUTINE



END MODULE integrals
