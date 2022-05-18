program reader
!

implicit none
real, allocatable, dimension(:,:) :: A
integer :: n
character*40 csv_file
character*80 command

call get_command_argument(1,csv_file)

command = "wc -l " // csv_file // " > lines"

! change the below "arr" to match the name of the file
! call execute_command_line("wc -l arr > lines")
call execute_command_line(command)
open(11, file="lines",status="unknown")
read(11,*) n
allocate(A(n,n))

open(10, file=csv_file,status="unknown")

read (10,*) A
A = transpose(A) ! must take the transpose to ensure that row-major ordering is done


close(10)
call print_matrix(A,n)

write (*,*) "The element A(1,2) is: "
write(*,*) A(1,2)

call execute_command_line("rm lines")

end program reader

subroutine print_matrix(A,n)
    implicit none
    integer, intent(in) :: n
    real, dimension(n,n), intent(in) :: A
    integer :: i

    do i = 1, n
        write(*,*) A(i,:)
    enddo

end subroutine print_matrix
