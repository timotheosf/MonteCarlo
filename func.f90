module functions
use, intrinsic :: iso_fortran_env, only: sp => real32, dp => real64, i4 => int32, i8 => int64
implicit none
public :: f_
type :: f_
    real(kind=dp) :: x , a , b , c 
    contains
        procedure :: linear_ 
        procedure :: quad_
        procedure :: sin_
        procedure :: cos_
end type f_

contains

    function linear_(this) result(f__)
        class(f_), intent(in) :: this
        real(kind=dp) f__
        f__ = this%x * this%a + this%b
    end function linear_

    function quad_(this) result(f__)
        class(f_), intent(in) :: this
        real(kind=dp) f__
        f__ = this%a*this%x**2+this%b*this%x+this%c
    end function quad_

    function sin_(this) result(f__)
        class(f_), intent(in) :: this
        real(kind=dp) f__
        f__ = this%a*sin(this%b*this%x+this%c)
    end function sin_

    function cos_(this) result(f__)
        class(f_), intent(in) :: this
        real(kind=dp) f__
        f__ = this%a*cos(this%b*this%x+this%c)
    end function cos_

end module