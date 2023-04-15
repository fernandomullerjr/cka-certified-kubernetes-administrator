
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "108. Demo: Encrypting Secret Data at Rest"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# RESUMO

- Aula em torno do material:
https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/
<https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/>

- Foi possível obter o valor da Secret via etcdctl no Minikube, seguindo o tutorial abaixo:
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao5-Application-Lifecycle-Management/108-Usando-Hexdump-no-ETCD-do-Minikube.md




------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 108. Demo: Encrypting Secret Data at Rest

- O foco será no conteúdo que é armazenado no etcd server.


- Primeiro, criar um objeto de Secret, usando o comando kubectl create secret generic


Examples:
  # Create a new secret named my-secret with keys for each file in folder bar
  kubectl create secret generic my-secret --from-file=path/to/bar

  # Create a new secret named my-secret with specified keys instead of names on disk
  kubectl create secret generic my-secret --from-file=ssh-privatekey=path/to/id_rsa
--from-file=ssh-publickey=path/to/id_rsa.pub

  # Create a new secret named my-secret with key1=supersecret and key2=topsecret
  kubectl create secret generic my-secret --from-literal=key1=supersecret --from-literal=key2=topsecret

  # Create a new secret named my-secret using a combination of a file and a literal
  kubectl create secret generic my-secret --from-file=ssh-privatekey=path/to/id_rsa --from-literal=passphrase=topsecret

  # Create a new secret named my-secret from env files
  kubectl create secret generic my-secret --from-env-file=path/to/foo.env --from-env-file=path/to/bar.env




- Criar usando esta
kubectl create secret generic my-secret --from-literal=key1=supersecret

~~~~bash
fernando@debian10x64:~$ kubectl create secret generic my-secret --from-literal=key1=supersecret
secret/my-secret created
fernando@debian10x64:~$
~~~~



- Verificando se a Secret foi criada:

~~~~bash
fernando@debian10x64:~$ kubectl get secret
NAME                                             TYPE                                  DATA   AGE
app-secret                                       Opaque                                3      31d
default-token-cb22x                              kubernetes.io/service-account-token   3      96d
meu-ingress-controller-ingress-nginx-admission   Opaque                                3      96d
minhaapi-api-secret                              Opaque                                2      70d
minhaapi-mongodb                                 Opaque                                2      70d
minhaapi-mongodb-token-bk9zr                     kubernetes.io/service-account-token   3      70d
my-secret                                        Opaque                                1      56s
sh.helm.release.v1.minhaapi.v1                   helm.sh/release.v1                    1      83d
sh.helm.release.v1.minhaapi.v10                  helm.sh/release.v1                    1      68d
sh.helm.release.v1.minhaapi.v2                   helm.sh/release.v1                    1      75d
sh.helm.release.v1.minhaapi.v3                   helm.sh/release.v1                    1      75d
sh.helm.release.v1.minhaapi.v4                   helm.sh/release.v1                    1      73d
sh.helm.release.v1.minhaapi.v5                   helm.sh/release.v1                    1      73d
sh.helm.release.v1.minhaapi.v6                   helm.sh/release.v1                    1      70d
sh.helm.release.v1.minhaapi.v7                   helm.sh/release.v1                    1      68d
sh.helm.release.v1.minhaapi.v8                   helm.sh/release.v1                    1      68d
sh.helm.release.v1.minhaapi.v9                   helm.sh/release.v1                    1      68d
fernando@debian10x64:~$
~~~~




- Detalhando a Secret:

kubectl describe secret my-secret

~~~~bash
fernando@debian10x64:~$ kubectl describe secret my-secret
Name:         my-secret
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
key1:  11 bytes
fernando@debian10x64:~$
~~~~






kubectl get secret my-secret -o yaml

~~~~bash
fernando@debian10x64:~$ kubectl get secret my-secret -o yaml
apiVersion: v1
data:
  key1: c3VwZXJzZWNyZXQ=
kind: Secret
metadata:
  creationTimestamp: "2023-04-07T17:57:41Z"
  name: my-secret
  namespace: default
  resourceVersion: "132333"
  uid: e02e2b0b-4be6-4f1b-9f42-2e6e21692787
type: Opaque
fernando@debian10x64:~$
~~~~




- Decodificando a Secret usando o Base64 decode:

cat | echo -n "c3VwZXJzZWNyZXQ=" | base64 --decode

~~~~bash
fernando@debian10x64:~$ cat | echo -n "c3VwZXJzZWNyZXQ=" | base64 --decode
supersecret
fernando@debian10x64:~$
~~~~








- Para verificar onde a Se

Verifying that data is encrypted

