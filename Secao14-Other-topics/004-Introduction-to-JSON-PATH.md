#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "JSONPath."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
## JSON (JavaScript Object Notation)

    Sintaxe baseada em pares chave-valor.
    Usa chaves {} e colchetes [] para denotar objetos e arrays, respectivamente.
    Não suporta comentários.
    Mais verboso, o que pode tornar os arquivos maiores e menos legíveis.

~~~~json
{
  "pessoa": {
    "nome": "João",
    "idade": 30,
    "endereço": {
      "rua": "Rua das Flores",
      "cidade": "São Paulo"
    }
  }
}
~~~~




# ###################################################################################################################### 
# ###################################################################################################################### 
## JSONPath

JSONPath é uma linguagem de consulta para JSON, similar ao XPath para XML. Ele permite extrair partes de um documento JSON usando expressões de caminho, tornando fácil acessar e manipular dados estruturados em JSON. Aqui está um guia sobre como JSONPath funciona:

### Sintaxe Básica

#### Operadores
- `$` - Representa o objeto raiz.
- `.` ou `[]` - Acessa um membro de um objeto.
- `..` - Recursivamente descende no objeto JSON.
- `*` - Corresponde a todos os membros de um objeto ou elementos de um array.
- `[,]` - Cria uma expressão união de vários subcaminhos.
- `[start:end:step]` - Slicing de arrays.
- `?()` - Filtragem com base em uma expressão.

#### Exemplos de Uso

Considere o seguinte documento JSON:

```json
{
  "store": {
    "book": [
      { "category": "fiction", "author": "Herman Melville", "title": "Moby Dick", "price": 8.99 },
      { "category": "fiction", "author": "J. R. R. Tolkien", "title": "The Lord of the Rings", "price": 22.99 },
      { "category": "non-fiction", "author": "Yuval Noah Harari", "title": "Sapiens", "price": 18.99 }
    ],
    "bicycle": { "color": "red", "price": 19.95 }
  }
}
```

#### Exemplos de JSONPath:

1. **Acessar a raiz:**
   ```jsonpath
   $
   ```
   Retorna o documento JSON inteiro.

2. **Acessar todos os livros na loja:**
   ```jsonpath
   $.store.book[*]
   ```
   Retorna uma lista de todos os livros.

3. **Acessar todos os títulos dos livros:**
   ```jsonpath
   $.store.book[*].title
   ```
   Retorna:
   ```json
   ["Moby Dick", "The Lord of the Rings", "Sapiens"]
   ```

4. **Acessar o preço da bicicleta:**
   ```jsonpath
   $.store.bicycle.price
   ```
   Retorna:
   ```json
   19.95
   ```

5. **Acessar o primeiro livro:**
   ```jsonpath
   $.store.book[0]
   ```
   Retorna:
   ```json
   { "category": "fiction", "author": "Herman Melville", "title": "Moby Dick", "price": 8.99 }
   ```

6. **Acessar o último livro:**
   ```jsonpath
   $.store.book[-1:]
   ```
   Retorna:
   ```json
   [{ "category": "non-fiction", "author": "Yuval Noah Harari", "title": "Sapiens", "price": 18.99 }]
   ```

7. **Filtrar livros que custam mais de 10:**
   ```jsonpath
   $.store.book[?(@.price > 10)]
   ```
   Retorna:
   ```json
   [
     { "category": "fiction", "author": "J. R. R. Tolkien", "title": "The Lord of the Rings", "price": 22.99 },
     { "category": "non-fiction", "author": "Yuval Noah Harari", "title": "Sapiens", "price": 18.99 }
   ]
   ```

8. **Acessar todos os autores:**
   ```jsonpath
   $.store.book[*].author
   ```
   Retorna:
   ```json
   ["Herman Melville", "J. R. R. Tolkien", "Yuval Noah Harari"]
   ```
 
### Conclusão

JSONPath é uma ferramenta poderosa para acessar e manipular dados JSON, proporcionando uma maneira eficiente e flexível de trabalhar com documentos JSON complexos. Com uma sintaxe intuitiva e suporte em várias linguagens, é uma excelente escolha para desenvolvedores que lidam com JSON regularmente.












