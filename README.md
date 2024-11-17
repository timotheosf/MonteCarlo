# Método de Monte Carlo

## Descrição

O programa `area` implementa o método de Monte Carlo para cálculo de área para a família das cônicas, de algumas funções e para qualquer fronteira definida a partir de um arquivo com dados `(X,Y)` gerados a partir da parametrização da fronteira (em senido horário ou anti-horário).

O módulo `rndgen` é o gerador de números KISS (keep it simple stupid) disponível no repositório `[rndgen-fortran](https://github.com/wcota/rndgen-fortran/)`.


## Uso

O programa deve ser compilado com todos os seus módulos. Para usá-lo, a sintaxe básica está abaixo
```zsh
./executável [tamanho do sistema em x] [tamanho do sistema em y] [curva] [parâmetro a] [parâmetro b] [parâmetro c]
```
ou, para o caso da fronteira definida por um arquivo:
```zsh
./executável [tamanho do sistema em x] [tamanho do sistema em y] data_ CAMINHO_PARA_ARQUIVO
```


O programa `gen_shape` apenas gera o formato de uma cruz e coloca numa lista de dados `data` como um exemplo para o módulo `any_shape`.
