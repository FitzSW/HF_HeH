Module Gauss

        IMPLICIT NONE

        USE constants


CONTAINS

        SUBROUTINE GAUSS_MULTIPLY(G1,G2,PROD)
                !Pass G1, G2 as a vector of necessary Gaussian Components (maybe?)
                !Use Gaussian Product Theorem

                IMPLICIT NONE

                DOUBLE PRECISION, DIMENSION(N), intent(in) :: G1, G2

                DOUBLE PRECISION, DIMENSION(N), intent(out) :: PROD

                REAL :: gamma_, p 

        END SUBROUTINE

END MODULE Gauss       
