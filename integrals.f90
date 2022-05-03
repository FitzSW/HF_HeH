PROGRAM integrals


! --------------------------------------------------------------------------------------
! Computes initial values of molecular integrals necessary for HF procedure
! S is the overlap matrix
! H = T + V, where T is the kinetic energy matrix and V is the nuclear attraction matrix
! TWO-ELECTRON is the two electron integral matrix
! --------------------------------------------------------------------------------------

!call LAPACK functions
EXTERNAL

IMPLICIT NONE

REAL(N,N) :: S, H, TWO_ELECTRON
!N here will be the size of the matrices based on basis set
!maybe 16x16





END PROGRAM integrals
