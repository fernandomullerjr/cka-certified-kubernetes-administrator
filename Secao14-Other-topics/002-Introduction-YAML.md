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




Existem alguns cuidados importantes a serem considerados ao trabalhar com dicionários e listas em YAML:

## Cuidados com Dicionários

1. **Chaves únicas**: Certifique-se de que cada chave no dicionário seja única. Caso contrário, o último valor associado à chave será o valor utilizado.

2. **Aninhamento**: Você pode criar dicionários aninhados, onde um valor de um dicionário é outro dicionário. Isso permite criar estruturas de dados complexas e hierárquicas.

3. **Tipos de dados**: Certifique-se de que os valores associados às chaves sejam do tipo de dado correto (string, número, booleano, etc.).

4. **Indentação**: A indentação é crucial em YAML. Certifique-se de que a indentação esteja correta, pois ela define a estrutura do dicionário.

## Cuidados com Listas

1. **Ordem dos itens**: A ordem dos itens na lista é importante, pois ela define a sequência dos elementos.

2. **Tipos de dados**: Assim como nos dicionários, certifique-se de que os itens da lista sejam do tipo de dado correto.

3. **Aninhamento**: Você pode criar listas aninhadas, onde um item da lista é outra lista. Isso permite criar estruturas de dados complexas.

4. **Indentação**: Assim como nos dicionários, a indentação é crucial para definir a estrutura da lista.

5. **Elementos duplicados**: Listas podem conter elementos duplicados, pois a ordem dos itens é importante.

Aqui estão alguns exemplos adicionais para ilustrar esses cuidados:

```yaml
# Dicionário com chave duplicada
pessoa:
  nome: João
  nome: Maria # A última chave "nome" será usada

# Dicionário aninhado
pessoa:
  nome: João
  endereco:
    rua: Rua dos Bobos
    numero: 0
    cidade: São Paulo
    estado: SP

# Lista com tipos de dados mistos
frutas:
  - maçã
  - 10
  - true

# Lista aninhada
pessoas:
  - nome: João
    hobbies:
      - leitura
      - cinema
  - nome: Maria
    hobbies:
      - pintura
      - jardinagem
```

Ao trabalhar com YAML, é importante estar atento a esses cuidados para garantir que sua estrutura de dados esteja correta e seja interpretada corretamente.



# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO

- Dicionarios não são ordenadas.

- Listas são ordenadas.
Ordem dos itens: A ordem dos itens na lista é importante, pois ela define a sequência dos elementos.