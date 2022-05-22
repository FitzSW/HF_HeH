MODULE Matrices


        IMPLICIT NONE


        USE Primitive, constants, orbitals, reader, integrals



CONTAINS



        SUBROUTINE Compute_Overlap(OM)


                REAL, dimension(6,6), intent(inout) :: OM

                INTEGER :: mu,nu,i,j,i_f,j_f


                DO mu = 1, 6
                        
                        !Specify length of contraction for mu
                        IF ((mu.eq.1).or.(mu.eq.4)) THEN
                                i_f = 3

                        ELSE
                                i_f = 1

                        DO nu = 1,6
                                
                                !Specificy length of contraction for nu
                                IF ((nu.eq.1).or.(nu.eq.4)) THEN
                                        j_f = 3
                                ELSE
                                        j_f = 1
                                        
                                
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

        
                REAL, dimension(6,6), intent(inout) :: KM

                INTEGER :: mu, nu, i, j, i_f, j_f

               
                DO mu = 1, 6
                        
                        !Specify length of contraction for mu
                        IF ((mu.eq.1).or.(mu.eq.4)) THEN
                                i_f = 3

                        ELSE
                                i_f = 1

                        DO nu = 1,6
                                
                                !Specificy length of contraction for nu
                                IF ((nu.eq.1).or.(nu.eq.4)) THEN
                                        j_f = 3
                                ELSE
                                        j_f = 1
                                        
                                
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

                
                REAL, dimension(6,6), intent(inout) :: PM
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

                                DO nu = 1,6
                                        
                                        !Specificy length of contraction for nu
                                        IF ((nu.eq.1).or.(nu.eq.4)) THEN
                                                j_f = 3
                                        ELSE
                                                j_f = 1
                                                
                                        
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


                



