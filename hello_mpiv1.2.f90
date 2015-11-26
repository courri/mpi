program hello
include 'mpif.h'
integer ierr
integer comm,iam,np
call mpi_init(ierr)
call mpi_comm_dup(mpi_comm_would,comm,ierr)   !must!
call mpi_comm_rank(comm,iam,ierr)
call mpi_comm_size(comm,np,ierr)


if(iam .eq. 0) then
print *,'Process ', iam, 'of', np, 'is running'
print *,"Hello, this is in Process", iam
endif

call mpi_finalize(ierr)
end

