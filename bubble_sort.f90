program bubble_test

  implicit none
  integer, dimension(6) :: vec  ! 限制了数组的维度为6
  integer :: temp, bubble, lsup, j

  read *, vec    !the user needs to put 6 values on the array
  lsup = 6       !lsup is the size of the array to be used

  do while (lsup > 1)
    bubble = 0 !bubble in the greatest element out of order
    do j = 1, (lsup-1)
      if (vec(j) > vec(j+1)) then
        temp = vec(j)
        vec(j) = vec(j+1)
        vec(j+1) = temp
        bubble = j
      endif 
    enddo
    lsup = bubble   
  enddo   
  print *, vec
end program