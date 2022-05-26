#! /bin/bash


gfortran constants.f90
gfortran diagonalizer.f90
# gfortran integrals.f90
gfortran orbitals.f90
gfortran reader.f90
# gfortran Matrices.f90
# gfortran Gauss_Multiply.f90
gfortran misc_tester.f90  diagonalizer.f90  orbitals.f90 reader.f90 constants.f90 #Matrices.f90 Gauss_Multiply.f90 constants.f90 integrals.f90
echo "

Fortran base files built!...

Compiling matrix executables...
"

c++   -O3 -Wall -Wextra Matrix_IO/cc_x_finder.cc -o ./cc_x_finder
c++   -O3 -Wall -Wextra Matrix_IO/cc_eigen_finder.cc -o ./cc_eigen_finder

echo "

Project successfully built! ...

"

echo "Running HF SCF Procedure..."

./a.out

echo "Done! Output written to 'hf_out.out'"
rm a.out
rm cc_eigen_finder
rm cc_x_finder
