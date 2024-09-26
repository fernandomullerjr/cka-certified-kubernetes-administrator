
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "JSONPath - Lists."
git push
git status


eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github


# ###################################################################################################################### 
# ###################################################################################################################### 
## JSONPath - Lists

JSONPath é uma linguagem de expressão para acessar dados em documentos JSON. Aqui estão alguns exemplos de JSONPath para acessar elementos em listas:

**Acessando elementos individuais**

* `$.lista[0]`: Acessa o primeiro elemento da lista chamada "lista".
* `$.lista[1]`: Acessa o segundo elemento da lista chamada "lista".
* `$.lista[-1]`: Acessa o último elemento da lista chamada "lista".

**Acessando elementos com índice variável**

* `$.lista[?(@.id == 1)]`: Acessa todos os elementos da lista chamada "lista" que têm o atributo "id" igual a 1.
* `$.lista[?(@.nome =~ "João")]`: Acessa todos os elementos da lista chamada "lista" que têm o atributo "nome" que contém a string "João".

**Acessando elementos com condições**

* `$.lista[?(@.idade > 18)]`: Acessa todos os elementos da lista chamada "lista" que têm a idade maior que 18.
* `$.lista[?(@.ativo == true)]`: Acessa todos os elementos da lista chamada "lista" que têm o atributo "ativo" igual a true.

**Acessando sub-objetos**

* `$.lista[0].nome`: Acessa o atributo "nome" do primeiro elemento da lista chamada "lista".
* `$.lista[?(@.id == 1)].endereco`: Acessa o atributo "endereco" do elemento da lista chamada "lista" que tem o atributo "id" igual a 1.

**Acessando elementos em sub-listas**

* `$.lista[0].sublista[0]`: Acessa o primeiro elemento da sub-lista do primeiro elemento da lista chamada "lista".
* `$.lista[?(@.id == 1)].sublista[?(@.nome == "João")]`: Acessa o elemento da sub-lista do elemento da lista chamada "lista" que tem o atributo "id" igual a 1 e o atributo "nome" igual a "João".

Esses são apenas alguns exemplos de JSONPath para acessar elementos em listas. Você pode combinar esses exemplos para criar expressões mais complexas e acessar os dados que precisam.



Claro, aqui estão alguns exemplos básicos de consultas JSONPath para listas:

1. Selecionar o primeiro item da lista:
```jsonpath
$.[0]
```
2. Selecionar o último item da lista:
```jsonpath
$.[-1]
```
3. Selecionar os 3 primeiros itens da lista:
```jsonpath
$.[0:3]
```
4. Selecionar todos os itens da lista, exceto o primeiro:
```jsonpath
$.[1:]
```
5. Selecionar itens da lista que satisfaçam uma condição, por exemplo, selecionar todos os itens com a propriedade "nome" igual a "João":
```jsonpath
$..[?(@.nome == "João")]
```
6. Selecionar a chave e o valor do primeiro item da lista:
```jsonpath
$.[0].*
```
7. Selecionar o valor da propriedade "idade" de todos os itens da lista:
```jsonpath
$..idade
```
8. Selecionar a quantidade de itens na lista:
```jsonpath
$.length
```

Espero que esses exemplos te ajudem a entender melhor como utilizar JSONPath para listas.


devopsmind.com.br




Para pular 2 itens de uma lista em JSONPath, você pode utilizar a sintaxe `$[start:end:step]`, onde `start` é o índice inicial, `end` é o índice final (opcional), e `step` é o tamanho do passo.

Por exemplo, para pular 2 itens a cada seleção em uma lista, você pode utilizar a seguinte consulta:
```jsonpath
$.[2::2]
```
Isso selecionará o terceiro item (índice 2), quinto item (índice 4), sétimo item (índice 6), etc. da lista, pulando dois itens a cada seleção.




Sim, é possível que você precise usar `:0` junto com `-1` em alguns casos.

Quando você usa `[-1]` em JSONPath, ele acessa o último elemento da lista. No entanto, se a lista estiver vazia, `[-1]` retornará `null`.

Se você quiser acessar o último elemento de uma lista que pode estar vazia, você pode usar `:0` junto com `-1`. Isso é conhecido como "segurança de nulo" em JSONPath.

Aqui está um exemplo:

```json
{
  "lista": []
}
```

Com o JSONPath `$.lista[-1]`, você acessará `null`, pois a lista está vazia.

Com o JSONPath `$.lista[:0][-1]`, você acessará `null`, pois a lista está vazia e não há elementos para acessar.

No entanto, se você usar `$.lista[:0][-1]` em um documento JSON que tem uma lista com elementos, você acessará o último elemento da lista.

Por exemplo:

```json
{
  "lista": [
    {"nome": "João", "idade": 25},
    {"nome": "Maria", "idade": 30},
    {"nome": "Pedro", "idade": 35}
  ]
}
```

Com o JSONPath `$.lista[:0][-1]`, você acessará o último elemento da lista:

```json
{"nome": "Pedro", "idade": 35}
```

Então, em resumo, se você precisar acessar o último elemento de uma lista que pode estar vazia, é uma boa prática usar `:0` junto com `-1` para garantir que você não obtenha `null` quando a lista está vazia.