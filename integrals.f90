PROGRAM integrals


! --------------------------------------------------------------------------------------
! Computes initial values of molecular integrals necessary for HF procedure
! S is the overlap matrix
! H = T + V, where T is the kinetic energy matrix and V is the nuclear attraction matrix
! TWO-ELECTRON is the two electron integral matrix
! --------------------------------------------------------------------------------------

! --------------------------------------------------------------------------------------
! Example of how the orbitals are parameterized: 
!
! s-Functions: g_1s(a,r) = (8a^3/\pi^3)^{1/4} exp{-ar^2}
! p-Functions: g_2px(a,r) = (128a^5/\pi^3)^{1/4} x * exp{-ar^2}
! d-functions: g_3dxy(a,r) = (2048a^7 / \pi^3)^{1/4} x * y * exp{-ar^2}
! --------------------------------------------------------------------------------------

  !call LAPACK functions
  EXTERNAL

  IMPLICIT NONE

  REAL, DIMENSION(N,N) :: S, H, TWO_ELECTRON
  !N here will be the size of the matrices based on basis set
  !maybe 16x16
  
   
   



END PROGRAM integrals

SUBROUTINE Gauss_Multiply(G1,G2, PROD)
  !May pass G1,G2 as a a vector of necessary gaussian values
  !Should return an array of necessary gaussian values (should be same length as inputs)
  IMPLICT NONE
  
  REAL, DIMENSION(N), intent(in) :: G1, G2
  REAL, DIMENSION(N), intent(out) :: PROD
  
END SUBROUTINE Gauss_Multiply


