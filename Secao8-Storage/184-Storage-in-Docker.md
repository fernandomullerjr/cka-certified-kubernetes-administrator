
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "184. Storage in Docker."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# 184. Storage in Docker

Transcrição

Olá e bem-vindo a esta palestra.

E estamos aprendendo conceitos mais sombrios avançados nesta palestra.

Vamos falar sobre os médicos Torres drivers e sistemas de arquivos.

Vamos ver onde e como os médicos armazenam dados e como ele gerencia os sistemas de arquivos de contêineres. Vamos

começar como um médico armazena dados no sistema de arquivos local quando você instala o Docker em um

sistema, ele cria essa estrutura de pastas no local onde o Docker labial você tem várias pastas nele chamadas de

volumes de imagem de contêineres de alguns casos etc.

É aqui que o Doctor armazena todos os seus dados por padrão.

Quando digo dados, quero dizer arquivos relacionados a imagens e contêineres em execução no dock ou host, por exemplo,

todos os arquivos relacionados a contêineres são armazenados na pasta containers e os arquivos relacionados a

imagens são armazenados na pasta image.

Quaisquer volumes criados pelos contêineres da janela de encaixe são criados na pasta volumes.

Bem, não se preocupe com isso por enquanto.

Voltaremos a isso daqui a pouco.

Por enquanto, vamos apenas entender onde o Docker armazena seus arquivos e em que formato.

Então, como exatamente o Docker armazenou os arquivos de uma imagem e um contêiner, você entende

que precisamos entender a arquitetura em camadas do Dockers.

Vamos recapitular rapidamente algo que aprendemos quando o Docker cria imagens e as cria em uma arquitetura em camadas.

Cada linha de instrução no arquivo da janela de encaixe cria uma nova camada na imagem do Docker com apenas as

alterações da camada anterior.

Por exemplo, a primeira camada é um sistema operacional Ubuntu básico, seguido pela segunda instrução que

cria uma segunda camada que instala todos os pacotes APD.

E então a terceira instrução cria uma terceira camada que, com os pacotes python, seguida pela

quarta camada que copia o código-fonte.

E, finalmente, a quinta camada que atualiza o ponto de entrada da imagem, pois cada camada armazena apenas as

alterações da camada anterior.

Também se reflete no tamanho.

Se você olhar para a base da imagem, ela tem cerca de 120 megabytes de tamanho.

Os pacotes AAPT instalados são de cerca de 300 MB e as camadas restantes são pequenas para entender

as vantagens dessa arquitetura em camadas.

Vamos considerar uma segunda aplicação. Essa aplicação tem um arquivo mais escuro, mas é muito semelhante à nossa

primeira aplicação, pois usa a mesma imagem base que a usada para usar as mesmas dependências de python

e frasco, mas usa um código-fonte diferente para criar uma imagem diferente. inscrição.

E também um ponto de entrada diferente.

Quando executo o comando docker build para criar uma nova imagem para este aplicativo, uma vez

que as três primeiras camadas dos dois aplicativos são as mesmas. O Docker não criará as três primeiras camadas.

Em vez disso, reutiliza as mesmas três camadas criadas para o primeiro aplicativo a partir do cache e apenas cria

as duas últimas camadas com as novas fontes e o novo ponto de entrada, dessa maneira o Docker cria imagens mais rapidamente

e economiza espaço em disco com eficiência.

Isso também é aplicável se você atualizar o código do aplicativo sempre que

atualizar o código do aplicativo, como o abduzido. Nesse caso, o Docker simplesmente reutiliza todas as camadas anteriores

do cache e reconstrói rapidamente a imagem do aplicativo, atualizando o código-fonte mais recente, economizando assim muito

tempo durante as reconstruções e atualizações, vamos reorganizar as camadas de baixo para cima para que possamos entendê-lo melhor na parte

inferior, temos a base aberta em camadas, os pacotes, as dependências e o código fonte do

aplicativo e, em seguida, o ponto de entrada dessas camadas são criadas quando executamos o comando docker build

para formar a imagem final do Docker, portanto, todas essas são as camadas de imagem do Docker.