# ###################################################################################################################### 
# ###################################################################################################################### 
## EXEMPLOS

 Vamos começar com exemplos de JSONPath mais básicos usando dicionários e, em seguida, vamos adicionar um pouco de complexidade com arrays.

### Exemplos Básicos com Dicionários

Considere o seguinte JSON simples:

```json
{
  "nome": "João",
  "idade": 30,
  "endereço": {
    "rua": "Rua das Flores",
    "cidade": "São Paulo"
  }
}
```

1. **Acessar o valor de uma chave simples:**
   ```jsonpath
   $.nome
   ```
   Resultado:
   ```json
   "João"
   ```

2. **Acessar o valor de uma chave aninhada:**
   ```jsonpath
   $.endereço.rua
   ```
   Resultado:
   ```json
   "Rua das Flores"
   ```

### Exemplos com Arrays

Agora, vamos adicionar um pouco mais de complexidade com arrays. Considere o seguinte JSON:

```json
{
  "nome": "João",
  "idade": 30,
  "endereços": [
    {
      "tipo": "residencial",
      "rua": "Rua das Flores",
      "cidade": "São Paulo"
    },
    {
      "tipo": "trabalho",
      "rua": "Avenida Paulista",
      "cidade": "São Paulo"
    }
  ]
}
```

3. **Acessar o primeiro endereço no array:**
   ```jsonpath
   $.endereços[0]
   ```
   Resultado:
   ```json
   {
     "tipo": "residencial",
     "rua": "Rua das Flores",
     "cidade": "São Paulo"
   }
   ```

4. **Acessar o tipo do primeiro endereço:**
   ```jsonpath
   $.endereços[0].tipo
   ```
   Resultado:
   ```json
   "residencial"
   ```

5. **Acessar todos os tipos de endereço:**
   ```jsonpath
   $.endereços[*].tipo
   ```
   Resultado:
   ```json
   ["residencial", "trabalho"]
   ```

6. **Acessar todas as cidades dos endereços:**
   ```jsonpath
   $.endereços[*].cidade
   ```
   Resultado:
   ```json
   ["São Paulo", "São Paulo"]
   ```

### Exemplos com Filtragem

Vamos adicionar alguns filtros para tornar os exemplos um pouco mais complexos. Considere o seguinte JSON:

```json
{
  "pessoas": [
    {
      "nome": "João",
      "idade": 30,
      "cidade": "São Paulo"
    },
    {
      "nome": "Maria",
      "idade": 25,
      "cidade": "Rio de Janeiro"
    },
    {
      "nome": "Ana",
      "idade": 28,
      "cidade": "São Paulo"
    }
  ]
}
```

7. **Acessar todas as pessoas:**
   ```jsonpath
   $.pessoas[*]
   ```
   Resultado:
   ```json
   [
     { "nome": "João", "idade": 30, "cidade": "São Paulo" },
     { "nome": "Maria", "idade": 25, "cidade": "Rio de Janeiro" },
     { "nome": "Ana", "idade": 28, "cidade": "São Paulo" }
   ]
   ```

8. **Filtrar pessoas que moram em São Paulo:**
   ```jsonpath
   $.pessoas[?(@.cidade == 'São Paulo')]
   ```
   Resultado:
   ```json
   [
     { "nome": "João", "idade": 30, "cidade": "São Paulo" },
     { "nome": "Ana", "idade": 28, "cidade": "São Paulo" }
   ]
   ```

9. **Filtrar pessoas com idade maior que 26:**
   ```jsonpath
   $.pessoas[?(@.idade > 26)]
   ```
   Resultado:
   ```json
   [
     { "nome": "João", "idade": 30, "cidade": "São Paulo" },
     { "nome": "Ana", "idade": 28, "cidade": "São Paulo" }
   ]
   ```

Esses exemplos cobrem o básico do JSONPath, mostrando como acessar e filtrar dados em dicionários e arrays. JSONPath é uma ferramenta poderosa para trabalhar com dados JSON e permite consultas complexas de forma intuitiva.









# ###################################################################################################################### 
# ###################################################################################################################### 
##  Root Element em JSON

