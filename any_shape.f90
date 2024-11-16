module any_shape
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
    open(3,file='num_trials')
    open(2,file='num_hits')
    call generator%init(seed)
    call read_array_from_file( PATH , x , y , size )
    do i = 1 , num_trials
        x_r = generator%real( -0.5*L_x , 0.5*L_x ) ! Gera duplas de números ao longo de todo o sistema
        y_r = generator%real( -0.5*L_y , 0.5*L_y )
        num_intersec = 0 ! Reseta a contagem de interseções com a fronteira
        do j = 1 , size-1
            ! Para haver interceção entre quaisquer poligonais que ligam o ponto P_r a um ponto fixo P_0 externo à fronteira
            ! com a fronteira, devemos ter que a distância em x de P_r a P_0 deve ser maior do que a de P_0_x à fronteira (dist. perpendicular)
            if ( x(j) <= x_r .and. y(j)/=y(j+1) ) then
                ! Para que isso valha, de fato, devemos garantir também que P_r tem o mesmo y que o ponto P_j da fronteira
                ! considerando, é claro, a precisão característica dos dados da tabela
                if ( (y(j) <= y_r .and. y_r <= y(j+1)) .or. (y(j+1) <= y_r .and. y_r <= y(j)) ) num_intersec = num_intersec + 1
            endif
        enddo
        ! A paridade do número de interseções das poligonais determina se o ponto P_r é interno ou externo ao conjunto
        ! para um número par, quer dizer que a reta corta a fronteira 'entrando' e 'saindo', de modo que é um ponto externo
        ! para um número ímpar, quer dizer que a reta corta a fronteira apenas 'saindo', de modo que é um ponto interno
        if ( mod(num_intersec,2)/=0 ) num_hits=num_hits+1
        if ( mod(num_intersec,2)/=0 ) write(2,*) x_r , y_r
        if ( mod(num_intersec,2)==0 ) write(3,*) x_r , y_r
    enddo
    area = real(num_hits,kind=dp)/real(num_trials,kind=dp) * L_x * L_y 
end subroutine
end module