Data is encrypted when written to etcd. After restarting your kube-apiserver, any newly created or updated Secret or other resource types configured in EncryptionConfiguration should be encrypted when stored. To check this, you can use the etcdctl command line program to retrieve the contents of your secret data.

    Create a new Secret called secret1 in the default namespace:

    kubectl create secret generic secret1 -n default --from-literal=mykey=mydata

    Using the etcdctl command line, read that Secret out of etcd:

    ETCDCTL_API=3 etcdctl get /registry/secrets/default/secret1 [...] | hexdump -C

    where [...] must be the additional arguments for connecting to the etcd server.

    For example:

    ETCDCTL_API=3 etcdctl \
       --cacert=/etc/kubernetes/pki/etcd/ca.crt   \
       --cert=/etc/kubernetes/pki/etcd/server.crt \
       --key=/etc/kubernetes/pki/etcd/server.key  \
       get /registry/secrets/default/secret1 | hexdump -C

    The output is similar to this (abbreviated):

    00000000  2f 72 65 67 69 73 74 72  79 2f 73 65 63 72 65 74  |/registry/secret|
    00000010  73 2f 64 65 66 61 75 6c  74 2f 73 65 63 72 65 74  |s/default/secret|
    00000020  31 0a 6b 38 73 3a 65 6e  63 3a 61 65 73 63 62 63  |1.k8s:enc:aescbc|
    00000030  3a 76 31 3a 6b 65 79 31  3a c7 6c e7 d3 09 bc 06  |:v1:key1:.l.....|
    00000040  25 51 91 e4 e0 6c e5 b1  4d 7a 8b 3d b9 c2 7c 6e  |%Q...l..Mz.=..|n|
    00000050  b4 79 df 05 28 ae 0d 8e  5f 35 13 2c c0 18 99 3e  |.y..(..._5.,...>|
    [...]
    00000110  23 3a 0d fc 28 ca 48 2d  6b 2d 46 cc 72 0b 70 4c  |#:..(.H-k-F.r.pL|
    00000120  a5 fc 35 43 12 4e 60 ef  bf 6f fe cf df 0b ad 1f  |..5C.N`..o......|
    00000130  82 c4 88 53 02 da 3e 66  ff 0a                    |...S..>f..|
    0000013a

    Verify the stored Secret is prefixed with k8s:enc:aescbc:v1: which indicates the aescbc provider has encrypted the resulting data. Confirm that the key name shown in etcd matches the key name specified in the EncryptionConfiguration mentioned above. In this example, you can see that the encryption key named key1 is used in etcd and in EncryptionConfiguration.

    Verify the Secret is correctly decrypted when retrieved via the API:

    kubectl get secret secret1 -n default -o yaml

    The output should contain mykey: bXlkYXRh, with contents of mydata encoded, check decoding a Secret to completely decode the Secret.







- Instalando o etcdctl

~~~~bash
fernando@debian10x64:~$ etcdctl
-bash: etcdctl: command not found
fernando@debian10x64:~$
~~~~



- Instalando: 

sudo apt-get install etcd-client




- Validando

~~~~bash

fernando@debian10x64:~$ etcdctl
NAME:
   etcdctl - A simple command line client for etcd.

WARNING:
   Environment variable ETCDCTL_API is not set; defaults to etcdctl v2.
   Set environment variable ETCDCTL_API=3 to use v3 API or ETCDCTL_API=2 to use v2 API.

USAGE:
   etcdctl [global options] command [command options] [arguments...]

VERSION:
   3.2.26

COMMANDS:
     backup          backup an etcd directory
     cluster-health  check the health of the etcd cluster
     mk              make a new key with a given value
     mkdir           make a new directory
     rm              remove a key or a directory
     rmdir           removes the key if it is an empty directory or a key-value pair
     get             retrieve the value of a key
     ls              retrieve a directory
     set             set the value of a key
     setdir          create a new directory or update an existing directory TTL
     update          update an existing key with a given value
     updatedir       update an existing directory
     watch           watch a key for changes
     exec-watch      watch a key for changes and exec an executable
     member          member add, remove and list subcommands
     user            user add, grant and revoke subcommands
     role            role add, grant and revoke subcommands
     auth            overall auth controls
     help, h         Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --debug                          output cURL commands which can be used to reproduce the request
   --no-sync                        don't synchronize cluster information before sending request
   --output simple, -o simple       output response in the given format (simple, `extended` or `json`) (default: "simple")
   --discovery-srv value, -D value  domain name to query for SRV records describing cluster endpoints
   --insecure-discovery             accept insecure SRV records describing cluster endpoints
   --peers value, -C value          DEPRECATED - "--endpoints" should be used instead
   --endpoint value                 DEPRECATED - "--endpoints" should be used instead
   --endpoints value                a comma-delimited list of machine addresses in the cluster (default: "http://127.0.0.1:2379,http://127.0.0.1:4001")
   --cert-file value                identify HTTPS client using this SSL certificate file
   --key-file value                 identify HTTPS client using this SSL key file
   --ca-file value                  verify certificates of HTTPS-enabled servers using this CA bundle
   --username value, -u value       provide username[:password] and prompt if password is not supplied.
   --timeout value                  connection timeout per request (default: 2s)
   --total-timeout value            timeout for the command execution (except watch) (default: 5s)
   --help, -h                       show help
   --version, -v                    print the version
fernando@debian10x64:~$

~~~~








- A instalação acima foi na VM do Debian, precisamos ir no Pod do etcd.

- Verificando o nome do Pod do etcd:

~~~~bash

fernando@debian10x64:~$ kubectl get pods -A
NAMESPACE       NAME                                                              READY   STATUS    RESTARTS       AGE
default         event-simulator-pod                                               1/1     Running   10 (9d ago)    58d
default         minhaapi-api-deployment-6586d4f7bc-6vcsx                          1/1     Running   14 (9d ago)    68d
default         minhaapi-mongodb-6c98c75fcc-lnq5l                                 1/1     Running   17 (9d ago)    68d
default         myapp-deployment-5c7c75f4d8-h4sn8                                 1/1     Running   9 (9d ago)     55d
default         myapp-deployment-5c7c75f4d8-lt7j4                                 1/1     Running   9 (9d ago)     55d
default         myapp-deployment-5c7c75f4d8-nzsph                                 1/1     Running   9 (9d ago)     55d
default         nginx                                                             1/1     Running   13 (9d ago)    66d
kube-system     coredns-78fcd69978-5xcpp                                          1/1     Running   33 (9d ago)    96d
kube-system     etcd-minikube                                                     1/1     Running   46 (9d ago)    96d
kube-system     kube-apiserver-minikube                                           1/1     Running   46 (9d ago)    96d
kube-system     kube-controller-manager-minikube                                  1/1     Running   50 (50m ago)   96d
kube-system     kube-proxy-5pc9k                                                  1/1     Running   33 (9d ago)    96d
kube-system     kube-scheduler-minikube                                           1/1     Running   42 (9d ago)    96d
kube-system     metrics-server-77c99ccb96-pnnwl                                   1/1     Running   14 (48m ago)   61d
kube-system     my-scheduler-6c595b886d-87dms                                     1/1     Running   13 (9d ago)    66d
kube-system     storage-provisioner                                               1/1     Running   65 (48m ago)   96d
nginx-ingress   meu-ingress-controller-ingress-nginx-controller-85685788f82hp89   1/1     Running   35 (9d ago)    90d
nginx-ingress   meu-ingress-controller-ingress-nginx-controller-85685788f8xpg5v   1/1     Running   35 (9d ago)    90d
fernando@debian10x64:~$

~~~~


- Acessar o Pod:
 kubectl exec -ti etcd-minikube -n kube-system -- sh



- Validando existência do etcdctl dentro do Pod:

~~~~bash
sh-5.0#
sh-5.0# ps -ef
sh: ps: command not found
sh-5.0#
sh-5.0#
sh-5.0#
sh-5.0#
sh-5.0# etcdctl
NAME:
        etcdctl - A simple command line client for etcd3.

USAGE:
        etcdctl [flags]

VERSION:
        3.5.0

API VERSION:
        3.5

COMMANDS:
        alarm disarm            Disarms all alarms
        alarm list              Lists all alarms
[....................................................................................................]
        user revoke-role        Revokes a role from a user
        version                 Prints the version of etcdctl
        watch                   Watches events stream on keys or prefixes

OPTIONS:
      --cacert=""                               verify certificates of TLS-enabled secure servers using this CA bundle
      --cert=""                                 identify secure client using this TLS certificate file
      --command-timeout=5s                      timeout for short running command (excluding dial timeout)
      --debug[=false]                           enable client-side debug logging
[....................................................................................................]
  -w, --write-out="simple"                      set the output format (fields, json, protobuf, simple, table)

sh-5.0#
~~~~










my-secret


ETCDCTL_API=3 etcdctl \
   --cacert=/etc/kubernetes/pki/etcd/ca.crt   \
   --cert=/etc/kubernetes/pki/etcd/server.crt \
   --key=/etc/kubernetes/pki/etcd/server.key  \
   get /registry/secrets/default/my-secret | hexdump -C





sh-5.0# ETCDCTL_API=3 etcdctl \
>    --cacert=/etc/kubernetes/pki/etcd/ca.crt   \
>    --cert=/etc/kubernetes/pki/etcd/server.crt \
>    --key=/etc/kubernetes/pki/etcd/server.key  \
>    get /registry/secrets/default/my-secret
Error: open /etc/kubernetes/pki/etcd/server.crt: no such file or directory
sh-5.0#




~~~~bash
sh-5.0# cd /var/lib/minikube/certs/etcd/
ca.crt                  healthcheck-client.crt  peer.crt                server.crt
ca.key                  healthcheck-client.key  peer.key                server.key
sh-5.0# cd /var/lib/minikube/certs/etcd/
~~~~


my-secret

~~~~bash
ETCDCTL_API=3 etcdctl \
   --cacert=/var/lib/minikube/certs/etcd/ca.crt   \
   --cert=/var/lib/minikube/certs/etcd/server.crt \
   --key=/var/lib/minikube/certs/etcd/server.key  \
   get /registry/secrets/default/my-secret | hexdump -C
~~~~


- Rodando sem o hexdump:

~~~~bash
sh-5.0# ETCDCTL_API=3 etcdctl \
>    --cacert=/var/lib/minikube/certs/etcd/ca.crt   \
>    --cert=/var/lib/minikube/certs/etcd/server.crt \
>    --key=/var/lib/minikube/certs/etcd/server.key  \
>    get /registry/secrets/default/my-secret
/registry/secrets/default/my-secret
k8s

v1Secret▒
▒
        my-secretdefault"*$e02e2b0b-4be6-4f1b-9f42-2e6e216927872▒▒▒z▒a
kubectl-createUpdatev▒▒▒FieldsV1:-
+{"f:data":{".":{},"f:key1":{}},"f:type":{}}B
key1
    supersecretOpaque"
sh-5.0#
~~~~




- A palavra "supersecretOpaque" indica que ela está oculta.



- Rodando com o hexdump:

~~~~bash
sh-5.0# ETCDCTL_API=3 etcdctl \
>    --cacert=/var/lib/minikube/certs/etcd/ca.crt   \
>    --cert=/var/lib/minikube/certs/etcd/server.crt \
>    --key=/var/lib/minikube/certs/etcd/server.key  \
>    get /registry/secrets/default/my-secret | hexdump -C
sh: hexdump: command not found
sh-5.0# apk add busybox-extras
sh: apk: command not found
sh-5.0# apt install hex
sh: apt: command not found
sh-5.0#
~~~~

- Não tem o hexdump no etcd do minikube
- Não tem o hexdump no etcd do minikube
- Não tem o hexdump no etcd do minikube
- Não tem o hexdump no etcd do minikube
- Não tem o hexdump no etcd do minikube
- Não tem o hexdump no etcd do minikube
- Não tem o hexdump no etcd do minikube
- Não tem o hexdump no etcd do minikube
- Não tem o hexdump no etcd do minikube








HEXDUMP(1)                    User Commands                   HEXDUMP(1)

NAME         top

       hexdump - display file contents in hexadecimal, decimal, octal,
       or ascii

       hexdump options file ...

       hd options file ...

DESCRIPTION         top

       The hexdump utility is a filter which displays the specified
       files, or standard input if no files are specified, in a
       user-specified format.






- Como o etcd do minikube não tem o hexdump, segue um exemplo de como seria o uso:

The output is similar to this (abbreviated):
~~~~bash
00000000  2f 72 65 67 69 73 74 72  79 2f 73 65 63 72 65 74  |/registry/secret|
00000010  73 2f 64 65 66 61 75 6c  74 2f 73 65 63 72 65 74  |s/default/secret|
00000020  31 0a 6b 38 73 3a 65 6e  63 3a 61 65 73 63 62 63  |1.k8s:enc:aescbc|
00000030  3a 76 31 3a 6b 65 79 31  3a c7 6c e7 d3 09 bc 06  |:v1:supersecret:.l.....|
00000040  25 51 91 e4 e0 6c e5 b1  4d 7a 8b 3d b9 c2 7c 6e  |%Q...l..Mz.=..|n|
00000050  b4 79 df 05 28 ae 0d 8e  5f 35 13 2c c0 18 99 3e  |.y..(..._5.,...>|
[...]
00000110  23 3a 0d fc 28 ca 48 2d  6b 2d 46 cc 72 0b 70 4c  |#:..(.H-k-F.r.pL|
00000120  a5 fc 35 43 12 4e 60 ef  bf 6f fe cf df 0b ad 1f  |..5C.N`..o......|
00000130  82 c4 88 53 02 da 3e 66  ff 0a                    |...S..>f..|
0000013a
~~~~



- É possível verifiar a chave decodificada:
supersecret






















### Conectando via minikube ssh

Como utilizar o hexdump no etcd do Minikube, já que o hexdump não vem instalado?

O hexdump é uma ferramenta útil para visualizar o conteúdo de arquivos binários em formato hexadecimal. No entanto, não está incluído por padrão no Minikube ou no etcd.

Para instalar o hexdump no Minikube, você pode seguir estas etapas:

    Acesse o shell do seu cluster Minikube executando o comando:

minikube ssh

    Atualize os repositórios do apt-get:

sql

sudo apt-get update

    Instale o pacote bsdmainutils, que inclui o hexdump:

arduino

sudo apt-get install bsdmainutils

    Verifique se o hexdump está instalado executando o comando:

css

hexdump --version

Com o hexdump instalado, você pode usá-lo para visualizar o conteúdo de arquivos binários no etcd. Por exemplo, para visualizar o conteúdo do diretório padrão do etcd (/var/lib/etcd), você pode executar o seguinte comando:

bash

sudo hexdump -C /var/lib/etcd/*

Isso exibirá o conteúdo de cada arquivo no diretório /var/lib/etcd em formato hexadecimal.
fernandomj90@gmail.com
na versão 1.23 do minikube onde fica o diretório do etcd?

Na versão 1.23 do Minikube, o diretório padrão do etcd é /data/etcd.

Para acessar o diretório do etcd, você pode seguir estas etapas:

    Acesse o shell do seu cluster Minikube executando o comando:

minikube ssh

    Acesse o diretório do etcd executando o comando:

bash

cd /data/etcd

    Você pode verificar o conteúdo do diretório executando o comando:

bash

ls -la

Isso listará todos os arquivos e diretórios no diretório do etcd.

A partir daqui, você pode usar ferramentas como o hexdump para visualizar o conteúdo dos arquivos binários no diretório do etcd. Por exemplo, para visualizar o conteúdo do arquivo member/snap/db em formato hexadecimal, você pode executar o seguinte comando:

bash

sudo hexdump -C member/snap/db

Isso exibirá o conteúdo do arquivo db em formato hexadecimal. Lembre-se de que você precisará ter o hexdump instalado no seu cluster Minikube para usar essa ferramenta.











sudo hexdump -C member/snap/db

~~~~bash
root@minikube:/var/lib/minikube/etcd/member# ls -lhasp
total 16K
4.0K drwx------ 4 root root 4.0K Apr  7 17:54 ./
4.0K drwx------ 3 root root 4.0K Apr  7 17:53 ../
4.0K drwx------ 2 root root 4.0K Apr  7 19:44 snap/
4.0K drwx------ 2 root root 4.0K Apr  7 17:54 wal/
root@minikube:/var/lib/minikube/etcd/member# pwd
/var/lib/minikube/etcd/member
root@minikube:/var/lib/minikube/etcd/member#
~~~~


sudo hexdump -C /var/lib/minikube/etcd/member/snap/db





~~~~bash
ETCDCTL_API=3 etcdctl \
>    --cacert=/var/lib/minikube/certs/etcd/ca.crt   \
>    --cert=/var/lib/minikube/certs/etcd/server.crt \
>    --key=/var/lib/minikube/certs/etcd/server.key  \
>    get /registry/secrets/default/my-secret | hexdump -C
~~~~










como instalar o etcdctl no minikube?

O etcdctl é a ferramenta de linha de comando para interagir com o etcd. Para instalar o etcdctl no Minikube, você pode seguir estas etapas:

    Acesse o shell do seu cluster Minikube executando o comando:

minikube ssh

    Baixe a versão mais recente do etcdctl usando o comando curl:

arduino

curl -L https://github.com/etcd-io/etcd/releases/latest/download/etcd-v3.6.0-linux-amd64.tar.gz -o etcd-v3.6.0-linux-amd64.tar.gz

Certifique-se de atualizar o URL com a versão mais recente do etcdctl disponível. Verifique o site oficial do etcd para obter a versão mais recente.

    Extraia o arquivo etcdctl do arquivo .tar.gz:

tar xzvf etcd-v3.6.0-linux-amd64.tar.gz

    Mova o arquivo etcdctl para o diretório /usr/local/bin/:

bash

sudo mv etcd-v3.6.0-linux-amd64/etcdctl /usr/local/bin/

    Verifique se o etcdctl foi instalado corretamente, executando o comando:

etcdctl version

Isso exibirá a versão do etcdctl instalada no Minikube.

Com o etcdctl instalado, você pode usá-lo para interagir com o etcd no seu cluster Minikube. Por exemplo, para listar as chaves armazenadas no etcd, você pode executar o seguinte comando:

css

etcdctl get / --prefix --keys-only

Isso listará todas as chaves no etcd. Lembre-se de que você precisará ter permissão adequada para executar esses comandos no etcd.









- Instalar o etcd client:
apt-get install etcd-client


~~~~bash
root@minikube:~# ls -lhasp /var/lib/minikube/certs/etcd/
total 40K
4.0K drwxr-xr-x 2 root root 4.0K Nov  1 01:45 ./
4.0K drwxr-xr-x 3 root root 4.0K Nov  1 01:45 ../
4.0K -rw-r--r-- 1 root root 1.1K Nov  1 01:45 ca.crt
4.0K -rw------- 1 root root 1.7K Nov  1 01:45 ca.key
4.0K -rw-r--r-- 1 root root 1.2K Nov  1 01:45 healthcheck-client.crt
4.0K -rw------- 1 root root 1.7K Nov  1 01:45 healthcheck-client.key
4.0K -rw-r--r-- 1 root root 1.2K Nov  1 01:45 peer.crt
4.0K -rw------- 1 root root 1.7K Nov  1 01:45 peer.key
4.0K -rw-r--r-- 1 root root 1.2K Nov  1 01:45 server.crt
4.0K -rw------- 1 root root 1.7K Nov  1 01:45 server.key
root@minikube:~#
~~~~bash





ETCDCTL_API=3 etcdctl \
   --cacert=/var/lib/minikube/certs/etcd/ca.crt   \
   --cert=/var/lib/minikube/certs/etcd/server.crt \
   --key=/var/lib/minikube/certs/etcd/server.key  \
   get /registry/secrets/default/my-secret | hexdump -C


~~~~bash
root@minikube:~# ETCDCTL_API=3 etcdctl \
>    --cacert=/var/lib/minikube/certs/etcd/ca.crt   \
>    --cert=/var/lib/minikube/certs/etcd/server.crt \
>    --key=/var/lib/minikube/certs/etcd/server.key  \
>    get /registry/secrets/default/my-secret | hexdump -C
00000000  2f 72 65 67 69 73 74 72  79 2f 73 65 63 72 65 74  |/registry/secret|
00000010  73 2f 64 65 66 61 75 6c  74 2f 6d 79 2d 73 65 63  |s/default/my-sec|
00000020  72 65 74 0a 6b 38 73 00  0a 0c 0a 02 76 31 12 06  |ret.k8s.....v1..|
00000030  53 65 63 72 65 74 12 d2  01 0a b2 01 0a 09 6d 79  |Secret........my|
00000040  2d 73 65 63 72 65 74 12  00 1a 07 64 65 66 61 75  |-secret....defau|
00000050  6c 74 22 00 2a 24 65 30  32 65 32 62 30 62 2d 34  |lt".*$e02e2b0b-4|
00000060  62 65 36 2d 34 66 31 62  2d 39 66 34 32 2d 32 65  |be6-4f1b-9f42-2e|
00000070  36 65 32 31 36 39 32 37  38 37 32 00 38 00 42 08  |6e216927872.8.B.|
00000080  08 95 b3 c1 a1 06 10 00  7a 00 8a 01 61 0a 0e 6b  |........z...a..k|
00000090  75 62 65 63 74 6c 2d 63  72 65 61 74 65 12 06 55  |ubectl-create..U|
000000a0  70 64 61 74 65 1a 02 76  31 22 08 08 95 b3 c1 a1  |pdate..v1"......|
000000b0  06 10 00 32 08 46 69 65  6c 64 73 56 31 3a 2d 0a  |...2.FieldsV1:-.|
000000c0  2b 7b 22 66 3a 64 61 74  61 22 3a 7b 22 2e 22 3a  |+{"f:data":{".":|
000000d0  7b 7d 2c 22 66 3a 6b 65  79 31 22 3a 7b 7d 7d 2c  |{},"f:key1":{}},|
000000e0  22 66 3a 74 79 70 65 22  3a 7b 7d 7d 42 00 12 13  |"f:type":{}}B...|
000000f0  0a 04 6b 65 79 31 12 0b  73 75 70 65 72 73 65 63  |..key1..supersec|
00000100  72 65 74 1a 06 4f 70 61  71 75 65 1a 00 22 00 0a  |ret..Opaque.."..|
00000110
root@minikube:~#
~~~~



- Foi possível trazer a "supersecret", de dentro do Cluster Minikube, via comando "minikube ssh" e o processo acima, que foi documentado no markdown abaixo:
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao5-Application-Lifecycle-Management/108-Usando-Hexdump-no-ETCD-do-Minikube.md






- Understanding the encryption at rest configuration

~~~~YAML
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
      - configmaps
      - pandas.awesome.bears.example
    providers:
      - identity: {}
      - aesgcm:
          keys:
            - name: key1
              secret: c2VjcmV0IGlzIHNlY3VyZQ==
            - name: key2
              secret: dGhpcyBpcyBwYXNzd29yZA==
      - aescbc:
          keys:
            - name: key1
              secret: c2VjcmV0IGlzIHNlY3VyZQ==
            - name: key2
              secret: dGhpcyBpcyBwYXNzd29yZA==
      - secretbox:
          keys:
            - name: key1
              secret: YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXoxMjM0NTY=
~~~~




# PENDENTE

- Continua em:
06:44

- Necessário fazer procedimento sobre "--encryption-provider-config" do kube-apiserver:
https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/


# RESUMO

- Foi possível obter o valor da Secret via etcdctl no Minikube, seguindo o tutorial abaixo:
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao5-Application-Lifecycle-Management/108-Usando-Hexdump-no-ETCD-do-Minikube.md










# Dia 14/04/2023

[07:00]

<https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/>

Configuration and determining whether encryption at rest is already enabled
The kube-apiserver process accepts an argument --encryption-provider-config that controls how API data is encrypted in etcd. The configuration is provided as an API named EncryptionConfiguration. --encryption-provider-config-automatic-reload boolean argument determines if the file set by --encryption-provider-config should be automatically reloaded if the disk contents change. This enables key rotation without API server restarts. An example configuration is provided below.


- Verificando se o kube-apiserver já utiliza o argumento "--encryption-provider-config":

minikube ssh
sudo su
ps -aux | grep kube-api
ps -aux | grep kube-api | grep "encryption-provider-config"

~~~~bash

root@minikube:/home/docker#
root@minikube:/home/docker# ps -aux | grep kube-api
root        1724 12.3  3.3 1172676 336696 ?      Ssl  23:39   0:40 kube-apiserver --advertise-address=192.168.49.2 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/var/lib/minikube/certs/ca.crt --enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota --enable-bootstrap-token-auth=true --etcd-cafile=/var/lib/minikube/certs/etcd/ca.crt --etcd-certfile=/var/lib/minikube/certs/apiserver-etcd-client.crt --etcd-keyfile=/var/lib/minikube/certs/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/var/lib/minikube/certs/apiserver-kubelet-client.crt --kubelet-client-key=/var/lib/minikube/certs/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/var/lib/minikube/certs/front-proxy-client.crt --proxy-client-key-file=/var/lib/minikube/certs/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=8443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/var/lib/minikube/certs/sa.pub --service-account-signing-key-file=/var/lib/minikube/certs/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/var/lib/minikube/certs/apiserver.crt --tls-private-key-file=/var/lib/minikube/certs/apiserver.key
root        8026  0.0  0.0   3440   660 pts/1    S+   23:44   0:00 grep --color=auto kube-api
root@minikube:/home/docker#


root@minikube:/home/docker# ps -aux | grep kube-api | grep "encryption-provider-config"
root@minikube:/home/docker#


~~~~


- Como foi possível verificar, o argumento "--encryption-provider-config" não está configurado no Kube-API-Server




- Através do manifesto, também é possível verificar se o argumento "--encryption-provider-config" não está configurado no Kube-API-Server


root@minikube:/home/docker# ls /etc/kubernetes/manifests/
etcd.yaml  kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml
root@minikube:/home/docker# date
Fri Apr 14 23:53:31 UTC 2023
root@minikube:/home/docker#


~~~~YAML

root@minikube:/home/docker#
root@minikube:/home/docker# ls /etc/kubernetes/manifests/kube-apiserver.yaml
/etc/kubernetes/manifests/kube-apiserver.yaml
root@minikube:/home/docker# cat /etc/kubernetes/manifests/kube-apiserver.yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 192.168.49.2:8443
  creationTimestamp: null
  labels:
    component: kube-apiserver
    tier: control-plane
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
    - --advertise-address=192.168.49.2
    - --allow-privileged=true
    - --authorization-mode=Node,RBAC
    - --client-ca-file=/var/lib/minikube/certs/ca.crt
    - --enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota
    - --enable-bootstrap-token-auth=true
    - --etcd-cafile=/var/lib/minikube/certs/etcd/ca.crt
    - --etcd-certfile=/var/lib/minikube/certs/apiserver-etcd-client.crt
    - --etcd-keyfile=/var/lib/minikube/certs/apiserver-etcd-client.key
    - --etcd-servers=https://127.0.0.1:2379
    - --kubelet-client-certificate=/var/lib/minikube/certs/apiserver-kubelet-client.crt
    - --kubelet-client-key=/var/lib/minikube/certs/apiserver-kubelet-client.key
    - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
    - --proxy-client-cert-file=/var/lib/minikube/certs/front-proxy-client.crt
    - --proxy-client-key-file=/var/lib/minikube/certs/front-proxy-client.key
    - --requestheader-allowed-names=front-proxy-client
    - --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt
    - --requestheader-extra-headers-prefix=X-Remote-Extra-
    - --requestheader-group-headers=X-Remote-Group
    - --requestheader-username-headers=X-Remote-User
    - --secure-port=8443
    - --service-account-issuer=https://kubernetes.default.svc.cluster.local
    - --service-account-key-file=/var/lib/minikube/certs/sa.pub
    - --service-account-signing-key-file=/var/lib/minikube/certs/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --tls-cert-file=/var/lib/minikube/certs/apiserver.crt
    - --tls-private-key-file=/var/lib/minikube/certs/apiserver.key
    image: k8s.gcr.io/kube-apiserver:v1.22.2
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 192.168.49.2
        path: /livez
        port: 8443
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-apiserver
    readinessProbe:
      failureThreshold: 3
      httpGet:
        host: 192.168.49.2
        path: /readyz
        port: 8443
        scheme: HTTPS
      periodSeconds: 1
      timeoutSeconds: 15
    resources:
      requests:
        cpu: 250m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 192.168.49.2
        path: /livez
        port: 8443
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /etc/ssl/certs
      name: ca-certs
      readOnly: true
    - mountPath: /etc/ca-certificates
      name: etc-ca-certificates
      readOnly: true
    - mountPath: /var/lib/minikube/certs
      name: k8s-certs
      readOnly: true
    - mountPath: /usr/local/share/ca-certificates
      name: usr-local-share-ca-certificates
      readOnly: true
    - mountPath: /usr/share/ca-certificates
      name: usr-share-ca-certificates
      readOnly: true
  hostNetwork: true
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/ssl/certs
      type: DirectoryOrCreate
    name: ca-certs
  - hostPath:
      path: /etc/ca-certificates
      type: DirectoryOrCreate
    name: etc-ca-certificates
  - hostPath:
      path: /var/lib/minikube/certs
      type: DirectoryOrCreate
    name: k8s-certs
  - hostPath:
      path: /usr/local/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-local-share-ca-certificates
  - hostPath:
      path: /usr/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-share-ca-certificates
status: {}
root@minikube:/home/docker#
~~~~










## ETAPAS NECESSÁRIAS PARA CONFIGURAR O "Encrypting Secret Data at Rest"

1. Criar o manifesto kind: EncryptionConfiguration
2. Passar este conf como argumento/opção.






- É possível definir quais tipos de recursos iremos encriptar

apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
      - configmaps
      - pandas.awesome.bears.example



- A ordem é importante.
- Quando o identity está no inicio, não ocorre encriptação!
  - identity: {}



- CONTINUA EM
10:52



## Encrypting your data

Create a new encryption config file:

~~~~YAML
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
      - configmaps
      - pandas.awesome.bears.example
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: <BASE 64 ENCODED SECRET>
      - identity: {}
~~~~


- Para que ocorra a encriptação, no caso do manifesto do EncryptionConfiguration, o "aescbc" precisa ser passado para o começo da listagem de providers, pois o "identity: {}" não efetua encriptação.








To create a new Secret, perform the following steps:

    Generate a 32-byte random key and base64 encode it. If you're on Linux or macOS, run the following command:

    head -c 32 /dev/urandom | base64

    Place that value in the secret field of the EncryptionConfiguration struct.

    Set the --encryption-provider-config flag on the kube-apiserver to point to the location of the config file.

    You will need to mount the new encryption config file to the kube-apiserver static pod. Here is an example on how to do that:
        Save the new encryption config file to /etc/kubernetes/enc/enc.yaml on the control-plane node.
        Edit the manifest for the kube-apiserver static pod: /etc/kubernetes/manifests/kube-apiserver.yaml similarly to this:

~~~~yaml
    apiVersion: v1
    kind: Pod
    metadata:
      annotations:
        kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 10.10.30.4:6443
      creationTimestamp: null
      labels:
        component: kube-apiserver
        tier: control-plane
      name: kube-apiserver
      namespace: kube-system
    spec:
      containers:
      - command:
        - kube-apiserver
        ...
        - --encryption-provider-config=/etc/kubernetes/enc/enc.yaml  # <-- add this line
        volumeMounts:
        ...
        - name: enc                           # <-- add this line
          mountPath: /etc/kubernetes/enc      # <-- add this line
          readonly: true                      # <-- add this line
        ...
      volumes:
      ...
      - name: enc                             # <-- add this line
        hostPath:                             # <-- add this line
          path: /etc/kubernetes/enc           # <-- add this line
          type: DirectoryOrCreate             # <-- add this line
      ...
~~~~

    Restart your API server.





- Entrar no Node do Minikube:
minikube ssh

- Gerar o valor randomico e encodificar ele com base64:
head -c 32 /dev/urandom | base64

root@minikube:/home/docker# head -c 32 /dev/urandom | base64
K4NniAyqOMm6To9hEuxDEKl8O9+IMk1IqPbcFaee9Ag=
root@minikube:/home/docker#


- Colocar o valor no manifesto do EncryptionConfiguration
Secao5-Application-Lifecycle-Management/108-EncryptionConfiguration-with-encryption_editado.yaml
ficando assim

~~~~YAML
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: K4NniAyqOMm6To9hEuxDEKl8O9+IMk1IqPbcFaee9Ag=
      - identity: {}
~~~~



- Criar o diretório onde vai ficar o manifesto do EncryptionConfiguration:
mkdir /etc/kubernetes/enc/

- Criar o manifesto:
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao5-Application-Lifecycle-Management/108-EncryptionConfiguration-with-encryption_editado.yaml
vi /etc/kubernetes/enc/enc.yaml



- Criar manifesto para o kube-apiserver:

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao5-Application-Lifecycle-Management/108-kube-apiserver.yaml

vi /etc/kubernetes/manifests/kube-apiserver.yaml


- --encryption-provider-config=/etc/kubernetes/enc/enc.yaml

    volumeMounts:
    - mountPath: /etc/kubernetes/enc      # <-- add this line
      name: enc                           # <-- add this line
      readonly: true                      # <-- add this line


  volumes:
  - hostPath:                             # <-- add this line
      path: /etc/kubernetes/enc           # <-- add this line
      type: DirectoryOrCreate             # <-- add this line
    name: enc                             # <-- add this line


-




- Após editado o manifesto o Pod do kube-apiserver é ajustado sozinho:

usando o crictl, é possível ver o container dentro do minikube

~~~~bash
fernando@debian10x64:~$ kubectl get pods -A | grep apiserver
kube-system     kube-apiserver-minikube                                           1/1     Running   0              82s
fernando@debian10x64:~$ date
Sat 15 Apr 2023 12:39:55 AM -03
fernando@debian10x64:~$


root@minikube:/home/docker#
root@minikube:/home/docker# crictl ps | head
CONTAINER           IMAGE                                                                                                       CREATED             STATE               NAME                      ATTEMPT             POD ID
a515a43162ae8       6e38f40d628db                                                                                               2 minutes ago       Running             storage-provisioner       71                  160934d6279f1
8749f0cec693f       e64579b7d8862                                                                                               2 minutes ago       Running             kube-apiserver            0                   f1a821ffd559a
a89e8717673b3       kodekloud/event-simulator@sha256:1e3e9c72136bbc76c96dd98f29c04f298c3ae241c7d44e2bf70bcc209b030bf9           18 minutes ago      Running             event-simulator           12                  e62e52b174a10
3f3d27b97a33b       nginx@sha256:63b44e8ddb83d5dd8020327c1f40436e37a6fffd3ef2498a6204df23be6e7e94                               18 minutes ago      Running             nginx                     15                  fcf8e1fac3ade
b5429d7732260       fabricioveronez/pedelogo-catalogo@sha256:82c6460c89b2e3b98f013a34dc720391a8c840c5ed4a0c8dbeaf14c648afc331   18 minutes ago      Running             api                       16                  34f78f4fd6e0d
249df364c7bfd       e3e043d3ed2f7                                                                                               18 minutes ago      Running             nginx-container           11                  cf5b69555007c
b374308e6998a       e3e043d3ed2f7                                                                                               18 minutes ago      Running             nginx-container           11                  09114b727bad2
b96353090af7d       8d147537fb7d1                                                                                               18 minutes ago      Running             coredns                   35                  e594caa3bcd25
396d180f39931       17c225a562d97                                                                                               18 minutes ago      Running             metrics-server            16                  9727912cada2a
root@minikube:/home/docker#

~~~~






- Validando a configuração:

~~~~bash

root@minikube:/home/docker# ps -aux | grep apiserver | grep "encrypt"
root       14824 10.2  3.9 1172932 399000 ?      Ssl  03:38   0:23 kube-apiserver --advertise-address=192.168.49.2 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/var/lib/minikube/certs/ca.crt --enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota --enable-bootstrap-token-auth=true --etcd-cafile=/var/lib/minikube/certs/etcd/ca.crt --etcd-certfile=/var/lib/minikube/certs/apiserver-etcd-client.crt --etcd-keyfile=/var/lib/minikube/certs/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/var/lib/minikube/certs/apiserver-kubelet-client.crt --kubelet-client-key=/var/lib/minikube/certs/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/var/lib/minikube/certs/front-proxy-client.crt --proxy-client-key-file=/var/lib/minikube/certs/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=8443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/var/lib/minikube/certs/sa.pub --service-account-signing-key-file=/var/lib/minikube/certs/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/var/lib/minikube/certs/apiserver.crt --tls-private-key-file=/var/lib/minikube/certs/apiserver.key --encryption-provider-config=/etc/kubernetes/enc/enc.yaml
root@minikube:/home/docker#

~~~~









- Criando uma nova Secret:

kubectl create secret generic my-secret-2 --from-literal=key2=topsecret

~~~~bash
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl create secret generic my-secret-2 --from-literal=key2=topsecret
secret/my-secret-2 created
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get secret
NAME                                             TYPE                                  DATA   AGE
app-secret                                       Opaque                                3      39d
default-token-cb22x                              kubernetes.io/service-account-token   3      103d
meu-ingress-controller-ingress-nginx-admission   Opaque                                3      103d
minhaapi-api-secret                              Opaque                                2      78d
minhaapi-mongodb                                 Opaque                                2      78d
minhaapi-mongodb-token-bk9zr                     kubernetes.io/service-account-token   3      78d
my-secret                                        Opaque                                1      7d9h
my-secret-2                                      Opaque                                1      8s
sh.helm.release.v1.minhaapi.v1                   helm.sh/release.v1                    1      91d
sh.helm.release.v1.minhaapi.v10                  helm.sh/release.v1                    1      76d
sh.helm.release.v1.minhaapi.v2                   helm.sh/release.v1                    1      83d
sh.helm.release.v1.minhaapi.v3                   helm.sh/release.v1                    1      83d
sh.helm.release.v1.minhaapi.v4                   helm.sh/release.v1                    1      81d
sh.helm.release.v1.minhaapi.v5                   helm.sh/release.v1                    1      81d
sh.helm.release.v1.minhaapi.v6                   helm.sh/release.v1                    1      78d
sh.helm.release.v1.minhaapi.v7                   helm.sh/release.v1                    1      76d
sh.helm.release.v1.minhaapi.v8                   helm.sh/release.v1                    1      76d
sh.helm.release.v1.minhaapi.v9                   helm.sh/release.v1                    1      76d
fernando@debian10x64:~$
~~~~






- Verificando a antiga Secret, ela segue aparecendo sem encriptação:

~~~~bash
ETCDCTL_API=3 etcdctl \
   --cacert=/var/lib/minikube/certs/etcd/ca.crt   \
   --cert=/var/lib/minikube/certs/etcd/server.crt \
   --key=/var/lib/minikube/certs/etcd/server.key  \
   get /registry/secrets/default/my-secret | hexdump -C
~~~~


~~~~bash

root@minikube:/home/docker# ETCDCTL_API=3 etcdctl \
>    --cacert=/var/lib/minikube/certs/etcd/ca.crt   \
>    --cert=/var/lib/minikube/certs/etcd/server.crt \
>    --key=/var/lib/minikube/certs/etcd/server.key  \
>    get /registry/secrets/default/my-secret | hexdump -C
00000000  2f 72 65 67 69 73 74 72  79 2f 73 65 63 72 65 74  |/registry/secret|
00000010  73 2f 64 65 66 61 75 6c  74 2f 6d 79 2d 73 65 63  |s/default/my-sec|
00000020  72 65 74 0a 6b 38 73 00  0a 0c 0a 02 76 31 12 06  |ret.k8s.....v1..|
00000030  53 65 63 72 65 74 12 d2  01 0a b2 01 0a 09 6d 79  |Secret........my|
00000040  2d 73 65 63 72 65 74 12  00 1a 07 64 65 66 61 75  |-secret....defau|
00000050  6c 74 22 00 2a 24 65 30  32 65 32 62 30 62 2d 34  |lt".*$e02e2b0b-4|
00000060  62 65 36 2d 34 66 31 62  2d 39 66 34 32 2d 32 65  |be6-4f1b-9f42-2e|
00000070  36 65 32 31 36 39 32 37  38 37 32 00 38 00 42 08  |6e216927872.8.B.|
00000080  08 95 b3 c1 a1 06 10 00  7a 00 8a 01 61 0a 0e 6b  |........z...a..k|
00000090  75 62 65 63 74 6c 2d 63  72 65 61 74 65 12 06 55  |ubectl-create..U|
000000a0  70 64 61 74 65 1a 02 76  31 22 08 08 95 b3 c1 a1  |pdate..v1"......|
000000b0  06 10 00 32 08 46 69 65  6c 64 73 56 31 3a 2d 0a  |...2.FieldsV1:-.|
000000c0  2b 7b 22 66 3a 64 61 74  61 22 3a 7b 22 2e 22 3a  |+{"f:data":{".":|
000000d0  7b 7d 2c 22 66 3a 6b 65  79 31 22 3a 7b 7d 7d 2c  |{},"f:key1":{}},|
000000e0  22 66 3a 74 79 70 65 22  3a 7b 7d 7d 42 00 12 13  |"f:type":{}}B...|
000000f0  0a 04 6b 65 79 31 12 0b  73 75 70 65 72 73 65 63  |..key1..supersec|
00000100  72 65 74 1a 06 4f 70 61  71 75 65 1a 00 22 00 0a  |ret..Opaque.."..|
00000110
root@minikube:/home/docker#

~~~~





- Já a nova Secret, está encriptada, conforme o esperado:

~~~~bash
ETCDCTL_API=3 etcdctl \
   --cacert=/var/lib/minikube/certs/etcd/ca.crt   \
   --cert=/var/lib/minikube/certs/etcd/server.crt \
   --key=/var/lib/minikube/certs/etcd/server.key  \
   get /registry/secrets/default/my-secret-2 | hexdump -C
~~~~

~~~~bash

root@minikube:/home/docker# ETCDCTL_API=3 etcdctl \
>    --cacert=/var/lib/minikube/certs/etcd/ca.crt   \
>    --cert=/var/lib/minikube/certs/etcd/server.crt \
>    --key=/var/lib/minikube/certs/etcd/server.key  \
>    get /registry/secrets/default/my-secret-2 | hexdump -C
00000000  2f 72 65 67 69 73 74 72  79 2f 73 65 63 72 65 74  |/registry/secret|
00000010  73 2f 64 65 66 61 75 6c  74 2f 6d 79 2d 73 65 63  |s/default/my-sec|
00000020  72 65 74 2d 32 0a 6b 38  73 3a 65 6e 63 3a 61 65  |ret-2.k8s:enc:ae|
00000030  73 63 62 63 3a 76 31 3a  6b 65 79 31 3a f5 2c 0e  |scbc:v1:key1:.,.|
00000040  80 c7 b9 9e 1c cd ae 96  42 83 db 82 5c 49 36 6f  |........B...\I6o|
00000050  00 96 5f cc cc b8 f6 88  4c e1 61 74 57 c6 73 d4  |.._.....L.atW.s.|
00000060  66 73 67 a0 90 5b f7 ed  d4 aa 5f df c5 da 3e 66  |fsg..[...._...>f|
00000070  b8 94 50 c6 15 db dd b9  a3 da 05 ac d4 21 7a 9a  |..P..........!z.|
00000080  0f 92 28 43 ea 7e bd 6b  5b 61 0f ff 20 8e db 61  |..(C.~.k[a.. ..a|
00000090  8e 7f e3 95 63 1b 4b 96  ec 93 a9 c5 2c 96 97 9a  |....c.K.....,...|
000000a0  cd e3 9a fb e9 78 fa 0a  e4 f9 a7 0f f0 99 8f 61  |.....x.........a|
000000b0  97 a4 97 b7 9e 32 00 5a  47 09 c1 bb c2 48 65 3b  |.....2.ZG....He;|
000000c0  2d 9a b4 fd c7 48 5c 59  90 00 25 c2 1c fb 09 99  |-....H\Y..%.....|
000000d0  d2 64 c2 2e e9 ff 1d da  50 8f 2c 20 8d 75 db 2f  |.d......P., .u./|
000000e0  6b 52 51 69 43 d7 ec 78  e1 24 e5 00 97 ee ba d0  |kRQiC..x.$......|
000000f0  33 53 be 95 3f 2a 53 37  3d a6 92 0b e4 2a 46 6a  |3S..?*S7=....*Fj|
00000100  1d 9d cb d6 d6 af 0b 87  24 66 d9 c8 87 3e 41 85  |........$f...>A.|
00000110  a4 e3 99 0a 49 d7 a1 d8  f7 b7 26 54 8a f1 24 b9  |....I.....&T..$.|
00000120  da cf 86 c3 8a 72 54 fe  96 de 20 6d a9 e7 51 c0  |.....rT... m..Q.|
00000130  81 df f9 69 e5 7e ea 48  2a 92 7c 98 f6 0a        |...i.~.H*.|...|
0000013e
root@minikube:/home/docker#

~~~~




- O procedimento de "Encrypting Secret Data at Rest" só tem efeito para novos recursos.







## Ensure all Secrets are encrypted

Since Secrets are encrypted on write, performing an update on a Secret will encrypt that content.

kubectl get secrets --all-namespaces -o json | kubectl replace -f -


- Comando Efetua uma nova escrita em todas secrets, para elas terem o seu conteúdo encriptado, caso tenha sido ativado o  "Encrypting Secret Data at Rest".





- Efetuando teste

~~~~bash
fernando@debian10x64:~$ kubectl get secrets --all-namespaces -o json | kubectl replace -f -
secret/app-secret replaced
secret/default-token-cb22x replaced
secret/meu-ingress-controller-ingress-nginx-admission replaced
secret/minhaapi-api-secret replaced
secret/minhaapi-mongodb replaced
secret/minhaapi-mongodb-token-bk9zr replaced
secret/my-secret replaced
secret/my-secret-2 replaced
secret/sh.helm.release.v1.minhaapi.v1 replaced
secret/sh.helm.release.v1.minhaapi.v10 replaced
secret/sh.helm.release.v1.minhaapi.v2 replaced
secret/sh.helm.release.v1.minhaapi.v3 replaced
secret/sh.helm.release.v1.minhaapi.v4 replaced
secret/sh.helm.release.v1.minhaapi.v5 replaced
secret/sh.helm.release.v1.minhaapi.v6 replaced
secret/sh.helm.release.v1.minhaapi.v7 replaced
secret/sh.helm.release.v1.minhaapi.v8 replaced
secret/sh.helm.release.v1.minhaapi.v9 replaced
secret/default-token-6sf65 replaced
secret/default-token-gggs7 replaced
secret/attachdetach-controller-token-8ch4s replaced
secret/bootstrap-signer-token-5xcvb replaced
secret/certificate-controller-token-rl9cr replaced
secret/clusterrole-aggregation-controller-token-xpdct replaced
secret/coredns-token-tj7nv replaced
secret/cronjob-controller-token-z9dgj replaced
secret/daemon-set-controller-token-mbs8c replaced
secret/default-token-rqmtv replaced
secret/deployment-controller-token-smjbs replaced
secret/disruption-controller-token-7lnfd replaced
secret/endpoint-controller-token-qw2cx replaced
secret/endpointslice-controller-token-5lvpd replaced
secret/endpointslicemirroring-controller-token-j8xhb replaced
secret/ephemeral-volume-controller-token-t7fgl replaced
secret/expand-controller-token-dm9m2 replaced
secret/generic-garbage-collector-token-2z7v2 replaced
secret/horizontal-pod-autoscaler-token-zrl7w replaced
secret/job-controller-token-2pqn4 replaced
secret/kube-proxy-token-cfwqb replaced
secret/metrics-server-token-hpq6k replaced
secret/my-scheduler-token-mfph4 replaced
secret/namespace-controller-token-ddn8z replaced
secret/node-controller-token-z6g5d replaced
secret/persistent-volume-binder-token-w5s2n replaced
secret/pod-garbage-collector-token-phlbr replaced
secret/pv-protection-controller-token-r6k56 replaced
secret/pvc-protection-controller-token-mw8qq replaced
secret/replicaset-controller-token-z45pz replaced
secret/replication-controller-token-jhr5q replaced
secret/resourcequota-controller-token-vjb42 replaced
secret/root-ca-cert-publisher-token-92d59 replaced
secret/service-account-controller-token-ncghb replaced
secret/service-controller-token-92qfn replaced
secret/statefulset-controller-token-2s2t5 replaced
secret/storage-provisioner-token-jsl7g replaced
secret/token-cleaner-token-72fpm replaced
secret/ttl-after-finished-controller-token-9x4l7 replaced
secret/ttl-controller-token-zqq6q replaced
secret/default-token-9jkwp replaced
secret/meu-ingress-controller-ingress-nginx-admission replaced
secret/meu-ingress-controller-ingress-nginx-token-9mn82 replaced
secret/sh.helm.release.v1.meu-ingress-controller.v1 replaced
secret/sh.helm.release.v1.meu-ingress-controller.v2 replaced
secret/sh.helm.release.v1.meu-ingress-controller.v3 replaced
secret/sh.helm.release.v1.meu-ingress-controller.v4 replaced
secret/sh.helm.release.v1.meu-ingress-controller.v5 replaced
fernando@debian10x64:~$
~~~~





- Agora encriptou até a antiga Secret:

~~~~bash

root@minikube:/home/docker# ETCDCTL_API=3 etcdctl \
>    --cacert=/var/lib/minikube/certs/etcd/ca.crt   \
>    --cert=/var/lib/minikube/certs/etcd/server.crt \
>    --key=/var/lib/minikube/certs/etcd/server.key  \
>    get /registry/secrets/default/my-secret | hexdump -C
00000000  2f 72 65 67 69 73 74 72  79 2f 73 65 63 72 65 74  |/registry/secret|
00000010  73 2f 64 65 66 61 75 6c  74 2f 6d 79 2d 73 65 63  |s/default/my-sec|
00000020  72 65 74 0a 6b 38 73 3a  65 6e 63 3a 61 65 73 63  |ret.k8s:enc:aesc|
00000030  62 63 3a 76 31 3a 6b 65  79 31 3a 7c 94 70 93 74  |bc:v1:key1:|.p.t|
00000040  00 40 74 98 07 f0 f4 bb  62 52 c8 f1 7f 9a 5e 13  |.@t.....bR....^.|
00000050  14 a3 0e 10 cb 3a 52 47  d1 e3 f4 3b b2 b1 8a 8c  |.....:RG...;....|
00000060  de 63 8a 81 61 80 ab 10  47 80 8a c4 7e 58 00 54  |.c..a...G...~X.T|
00000070  9b d2 00 10 8e bb 06 e1  04 3b d3 86 ce b8 32 dd  |.........;....2.|
00000080  b3 dd 69 af 02 45 c3 0f  ba c9 72 00 e4 4e 00 e3  |..i..E....r..N..|
00000090  11 7c b8 f8 99 b5 b6 6e  2d 7d 0e f2 66 30 f8 f2  |.|.....n-}..f0..|
000000a0  92 db 74 dd d9 c9 e7 bb  af 5f 45 f9 9a 0e 2a d9  |..t......_E...*.|
000000b0  c3 65 02 f0 de 0e 53 c3  e4 d4 dd f5 55 07 9b 46  |.e....S.....U..F|
000000c0  e6 6e fc 4b d5 c6 d6 b5  ee 55 09 e4 92 8a 96 9e  |.n.K.....U......|
000000d0  1f 8d c2 fa 70 35 41 ae  6c a2 7b 4f 51 90 4a 1b  |....p5A.l.{OQ.J.|
000000e0  de 8c ba b3 f4 40 95 03  33 00 e5 c2 00 c6 ca 6f  |.....@..3......o|
000000f0  fc 27 ed 8e 9d 69 c5 76  ba e0 3f f2 a4 9d 3e f8  |.'...i.v..?...>.|
00000100  49 a7 b4 75 4a 23 6e cd  d2 75 34 ad c0 0a 43 d6  |I..uJ#n..u4...C.|
00000110  65 35 e9 7b 57 f9 a1 e2  a6 3d 61 31 0a c3 d0 cc  |e5.{W....=a1....|
00000120  70 8d 32 be aa 7f 78 08  91 00 1c 7a 74 4c b8 56  |p.2...x....ztL.V|
00000130  7b aa 3e e8 2e e9 c5 06  b4 f1 bd 0a              |{.>.........|
0000013c
root@minikube:/home/docker#

~~~~