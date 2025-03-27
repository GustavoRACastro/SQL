import random
from datetime import datetime, timedelta

# Função para gerar uma data aleatória
def gerar_data_aleatoria(inicio, fim):
    dias = (fim - inicio).days
    return inicio + timedelta(days=random.randint(0, dias))

# Gerar a lista de registros
registros = []
data_inicio = datetime(2024, 1, 1)  # Data inicial: 01/01/2024
data_hoje = datetime.now()  # Data final: hoje
data_limite_nao_devolvidos = datetime(2025, 3, 24)  # Registros após esta data não terão devolução

# Rastrear os filmes que não foram devolvidos
filmes_nao_devolvidos = set()

for i in range(1, 2001):  # Geração de 1000 registros
    cod_cliente = str(random.randint(1, 200)).zfill(3)  # CodCliente entre 001 e 200
    cod_filme = str(random.choice(range(1, 922, 5))).zfill(3)  # CodFilme entre 001 e 921, incrementos de 5
    
    # Verificar se o filme já está na lista de não devolvidos
    if cod_filme in filmes_nao_devolvidos:
        continue  # Não incluir novamente este filme
    
    data_locacao = gerar_data_aleatoria(data_inicio, data_hoje)  # Data de locação entre 2024 e hoje

    # Determinar data de devolução
    if data_locacao >= data_limite_nao_devolvidos:
        data_devolucao = None  # Ainda não devolvido
        filmes_nao_devolvidos.add(cod_filme)  # Marcar filme como não devolvido
    else:
        # Devolução padrão 15 dias, mas pode variar
        variacao = random.randint(-5, 5)  # Variação de até -5 ou +5 dias
        data_devolucao = data_locacao + timedelta(days=15 + variacao)
        # Simular valores nulos (não devolvido ainda)
        if random.random() < 0.1:  # 10% de chance de devolução ser nula
            data_devolucao = None
            filmes_nao_devolvidos.add(cod_filme)  # Marcar filme como não devolvido

    registros.append((
        cod_cliente,
        cod_filme,
        data_locacao.strftime("%Y-%m-%d"),  # Formato AAAA-MM-DD
        data_devolucao.strftime("%Y-%m-%d") if data_devolucao else None
    ))

# Exibir os primeiros registros como exemplo
for r in registros[:10]:
    print(r)