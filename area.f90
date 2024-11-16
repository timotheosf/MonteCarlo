program calculo_de_area_monte_carlo
use conicas 
use func
use any_shape
use, intrinsic :: iso_fortran_env, only: sp => real32, dp => real64, i4 => int32, i8 => int64
implicit none
real(kind=dp) a , b , c , L_x , L_y , area
character(len=5) figure
character(len=100) arg
character(len=1) first_char
character(len=10) PATH

call get_command_argument( 1 , arg ) ; read(arg,*) L_x ! Lê o tamanho do sistema em x
call get_command_argument( 2 , arg ) ; read(arg,*) L_y ! Lê o tamanho do sistema em y


call get_command_argument( 3 , figure ) ! Lê a figura do sistema
call get_command_argument( 3 , first_char ) ! Identifica o primeiro caracter do nome da figura

if ( figure=='elips') then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    call get_command_argument( 5 , arg ) ; read(arg,*) b ! Lê o segundo argumento
    call write_params( L_x , L_y , figure , a , b , 0.d0 )
    call elipse( a , b , L_x , L_y , area )
    print*, area

else if ( figure=='circu' .or. figure=='circl' ) then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    b=0.d0
    call write_params( L_x , L_y , figure , a , b , 0.d0 )
    call elipse( a , a , L_x , L_y , area )
    print*, area

else if ( figure=='hiper' ) then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    call get_command_argument( 5 , arg ) ; read(arg,*) b ! Lê o segundo argumento
    call write_params( L_x , L_y , figure , a , b , 0.d0 )
    call hiperbole( a , b , L_x , L_y , area )
    print*, area
    
else if ( figure=='parab' ) then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    b=0.d0
    call write_params( L_x , L_y , figure , a , b , 0.d0 )
    call parabola( a , L_x , L_y , area )
    print*, area

else if ( first_char=='f' ) then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    call get_command_argument( 5 , arg ) ; read(arg,*) b ! Lê o segundo argumento
    call get_command_argument( 6 , arg ) ; read(arg,*) c ! Lê o terceiro argumento
    call write_params( L_x , L_y , figure , a , b , c )
    call area_under_f( a , b , c , figure , L_x , L_y , area )
    print*, area

else if ( figure=='data_' ) then
    call get_command_argument( 4 , PATH )
    call write_params( L_x , L_y , PATH , 0d0 , 0d0 , 0d0 )
    call any( L_x , L_y , PATH , area )
    print*, area
endif

contains
subroutine write_params( L_x , L_y , fig , a , b , c )
    implicit none
    real(kind=dp) L_x , L_y , a , b , c
    character(len=5) fig
    open(1,file='params.txt')
    write(1,*) L_x 
    write(1,*) L_y
    write(1,*) fig
    write(1,*) a 
    write(1,*) b
    write(1,*) c
    close(1)
end subroutine write_params

endprogram