
# Dia 13/07/2023

- Analisando o "describe pod etcd-controlplane".
- Temos o caminho do certificado, diretório data, etc

      etcd
      --advertise-client-urls=https://192.0.135.9:2379
      --cert-file=/etc/kubernetes/pki/etcd/server.crt
      --client-cert-auth=true
      --data-dir=/var/lib/etcd
      --experimental-initial-corrupt-check=true
      --experimental-watch-progress-notify-interval=5s
      --initial-advertise-peer-urls=https://192.0.135.9:2380
      --initial-cluster=controlplane=https://192.0.135.9:2380
      --key-file=/etc/kubernetes/pki/etcd/server.key
      --listen-client-urls=https://127.0.0.1:2379,https://192.0.135.9:2379
      --listen-metrics-urls=http://127.0.0.1:2381
      --listen-peer-urls=https://192.0.135.9:2380
      --name=controlplane
      --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
      --peer-client-cert-auth=true
      --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
      --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
      --snapshot-count=10000
      --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt


- Sobre Static Pods
- Os Pods que são criados através do Kubelet, são lidos da pasta:
kubernetes static pods /etc/kubernetes/manifests
- Onde tem estes arquivos normalmente:

~~~~bash

controlplane ~ ➜  ls -lhasp /etc/kubernetes/manifests/
total 28K
4.0K drwxr-xr-x 1 root root 4.0K Dec 13 01:39 ./
8.0K drwxr-xr-x 1 root root 4.0K Dec 13 01:39 ../
4.0K -rw------- 1 root root 2.3K Dec 13 01:39 etcd.yaml
4.0K -rw------- 1 root root 3.8K Dec 13 01:39 kube-apiserver.yaml
4.0K -rw------- 1 root root 3.3K Dec 13 01:39 kube-controller-manager.yaml
4.0K -rw------- 1 root root 1.5K Dec 13 01:39 kube-scheduler.yaml

controlplane ~ ➜  

~~~~



- Olhar para o etcd.yaml
- Nele tem uma parte sobre volumes, nesta parte é usado "hostPath", indicando que não é algo externo, é algo local mesmo.
- Dizendo que ele monta este diretório no container, usando este volume.



06:13

08:18
export
 ETCDCTL_API=3 etcdctl snapshot save /opt/snapshot-pre-boot.db


formando o comando
10:40 , terminou