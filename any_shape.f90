module any_shape
use rndgen_mod
use, intrinsic :: iso_fortran_env, only: sp => real32, dp => real64, i4 => int32, i8 => int64
implicit none
! Variáveis do módulo
real(kind=dp) :: x_r , y_r
integer(kind=i4) :: num_trials=1000000 , num_hits=0 , i
! Gerador de numéros
integer(i4) :: seed = 294727492 
type(rndgen) :: generator
! Privando as variáveis
private x_r , y_r , num_hits , num_trials , seed , generator

contains

subroutine read_array_from_file( PATH , x , y , size )
    character(len=10) PATH
    integer(kind=i4) :: io_status , j
    integer(kind=i4) , intent(out) :: size
    real(kind=dp) , allocatable , intent(out) :: x(:) , y(:)
    size=0
    open(1,file=PATH )
    do
        read(1,*,iostat=io_status)
        if ( io_status==0 ) size=size+1
        if ( io_status/=0 ) exit
    enddo ; rewind(1)
    allocate( x(1:size) , y(1:size) )
    do j = 1 , size
        read(1,*) x(j) , y(j)
    enddo
end subroutine 

subroutine any( L_x , L_y , PATH , area )
    real(kind=dp) , intent(in) :: L_x , L_y
    real(kind=dp) , intent(out) :: area
    character(len=10) PATH
    integer(kind=i4) :: i , j , size , num_intersec
    real(kind=dp) , allocatable :: x(:) , y(:)
    real(kind=dp) :: P_0_x , P_0_y , a_r , a_j , x_comum
    call generator%init(seed)
    P_0_x = -0.5*L_x ; P_0_y = -0.5*L_y
    call read_array_from_file( PATH , x , y , size )
    do i = 1 , num_trials
        x_r = generator%real( -0.5*L_x , 0.5*L_x ) ! Gera duplas de números ao longo de todo o sistema
        y_r = generator%real( -0.5*L_y , 0.5*L_y )
        num_intersec = 0 ! Reseta a contagem de interseções com a fronteira
        a_r = (y_r-P_0_y)/(x_r-P_0_x) ! Inclinação da reta que liga P_0 a P_r
        do j = 1 , size-1
            ! Só é necessário vasculhar entre os pontos que são menores que x_r
            if ( x(j) <= x_r ) then
                a_j = (y(j+1)-y(j))/(x(j+1)-(j)) ! Inclinação da reta que liga (x_j,y_j) a (x_j+1,y_j+1)
                ! X comum entre as retas que ligam (x_j,y_j) a (x_j+1,y_j+1) e P_0 a P_r
                if ( a_r/=a_j ) then ! Evitar divisão por zero
                x_comum = (y(j)-P_0_y+a_r*P_0_x-a_j*x(j))/(a_r-a_j)
                ! As retas têm uma interseção que deve ser contabilizada se x_comum está entre P_0_x e x_r
                if ( P_0_x <= x_comum .and. x_comum <= x_r ) num_intersec = num_intersec + 1
                endif
            endif
        enddo
        ! A paridade do número de interseções da reta P_0 a (x_r,y_r) determina se o ponto P_r é interno ou externo ao conjunto
        ! para um número par, quer dizer que a reta corta a fronteira 'entrando' e 'saindo', de modo que é um ponto externo
        ! para um número ímpar, quer dizer que a reta corta a fronteira apenas 'saindo', de modo que é um ponto interno
        if ( mod(num_intersec,2)/=0 ) num_hits=num_hits+1
    enddo
    area = real(num_hits,kind=dp)/real(num_trials,kind=dp) * L_x * L_y 
end subroutine
end module