Depois que a compilação estiver concluída, você não poderá modificar o conteúdo dessas camadas e,

portanto, elas serão apenas de leitura. Você poderá modificá-las iniciando uma nova compilação quando executar um contêiner com base nessa imagem.

Usando o comando docker run, o Docker cria um contêiner com base nessas camadas e cria uma nova camada

tributável na parte superior da camada da imagem.

A camada tributável é usada para armazenar dados criados pelo contêiner, como arquivos de log pelos aplicativos.

Qualquer arquivo temporário gerado pelo contêiner ou apenas qualquer arquivo modificado pelo usuário nesse contêiner, a

vida útil dessa camada é apenas enquanto o contêiner estiver ativo.

Quando o contêiner é destruído, essa camada e todas as alterações armazenadas nele também são destruídas.

Lembre-se de que a mesma camada de imagem é compartilhada por todos os contêineres criados usando essa imagem se eu fizer

login no contêiner recém-criado e dizer criar um novo arquivo chamado temp dot t t.

Ele criaria esse arquivo na camada do contêiner, que é de leitura e gravação.

Acabamos de dizer que os arquivos na camada da imagem são somente leitura, o que significa que você não pode

editar nada nessas camadas.

Vamos dar um exemplo de nosso código de aplicativo, pois inserimos nosso código na imagem.

O código faz parte da camada de imagem e, como tal, é lido somente após a execução de um contêiner.

E se eu desejar modificar o código fonte para dizer testar uma alteração.

Lembre-se de que a mesma camada de imagem pode ser compartilhada entre vários contêineres criados a partir desta imagem.

Então isso significa que não posso modificar este arquivo dentro do contêiner.

Agora ainda posso modificar esse arquivo, mas antes de salvar o arquivo modificado, o Docker cria automaticamente uma cópia

do arquivo na camada de leitura e gravação e modifico uma versão diferente do arquivo

na camada de reescrita.

Todas as modificações futuras serão feitas nesta cópia do arquivo na camada de reescrita.

Isso é chamado de mecanismo de cópia no gravador, e a camada de imagem sendo lida apenas significa que

os arquivos nessas camadas não serão modificados na própria imagem; portanto, a imagem permanecerá a mesma o tempo todo

até que você reconstrua a imagem usando o comando docker build.

O que acontece quando nos livramos do contêiner, todos os dados armazenados na camada do

contêiner também são excluídos.

A alteração que fizemos no Abdul Pillai e o novo arquivo de dez que criamos também serão removidos.

E daí se desejarmos manter esses dados.

Por exemplo, se estivéssemos trabalhando com um banco de dados e gostaríamos de preservar

os dados criados pelo contêiner, poderíamos adicionar um volume persistente ao contêiner. Para isso, primeiro crie um volume usando o

comando docker volume create.

Portanto, quando executamos o comando criar volume de sublinhado de volume do docker, ele cria uma

pasta chamada volume de sublinhado de dados no diretório var lib Docker volumes.

Então, quando eu executo o contêiner do docker usando o comando docker run, eu poderia montar esse volume

dentro dos contêineres do docker, reescrever a camada usando o traço na opção desta maneira.

Então, eu faria uma janela de encaixe executando o Daschle e depois especificaria meu nome de volume recém-criado, seguido de

dois pontos e o local dentro do meu contêiner, que é o local padrão onde minúsculos dados armazenados

e é onde lib está distorcido.

E, em seguida, o nome da imagem, tudo isso criará um novo contêiner e montará o volume de dados que criamos

em var lib.

Minha pasta obscura dentro do contêiner, para que todos os dados gravados pelo banco de dados sejam realmente armazenados

no volume criado no host do docker.

Mesmo que o contêiner seja destruído, os dados ainda estão ativos.

Agora, e se você não executou o comando docker volume create para criar o volume antes do

comando docker run.

Por exemplo, se eu executar o comando docker run para criar uma nova instância do meu contêiner de resgate

com o volume 2 de sublinhado de dados do volume que ainda não criei, o Docker criará automaticamente um volume

