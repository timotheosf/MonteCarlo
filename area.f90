program calculo_de_area_monte_carlo
use conicas
use, intrinsic :: iso_fortran_env, only: sp => real32, dp => real64, i4 => int32, i8 => int64
implicit none
real(kind=dp) a , b , L_x , L_y , area
character(len=5) figure
character(len=100) arg

call get_command_argument( 1 , arg ) ; read(arg,*) L_x ! Lê o tamanho do sistema em x
call get_command_argument( 2 , arg ) ; read(arg,*) L_y ! Lê o tamanho do sistema em y


call get_command_argument( 3 , figure )

if ( figure=='elips') then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    call get_command_argument( 5 , arg ) ; read(arg,*) b ! Lê o segundo argumento
    call write_params( L_x , L_y , figure , a , b )
    call elipse( a , b , L_x , L_y , area )
    print*, area
    

else if ( figure=='circu' .or. figure=='circl' ) then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    b=0.d0
    call write_params( L_x , L_y , figure , a , b )
    
else if ( figure=='hiper' ) then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    call get_command_argument( 5 , arg ) ; read(arg,*) b ! Lê o segundo argumento
    call write_params( L_x , L_y , figure , a , b )
    
else if ( figure=='parab' ) then
    call get_command_argument( 4 , arg ) ; read(arg,*) a ! Lê o primeiro argumento
    b=0.d0
    call write_params( L_x , L_y , figure , a , b )
    
endif

contains
subroutine write_params( L_x , L_y , fig , a , b )
    implicit none
    real(kind=dp) L_x , L_y , a , b
    character(len=5) fig
    open(1,file='params.txt')
    write(1,*) L_x 
    write(1,*) L_y
    write(1,*) fig
    write(1,*) a 
    write(1,*) b
    close(1)
end subroutine write_params

endprogram