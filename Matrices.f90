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
                                                
                                                WRITE(*,*) "Contraction:", mu,nu
                                                
                                                WRITE(*,*) "Primitives:", i,j
                                                
                                                WRITE(*,*) "Primitive Integral Value:", Overlap_Prim(mu,nu,i,j)

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



        SUBROUTINE Compute_G(P, GM)

                IMPLICIT NONE

                REAL, dimension(6,6), intent(in) :: P !Density matrix

                REAL, dimension(6,6), intent(out) :: GM

                INTEGER :: mu,nu,lambda,sigma,i,j,k,l,i_f,j_f,k_f,l_f

                
                DO mu = 1,6
                        
                        !specificy length of contraction for mu
                        IF ((mu.eq.1).or.(mu.eq.4)) THEN
                                i_f = 3
                        ELSE
                                i_f=1
                        END IF

                        DO nu = 1,6
                                
                                !specificy length of contraction
                                IF ((nu.eq.1).or.(nu.eq.4)) THEN
                                        j_f = 3
                                ELSE
                                        j_f = 1
                                END IF

                                DO lambda = 1,6

                                        !specify length of contraction
                                        IF ((lambda.eq.1).or.(lambda.eq.4)) THEN
                                                k_f = 3
                                        ELSE
                                                k_f = 1
                                        END IF

                                        DO sigma = 1,6
                                                
                                                !specificy length of contraction
                                                IF ((sigma.eq.1).or.(sigma.eq.4)) THEN
                                                        l_f = 3
                                                ELSE
                                                        l_f = 1
                                                END IF

                                                
                                                !iterate over primitives

                                                DO i = 1,i_f
                                                        DO j = 1,j_f
                                                                DO k = 1, k_f
                                                                        DO l = 1, l_f
                                                                
                                                                GM(mu,nu) = GM(mu,nu) + &
                                                                P(lambda,sigma)*(Two_Electron_Prim(mu,nu,lambda,sigma,i,j,k,l)&
                                                                - (1/2) * Two_Electron_Prim(mu,lambda,sigma,nu,i,k,l,j))
                                                                                

                                                                        END DO

                                                                END DO
                                                        END DO
                                                END DO
                                        END DO
                                END DO
                        END DO
                END DO
        END SUBROUTINE
                                        


                        


END MODULE

                



