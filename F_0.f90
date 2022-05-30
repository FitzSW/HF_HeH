MODULE F_0

        Use constants, only : PI_16

        IMPLICIT NONE

CONTAINS

        FUNCTION Function_0(t) result(F) 

                REAL, intent(in) :: t

                REAL :: F


                F = (0.5)*((PI_16/t)**(0.5))*ERF(SQRT(t))


        END FUNCTION

END MODULE F_0
              
