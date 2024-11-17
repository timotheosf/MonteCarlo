module conicas
use rndgen_mod
use, intrinsic :: iso_fortran_env, only: sp => real32, dp => real64, i4 => int32, i8 => int64
implicit none
! Variáveis do módulo
real(kind=dp) :: x_r , y_r
integer(kind=i4) :: num_trials=100000 , num_hits=0 , i
! Gerador de numéros
integer(i4) :: seed = 294727492 
type(rndgen) :: generator
! Privando as variáveis
private x_r , y_r , num_hits , num_trials , seed , generator

contains

subroutine elipse( a , b , L_x , L_y , area )
    !   Subrotina que pega os dados passados para o programa principal, 
    !   gera as informações geométricas da ELIPSE 
    !   e aplica o método de Monte Carlo para sua medida
    real(kind=dp), intent(in) :: a , b , L_x , L_y
    real(kind=dp), intent(out) :: area
    call generator%init(seed)
    open(3,file='num_trials')
    open(2,file='num_hits')
    do i = 1 , num_trials
        x_r = generator%real( -0.5*L_x , 0.5*L_x ) ! Gera duplas de números ao longo de todo o sistema
        y_r = generator%real( -0.5*L_y , 0.5*L_y )
        if ( -b*sqrt(1. - (x_r/a)**2)<= y_r  .and. y_r <= b*sqrt(1. - (x_r/a)**2) ) then ! Condição para o número ser interno à elipse
            num_hits = num_hits + 1
            write(2,*) x_r , y_r
        else
            write(3,*) x_r , y_r
        endif
    enddo
    area = real(num_hits,kind=dp)/real(num_trials,kind=dp) * L_x * L_y ! Medida da elipse
end subroutine elipse

subroutine hiperbole( a , b , L_x , L_y , area  ) 
    !   Subrotina que pega os dados passados para o programa principal, 
    !   gera as informações geométricas da HIPÉRBOLE 
    !   e aplica o método de Monte Carlo para sua medida
    real(kind=dp), intent(in) :: a , b , L_x , L_y
    real(kind=dp), intent(out) :: area
    call generator%init(seed)
    open(3,file='num_trials')
    open(2,file='num_hits')
    do i = 1 , num_trials
        x_r = generator%real( -0.5*L_x , 0.5*L_x ) ! Gera duplas de números ao longo de todo o sistema
        y_r = generator%real( -0.5*L_y , 0.5*L_y )
        if ( x_r <= a .or. a <= x_r ) then
            if ( -b*sqrt((x_r/a)**2 - 1.) <= y_r .and. y_r <= b*sqrt((x_r/a)**2 - 1.) ) then ! Condição para o número ser interno à hipérbole
                num_hits = num_hits + 1
                write(2,*) x_r , y_r
            else
                write(3,*) x_r , y_r
            endif
        endif
    enddo
    area = real(num_hits,kind=dp)/real(num_trials,kind=dp) * L_x * L_y ! Medida da hipérbole
end subroutine hiperbole

subroutine parabola( a , L_x , L_y , area )
    !   Subrotina que pega os dados passados para o programa principal, 
    !   gera as informações geométricas da PARÁBOLA 
    !   e aplica o método de Monte Carlo para sua medida
    real(kind=dp), intent(in) :: a , L_x , L_y
    real(kind=dp), intent(out) :: area
    call generator%init(seed)
    open(3,file='num_trials')
    open(2,file='num_hits')
    do i = 1 , num_trials
        x_r = generator%real( -0.5*L_x , 0.5*L_x ) ! Gera duplas de números ao longo de todo o sistema
        y_r = generator%real( -0.5*L_y , 0.5*L_y )
        if ( 0. <= x_r ) then
            if ( -2.*sqrt(a*x_r) <= y_r .and. y_r <= 2.*sqrt(a*x_r) ) then ! Condição para o número ser interno à parábola
                num_hits = num_hits + 1
                write(2,*) x_r , y_r
            else
                write(3,*) x_r , y_r
            endif
        else
            write(3,*) x_r , y_r
        endif
    enddo
    area = real(num_hits,kind=dp)/real(num_trials,kind=dp) * L_x * L_y ! Medida da parábola
end subroutine parabola

end module conicas