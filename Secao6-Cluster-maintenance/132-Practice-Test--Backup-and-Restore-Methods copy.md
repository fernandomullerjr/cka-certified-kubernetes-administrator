

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "132. Practice Test - Backup and Restore Methods."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 132. Practice Test - Backup and Restore Methods

 

We have a working Kubernetes cluster with a set of web applications running. Let us first explore the setup.

How many deployments exist in the cluster?


controlplane ~ ➜  kubectl get deployments.apps -A
NAMESPACE     NAME      READY   UP-TO-DATE   AVAILABLE   AGE
default       blue      3/3     3            3           28s
default       red       2/2     2            2           28s
kube-system   coredns   2/2     2            2           6m14s

controlplane ~ ➜  









What is the version of ETCD running on the cluster?

Check the ETCD Pod or Process

controlplane ~ ➜  kubectl get pods -A 
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        blue-6b478c8dbf-fbsgx                  1/1     Running   0          71s
default        blue-6b478c8dbf-lx8g2                  1/1     Running   0          71s
default        blue-6b478c8dbf-wp8ct                  1/1     Running   0          71s
default        red-6684f7669d-22hcm                   1/1     Running   0          71s
default        red-6684f7669d-qw8ff                   1/1     Running   0          71s
kube-flannel   kube-flannel-ds-l7fp8                  1/1     Running   0          6m46s
kube-system    coredns-5d78c9869d-2d7bh               1/1     Running   0          6m46s
kube-system    coredns-5d78c9869d-rzsfz               1/1     Running   0          6m46s
kube-system    etcd-controlplane                      1/1     Running   0          6m59s
kube-system    kube-apiserver-controlplane            1/1     Running   0          6m56s
kube-system    kube-controller-manager-controlplane   1/1     Running   0          6m56s
kube-system    kube-proxy-hj77n                       1/1     Running   0          6m46s
kube-system    kube-scheduler-controlplane            1/1     Running   0          7m

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A | grep etcd
kube-system    etcd-controlplane                      1/1     Running   0          7m10s

controlplane ~ ➜  



controlplane ~ ➜  kubectl describe pod etcd-controlplane -n kube-system
Name:                 etcd-controlplane
Namespace:            kube-system
Priority:             2000001000
Priority Class Name:  system-node-critical
Node:                 controlplane/192.0.135.9
Start Time:           Wed, 12 Jul 2023 18:33:40 -0400
Labels:               component=etcd
                      tier=control-plane
Annotations:          kubeadm.kubernetes.io/etcd.advertise-client-urls: https://192.0.135.9:2379
                      kubernetes.io/config.hash: d52d61d5416c9c9c6f8622259b8b5037
                      kubernetes.io/config.mirror: d52d61d5416c9c9c6f8622259b8b5037
                      kubernetes.io/config.seen: 2023-07-12T18:33:27.635910996-04:00
                      kubernetes.io/config.source: file
Status:               Running
SeccompProfile:       RuntimeDefault
IP:                   192.0.135.9
IPs:
  IP:           192.0.135.9
Controlled By:  Node/controlplane
Containers:
  etcd:
    Container ID:  containerd://692cf2be0f8aabda22116ed37377641eb782f9f772bc8c0213563c3837dea248
    Image:         registry.k8s.io/etcd:3.5.7-0
    Image ID:      registry.k8s.io/etcd@sha256:51eae8381dcb1078289fa7b4f3df2630cdc18d09fb56f8e56b41c40e191d6c83
    Port:          <none>
    Host Port:     <none>
    Command:
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
    State:          Running
      Started:      Wed, 12 Jul 2023 18:33:29 -0400
    Ready:          True
    Restart Count:  0
    Requests:
      cpu:        100m
      memory:     100Mi
    Liveness:     http-get http://127.0.0.1:2381/health%3Fexclude=NOSPACE&serializable=true delay=10s timeout=15s period=10s #success=1 #failure=8
    Startup:      http-get http://127.0.0.1:2381/health%3Fserializable=false delay=10s timeout=15s period=10s #success=1 #failure=24
    Environment:  <none>
    Mounts:
      /etc/kubernetes/pki/etcd from etcd-certs (rw)
      /var/lib/etcd from etcd-data (rw)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  etcd-certs:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/kubernetes/pki/etcd
    HostPathType:  DirectoryOrCreate
  etcd-data:
    Type:          HostPath (bare host directory volume)
    Path:          /var/lib/etcd
    HostPathType:  DirectoryOrCreate
QoS Class:         Burstable
Node-Selectors:    <none>
Tolerations:       :NoExecute op=Exists
Events:
  Type    Reason   Age    From     Message
  ----    ------   ----   ----     -------
  Normal  Pulled   7m55s  kubelet  Container image "registry.k8s.io/etcd:3.5.7-0" already present on machine
  Normal  Created  7m55s  kubelet  Created container etcd
  Normal  Started  7m55s  kubelet  Started container etcd

controlplane ~ ➜  










At what address can you reach the ETCD cluster from the controlplane node?

Check the ETCD Service configuration in the ETCD POD


-  RESPOSTA
https://127.0.0.1:2379








Where is the ETCD server certificate file located?

Note this path down as you will need to use it later


- RESPOSTA
/etc/kubernetes/pki/etcd/server.crt







Where is the ETCD CA Certificate file located?

Note this path down as you will need to use it later.

- RESPOSTA
/etc/kubernetes/pki/etcd/ca.crt









The master node in our cluster is planned for a regular maintenance reboot tonight. While we do not anticipate anything to go wrong, we are required to take the necessary backups. Take a snapshot of the ETCD database using the built-in snapshot functionality.

Store the backup file at location /opt/snapshot-pre-boot.db

    Backup ETCD to /opt/snapshot-pre-boot.db



~~~~BASH
ETCDCTL_API=3 etcdctl snapshot save /opt/snapshot-pre-boot.db

ETCDCTL_API=3 etcdctl snapshot status /opt/snapshot-pre-boot.db
~~~~


 ~ ➜  ^C

controlplane ~ ✖ ETCDCTL_API=3 etcdctl snapshot save /opt/snapshot-pre-boot.db
Error: rpc error: code = Unavailable desc = transport is closing

controlplane ~ ✖ 

controlplane ~ ➜  kubectl exec -ti etcd-controlplane -n kube-system sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
sh-5.1#                                                                                                                                        sh-5.1# 
sh-5.1# 
sh-5.1# 
sh-5.1# 
sh-5.1# 
sh-5.1# 
sh-5.1# 
sh-5.1# ps -ef
sh: ps: command not found
sh-5.1# ps
sh: ps: command not found
sh-5.1# ls
sh: ls: command not found
sh-5.1# ETCDCTL_API=3 etcdctl snapshot save /opt/snapshot-pre-boot.db
Error: could not open /opt/snapshot-pre-boot.db.part (open /opt/snapshot-pre-boot.db.part: no such file or directory)
sh-5.1# 


- ERROS,
- Tentar copiar sem passar o path /opt:
ETCDCTL_API=3 etcdctl snapshot save snapshot-pre-boot.db

sh-5.1# 
sh-5.1# lsb_release -a
sh: lsb_release: command not found
sh-5.1# uname -r
sh: uname: command not found
sh-5.1# ETCDCTL_API=3 etcdctl snapshot save snapshot-pre-boot.db
{"level":"info","ts":"2023-07-12T22:56:19.544Z","caller":"snapshot/v3_snapshot.go:65","msg":"created temporary db file","path":"snapshot-pre-boot.db.part"}




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

