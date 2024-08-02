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