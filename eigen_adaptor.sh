#! /bin/bash

# This is a script to adapt the Eigen header files include statements for
# local use if you are doing a local installation of the "Eigen" directory
# from the linked gitlab

# THIS SHOULD NOT BE RUN IF YOU ALREADY HAD ACCESS TO EIGEN

sed -i '' -e 's/<Eigen\/Dense>/"Eigen\/Dense"/g' Matrix_IO/cc_x_finder.cc
sed -i '' -e 's/<Eigen\/Dense>/"Eigen\/Dense"/g' Matrix_IO/cc_eigen_finder.cc
sed -i '' -e 's/<Eigen\/Eigenvalues>/"Eigen\/Eigenvalues"/g' Matrix_IO/cc_x_finder.cc
sed -i '' -e 's/<Eigen\/Eigenvalues>/"Eigen\/Eigenvalues"/g' Matrix_IO/cc_eigen_finder.cc