No contexto de JSON, o conceito de "root element" refere-se ao primeiro e único objeto ou array que encapsula todos os dados no documento JSON. Aqui está um resumo de como o root element funciona em JSON:

### O que é o Root Element em JSON?

- **Root Element:** Em JSON, o root element é o objeto ou array que contém todos os outros pares chave-valor ou elementos. Não há um termo específico para "root element" em JSON, mas o conceito é essencial para estruturar os dados.

### Estrutura de JSON

JSON pode começar com:

1. **Objeto JSON (`{}`):** Um conjunto de pares chave-valor, onde cada chave é uma string e cada valor pode ser uma string, número, booleano, nulo, objeto ou array.

   **Exemplo:**

   ```json
   {
     "livro": {
       "titulo": "O Senhor dos Anéis",
       "autor": "J. R. R. Tolkien",
       "ano": 1954
     }
   }
   ```

   - **Root Element:** O objeto `{}` que contém a chave `"livro"` e seu valor, que é outro objeto JSON.

2. **Array JSON (`[]`):** Uma lista ordenada de valores, que podem ser strings, números, booleanos, nulos, objetos ou arrays.

   **Exemplo:**

   ```json
   [
     {
       "titulo": "O Senhor dos Anéis",
       "autor": "J. R. R. Tolkien",
       "ano": 1954
     },
     {
       "titulo": "O Hobbit",
       "autor": "J. R. R. Tolkien",
       "ano": 1937
     }
   ]
   ```

   - **Root Element:** O array `[]` que contém dois objetos JSON, cada um representando um livro.

### Como Funciona o Root Element

1. **Estrutura de Dados:**
   - **Objeto JSON:** O objeto JSON é a estrutura de nível superior e pode conter pares chave-valor, onde as chaves são strings e os valores podem ser qualquer tipo JSON.
   - **Array JSON:** O array JSON é uma lista de elementos, e cada elemento pode ser de qualquer tipo JSON, incluindo outros objetos ou arrays.

2. **Navegação e Manipulação:**
   - **Objeto JSON:** Permite acessar e manipular os dados usando chaves para acessar valores específicos.
   - **Array JSON:** Permite acessar e manipular dados usando índices para acessar elementos específicos.

3. **Interoperabilidade:**
   - **Objeto JSON e Array JSON:** Ambos podem ser usados como root element, e a escolha depende da estrutura dos dados que você deseja representar.

### Conclusão

Em JSON, o root element é o objeto ou array que encapsula todos os dados. Esse elemento define a estrutura do documento JSON e serve como o ponto de partida para acessar e manipular os dados. A escolha entre um objeto e um array como root depende da natureza dos dados que você está representando.















# ###################################################################################################################### 
# ###################################################################################################################### 
## **`$`** - Representa o root element do JSON

Sim, o símbolo `$` é comumente usado em JSONPath para representar o root element, que é o ponto de partida para a consulta. Ele indica que a expressão deve começar a partir do root element do documento JSON.

### Uso do `$` em JSONPath

1. **Representar o Root Element:**
   - **`$`** - Representa o root element do JSON. Pode ser usado para acessar o nível superior do documento JSON.

   **Exemplo:**
   ```json
   {
     "livro": {
       "titulo": "O Senhor dos Anéis",
       "autor": "J. R. R. Tolkien",
       "ano": 1954
     }
   }
   ```

   - **JSONPath:** `$`
     - Retorna o documento JSON inteiro.

2. **Acessar Dados a partir do Root Element:**
   - Para acessar dados específicos, você começa com `$` e depois usa a notação de ponto `.` ou colchetes `[]` para navegar pela estrutura do JSON.

   **Exemplo:**
   - **Acessar a chave `"livro"` no root element:**
     ```jsonpath
     $.livro
     ```
     - Retorna:
       ```json
       {
         "titulo": "O Senhor dos Anéis",
         "autor": "J. R. R. Tolkien",
         "ano": 1954
       }
       ```

   - **Acessar o valor da chave `"titulo"` dentro de `"livro"`:**
     ```jsonpath
     $.livro.titulo
     ```
     - Retorna:
       ```json
       "O Senhor dos Anéis"
       ```

