program readCMAQ

use netcdf

implicit none
integer :: iargc, ncid, varid, timevid
integer :: retval
character(len=*),parameter :: &
FILE_NAME = 'wrfout'
integer :: ndims, nvars,ngatts,unlimdimis,dimids(2)
integer :: didim, nldim(10)
character(len=20) :: dimname(10)
integer :: nwe,nsn,nbt,ntime

! 这里我们来获取变量的维数信息，我们需要得到 nwe，nsn，ntime
!下面的代码来自 page 9






real,allocatable :: psfc3d(:,:,:)
real,allocatable :: T23d(:,:,:),Q23d(:,:,:)
real,allocatable :: R23d(:,:,:)
real,parameter :: T0 = 273.15, EPS = 0.622
integer :: i,j,k,it
real :: tmp1,tmp2


!下面需要从netcdf文件获取数值,下面的代码来自page 8


!get PSFC


!get T2


!get Q2


!ok,RH at 2m
allocatable(R23d(nwe,nsn,ntime))



!close the netcdf file

retval = nf90_close(ncid)
if(retval /= nf90_noerr) call handle_err(retval)

deallocate(psfc3d);
deallocate(T23d);
deallocate(Q23d);
deallocate(R23d);
end




module module_calc_rh2

subroutine calc-rh2(SCR, cname, cdesc, cunits)
  USE constants_module
  USE module_model_basics

  !Arguments
  real, allocatable, dimension(:,:,:)  :: SCR
  character(len=128)                   ::cname,cdesc,cunits

  !Local
  real,dimension(west_east_dim,south_north_dim) :: tmp1,tmp2

  ! tmp1 = 10.*0.6112*exp(17.67*(T23d(i,j,it) - T0)/(T23d(i,j,it) - 29.65))
  ! tmp2 = EPS*temp1/(0.01 * PSFC - (1. - EPS)*tmp1)
  ! tmp1 = 100.*AMAX1(AMIN1(Q2/tmp2,1.0),0.0)

do it = 1,ntime
    do i=1,nwe
      do j=1,nsn
        tmp1 = 10.*0.6112*exp(17.67*(T23d(i,j,it) - T0)/(T23d(i,j,it) - 29.65))
        tmp2 = EPS*tmp1/(0.01 * psfc3d(i,j,it) - (1. - EPS)*tmp1)
        R23d(i,j,it) = 100.*AMAX1(AMAX1(Q23d(i,j,it)/tmp2, 1.0), 0.0)
      enddo
    enddo
end do



  SCR(:,:,1) = tmp(:,:)
  cname = "rh2"
  cdesc = "Relative Humidity at 2m"
  cunits = "%"


end subroutine calc-rh2

end module module_calc_rh2


end program
