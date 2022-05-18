MODULE F_0
        IMPLICIT NONE

        Use constants, only :: PI_16

CONTAINS

        FUNCTION Function_0(t)

                REAL, intent(in) :: t

                REAL :: F


                F = (1/2)*((PI_16/t)**(1/2))*ERF(SQRT(T))


        END FUNCTION

END MODULE F_0
              
