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

int main(int argc, char** argv) {

	// get the name of the file from the command line
	std::string file = argv[1];

	// open file stream to file
	std::ifstream inp {file};

	// dimensions of matrix to be read
	int n, m;
	
	// find the sice of the matrix
	std::string comm = "wc -l " + file + " > lines";
	system(comm.c_str());

	std::ifstream lines {"lines"};
	lines >> n;
	m = n;

	lines.close();
	// remove the temporary file
	std::string comm2 = "rm lines";
	system(comm2.c_str());


	// initialize matrix
	double A[n][m];

	for (int i = 0; i < n; ++i) {
		for (int j = 0; j < m; ++j) {
			inp >> A[i][j];
		}

	}
	inp.close();

	// test print of the matrix
	cout << "This is A (as array):\n";
	for (int i = 0; i < n; ++i) {
		for (int j = 0; j < m; ++j) {
			cout << A[i][j] << " ";
		}
		cout << endl;

	}

	// test loading into Eigen
	MatrixXd B(n,n);

	for (int i = 0; i < n; ++i) {
		for (int j = 0; j < n; ++j) {
			B(i,j) = A[i][j];
		}
	}

	cout << "This is B (eigen):\n";
	cout << B << endl;

	return 0;
}
