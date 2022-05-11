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

/* File Description: 
 * 
 * A test with eigen
 *
 */

int main(int argc, char** argv) {

	/* Eigen::MatrixXd A = Eigen::MatrixXd::Random(6,6); */
	/* cout << "Here is a random 6x6 matrix, A:" << endl << A << endl << endl; */

	/* Eigen::EigenSolver<MatrixXd> es(A); */
	/* cout << "The eigenvalues of A are:" << endl << es.eigenvalues() << endl; */
	/* cout << "The matrix of eigenvectors, V, is:" << endl << es.eigenvectors() << endl << endl; */

	/* complex<double> lambda = es.eigenvalues()[0]; */
	/* cout << "Consider the first eigenvalue, lambda = " << lambda << endl; */
	/* Eigen::VectorXcd v = es.eigenvectors().col(0); */
	/* cout << "If v is the corresponding eigenvector, then lambda * v = " << endl << lambda * v << endl; */
	/* cout << "... and A * v = " << endl << A.cast<complex<double> >() * v << endl << endl; */

	/* Eigen::MatrixXcd D = es.eigenvalues().asDiagonal(); */
	/* Eigen::MatrixXcd V = es.eigenvectors(); */
	/* cout << "Finally, V * D * V^(-1) = " << endl << V * D * V.inverse() << endl; */

	MatrixXd A(2,2);
	A(0,0) = 1.0;
	A(0,1) = 0.4508;
	A(1,0) = 0.4508;
	A(1,1) = 1.0;

	SelfAdjointEigenSolver<MatrixXd> es(A);

	MatrixXd B(2,2);

	B = es.operatorInverseSqrt();


   	/* B	=  A.inverse(); */
	/* B = B.sqrt(); */

	cout << "This is S\n";
	cout << A << "\n";

	cout << "This is X\n";
	cout << B << "\n";

	/* MatrixXcd C(2,2); */

	/* C = B * A; */
	/* cout << "This is C\n"; */
	/* cout << C << "\n"; */

	std::ofstream ofs {"matout.csv"};

	ofs << B << endl;

}
