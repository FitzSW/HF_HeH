#! /bin/bash


# gfortran constants.f90
gfortran diagonalizer.f90
# gfortran integrals.f90
gfortran orbitals.f90
gfortran reader.f90
# gfortran Matrices.f90
# gfortran Gauss_Multiply.f90
gfortran misc_tester.f90  diagonalizer.f90  orbitals.f90 reader.f90 #Matrices.f90 Gauss_Multiply.f90 constants.f90 integrals.f90
