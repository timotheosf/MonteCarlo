program gerador_de_formato_para_determinar_area
use, intrinsic :: iso_fortran_env, only: sp => real32, dp => real64, i4 => int32, i8 => int64
implicit none
real(kind=dp) :: x , y , t=0.d0 , delta_t = 5.d-2
open(1,file='data')
do
    if ( 0. <= t .and. t <= 0.5 ) then
        x = -t ; y = 1.5
        write(1,*) x , y
    else if ( 0.5 < t .and. t <= 1.5 ) then
        x = -0.5 ; y = 2. - t
    write(1,*) x , y        
    else if ( 1.5 <= t .and. t <= 2.5 ) then
        x = 1. - t ; y = 0.5
        write(1,*) x , y
    else if ( 2.5  <= t .and. t <= 3.5 ) then
        x = -1.5 ; y = 3 - t
        write(1,*) x , y
    else if ( 3.5 <= t .and. t <= 4.5 ) then
        x = -5. + t ; y = -0.5
        write(1,*) x , y
    else if ( 4.5 <= t .and. t <= 6.5 ) then
        x = -0.5 ; y = 4 - t
        write(1,*) x , y
    else if ( 6.5 <= t .and. t <= 7.5 ) then
        x = -0.5+(t-6.5) ; y = -2.5
        write(1,*) x , y
    else if ( 7.5 <= t .and. t <= 9.5 ) then
        x = 0.5 ; y = -2.5+(t-7.5)
        write(1,*) x , y
    else if ( 9.5 <= t .and. t <= 10.5 ) then
        x = 0.5 + (t-9.5) ; y = -0.5
        write(1,*) x , y
    else if ( 10.5 <= t .and. t <= 11.5 ) then
        x = 1.5 ; y = -0.5+(t-10.5)
        write(1,*) x , y
    else if ( 11.5 <= t .and. t <= 12.5 ) then
        x = 1.5-(t-11.5) ; y = 0.5
        write(1,*) x , y
    else if ( 12.5 <= t .and. t <= 13.5 ) then
        x = 0.5 ; y = 0.5+(t-12.5)
        write(1,*) x , y
    else if ( 13.5 <= t .and. t <= 14. ) then
        x = 0.5-(t-13.5) ; y = 1.5
        write(1,*) x , y
    endif

    t = t + delta_t
    if ( t > 14. ) exit

enddo

end program