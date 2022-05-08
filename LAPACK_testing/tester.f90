! code demo from: https://cyber.dabamos.de/programming/modernfortran/lapack.html
program main
!
implicit none (type, external)

external :: sgesv 
real :: a(2,2)
real :: b(2)
real :: pivot(2)
integer :: rc

a = reshape([ 2., 3., 1., 1. ], [ 2, 2 ])
b = [ 5., 6. ]

call sgesv(2, 1, a, 2, pivot, b, 2, rc)

if (rc /= 0) then
    print '(a, i0)', 'Error: ', rc
    stop
end if

print '("Solution (x1, x2): ", f0.4, ", ", f0.4)', b


end program main
