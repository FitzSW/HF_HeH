MODULE Matrices



        USE Primitive

        USE constants

        USE orbitals

        USE reader

        USE integrals


        IMPLICIT NONE



CONTAINS



        SUBROUTINE Compute_Overlap(OM)


                REAL, dimension(2,2), intent(out) :: OM

                INTEGER :: mu,nu,i,j,i_f,j_f


                DO mu = 1, 2
                        

                        DO nu = 1,2
                                
                                !Iterate over the length of both contractions in order to compute matrix element
                                DO i = 1, 3

                                        DO j = 1, 3
                                                

                                                OM(mu,nu) = OM(mu,nu) + Overlap_Prim(mu,nu,i,j)

                                        END DO

                                END DO
                        END DO
                END DO



        END SUBROUTINE




        SUBROUTINE Compute_Kinetic(KM)

        
                REAL, dimension(2,2), intent(out) :: KM

                INTEGER :: mu, nu, i, j, i_f, j_f

               
                DO mu = 1, 2
                        

                        DO nu = 1,2
                                
                                !Iterate over the length of both contractions in order to compute matrix element
                                DO i = 1, 3

                                        DO j = 1, 3

                                                KM(mu,nu) = KM(mu,nu) + Kinetic_Prim(mu,nu,i,j)

                                        END DO

                                END DO
                        END DO
                END DO



        END SUBROUTINE




        SUBROUTINE  Compute_Potential(PM, Z_c, R_c)

                
                REAL, dimension(2,2), intent(out) :: PM
                INTEGER :: mu,nu,i,j
                REAL :: Z_c
                REAL, dimension(3) :: R_c
                        
                        
                DO mu = 1, 2
                                

                        DO nu = 1,2
                                        
                                !Iterate over the length of both contractions in order to compute matrix element
                                DO i = 1, 3

                                        DO j = 1, 3

                                                PM(mu,nu) = PM(mu,nu) + Potential_Prim(mu,nu,i,j, Z_c, R_c)

                                   

                         

                                        END DO
                                END DO
                        END DO
                END DO


        END SUBROUTINE
        

        SUBROUTINE Two_Tensor(Tens)

                REAL, dimension(2,2,2,2), intent(out) :: Tens

                REAL :: V1111,V2111,V2121,V2211,V2221,V2222


                V1111 = 1.307152
                V2111 = 0.437279
                V2211 = 0.605703
                V2121 = 0.177267
                V2221 = 0.311795
                V2222 = 0.774608


                Tens(1,1,1,1) = V1111

                Tens(2,1,1,1) = V2111

                Tens(1,2,1,1) = V2111

                Tens(1,1,2,1) = V2111

                Tens(1,1,1,2) = V2111

                Tens(2,1,2,1) = V2121

                Tens(1,2,2,1) = V2121

                Tens(2,1,1,2) = V2121

                Tens(1,2,1,2) = V2121

                Tens(2,2,1,1) = V2211

                Tens(1,1,2,2) = V2211

                Tens(2,2,2,1) = V2221

                Tens(2,2,1,2) = V2221

                Tens(2,1,2,2) = V2221

                Tens(1,2,2,2) = V2221

                Tens(2,2,2,2) = V2222




        END SUBROUTINE Two_Tensor


        SUBROUTINE FORMG(Tens, GM, P)

                REAL, dimension(2,2,2,2), intent(in) :: Tens

                REAL, dimension(2,2), intent(in) :: P

                REAL, dimension(2,2), intent(inout) :: GM

                INTEGER :: i,j,k,l

                DO I=1,2
                DO J=1,2
                GM(I,J) = 0
                END DO 
                END DO


                DO I=1,2
                DO J=1,2
                DO K=1,2
                DO L=1,2
                GM(I,J) = GM(I,J) + P(K,L)*(Tens(I,J,K,L) - 0.5*Tens(I,L,K,J))

                END DO
                END DO
                END DO
                END DO

        END SUBROUTINE



END MODULE
