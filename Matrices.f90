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

<<<<<<< HEAD
                REAL :: V1111,V2111,V2121,V2211,V2221,V2222
=======
        SUBROUTINE Compute_Tensor(Ten1)
>>>>>>> Test


<<<<<<< HEAD
                V1111 = 1.307152
                V2111 = 0.437279
                V2211 = 0.605703
                V2121 = 0.177267
                V2221 = 0.311795
                V2222 = 0.774608


                Tens(1,1,1,1) = V1111

                Tens(2,1,1,1) = V2111

                Tens(1,2,1,1) = V2111
=======
                REAL, dimension(6,6,6,6), intent(out) :: Ten1

                INTEGER :: a,b,c,d,i,j,k,l,i_f,j_f,k_f,l_f



                !populate tensor

                DO a=1,6
                        DO b=1,6
                                DO c = 1,6
                                        DO d = 1,6

                                                Ten1(a,b,c,d) = 0
                                        END DO
                                END DO
                        END DO
                END DO


                !first, compute two two electron tensors

                DO a = 1, 6

                        IF ((a.eq.1).or.(a.eq.4)) THEN
                                i_f = 3
                        ELSE
                                i_f = 1
                        END IF

                        DO b=1,6

                                IF ((b.eq.1).or.(b.eq.4)) THEN
                                        j_f = 3
                                ELSE
                                        j_f = 1
                                END IF

                                DO c = 1,6
                                        
                                        IF ((c.eq.1).or.(c.eq.4)) THEN
                                                k_f = 3
                                        ELSE
                                                k_f = 1
                                        END IF

                                        DO d = 1,6

                                                IF ((d.eq.1).or.(d.eq.4)) THEN
                                                        l_f = 3
                                                ELSE
                                                        l_f = 1
                                                END IF




                                                DO i = 1,i_f

                                                        DO j=1, j_f
                                                                DO k=1,k_f
                                                                        DO l=1,l_f


                                                                                Ten1(a,b,c,d) =  Ten1(a,b,c,d) &
                                                                                + Two_Electron_Prim(a,b,c,d,i,j,k,l)
                                                                                


                                                                        END DO
                                                                END DO
                                                        END DO

                                                END DO

                                        END DO

                                END DO
                        END DO

                END DO

        
        END SUBROUTINE



        SUBROUTINE Compute_G(P, GM, Ten1)
                
                IMPLICIT NONE

                REAL, dimension(6,6), intent(in) :: P

                REAL, dimension(6,6), intent(out) :: GM

                REAL, dimension(6,6,6,6), intent(in) :: Ten1

                INTEGER :: mu, nu, lambda, sigma, I, J, K, L
                
                
                DO I = 1,6
                DO J = 1,6
                GM(I,J) = 0 
                END DO
                END DO


                DO mu = 1,6
                        DO nu = 1,6
                                DO lambda = 1,6
                                        DO sigma = 1,6

                                 

                                                GM(mu,nu) = GM(mu,nu) + P(lambda,sigma) * &
                                                (Ten1(mu,nu,sigma,lambda) &
                                                - 0.5*Ten1(mu,lambda,sigma,nu))




                                        END DO
                                END DO
                        END DO
                END DO



        END SUBROUTINE
                                        
>>>>>>> Test

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
