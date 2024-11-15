program calculo_de_area_monte_carlo
use, intrinsic :: iso_fortran_env, only: sp => real32, dp => real64, i4 => int32, i8 => int64
implicit none
real(kind=dp) a , b , L_x , L_y
character(len=5) figure
character(len=100) arg

call get_command_argument( 1 , arg ) ; read(arg,*) L_x ! Lê o tamanho do sistema em x
call get_command_argument( 2 , arg ) ; read(arg,*) L_y ! Lê o tamanho do sistema em y


call get_command_argument( 3 , figure )

if ( figure=='elips') then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    call get_command_argument( 5 , arg ) ; read(arg,*) b ! Lê o segundo argumento
    

else if ( figure=='circu' .or. figure=='circl' ) then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    b=0.d0
    
else if ( figure=='hiper' ) then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    call get_command_argument( 5 , arg ) ; read(arg,*) b ! Lê o segundo argumento
    
else if ( figure=='parab' ) then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    b=0.d0
    
endif


endprogram