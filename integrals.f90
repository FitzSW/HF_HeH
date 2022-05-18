MODULE integrals


! --------------------------------------------------------------------------------------
! Computes initial values of molecular integrals necessary for HF procedure
! S is the overlap matrix
! H = T + V, where T is the kinetic energy matrix and V is the nuclear attraction matrix
! TWO-ELECTRON is the two electron integral matrix
! --------------------------------------------------------------------------------------
  

          !import necessary modules
          USE constants, only : PI_16
          
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
        SUBROUTINE Potential(alpha_a,alpha_b, R_a, R_b, P)

            IMPLICIT NONE

            REAL, intent(in) :: alpha_a, alpha_b, R_a, R_b
            REAL, intent(out) :: P

        END SUBROUTINE
        !--------------------------------
        SUBROUTINE TWO_ELECTRON(alpha_a,alpha_b, R_a, R_b, TE)
            IMPLICIT NONE

            REAL, intent(in) :: alpha_a,alpha_b, R_a, R_b
            REAL, intent(out) :: TE

        END SUBROUTINE



END MODULE integrals
