



- Acesse o shell do seu cluster Minikube executando o comando:

minikube ssh



- Atualize os repositórios do apt-get:

sudo apt-get update




- Instale o pacote bsdmainutils, que inclui o hexdump:

sudo apt-get install bsdmainutils



- Instalar o etcd client no Cluster Minikube:

apt-get install etcd-client




- Virar root:
sudo su


- Verificar o diretório dos certificados utilizados pelo etcd:

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
~~~~






- Adaptar o comando:

Verificar os paths usados no Node, seja Minikube ou não.

https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/
<https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/>

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