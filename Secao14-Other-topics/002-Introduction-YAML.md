#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "Introduction to YAML."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
## Introduction to YAML


- Dicionarios não são ordenadas.

- Listas são ordenadas.



Claro, vou fornecer exemplos de YAML com dicionários e listas, bem como explicações sobre as diferenças entre eles.

## YAML com Dicionários

Um dicionário em YAML é uma coleção de pares chave-valor, onde cada chave é única e está associada a um valor. Aqui está um exemplo:

```yaml
pessoa:
  nome: João
  idade: 30
  endereco:
    rua: Rua dos Bobos
    numero: 0
    cidade: São Paulo
    estado: SP
```

Neste exemplo, temos um dicionário chamado `pessoa` que contém informações sobre uma pessoa, incluindo seu nome, idade e endereço. O endereço, por sua vez, é outro dicionário com informações sobre a rua, número, cidade e estado.

## YAML com Listas

Uma lista em YAML é uma coleção de valores, onde cada valor pode ser de qualquer tipo (string, número, booleano, etc.). Aqui está um exemplo:

```yaml
frutas:
  - maçã
  - banana
  - laranja
```

Neste exemplo, temos uma lista chamada `frutas` que contém três itens: `maçã`, `banana` e `laranja`.

## Diferenças entre Dicionários e Listas em YAML

A principal diferença entre dicionários e listas em YAML é a forma como os dados são organizados.

Os dicionários são usados para armazenar informações estruturadas, onde cada chave é única e está associada a um valor. Isso permite que você organize seus dados de uma maneira hierárquica e fácil de entender.

As listas, por outro lado, são usadas para armazenar coleções de valores, onde a ordem dos itens é importante. Elas são úteis quando você precisa de uma estrutura mais simples e linear para seus dados.

Aqui está outro exemplo que mostra a diferença entre dicionários e listas:

```yaml
# Dicionário
pessoa:
  nome: João
  idade: 30
  hobbies:
    - leitura
    - cinema
    - viagem

# Lista
pessoas:
  - nome: João
    idade: 30
    hobbies:
      - leitura
      - cinema
      - viagem
  - nome: Maria
    idade: 25
    hobbies:
      - pintura
      - jardinagem
```

No primeiro exemplo, temos um dicionário chamado `pessoa` que contém informações sobre uma pessoa, incluindo seu nome, idade e uma lista de hobbies.

No segundo exemplo, temos uma lista chamada `pessoas` que contém informações sobre duas pessoas diferentes, cada uma com seu próprio nome, idade e lista de hobbies.

A escolha entre usar um dicionário ou uma lista depende da estrutura dos seus dados e da forma como você deseja organizá-los.





- Dicionarios não são ordenadas.

- Listas são ordenadas.