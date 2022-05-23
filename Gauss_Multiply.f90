Module Gauss_Multiply


        USE constants

        IMPLICIT NONE

CONTAINS

        SUBROUTINE GAUSS_MULTIPLY(alpha_a,alpha_b, R_a, R_b , konstant, R_p, p)
                !Takes exponent and centers of two primitive gaussians and returns the exponents, centers, and proportionality constant for their product
        
                !currently unnormalized, but v. easy to add
                IMPLICIT NONE

                DOUBLE PRECISION,  intent(in) :: alpha_a, alpha_b
                
                DOUBLE PRECISION, dimension(3), intent(in) :: R_a, R_b

                DOUBLE PRECISION,  intent(out) :: konstant, p
                
                DOUBLE PRECISION, dimension(3), intent(out) :: R_p

                REAL :: gamma_
                
                REAL, dimension(3) :: vec_new
                
                
                !define center of new gaussian
                R_p = (alpha_a*R_a + alpha_b*R_b)/(alpha_a+alpha_b)
                
                
                !define exponential of proportionality constant
                gamma_ = -(alpha_a*alpha_b)/(alpha_a+alpha_b)
                
                vec_new = R_a - R_b
                
                konstant = EXP(gamma_ * DOT_PRODUCT(vec_new,vec_new))
                
                !define exponent of new gaussian
                p = alpha_a + alpha_b
           
  

        END SUBROUTINE

END MODULE Gauss_Multiply
