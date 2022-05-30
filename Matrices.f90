MODULE Matrices



        USE Primitive

        USE constants

        USE orbitals

        USE reader

        USE integrals


        IMPLICIT NONE



CONTAINS



        SUBROUTINE Compute_Overlap(OM)


                REAL, dimension(6,6), intent(out) :: OM

                INTEGER :: mu,nu,i,j,i_f,j_f


                DO mu = 1, 6
                        
                        !Specify length of contraction for mu
                        IF ((mu.eq.1).or.(mu.eq.4)) THEN
                                i_f = 3

                        ELSE
                                i_f = 1

                        END IF

                        DO nu = 1,6
                                
                                !Specificy length of contraction for nu
                                IF ((nu.eq.1).or.(nu.eq.4)) THEN
                                        j_f = 3
                                ELSE
                                        j_f = 1
                                        
                                END IF
                                !Iterate over the length of both contractions in order to compute matrix element
                                DO i = 1, i_f

                                        DO j = 1, j_f
                                                

                                                OM(mu,nu) = OM(mu,nu) + Overlap_Prim(mu,nu,i,j)

                                        END DO

                                END DO
                        END DO
                END DO



        END SUBROUTINE




        SUBROUTINE Compute_Kinetic(KM)

        
                REAL, dimension(6,6), intent(out) :: KM

                INTEGER :: mu, nu, i, j, i_f, j_f

               
                DO mu = 1, 6
                        
                        !Specify length of contraction for mu
                        IF ((mu.eq.1).or.(mu.eq.4)) THEN
                                i_f = 3

                        ELSE
                                i_f = 1

                        END IF

                        DO nu = 1,6
                                
                                !Specificy length of contraction for nu
                                IF ((nu.eq.1).or.(nu.eq.4)) THEN
                                        j_f = 3
                                ELSE
                                        j_f = 1
                                        
                                END IF
                                !Iterate over the length of both contractions in order to compute matrix element
                                DO i = 1, i_f

                                        DO j = 1, j_f

                                                KM(mu,nu) = KM(mu,nu) + Kinetic_Prim(mu,nu,i,j)

                                        END DO

                                END DO
                        END DO
                END DO



        END SUBROUTINE




        SUBROUTINE  Compute_Potential(PM)

                
                REAL, dimension(6,6), intent(out) :: PM
                INTEGER :: mu,nu,i,j,i_f,j_f, ai
                CHARACTER(len=2) :: atom
                CHARACTER(len=2), dimension(2) :: atom_list


                atom_list = (/'H+', 'He'/)


                DO ai = 1,2
                        
                        atom = atom_list(ai) 
                        
                        
                        DO mu = 1, 6
                                
                                !Specify length of contraction for mu
                                IF ((mu.eq.1).or.(mu.eq.4)) THEN
                                        i_f = 3

                                ELSE
                                        i_f = 1

                                END IF

                                DO nu = 1,6
                                        
                                        !Specificy length of contraction for nu
                                        IF ((nu.eq.1).or.(nu.eq.4)) THEN
                                                j_f = 3
                                        ELSE
                                                j_f = 1
                                                
                                        END IF
                                        !Iterate over the length of both contractions in order to compute matrix element
                                        DO i = 1, i_f

                                                DO j = 1, j_f

                                                        PM(mu,nu) = PM(mu,nu) + Potential_Prim(mu,nu,i,j, atom)

                                                END DO

                                        END DO
                                END DO
                        END DO
                END DO


        END SUBROUTINE



        SUBROUTINE Compute_Tensor(Ten1)

                IMPLICIT NONE

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



        SUBROUTINE Compute_G(P, GM)
                
                IMPLICIT NONE

                REAL, dimension(6,6), intent(in) :: P

                REAL, dimension(6,6), intent(out) :: GM

                REAL, dimension(6,6,6,6) :: Ten1

                INTEGER :: mu, nu, lambda, sigma


                DO mu = 1,6
                        DO nu = 1,6
                                DO lambda = 1,6
                                        DO sigma = 1,6

                                                CALL Compute_Tensor(Ten1)

                                                GM(mu,nu) = GM(mu,nu) + P(lambda,sigma) * &
                                                (Ten1(mu,nu,sigma,lambda) &
                                                - 0.5*Ten1(mu,lambda,sigma,nu))




                                        END DO
                                END DO
                        END DO
                END DO



        END SUBROUTINE
                                        


                        


END MODULE

                



