import random

# Lista de nomes para geração
nomes = ["João Silva", "Maria Oliveira", "Pedro Santos", "Ana Costa", "Lucas Pereira", "Carla Ferreira"]
bairros = ["Centro", "Jardins", "Vila Nova", "Santa Luzia", "Boa Vista", "Palmeiras"]
estados = ["RJ", "SP", "MG", "RS", "SC"]
capitais = {
    "RJ": "Rio de Janeiro",
    "SP": "São Paulo",
    "MG": "Belo Horizonte",
    "RS": "Porto Alegre",
    "SC": "Florianópolis"
}

# Gerar lista de registros
registros = []
for i in range(1, 201):  # Ids de 001 a 200
    id = str(i).zfill(3)
    nome = random.choice(nomes)
    bairro = random.choice(bairros)
    estado = random.choice(estados)
    cidade = capitais[estado]
    registro = (id, nome, f"Endereço {i}", bairro, cidade, estado)
    registros.append(registro)

# Exibir os primeiros registros como exemplo
for r in registros[:10]:
    print(r)