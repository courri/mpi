program main
  implicit none

  interface 
     function fib(n)
       integer, intent(in) :: n 
       integer :: fib
     end function fib
  end interface


integer x
do x = 1,20,1
  print *, fib(x)
end do

end program main

recursive function fib (n)  result (fnum) 
  integer, intent(in)  :: n
  integer :: fnum
  if (n<2) then 
     fnum = n
  else
     fnum = fib(n-1) + fib(n-2)
  endif
end function fib