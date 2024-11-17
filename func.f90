module func
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

function f_( x , a , b , c , fig ) result( result )
    ! Essa função seleciona de qual função será analisada 
    ! a área debaixo de sua curva
    real(kind=dp) , intent(in) :: x , a , b , c
    real(kind=dp) :: result
    character(len=5) , intent(in) :: fig
    if ( fig=='f_sin' ) then
        result = a*sin(b*x+c)
    else if ( fig=='f_cos') then
        result = a*cos(b*x+c)
    else if ( fig=='f_lin') then
        result = a*x+b
    else if ( fig=='f_qua') then
        result = a*x**2+b*x+c
    endif
end function f_

subroutine area_under_f( a , b , c , fig , L_x , L_y , area )
    ! Subrotina para cálculo da área entre o gráfico de uma função e o eixo y
    ! Veja que o resultado NÃO É igual à integral da função,
    ! mas, sim, igual à integral do móduo da função
    real(kind=dp), intent(in) :: a , b , c , L_x , L_y
    real(kind=dp), intent(out) :: area
    character(len=5) , intent(in) :: fig
    open(3,file='num_trials')
    open(2,file='num_hits')
    call generator%init(seed)
    do i = 1 , num_trials
        x_r = generator%real( -0.5*L_x , 0.5*L_x ) ! Gera duplas de números ao longo de todo o sistema
        y_r = generator%real( -0.5*L_y , 0.5*L_y )
        if ( (f_( x_r , a , b , c , fig ) <= y_r .and. y_r <= 0. ) .or. ( 0. <= y_r .and. y_r <= f_( x_r , a , b , c , fig ))) then
            num_hits = num_hits + 1 ! Conta para as regiões em que f_ é negativa ou positiva
            write(2,*) x_r , y_r
        else
            write(3,*) x_r , y_r
        endif
    enddo
    area = real(num_hits,kind=dp)/real(num_trials,kind=dp) * L_x * L_y 
end subroutine area_under_f
end module