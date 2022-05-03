# Necessary Computations
1. Read In/Hardcode molecular geometries (x,y,z), atomic numbers, number of electrons, and basis set
2. Calculate overlap matrix, energy matrix, two electron integral matrix
3. Diagonalize overlap matrix
4. Obtain X = S^{-1/2}
5. Guess for density matrix, P
6. Calculate G from two electron integral matrix and density matrix guess, P
7. Obtain Fock Matrix, F = h + G
8. Transform Fock Matrix w/ X, F' = X_dag * F * X
9. Diagonalize F'
10. From F' obtain C' (density coefficient matrix) and epsilon (orbital energies)
11. Form a new density matrix from C, using P = 2 * Sum_occupied[C_{\lambda i}* C_{\sigma j}]
12. Determine convergence through element by element comparison of new and old density matrices, declare convergance based on pre-decided tolerance
13. If not converged, return to step 6.
14. If converged, good job, pull what you need from the density, fock, etc. matrices
