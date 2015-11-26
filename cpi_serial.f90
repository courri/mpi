program cpi
integer,parameter :: N = 1.0e10
real,parameter :: PI25DT = 3.141592653589793238462643
real*8 pi,h,psum,local
integer integer

h = 1.0/N
psum = 0.0
do i  = 1,N
	local = (i+0.5)*h
	psum = psum + 4.0/(1.0+local*local)
enddo

pi = psum *h
print *,'pi is',pi
print *,'error is', abs(PI25DT - pi)

end