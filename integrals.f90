MODULE integrals


! --------------------------------------------------------------------------------------
! Computes initial values of molecular integrals necessary for HF procedure
! S is the overlap matrix
! H = T + V, where T is the kinetic energy matrix and V is the nuclear attraction matrix
! TWO-ELECTRON is the two electron integral matrix
! --------------------------------------------------------------------------------------

  !call LAPACK functions
  EXTERNAL

  IMPLICIT NONE

  REAL, DIMENSION(N,N) :: S, H, TWO_ELECTRON
  !N here will be the size of the matrices based on basis set
  !maybe 16x16

  





CONTAINS
        
        !--------------------------------
        SUBROUTINE Gauss_Multiply(G1,G2, PROD)
                !May pass G1,G2 as a a vector of necessary gaussian values
                !Should return an array of necessary gaussian values (should be same length as inputs)
                !will likely be called often
                !Use the Gaussian Product Theorem 
                IMPLICIT NONE
          
                REAL, DIMENSION(N), intent(in) :: G1, G2
                REAL, DIMENSION(N), intent(out) :: PROD

                REAL :: gama, p, 

          
          
        END SUBROUTINE Gauss_Multiply
        !--------------------------------
        SUBROUTINE Overlap(G1,G2,PROD)

            IMPLICIT NONE

            REAL, DIMENSION(N), intent(in) :: G1, G2
            REAL, DIMENSION(N), intent(out) :: PROD

        END SUBROUTINE
        !--------------------------------
        SUBROUTINE Kinetic(G1, G2, PROD)

            IMPLICIT NONE

            REAL, DIMENSION(N), intent(in) :: G1, G2
            REAL, DIMENSION(N), intent(out) :: PROD

        END SUBROUTINE
        !--------------------------------
        SUBROUTINE Potential(G1, G2, PROD)

            IMPLICIT NONE

            REAL, DIMENSION(N), intent(in) :: G1, G2
            REAL, DIMENSION(N), intent(out) :: PROD

        END SUBROUTINE
        !--------------------------------
        SUBROUTINE TWO_ELECTRON
            IMPLICIT NONE

            REAL, DIMENSION(N), intent(in) :: G1, G2
            REAL, DIMENSION(N), intent(out) :: PROD

        END SUBROUTINE



END MODULE integrals
