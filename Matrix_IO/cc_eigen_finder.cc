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

	// file names
	std::string in_file    = "temp_file_1";
	std::string out_file_O = "temp_file_2";
	std::string out_file_E = "temp_file_3";

	// file streams
	std::ifstream inp    {in_file};
	std::ofstream out_O  {out_file_O};
	std::ofstream out_E  {out_file_E};

	// Dimension of square matrix being read
	int n;

	// Read in the number of lines to expect
	std::string comm = "wc -l " + in_file + " > lines";
	system(comm.c_str());

	std::ifstream lines {"lines"};
	lines >> n;

	lines.close();
	system("rm lines");

	double A[n][n];
	MatrixXd B(n,n);
	MatrixXd O(n,n);
	MatrixXd E(n,n);

	for (int i = 0; i < n; ++i) {
		for (int j = 0; j < n; ++j) {
			inp >> A[i][j];
			B(i,j) = A[i][j];
		}
	}
	inp.close();

	Eigen::SelfAdjointEigenSolver<Eigen::MatrixXd> eigensolver(B);

	if (eigensolver.info() != Eigen::Success) {
		cout << "ERROR: Finding eigenvalues did not converge..." << endl;
		abort();
	}

	/* cout << "First eigenval\n"; */
	/* cout << eigensolver.eigenvalues()[0]; */
	/* cout << endl; */

	// Put the eigen values into the E matrix
	for (int i = 0; i < n; ++i) {
		for (int j = 0; j < n; ++j) {
			if (i == j) {
				E(i,j) = eigensolver.eigenvalues()[i];
			} else {
				E(i,j) = 0.0;
			}
		}
	}

	/* // test print the val matrix */
	/* cout << "The val matrix:\n"; */
	/* cout << E << endl; */
	/* cout << "\n"; */

	// Put the eigenvectors into the O Matrix
	O = eigensolver.eigenvectors();

	/* //print a test */
	/* cout << "The vec matrix:\n"; */
	/* cout << O << endl; */

	// Write the resulting data to file
	out_O << O << endl;
	out_E << E << endl;
	out_O.close();
	out_E.close();


	return 0;
}
