program cpi
include 'mpif.h'

integer,parameter :: N = 1.0e8
real,parameter :: PI25DT = 3.141592653589793238462643
real*8 pi,h,psum,local
integer i

h = 1.0/N
psum = 0.0

call mpi_init(ierr)
call mpi_comm_dup(mpi_comm_world,comm,ierr)   !must!
call mpi_comm_rank(comm,myid,ierr)
call mpi_comm_size(comm,np,ierr)

allocate(mypi0(np))
do i=myid,N,np
	local = (i+0.5)*h
	psum = psum + 4.0/(1.0+local*local)
enddo

mypi = psum * h
print *,'my pi is', mypi, 'in Process', myid
call mpi_send(mypi,1,MPI_DOUBLE_PRECISION,0,1,comm,ierr)

if(myid .eq. 0) then
mypi0(1)=mypi

do i=1,np
	call mpi_recv(mypi0(i),1,MPI_DOUBLE_PRECISION,i-1,1,comm,status,ierr)
	print *,'mypi0(', i-1 ,') is', mypi0(i)
enddo
endif
call mpi_finalize(ierr)

pi = sum(mypi0)
deallocate(mypi0)

if(myid .eq. 0) then
	print *, 'pi is',pi
	print *, 'error is', abs(PI25DT-pi)
endif

end



