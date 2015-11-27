program hello
include 'mpif.h'
integer ierr
call mpi_init(ierr)
print *,"Hello!"
call mpi_finalize(ierr)
end