### Exemplos Adicionais

1. **Com Objeto como Root Element:**
   ```json
   {
     "pessoa": {
       "nome": "João",
       "idade": 30
     }
   }
   ```
   - **JSONPath:** `$`
     - Retorna o objeto JSON inteiro.

   - **JSONPath:** `$.pessoa.nome`
     - Retorna:
       ```json
       "João"
       ```

2. **Com Array como Root Element:**
   ```json
   [
     { "nome": "João", "idade": 30 },
     { "nome": "Maria", "idade": 25 }
   ]
   ```
   - **JSONPath:** `$`
     - Retorna o array JSON inteiro.

   - **JSONPath:** `$[0].nome`
     - Retorna:
       ```json
       "João"
       ```

### Conclusão

O símbolo `$` é uma convenção importante em JSONPath para indicar o root element do documento JSON. Ele serve como o ponto de partida para a navegação e consulta dos dados. A partir dele, você pode usar notação adicional para acessar e manipular os dados conforme necessário.

















# ###################################################################################################################### 
# ###################################################################################################################### 
## JSONPath   listas

JSONPath permite consultar e extrair informações de listas (ou arrays) dentro de um documento JSON. Aqui estão alguns conceitos e exemplos de como trabalhar com listas usando JSONPath:

### Conceitos Básicos

1. **Acesso a Elementos de Array:**
   - Use a notação de colchetes `[]` para acessar elementos em um array. Os índices são baseados em zero.

2. **Acesso a Todos os Elementos:**
   - O asterisco `*` pode ser usado para acessar todos os elementos em um array.

3. **Slicing de Arrays:**
   - Você pode usar a notação de slicing `[start:end]` para acessar um intervalo de elementos.

4. **Filtragem de Arrays:**
   - Use a notação de filtro `?()` para filtrar elementos com base em uma condição.

### Exemplos de JSONPath com Arrays

#### JSON Exemplo

Considere o seguinte JSON:

```json
{
  "pessoas": [
    { "nome": "João", "idade": 30 },
    { "nome": "Maria", "idade": 25 },
    { "nome": "Ana", "idade": 28 }
  ]
}
```

1. **Acessar Todos os Elementos do Array:**
   ```jsonpath
   $.pessoas[*]
   ```
   - Retorna:
     ```json
     [
       { "nome": "João", "idade": 30 },
       { "nome": "Maria", "idade": 25 },
       { "nome": "Ana", "idade": 28 }
     ]
     ```

2. **Acessar um Elemento Específico do Array (por Índice):**
   ```jsonpath
   $.pessoas[1]
   ```
   - Retorna:
     ```json
     { "nome": "Maria", "idade": 25 }
     ```

3. **Acessar um Valor Específico em um Elemento do Array:**
   ```jsonpath
   $.pessoas[1].nome
   ```
   - Retorna:
     ```json
     "Maria"
     ```

4. **Slicing de Array:**
   ```jsonpath
   $.pessoas[0:2]
   ```
   - Retorna:
     ```json
     [
       { "nome": "João", "idade": 30 },
       { "nome": "Maria", "idade": 25 }
     ]
     ```

5. **Filtrar Elementos com Base em uma Condição:**
   ```jsonpath
   $.pessoas[?(@.idade > 26)]
   ```
   - Retorna:
     ```json
     [
       { "nome": "João", "idade": 30 },
       { "nome": "Ana", "idade": 28 }
     ]
     ```

6. **Filtrar e Acessar um Valor Específico em Elementos Filtrados:**
   ```jsonpath
   $.pessoas[?(@.idade > 26)].nome
   ```
   - Retorna:
     ```json
     ["João", "Ana"]
     ```

### Usando JSONPath em Diferentes Linguagens

- **JavaScript:** Utilize bibliotecas como `jsonpath` para executar consultas JSONPath.
- **Python:** Utilize bibliotecas como `jsonpath-ng` para trabalhar com JSONPath.
- **Java:** Utilize bibliotecas como `JsonPath` para consultas JSONPath.

### Conclusão

