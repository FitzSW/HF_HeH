program main
!

! this is a short test to find the inverse of a matrix with LAPACK


implicit none (type, external)

external :: dgetrf
external :: dgetri

real :: a(2,2), a_copy(2,2)
real :: ainv(2,2)
integer :: n, info
real :: work(4) ! this and below needed for LAPACK
real :: ipiv(2)
integer i ! counter
real :: output(2,2)
real :: row(2,2)

a = reshape([1.,2.,3.,4.],[2,2])

write(*,*) "Initial matrix"
do i = 1, size(a,1)
    row = transpose(a)
    write(*,*) row(i,:)
enddo

write(*,*) "Element 1,2"
write(*,*) a(1,2)


Ainv = a 
a_copy =  a 


n = size (a,1)

call dgetrf(n, n, Ainv, n, ipiv, info)
write(*,*) "LU factorization"
do i =1 ,2 
    write(*,*) Ainv(i,:)
enddo
call dgetri(n, Ainv, n, ipiv, work, n, info)

write(*,*) "Called dgetri"
do i =1 ,2 
    write(*,*) Ainv(i,:)
enddo

write(*,*) "This is the result of the inverse times the old"


output = matmul(Ainv,a_copy)
do i = 1, size(output,1)
    write(*,*) output(i,:)
enddo


end program main
