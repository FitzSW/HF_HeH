#include<math.h>
#include<iostream>
#include<fstream>
#include<typeinfo>
#include<vector>
#include<string>
#include<Eigen/Dense>
#include<Eigen/Eigenvalues>

using std::cout;
using std::complex;
using std::endl;
using std::string;
using std::system;
using std::ctype;
using std::vector;
using std::pair;
using Eigen::Matrix2f;
using Eigen::MatrixXd;


using namespace Eigen;

int main() { 

	// file string names
	std::string in_file = "temp_file_1";
	std::string out_file = "temp_file_2";

	// file streams
	std::ifstream inp {in_file};
	std::ofstream out {out_file};

	// Dimension of (square) matrix being read
	//
	// Maybe just worth it to do it the long way through a 
	// lines file? If the argv method does not work with the fortran 
	// system command string being messed up
	/* char *p; */
	/* int n = (int)std::strtol(argv[2], &p, 10); */

	int n;
	std::string comm = "wc -l " + in_file + " > lines";
	system(comm.c_str());

	std::ifstream lines {"lines"};
	lines >> n;

	lines.close();
	system("rm lines");


	/* cout << "This is n " << n << endl; */
	
	double A[n][n];
	MatrixXd B(n,n);

	for (int i = 0; i < n; ++i) {
		for (int j = 0; j < n; ++j) {
			inp >> A[i][j];
			B(i,j) = A[i][j];
		}
	}
	inp.close();

	SelfAdjointEigenSolver<MatrixXd> es(B);

	MatrixXd C(n,n);

	C = es.operatorInverseSqrt();

	out << C << endl;
	out.close();

	return 0;
}