JSONPath fornece uma maneira poderosa e flexível para consultar e manipular listas em documentos JSON. Usando notações específicas como `[*]`, `[index]`, `[start:end]`, e `?()`, você pode acessar e filtrar dados de forma eficaz.





# ###################################################################################################################### 
# ###################################################################################################################### 
## JSON com Dicionário e Lista

Quando você está trabalhando com JSON que contém tanto dicionários (objetos) quanto listas (arrays), JSONPath pode ser usado para acessar e manipular os dados de forma eficiente. Vou fornecer exemplos para ilustrar como você pode consultar e extrair informações de um JSON que inclui tanto dicionários quanto listas.

### Exemplo de JSON com Dicionário e Lista

Considere o seguinte JSON:

```json
{
  "empresa": {
    "nome": "Tech Solutions",
    "funcionarios": [
      { "nome": "João", "cargo": "Desenvolvedor", "idade": 30 },
      { "nome": "Maria", "cargo": "Designer", "idade": 25 },
      { "nome": "Ana", "cargo": "Gerente", "idade": 28 }
    ],
    "departamentos": ["TI", "Design", "RH"]
  }
}
```

### Exemplos de Consultas JSONPath

1. **Acessar o Nome da Empresa:**
   ```jsonpath
   $.empresa.nome
   ```
   - Retorna:
     ```json
     "Tech Solutions"
     ```

2. **Acessar a Lista de Funcionários:**
   ```jsonpath
   $.empresa.funcionarios
   ```
   - Retorna:
     ```json
     [
       { "nome": "João", "cargo": "Desenvolvedor", "idade": 30 },
       { "nome": "Maria", "cargo": "Designer", "idade": 25 },
       { "nome": "Ana", "cargo": "Gerente", "idade": 28 }
     ]
     ```

3. **Acessar o Nome do Primeiro Funcionário:**
   ```jsonpath
   $.empresa.funcionarios[0].nome
   ```
   - Retorna:
     ```json
     "João"
     ```

4. **Acessar o Cargo de Todos os Funcionários:**
   ```jsonpath
   $.empresa.funcionarios[*].cargo
   ```
   - Retorna:
     ```json
     ["Desenvolvedor", "Designer", "Gerente"]
     ```

5. **Acessar Todos os Departamentos:**
   ```jsonpath
   $.empresa.departamentos
   ```
   - Retorna:
     ```json
     ["TI", "Design", "RH"]
     ```

6. **Filtrar Funcionários com Idade Maior que 26:**
   ```jsonpath
   $.empresa.funcionarios[?(@.idade > 26)]
   ```
   - Retorna:
     ```json
     [
       { "nome": "João", "cargo": "Desenvolvedor", "idade": 30 },
       { "nome": "Ana", "cargo": "Gerente", "idade": 28 }
     ]
     ```

7. **Filtrar Funcionários com Idade Maior que 26 e Acessar Seus Nomes:**
   ```jsonpath
   $.empresa.funcionarios[?(@.idade > 26)].nome
   ```
   - Retorna:
     ```json
     ["João", "Ana"]
     ```

8. **Acessar o Primeiro Departamento:**
   ```jsonpath
   $.empresa.departamentos[0]
   ```
   - Retorna:
     ```json
     "TI"
     ```

9. **Acessar o Nome do Segundo Funcionário e o Cargo do Terceiro Funcionário:**
   ```jsonpath
   $.empresa.funcionarios[1].nome
   $.empresa.funcionarios[2].cargo
   ```
   - Retorna:
     ```json
     "Maria"
     ```
     ```json
     "Gerente"
     ```

### Conclusão

Usar JSONPath para acessar dados em um JSON que contém tanto dicionários quanto listas é bastante direto. A chave é usar a notação adequada para navegar pela estrutura hierárquica do JSON. Com JSONPath, você pode facilmente acessar e filtrar dados em objetos e arrays para obter as informações necessárias.







# ###################################################################################################################### 
# ###################################################################################################################### 
## JSONPath com base em critérios específicos

Filtrar dados em um JSON usando JSONPath com base em critérios específicos é uma funcionalidade poderosa. Isso permite selecionar subconjuntos de dados que atendem a determinadas condições. A filtragem é feita usando a notação de filtro `?()`.

