module conicas
use rndgen_mod
use, intrinsic :: iso_fortran_env, only: sp => real32, dp => real64, i4 => int32, i8 => int64
implicit none
integer(i4) :: seed = 294727492 
type(rndgen) :: generator

contains

subroutine elipse( a , b , L_x , L_y , area )
    real(kind=dp), intent(in) :: a , b , L_x , L_y
    real(kind=dp), intent(out) :: area
    
end subroutine elipse

subroutine hiperbole( a , b , L_x , L_y , area  ) 
    real(kind=dp), intent(in) :: a , b , L_x , L_y
    real(kind=dp), intent(out) :: area

end subroutine hiperbole

subroutine parabola( a , L_x , L_y , area )
    real(kind=dp), intent(in) :: a , L_x , L_y
    real(kind=dp), intent(out) :: area

end subroutine parabola

end module conicas