denominado volume de sublinhado de dados 2 e o montará no contêiner.

Você poderá ver todos esses volumes se listar o conteúdo da pasta var lib Docker volumes.

Isso se chama montagem de volume, pois estamos montando no volume criado pelo Docker na pasta var lib

Docker volumes.

Mas e se já tivéssemos nossos dados em outro local, por exemplo, digamos que tenhamos algum armazenamento externo no

host da janela de encaixe ou reduza os dados e gostaríamos de armazenar dados do banco de dados nesse volume e

não no padrão em que a pasta de estivadores está pasta.

Nesse caso, executaríamos um contêiner usando o comando Docker run Daschle.

Mas, neste caso, forneceremos a peça completa para a pasta que gostaríamos de montar.

É isso que slash dados para Slash menos Q Well e, portanto, ele criará um contêiner e montará

a pasta no contêiner.

Isso é chamado de montagem de ligação.

Portanto, existem dois tipos de montagens uma montagem de volume e uma montagem de montagem de volume monta um volume

do diretório de volumes e montagem de ligação monta um diretório de qualquer local no host do docker.

Um ponto final a ser observado antes de eu deixar você usar o traço V é um estilo antigo, a nova maneira de

usar a opção de montagem no painel é a preferida, pois é mais detalhada.

Portanto, você deve especificar cada parâmetro em uma chave igual ao formato do valor.

Por exemplo, o comando anterior pode ser gravado com a opção de montagem em traço, usando as opções de tipo

de origem e destino.

O tipo nesse caso é vincular a origem é o local no meu host e o destino é o local no

meu

contêiner, portanto, quem é responsável por executar todas essas operações.

Mantendo a arquitetura em camadas.

Criando uma camada viável movendo arquivos entre as camadas para permitir copiar e gravar etc. São os drivers de armazenamento.

Portanto, o Dockery usa drivers de armazenamento para habilitar a arquitetura em camadas.

Alguns dos drivers de armazenamento comuns são sobreposições de mapeador de dispositivo DFS de casos de BTR rápidas do usuário e

sobreposição na seleção do driver de armazenamento.

Depende do sistema operacional subjacente que está sendo usado, por exemplo, com o Ubuntu.

A história padrão é que driver é uma nova ofensa, enquanto essa loja como driver não está disponível em outros sistemas operacionais como o

fedora ou o S. O. S.

Nesse caso, o mapeador de dispositivos pode ser uma opção melhor. O Docker escolherá o melhor driver de histórias

disponível automaticamente com base no sistema operacional. Os diferentes drivers de histórias também fornecem características diferentes

de desempenho e estabilidade. Portanto, convém escolher uma que atenda às necessidades de seu aplicativo

e sua organização.

Se você quiser ler mais sobre algum desses drivers de histórias, consulte os links na

documentação em anexo por enquanto.

Isso é tudo dos conceitos de arquitetura do docker.

Vejo você na próxima palestra.








# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#


Container size on disk

To view the approximate size of a running container, you can use the docker ps -s command. Two different columns relate to size.

    size: the amount of data (on disk) that's used for the writable layer of each container.
    virtual size: the amount of data used for the read-only image data used by the container plus the container's writable layer size. Multiple containers may share some or all read-only image data. Two containers started from the same image share 100% of the read-only data, while two containers with different images which have layers in common share those common layers. Therefore, you can't just total the virtual sizes. This over-estimates the total disk usage by a potentially non-trivial amount.


docker run -d --name meu_container -it ubuntu

~~~~bash

fernando@debian10x64:~$ docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS         PORTS     NAMES
3e147a5ba6f7   ubuntu    "/bin/bash"   14 minutes ago   Up 3 seconds             meu_container
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ docker ps -s
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS         PORTS     NAMES           SIZE
3e147a5ba6f7   ubuntu    "/bin/bash"   14 minutes ago   Up 6 seconds             meu_container   0B (virtual 77.9MB)
fernando@debian10x64:~$

~~~~



## Volumes

https://docs.docker.com/storage/volumes/
<https://docs.docker.com/storage/volumes/>


## Bind Mount

