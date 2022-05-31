MODULE F_0

        Use constants, only : PI_16

        IMPLICIT NONE

CONTAINS

        FUNCTION Function_0(t) result(F) 

                REAL, intent(in) :: t

                REAL :: F

                if (t.lt.1.0D-6) GO TO 10


                F = (0.5)*SQRT(PI_16/t)*ERF(SQRT(t))

                GOTO 20


            10  F = 1.0D0 - t/3.0D0

            20 CONTINUE


        END FUNCTION

END MODULE F_0
              
