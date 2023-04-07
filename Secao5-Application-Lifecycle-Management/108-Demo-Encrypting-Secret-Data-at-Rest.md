
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



- Validando existência do etc

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