<https://docs.docker.com/storage/bind-mounts/>

~~~~bash
docker run -d \
  -it \
  --name devtest \
  --mount type=bind,source="$(pwd)"/target,target=/app \
  nginx:latest
~~~~



preciso de exemplo de comando docker que sobe container com volume mount bind
ChatGPT

Claro, vou fornecer um exemplo de comando Docker que cria um container com um volume montado usando a opção --mount para fazer um "bind mount". Este tipo de montagem permite mapear um diretório no host para um diretório no container, proporcionando persistência aos dados.

Suponha que você tenha um diretório chamado /caminho/do/host no seu host e deseja montá-lo no diretório /caminho/no/container dentro do container. O comando seria semelhante ao seguinte:

~~~~bash
docker run -d --name meu_container --mount type=bind,source=/caminho/do/host,target=/caminho/no/container -it ubuntu
~~~~

Neste exemplo:

    -d: Executa o container em segundo plano.
    --name meu_container: Define o nome do container como "meu_container".
    --mount type=bind,source=/caminho/do/host,target=/caminho/no/container: Especifica o tipo de montagem como "bind" e mapeia o diretório do host /caminho/do/host para o diretório no container /caminho/no/container.
    -it ubuntu: Associa o terminal do host ao terminal dentro do container, usando a imagem do Ubuntu.

Lembre-se de substituir /caminho/do/host e /caminho/no/container pelos caminhos e diretórios desejados no seu sistema.

Com esse comando, qualquer alteração feita dentro do diretório /caminho/no/container no container será refletida no diretório /caminho/do/host no host e vice-versa. Isso é útil para persistência de dados, pois os dados são armazenados no sistema de arquivos do host e persistem mesmo quando o container é removido.





## Storage Drivers

<https://docs.docker.com/storage/storagedriver/select-storage-driver/>

The Docker Engine provides the following storage drivers on Linux:
Driver	Description
overlay2	overlay2 is the preferred storage driver for all currently supported Linux distributions, and requires no extra configuration.
fuse-overlayfs	fuse-overlayfsis preferred only for running Rootless Docker on a host that does not provide support for rootless overlay2. On Ubuntu and Debian 10, the fuse-overlayfs driver does not need to be used, and overlay2 works even in rootless mode. Refer to the rootless mode documentation for details.
btrfs and zfs	The btrfs and zfs storage drivers allow for advanced options, such as creating "snapshots", but require more maintenance and setup. Each of these relies on the backing filesystem being configured correctly.
vfs	The vfs storage driver is intended for testing purposes, and for situations where no copy-on-write filesystem can be used. Performance of this storage driver is poor, and is not generally recommended for production use.
devicemapper ( deprecated)	The devicemapper storage driver requires direct-lvm for production environments, because loopback-lvm, while zero-configuration, has very poor performance. devicemapper was the recommended storage driver for CentOS and RHEL, as their kernel version did not support overlay2. However, current versions of CentOS and RHEL now have support for overlay2, which is now the recommended driver.

Linux distribution	Recommended storage drivers	Alternative drivers
Ubuntu	overlay2	devicemapper¹, zfs, vfs
Debian	overlay2	devicemapper¹, vfs
CentOS	overlay2	devicemapper¹, zfs, vfs
Fedora	overlay2	devicemapper¹, zfs, vfs
SLES 15	overlay2	devicemapper¹, vfs
RHEL	overlay2	devicemapper¹, vfs



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# RESUMO

- O Docker reaproveita layers, quando vai criar nova imagem Docker, criando apenas as Layers que sofreram alguma alteração.
- As Layers da Docker Image são Read-Only.
- Ao efetuar o "docker run", o Docker cria uma Layer adicional chamada "Container Layer". Esta Layer é Read/Write. Esta Layer armazena logs e outras coisas do Container.
- Caso um container seja criado passando o parametro -v, para criar o volume, o Docker cria o volume automaticamente, caso ele não exista.
- Para os "Mount Bind", antes era usado o -v, porém atualmente é utilizado o --mount preferencialmente.
-  AuFS storage driver has been deprecated

