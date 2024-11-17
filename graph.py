#%%
import matplotlib.pyplot as plt
import numpy as np

def importar_parametros(nome_arquivo="params.txt"):
    """
        Importa os parâmetros do programa principal
        
        IMPORTANTE:
        Retorna None em caso de erro.
    """
    try:
        with open(nome_arquivo, 'r') as f:
            linhas = f.readlines()
            L_x = float(linhas[0].strip())
            L_y = float(linhas[1].strip())
            figure = linhas[2].strip()
            a = float(linhas[3].strip())
            b = float(linhas[4].strip())
            c = float(linhas[5].strip())
        return L_x, L_y, figure, a, b, c
    except (FileNotFoundError, IndexError, ValueError) as e:
        print(f"Erro ao importar parâmetros: {e}")
        return None

def MonteCarlo_scatter( L_x , L_y ):
    """
        Faz o gráfico scatter dos números aleatórios gerados
    """
    # Importa os dados dos arquivos
    x_trials, y_trials = np.loadtxt("num_trials", unpack=True)
    x_hits, y_hits = np.loadtxt("num_hits", unpack=True)
    
    # Chama a figura
    plt.figure(figsize=(10, 8))
    # Scatter dos dados
    plt.scatter(x_trials, y_trials, color='blue', label="Trials", s=0.5, alpha = 0.4) # s controla tamanho, alpha a transparencia
    plt.scatter(x_hits, y_hits, color='red', label="Hits", s=0.5 , alpha = 0.4)
    # Tamanho do sistema considerado
    plt.xlim(-0.5 * L_x, 0.5 * L_x)
    plt.ylim(-0.5 * L_y, 0.5 * L_y)

def plot_any(PATH):
    """
        Plot a fronteira a patir do arquivo que a define
    """
    x_c, y_c = np.loadtxt(PATH, unpack=True)
    plt.plot(x_c, y_c, label="Curva" , color='black',lw=2)

def plot_conicas( parametros ):
    """
        Plot as curvas cônicas do problema
    """
    L_x, L_y, figure, a, b, c = parametros
    x = np.linspace(-L_x / 2, L_x / 2, 500)
    y = np.linspace(-L_y / 2, L_y / 2, 500)
    X, Y = np.meshgrid(x, y)
    # Seleciona qual cônica é
    if (figure=='elips' or figure=='circu' or figure=='circl'):
        conica = X**2 / a**2 + Y**2 / b**2 - 1
    elif (figure=='hiper'):
        conica = X**2 / a**2 - Y**2 / b**2 - 1
    elif (figure=='parab'):
        conica = 4*a*X - Y**2
    # Plot a curva de nível que gera a cônica
    plt.contour( X, Y, conica, [0] , label='Cônica' )

def plot_funcs( parametros ):
    """
        Plota as funções do problema
    """
    L_x, L_y, figure, a, b, c = parametros
    x = np.linspace(-L_x / 2, L_x / 2, 500)
    y_2 = x*0
    # Seleciona qual é a função
    if ( figure=='f_sin' ):
        y = a*np.sin(b*x+c)
    elif ( figure=='f_cos'):
        y = a*np.cos(b*x+c)
    elif ( figure=='f_lin'):
        y = a*x+b
    elif ( figure=='f_qua'):
        y = a*x**2+b*x+c
    # Plota a função de acordo com a seleção
    plt.plot(x, y, label="Função" , color='black',lw=2)
    plt.plot(x, y_2, label="Função" , color='black',lw=2)

parametros = importar_parametros()
L_x, L_y, figure, a, b, c = parametros
MonteCarlo_scatter( L_x , L_y )
if ( figure=='elips' or figure=='circu' or figure=='circl' or figure=='hiper' or figure=='parab' ):
    plot_conicas( parametros )
elif ( figure=='f_sin' or figure=='f_cos' or figure=='f_lin' or figure=='f_qua'):
    plot_funcs( parametros )
else:
    plot_any( figure )
plt.xlabel("x")
plt.ylabel("y")
plt.title(f"Fronteira e Scatter do Método de Monte Carlo")
plt.grid(True)
plt.legend(loc='upper left')
plt.show()