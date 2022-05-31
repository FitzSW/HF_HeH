#! /bin/bash


gfortran constants.f90
gfortran Gauss_Multiply.f90
gfortran F_0.f90
gfortran integrals.f90
# gfortran Diag.f90
gfortran orbitals.f90
gfortran reader.f90
gfortran Primitives.f90
gfortran Matrices.f90
gfortran diagonalizer.f90

# c++ -std=c++20  -O3 -Wall -Wextra Matrix_IO/cc_x_finder.cc -o ./cc_x_finder
# c++ -std=c++20  -O3 -Wall -Wextra Matrix_IO/cc_eigen_finder.cc -o ./cc_eigen_finder

gfortran main.f90 constants.f90 Gauss_Multiply.f90 F_0.f90 integrals.f90 orbitals.f90 reader.f90 Primitives.f90 Matrices.f90 diagonalizer.f90
#Diag.f90 
# ./a.out
# rm a.out
# rm S_out
# rm -f temp_file_1 temp_file_2 temp_file_3
