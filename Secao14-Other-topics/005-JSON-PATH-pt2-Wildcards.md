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


> npm bin -g

Unknown command: "bin"

To see a list of supported npm commands, run:
  npm help



> npm config get prefix

/home/fernando/.asdf/installs/nodejs/22.8.0




asdf install nodejs 22.8.0



npm install -g jsonpath

> 
> npm install -g jsonpath

changed 16 packages in 1s
Reshimming asdf nodejs...



> cat 005-json-para-aula-wildcards.json | jsonpath '$.*.color'
zsh: command not found: jsonpath












It seems like you've encountered an issue after installing the `jsonpath` package globally using npm. The error message suggests that the `jsonpath` command is not found, even though you've just installed it. This can happen due to a few reasons. Let's troubleshoot this step by step:

1. First, make sure the global npm bin directory is in your PATH. You can check this by running:

   ```
   echo $PATH
   ```

   Look for the npm global bin directory in the output. It's usually something like `/usr/local/bin` or `~/.npm-global/bin`.

2. If it's not in your PATH, you'll need to add it. You can do this by adding a line to your `~/.zshrc` file (since you're using zsh):

   ```
   export PATH=$PATH:$(npm config get prefix)/bin
   ```

   After adding this line, run `source ~/.zshrc` to apply the changes.

3. If the path is already correct, try running `hash -r` to clear the shell's command hash table.

4. If that doesn't work, try installing the package with a different name that includes the CLI tool:

   ```
   npm install -g jsonpath-plus
   ```

   This package provides a CLI tool named `jsonpath` that should work for your use case.

5. After installing `jsonpath-plus`, try running your command again:

   ```
   cat 005-json-para-aula-wildcards.json | jsonpath '$.*.color'
   ```

If you're still encountering issues, please let me know, and we can try some other solutions. Also, could you share the content of your JSON file? That would help in providing a more specific solution or alternative approaches if needed.






> npm config get prefix
/home/fernando/.asdf/installs/nodejs/22.8.0



> 
> echo $PATH
/home/fernando/.vscode-server/bin/38c31bc77e0dd6ae88a4e9cc93428cc27a56ba40/bin/remote-cli:/home/fernando/.asdf/shims:/home/fernando/.asdf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib




vi ~/.zshrc
export PATH=$PATH:$(npm config get prefix)/bin
source ~/.zshrc




cat 005-json-para-aula-wildcards.json | jsonpath '$.*.color'


> hash -r
> cat 005-json-para-aula-wildcards.json | jsonpath '$.*.color'
zsh: command not found: jsonpath



> cat 005-json-para-aula-wildcards.json | jsonpath '$.*.color'
zsh: command not found: jsonpath
> echo $PATH
/home/fernando/.vscode-server/bin/38c31bc77e0dd6ae88a4e9cc93428cc27a56ba40/bin/remote-cli:/home/fernando/.asdf/shims:/home/fernando/.asdf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/home/fernando/.asdf/installs/nodejs/22.8.0/bin
> 
> 



- Instalando o jsonpath-plus:

> 
> npm install -g jsonpath-plus

added 4 packages in 3s
Reshimming asdf nodejs...











- Mudou o erro ao usar o jsonpath-plus:

> cat 005-json-para-aula-wildcards.json | jsonpath '$.*.color'
usage: /home/fernando/.asdf/installs/nodejs/22.8.0/bin/jsonpath <file> <path>

Error: ENOENT: no such file or directory, open '$.*.color'
    at async open (node:internal/fs/promises:638:25)
    at async readFile (node:internal/fs/promises:1238:14)
    at async file:///home/fernando/.asdf/installs/nodejs/22.8.0/lib/node_modules/jsonpath-plus/bin/jsonpath-cli.js:9:29 {
  errno: -2,
  code: 'ENOENT',
  syscall: 'open',
  path: '$.*.color'
}
> date
Sat Sep 14 12:00:57 -03 2024





Thank you for providing the updated output. It looks like the `jsonpath` command is now recognized, but there's an issue with how it's being used. Let's break down the problem and provide a solution:

1. The error message indicates that the `jsonpath` command is expecting two arguments: a file and a path. However, you're trying to use it with piped input.

2. The command is interpreting `$.*.color` as a file name, which is why you're seeing the "no such file or directory" error.

To fix this, you have two options:

Option 1: Use the command as intended by the CLI tool:

```bash
jsonpath 005-json-para-aula-wildcards.json '$.*.color'
```

Option 2: If you want to use it with piped input, you can use process substitution in bash or zsh:

```bash
jsonpath <(cat 005-json-para-aula-wildcards.json) '$.*.color'
```

This creates a file-like object from the output of the `cat` command, which `jsonpath` can then read as a file.

If you're still having trouble, you might want to consider using a different tool that's more pipe-friendly, such as `jq`. With `jq`, you could do:

```bash
cat 005-json-para-aula-wildcards.json | jq '.[].color'
```

This assumes your JSON structure is an array of objects, each with a `color` property. If the structure is different, you might need to adjust the jq query.

Lastly, I noticed the date output shows September 14, 2024. As an AI language model, my knowledge cutoff is in April 2024, so I can't account for any changes that might have occurred in tools or best practices after that date. If you're using a version of the tools released after April 2024, there might be changes I'm not aware of.



