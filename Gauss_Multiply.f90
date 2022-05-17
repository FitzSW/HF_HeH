Module Gauss

        IMPLICIT NONE

        USE constants


CONTAINS

        SUBROUTINE GAUSS_MULTIPLY(alpha_a,alpha_b, R_a, R_b , alpha_new, R_new)
                !Pass G1, G2 as a vector of necessary Gaussian Components (maybe?)
                !Use Gaussian Product Theorem

                IMPLICIT NONE

                DOUBLE PRECISION,  intent(in) :: alpha_a, alpha_b, R_a, R_b

                DOUBLE PRECISION,  intent(out) :: alpha_new, R_new

                REAL :: gamma_, p 

        END SUBROUTINE

END MODULE Gauss       
