MODULE integrals


! --------------------------------------------------------------------------------------
! Computes initial values of molecular integrals necessary for HF procedure
! S is the overlap matrix
! H = T + V, where T is the kinetic energy matrix and V is the nuclear attraction matrix
! TWO-ELECTRON is the two electron integral matrix
! --------------------------------------------------------------------------------------
  

          !import necessary modules
          USE constants!, only :: PI_16
          
          USE Gauss

          USE F_0

          IMPLICIT NONE


  





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
            
            O = ((2.*alpha_a/PI_16)**(3./4.)) * ((2.*alpha_b/PI_16)**(3./4.)) * ((PI_16/p)**(3./2.)) * konstant

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
            
            pref = (alpha_a*alpha_b/p)*(3.-(2.*alpha_a*alpha_b/p)*DOT_PRODUCT(vec_new, vec_new))
            
            K = ((2.*alpha_a/PI_16)**(3./4.)) * ((2.*alpha_b/PI_16)**(3./4.)) * pref * ((PI_16/p)**(3./2.)) * konstant

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
            
            REAL :: konstant, p, t1
            REAL, dimension(3) :: R_p, vec_newv
            
            CALL Gauss_Multiply(alpha_a, alpha_b, R_a, R_b, konstant, R_p, p)
            
            !Szabo and Ostlund don't mention these two cases, but another report I found does, so I will include them just in case
            !To be clear, Szabo and Ostlund just includes the R_p != R_c case
            

            vec_newv = R_p - R_c

            t1 = p*DOT_PRODUCT(vec_newv,vec_newv)
                
            V = ((2.*alpha_a/PI_16)**(3./4.)) * ((2.*alpha_b/PI_16)**(3./4.)) * (2.*PI_16/p)*konstant*Function_0(t1)

            V = -V * Z_c
            
            
            
            

        END SUBROUTINE
        !--------------------------------
        SUBROUTINE TWO_ELECTRON(alpha_a,alpha_b, alpha_c, alpha_d, R_a, R_b, R_c, R_d, TE)
            IMPLICIT NONE

            REAL, intent(in) :: alpha_a,alpha_b, alpha_c, alpha_d
            REAL, dimension(3), intent(in) :: R_a, R_b, R_c, R_d
            REAL, intent(out) :: TE
            
            REAL :: konstant_p, konstant_q, p, q, t1
            REAL, dimension(3) :: R_p, R_q, vec_new
            !R_p is combined center of Gauss Product a,b; R_q is combined center of gauss product, c,d
            
            !multiply a,b
            CALL Gauss_Multiply(alpha_a, alpha_b, R_a, R_b, konstant_p, R_p, p)
            !multiply c,d
            CALL Gauss_Multiply(alpha_c, alpha_d, R_c, R_d, konstant_q, R_q, q)
            
            !There are two possible results for this integral based on if R_p and R_q are equal
            
            IF (ALL(R_p.eq.R_q)) THEN
            
              !case one

              TE = ((2.*alpha_a/PI_16)**(3./4.)) * ((2.*alpha_b/PI_16)**(3./4.)) * ((2.*alpha_c/PI_16)**(3./4.)) &
              * ((2.*alpha_d/PI_16)**(3./4.)) * ((2.*PI_16**(5./2.))/(p*q*SQRT(p+q)))*konstant_p*konstant_q
            
            ELSE
            
              !case two

              vec_new = R_p-R_q

              t1 = ((p*q)/(p+q))*DOT_PRODUCT(vec_new,vec_new)

              TE = ((2.*alpha_a/PI_16)**(3./4.)) * ((2.*alpha_b/PI_16)**(3./4.)) * ((2.*alpha_c/PI_16)**(3./4.)) &
              * ((2.*alpha_d/PI_16)**(3./4.)) * ((2*PI_16**(5./2.))/(p*q*SQRT(p+q)))*konstant_p*konstant_q*Function_0(t1)

            END IF
            
            
         
            

        END SUBROUTINE



END MODULE integrals
