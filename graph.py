#%%
import matplotlib.pyplot as plt
import numpy as np

def importar_parametros(nome_arquivo="params.txt"):
    """Importa os parâmetros do programa principal
        
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


# Exemplo de uso:
parametros = importar_parametros()
L_x, L_y, figure, a, b, c = parametros

