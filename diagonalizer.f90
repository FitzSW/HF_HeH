module diagonalizer
!
implicit none

contains

subroutine diagonalize(N,I,O)
    implicit none
    !input 
    integer, intent(in)              :: N ! The size of the square matrix
    real, dimension(N,N), intent(in) :: I

    ! intermediate
    character*80 :: temp_file_1
    character*80 :: temp_file_2
    character*80 :: executable

    !output
    real, allocatable, dimension(:,:) :: O ! need intent(in)?  or should this be made alloc


    ! Need to write the matrix to file
    temp_file_1 = "temp_file_1"
    temp_file_2 = "temp_file_2"
    executable  = "./cc_matrix_handler" 

    call matrix_writer(N,I,temp_file_1)

    ! Should read temp_file_1, diagonalize it, and then write to temp
    ! file 2
    ! say = trim("THIS IS N ")//trim(char(N))
    call execute_command_line(trim(executable))
    

    ! read the output into matrix O
    call matrix_reader(N,O,temp_file_2)
    call matrix_printer(N,O)

    ! Call an executable that will read the matrix and diagonalize it,
    ! writing the output to "temp_file_2"
    call execute_command_line("rm temp_file_1")
    call execute_command_line("rm temp_file_2")

end subroutine diagonalize

subroutine matrix_writer(N,I,temp_file)
    implicit none
    integer, intent(in)              :: N
    real, dimension(N,N),intent (in) :: I
    character*80, intent(in)         :: temp_file
    integer :: j

    open(unit=10,file=temp_file,access='sequential',status='unknown')
    do j = 1, N
       write(10,*) I(j,:)
    enddo 
    close(10)
end subroutine matrix_writer

subroutine matrix_printer(N,I)
    implicit none
    integer, intent(in)              :: N
    real, dimension(N,N), intent(in) :: I
    integer                          :: j

    do j = 1, N
        write(*,*) I(j,:)
    enddo
end subroutine matrix_printer

subroutine matrix_reader(N,O,file_name)
    implicit none
    integer, intent(in)                :: N
    real, allocatable, dimension(:,:)  :: O ! needs intent(in)?
    ! 'file_name' *must* contain an N,N matrix of reals
    character*80, intent(in)           :: file_name

    allocate(O(N,N))
    open(unit=66,file=file_name,status="unknown")
    read(66,*) O
    O = transpose(O)
end subroutine matrix_reader

end module diagonalizer
