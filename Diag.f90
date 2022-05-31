MODULE diag


        USE constants

        IMPLICIT NONE


CONTAINS

        SUBROUTINE diagonalize(F,C,E)

                IMPLICIT NONE

                REAL, dimension(2,2), intent(inout) :: F,C,E

                REAL :: THETA, TEMP

                IF (ABS(F(1,1) - F(2,2)).gt.1.0D-20) GO TO 10

                THETA = PI_16/4.0D0

                GO TO 20

             10 continue

                THETA = 0.5D0*ATAN(2.0D0*F(1,2)/(F(1,1)-F(2,2)))

             20 continue
                
                C(1,1) = COS(THETA)
                C(2,1) = SIN(THETA)
                C(1,2) = SIN(THETA)
                C(2,2) = -COS(THETA)

                E(1,1) = F(1,1) * COS(THETA)**2 + F(2,2)*SIN(THETA)**2 + F(1,2)*SIN(2.0D0*THETA)
                E(2,2) = F(2,2) * COS(THETA)**2 + F(1,1)*SIN(THETA)**2 - F(1,2)*SIN(2.0D0*THETA)

                E(2,1) = 0.0D0
                E(1,2) = 0.0D0

                IF (E(2,2).GT.E(1,1)) GO TO 30
                TEMP=E(2,2)
                E(2,2) = E(1,1)
                E(1,1) = TEMP
                TEMP=C(1,2)
                C(1,2) = C(1,1)
                C(1,1) = TEMP
                TEMP=C(2,2)
                C(2,2) = C(2,1)
                C(2,1) = TEMP

                30 RETURN

        END SUBROUTINE
END MODULE


