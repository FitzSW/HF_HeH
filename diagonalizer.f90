module diagonalizer
!
implicit none

contains

subroutine x_finder(N,I,O)
    implicit none
    !input
    integer, intent(in)              :: N ! The size of the square matrix
    real, dimension(N,N), intent(in) :: I


    ! intermediate
    ! character*80 :: S_out
    character*80 :: temp_file_1
    character*80 :: temp_file_2
    character*80 :: executable

    !output
    real, allocatable, dimension(:,:) :: O 

    ! Need to write the matrix to file
    ! S_out       = "S_out"
    temp_file_1 = "temp_file_1"
    temp_file_2 = "temp_file_2"
    executable  = "./cc_x_finder"

    call matrix_writer(N,I,temp_file_1)

    ! Should read temp_file_1, diagonalize it, and then write to temp
    ! file 2
    call execute_command_line(trim(executable))
   

    ! read the output into matrix O
    call matrix_reader(N,O,temp_file_2)
    write(*,*) "checkpoint alpha"
    call matrix_printer(N,O)
    write(*,*) "checkpoint beta"

    ! Call an executable that will read the matrix and diagonalize it,
    ! writing the output to "temp_file_2"
    call execute_command_line("rm temp_file_1")
    call execute_command_line("rm temp_file_2")

end subroutine x_finder

subroutine eigen_finder(N,I,O,E)
    ! Find eigenvalues and vectors of input I (size N)
    ! Relevant to solving F'C' = C'e
    ! O holds the output eigvec matrix
    ! E holds a diagonal eigval matrix
    implicit none
    integer, intent(in)              :: N
    real, dimension(N,N), intent(in) :: I
    real, dimension(N,N)             :: O
    real, dimension(N,N)             :: E

    ! Temp file 1 to write down input
    ! Temp file 2 to house O
    ! Temp file 3 to house E
    ! Eigen executable command
    character*80 :: temp_file_1
    character*80 :: temp_file_2
    character*80 :: temp_file_3
    character*80 :: executable

    ! Make strings
    temp_file_1 = "temp_file_1"
    temp_file_2 = "temp_file_2"
    temp_file_3 = "temp_file_3"
    executable  = "./cc_eigen_finder"

    ! Write down the input file to temp_file_1
    call matrix_writer(N,I,temp_file_1)

    ! Invoke the executable to find the two output matrices
    call execute_command_line(trim(executable))

    ! Read the output matrices
    call matrix_reader2(N,O,temp_file_2)
    call matrix_reader2(N,E,temp_file_3)

    ! Clean up the files
    call execute_command_line("rm temp_file_1")
    call execute_command_line("rm temp_file_2")
    call execute_command_line("rm temp_file_3")

end subroutine eigen_finder


subroutine matrix_writer(N,I,temp_file)
    implicit none
    integer, intent(in)              :: N
    real, dimension(N,N),intent(in)  :: I
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
    integer, intent(in)                 :: N
    real, allocatable, dimension(:,:)   :: O 
    ! 'file_name' *must* contain an N,N matrix of reals
    character*80, intent(in)            :: file_name

    allocate(O(N,N))
    open(unit=66,file=file_name,status="unknown")
    read(66,*) O
    O = transpose(O)
end subroutine matrix_reader

subroutine matrix_reader2(N,O,file_name)
    implicit none
    integer, intent(in)      :: N
    real, dimension(N,N)     :: O 
    ! 'file_name' *must* contain an N,N matrix of reals
    character*80, intent(in) :: file_name

    ! allocate(O(N,N))
    open(unit=66,file=file_name,status="unknown")
    read(66,*) O
    O = transpose(O)
end subroutine matrix_reader2

! look up if saying G = 0 is acceptable array notation in Fortran
subroutine G_init(N,G)
    implicit none
    integer, intent(in)               :: N
    real, allocatable, dimension(:,:) :: G
    integer                           :: i, j

    allocate(G(N,N))
    do i = 1, N
        do j = 1, N
            G(i,j) = 0.0
        enddo
    enddo
end subroutine G_init

subroutine hermitian_conjg(N,I,O)
    ! Finds the Hermitian Conjugate of a square Matrix I
    ! of size N, placing it in O
    implicit none
    integer, intent(in)                 :: N
    complex, dimension(N,N), intent(in) :: I
    complex, dimension(N,N)             :: O
    integer                             :: j, k
    do j = 1, N
        do k = 1, N
            O(j,k) = conjg(I(k,j))
        enddo
    enddo
end subroutine hermitian_conjg


end module diagonalizer