### Sintaxe do Filtro JSONPath

A sintaxe básica para filtragem é:

```jsonpath
$.[?(@.campo == 'valor')]
```

Aqui, `?()` é usado para aplicar um filtro, e `@` refere-se ao elemento atual sendo avaliado.

### Exemplos de Filtragem

Considere o seguinte JSON como exemplo:

```json
{
  "empresa": {
    "nome": "Tech Solutions",
    "funcionarios": [
      { "nome": "João", "cargo": "Desenvolvedor", "idade": 30 },
      { "nome": "Maria", "cargo": "Designer", "idade": 25 },
      { "nome": "Ana", "cargo": "Gerente", "idade": 28 }
    ],
    "departamentos": ["TI", "Design", "RH"]
  }
}
```

1. **Filtrar Funcionários com Idade Maior que 26:**

   ```jsonpath
   $.empresa.funcionarios[?(@.idade > 26)]
   ```

   - **Resultado:**
     ```json
     [
       { "nome": "João", "cargo": "Desenvolvedor", "idade": 30 },
       { "nome": "Ana", "cargo": "Gerente", "idade": 28 }
     ]
     ```

2. **Filtrar Funcionários com Cargo "Designer":**

   ```jsonpath
   $.empresa.funcionarios[?(@.cargo == 'Designer')]
   ```

   - **Resultado:**
     ```json
     [
       { "nome": "Maria", "cargo": "Designer", "idade": 25 }
     ]
     ```

3. **Filtrar Funcionários com Nome que Começa com "A":**

   ```jsonpath
   $.empresa.funcionarios[?(@.nome =~ /^A/)]
   ```

   - **Resultado:**
     ```json
     [
       { "nome": "Ana", "cargo": "Gerente", "idade": 28 }
     ]
     ```

4. **Filtrar Funcionários com Idade Entre 25 e 30:**

   ```jsonpath
   $.empresa.funcionarios[?(@.idade >= 25 && @.idade <= 30)]
   ```

   - **Resultado:**
     ```json
     [
       { "nome": "João", "cargo": "Desenvolvedor", "idade": 30 },
       { "nome": "Maria", "cargo": "Designer", "idade": 25 },
       { "nome": "Ana", "cargo": "Gerente", "idade": 28 }
     ]
     ```

5. **Filtrar Departamentos que Contêm a Letra "D":**

   ```jsonpath
   $.empresa.departamentos[?(@ =~ /D/)]
   ```

   - **Resultado:**
     ```json
     [
       "Design"
     ]
     ```

### Notações Adicionais

- **`==`**: Verifica se um valor é igual a um valor específico.
- **`!=`**: Verifica se um valor é diferente de um valor específico.
- **`>`**: Verifica se um valor é maior que um valor específico.
- **`<`**: Verifica se um valor é menor que um valor específico.
- **`>=`**: Verifica se um valor é maior ou igual a um valor específico.
- **`<=`**: Verifica se um valor é menor ou igual a um valor específico.
- **`=~`**: Verifica se um valor corresponde a uma expressão regular (regex).

### Conclusão

JSONPath fornece uma maneira robusta de filtrar dados em documentos JSON com base em critérios específicos. Usando a notação de filtro `?()`, você pode realizar consultas complexas e extrair exatamente as informações de que precisa.




# ###################################################################################################################### 
# ###################################################################################################################### 
## resumo

- Inserir o $ no começo, para indicar o root.

- **JSONPath:** `$`
Retorna o documento JSON inteiro.


- Use a notação de colchetes `[]` para acessar elementos em um array. Os índices são baseados em zero
começa em 0


- Filtrar Elementos com Base em uma Condição:
exemplo base:
$[?(@ > 40)]

filtrando por idade das pessoas maior que 40:
$.pessoas[?(@.idade > 40)]


- JSONPath com base em critérios específicos
$.[?(@.campo == 'valor')]


- Jeito bom para filtrar sem saber a posição, filtrando por um critério:
$.pessoas[?(@.cidade == 'São Paulo')]