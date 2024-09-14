#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "JSON PATH - Wildcards."
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
##  JSON PATH - Wildcards

- JSON de base
Secao14-Other-topics/005-json-para-aula-wildcards.json

~~~~json
{
    "car": {
        "color": "blue",
        "price": "$20,000"
    },
    "bus": {
        "color": "white",
        "price": "$120,000"
    }
}
~~~~




Get all colors
$.*.price





cat 005-json-para-aula-wildcards.json | jpath $.*.color

- Não tem o jpath no Ubuntu:

 12K -rw-r--r--  1 fernando fernando 8.3K Sep 12 22:11 q11.json
> cat 005-json-para-aula-wildcards.json | jpath $.*.color
zsh: no matches found: $.*.color
> cat 005-json-para-aula-wildcards.json | jpath $.bus.color
zsh: command not found: jpath
>



- Eu tinha o jq instalado
cat 005-json-para-aula-wildcards.json | jq $.*.color

> cat 005-json-para-aula-wildcards.json | jq $.*.color
zsh: no matches found: $.*.color




O erro que você está vendo ocorre porque o shell `zsh` tenta interpretar o caractere `$.*.color` como uma expressão de variável ou como um padrão de arquivo antes de passá-lo para o `jq`. Para evitar que o shell processe a expressão de consulta do `jq`, você precisa envolver a consulta em aspas simples (`'`) ou aspas duplas (`"`).

Aqui está o que você deve fazer:

### 1. **Consulta correta com `jq`**

- Para buscar todas as cores no JSON:

    ```bash
    cat 005-json-para-aula-wildcards.json | jq '.[].color'
    ```

- Para buscar a cor de um objeto específico, como o `bus`:

    ```bash
    cat 005-json-para-aula-wildcards.json | jq '.bus.color'
    ```

### 2. **Explicação**
Ao usar `zsh`, ele tenta interpretar caracteres especiais como `*` ou `$` no terminal. Colocar a consulta entre aspas impede que o shell faça isso e deixa o `jq` processar a consulta corretamente.

Se ainda houver algum problema ou se a estrutura do JSON for diferente, sinta-se à vontade para compartilhar mais detalhes do arquivo `json` e poderei ajustar o comando para você!




cat 005-json-para-aula-wildcards.json | jq '$.*.color'

- ERRO
> cat 005-json-para-aula-wildcards.json | jq '$.*.color'
jq: error: syntax error, unexpected '.', expecting IDENT or __loc__ (Unix shell quoting issues?) at <top-level>, line 1:
$.*.color
jq: 1 compile error
>


- No Ubuntu e utilizando o jq, é assim a sintaxe:

> cat 005-json-para-aula-wildcards.json | jq '.[].color'
"blue"
"white"










sudo apt-get install nodejs npm

npm install -g jsonpath



> cat 005-json-para-aula-wildcards.json | jsonpath '$.*.color'
zsh: command not found: jsonpath




O erro "command not found: jsonpath" pode ocorrer por várias razões, mesmo após a instalação via `npm`. O mais comum é que o diretório onde o `npm` instala pacotes globais não esteja no seu **PATH** do sistema, então o terminal não consegue encontrar o comando.

### Passos para resolver o problema:

#### 1. **Verificar onde o `npm` instalou o pacote globalmente:**

Execute o seguinte comando para verificar onde o `npm` instala pacotes globais:

```bash
npm root -g
```

Isso mostrará o caminho de instalação global dos pacotes `npm`. Normalmente, no Ubuntu, é algo como:

```
/usr/local/lib/node_modules
```

Agora verifique onde os **executáveis globais** estão instalados:

```bash
npm bin -g
```

Esse caminho deve ser algo como:

```
/usr/local/bin
```

#### 2. **Adicionar o diretório de binários do `npm` ao seu PATH:**

Se o diretório de binários globais (`/usr/local/bin` ou outro caminho retornado pelo comando anterior) não estiver no seu **PATH**, você precisa adicioná-lo.

Para fazer isso, siga os passos abaixo:

1. Abra o arquivo `.zshrc` no seu editor de texto:

   ```bash
   nano ~/.zshrc
   ```

2. Adicione esta linha ao final do arquivo (substituindo `/usr/local/bin` pelo caminho correto, se necessário):

   ```bash
   export PATH=$PATH:/usr/local/bin
   ```

3. Salve o arquivo e feche o editor.

4. Aplique as alterações:

   ```bash
   source ~/.zshrc
   ```

#### 3. **Verifique se o `jsonpath` está disponível:**

Agora, verifique se o comando `jsonpath` está acessível:

```bash
jsonpath --help
```

Se isso funcionar, você já deve conseguir executar sua consulta JSONPath:

```bash
cat 005-json-para-aula-wildcards.json | jsonpath '$.*.color'
```

### Se ainda houver problemas:

Se o comando ainda não funcionar, verifique se o `jsonpath` foi instalado corretamente:

```bash
npm list -g --depth=0
```

Isso listará todos os pacotes globais instalados. Verifique se o `jsonpath` aparece na lista.

Se não aparecer, tente reinstalar:

```bash
npm install -g jsonpath
```

Com essas etapas, o comando `jsonpath` deve estar disponível para uso no terminal.




> npm root -g

/home/fernando/.asdf/installs/nodejs/22.8.0/lib/node_modules