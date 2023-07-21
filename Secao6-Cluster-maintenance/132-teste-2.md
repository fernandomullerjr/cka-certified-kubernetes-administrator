    1
    2
    3
    4
    5
    6
    7
    8
    9 

We have a working Kubernetes cluster with a set of web applications running. Let us first explore the setup.

How many deployments exist in the cluster?


controlplane ~ ➜  kubectl get deploy
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
blue   3/3     3            3           16s
red    2/2     2            2           16s

controlplane ~ ➜  kubectl get deploy -A
NAMESPACE     NAME      READY   UP-TO-DATE   AVAILABLE   AGE
default       blue      3/3     3            3           18s
default       red       2/2     2            2           18s
kube-system   coredns   2/2     2            2           16m

controlplane ~ ➜  


- RESPOSTA
2










What is the version of ETCD running on the cluster?

Check the ETCD Pod or Process



controlplane ~ ➜   kubectl get pods -A 
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        blue-6b478c8dbf-n5h9j                  1/1     Running   0          54s
default        blue-6b478c8dbf-qj5bn                  1/1     Running   0          54s
default        blue-6b478c8dbf-rdnl4                  1/1     Running   0          54s
default        red-6684f7669d-9lmqs                   1/1     Running   0          54s
default        red-6684f7669d-qm7jh                   1/1     Running   0          54s
kube-flannel   kube-flannel-ds-6vpg7                  1/1     Running   0          16m
kube-system    coredns-5d78c9869d-bhmz5               1/1     Running   0          16m
kube-system    coredns-5d78c9869d-h8rnh               1/1     Running   0          16m
kube-system    etcd-controlplane                      1/1     Running   0          16m
kube-system    kube-apiserver-controlplane            1/1     Running   0          16m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          16m
kube-system    kube-proxy-lhtzq                       1/1     Running   0          16m
kube-system    kube-scheduler-controlplane            1/1     Running   0          16m

controlplane ~ ➜  kubectl get pods -A | grep etcd
kube-system    etcd-controlplane                      1/1     Running   0          16m

controlplane ~ ➜  kubectl describe pod etcd-controlplane -n kube-system
Name:                 etcd-controlplane
Namespace:            kube-system
Priority:             2000001000
Priority Class Name:  system-node-critical
Node:                 controlplane/192.1.29.3
Start Time:           Fri, 21 Jul 2023 18:50:41 -0400
Labels:               component=etcd
                      tier=control-plane
Annotations:          kubeadm.kubernetes.io/etcd.advertise-client-urls: https://192.1.29.3:2379
                      kubernetes.io/config.hash: 8c992d11868c5abd9f5f66239320fbc5
                      kubernetes.io/config.mirror: 8c992d11868c5abd9f5f66239320fbc5
                      kubernetes.io/config.seen: 2023-07-21T18:50:40.896513222-04:00
                      kubernetes.io/config.source: file
Status:               Running
SeccompProfile:       RuntimeDefault
IP:                   192.1.29.3
IPs:
  IP:           192.1.29.3
Controlled By:  Node/controlplane
Containers:
  etcd:
    Container ID:  containerd://da931335d39ebcb194916d2ce6033a46c68bdb2a6870de268a06e4bf4f854cbe
    Image:         registry.k8s.io/etcd:3.5.7-0
    Image ID:      registry.k8s.io/etcd@sha256:51eae8381dcb1078289fa7b4f3df2630cdc18d09fb56f8e56b41c40e191d6c83
    Port:          <none>
    Host Port:     <none>
    Command:
      etcd
      --advertise-client-urls=https://192.1.29.3:2379
      --cert-file=/etc/kubernetes/pki/etcd/server.crt
      --client-cert-auth=true
      --data-dir=/var/lib/etcd
      --experimental-initial-corrupt-check=true
      --experimental-watch-progress-notify-interval=5s
      --initial-advertise-peer-urls=https://192.1.29.3:2380
      --initial-cluster=controlplane=https://192.1.29.3:2380
      --key-file=/etc/kubernetes/pki/etcd/server.key
      --listen-client-urls=https://127.0.0.1:2379,https://192.1.29.3:2379
      --listen-metrics-urls=http://127.0.0.1:2381
      --listen-peer-urls=https://192.1.29.3:2380
      --name=controlplane
      --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
      --peer-client-cert-auth=true
      --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
      --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
      --snapshot-count=10000
      --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    State:          Running
      Started:      Fri, 21 Jul 2023 18:50:31 -0400
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
  Type    Reason   Age   From     Message
  ----    ------   ----  ----     -------
  Normal  Pulled   17m   kubelet  Container image "registry.k8s.io/etcd:3.5.7-0" already present on machine
  Normal  Created  17m   kubelet  Created container etcd
  Normal  Started  17m   kubelet  Started container etcd


















At what address can you reach the ETCD cluster from the controlplane node?

Check the ETCD Service configuration in the ETCD POD


- RESPOSTA
https://127.0.0.1:2379










Where is the ETCD server certificate file located?

Note this path down as you will need to use it later


- resposta
/etc/kubernetes/pki/etcd/server.crt














Where is the ETCD CA Certificate file located?

Note this path down as you will need to use it later.

- resposta
      --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt















The master node in our cluster is planned for a regular maintenance reboot tonight. While we do not anticipate anything to go wrong, we are required to take the necessary backups. Take a snapshot of the ETCD database using the built-in snapshot functionality.

Store the backup file at location /opt/snapshot-pre-boot.db


- Testando:
ETCDCTL_API=3 etcdctl snapshot save /opt/snapshot-pre-boot.db
NÃO FUNCIONOU

- Dica do github
https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/06-Cluster-Maintenance/09-Practice-Test-Backup-and-Restore-Methods.md
<https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/06-Cluster-Maintenance/09-Practice-Test-Backup-and-Restore-Methods.md>
Take a snapshot of the ETCD database using the built-in snapshot functionality.
Store the backup file at location /opt/snapshot-pre-boot.db

~~~~bash
ETCDCTL_API=3 etcdctl snapshot save \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  /opt/snapshot-pre-boot.db
~~~~



- Editando

~~~~bash
ETCDCTL_API=3 etcdctl snapshot save --endpoints=127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  /opt/snapshot-pre-boot.db
~~~~



- Saída

~~~~bash

controlplane ~ ✖ ETCDCTL_API=3 etcdctl snapshot save --endpoints=127.0.0.1:2379 \
>   --cacert=/etc/kubernetes/pki/etcd/ca.crt \
>   --cert=/etc/kubernetes/pki/etcd/server.crt \
>   --key=/etc/kubernetes/pki/etcd/server.key \
>   /opt/snapshot-pre-boot.db
Snapshot saved at /opt/snapshot-pre-boot.db

controlplane ~ ➜  
~~~~


- OK, funcionou!


















Great! Let us now wait for the maintenance window to finish. Go get some sleep. (Don't go for real)

Click Ok to Continue













It's about 2 AM at Midnight! You get a call!
It's about 2 AM at Midnight! You get a call!
It's about 2 AM at Midnight! You get a call!










Wake up! We have a conference call! After the reboot the master nodes came back online, but none of our applications are accessible. Check the status of the applications on the cluster. What's wrong?


controlplane ~ ➜  kubectl get deploy
No resources found in default namespace.

controlplane ~ ➜  kubectl get pods
No resources found in default namespace.

controlplane ~ ➜  kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   71s

controlplane ~ ➜  


- RESPOSTA
All of the above












Luckily we took a backup. Restore the original state of the cluster using the backup file.

    Deployments: 2

    Services: 3











## Restore - ETCD

    To restore etcd from the backup at later in time. First stop kube-apiserver service
~~~~BASH
    $ service kube-apiserver stop
~~~~


Run the etcdctl snapshot restore command

~~~~BASH
ETCDCTL_API=3 etcdctl \
  snapshot restore snapshot.db \
  --data-dir /var/lib/etcd-from-backup
~~~~

Update the etcd service
    usar conf de exemplo

Reload system configs

~~~~BASH
$ systemctl daemon-reload
~~~~

Restart etcd

~~~~BASH
$ service etcd restart
~~~~


Start the kube-apiserver

~~~~BASH
$ service kube-apiserver start
~~~~




- Testando:

ETCDCTL_API=3 etcdctl --endpoints=127.0.0.1:2379 \
  snapshot restore snapshot-pre-boot.db \
  --data-dir /opt

- ERROS:

controlplane ~ ✖ ETCDCTL_API=3 etcdctl --endpoints=127.0.0.1:2379 \
>   snapshot restore snapshot-pre-boot.db \
>   --data-dir /opt/
Error: data-dir "/opt/" exists

controlplane ~ ✖ ls /opt
cni  containerd  snapshot-pre-boot.db

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  ETCDCTL_API=3 etcdctl --endpoints=127.0.0.1:2379 \
>   snapshot restore snapshot-pre-boot.db \
>   --data-dir /opt
Error: data-dir "/opt" exists

controlplane ~ ✖ 







ETCDCTL_API=3 etcdctl --endpoints=127.0.0.1:2379 \
  snapshot restore /opt/snapshot-pre-boot.db \
  --data-dir /var/lib/etcd


- ERRO

controlplane ~ ✖ ETCDCTL_API=3 etcdctl --endpoints=127.0.0.1:2379 \
>   snapshot restore /opt/snapshot-pre-boot.db \
>   --data-dir /var/lib/etcd
Error: data-dir "/var/lib/etcd" exists

controlplane ~ ✖ 



- Vai ser necessário mudar a estratégia.
- Terei que mudar o diretório onde o Pod busca o dado.
- Não é necessário contatar o endpoint desta vez, pois agora a comunicação é local, não vai se comunicar com o etcd server.





ETCDCTL_API=3 etcdctl \
  snapshot restore /opt/snapshot-pre-boot.db \
  --data-dir /var/lib/etcd-from-backup



controlplane ~ ✖ ETCDCTL_API=3 etcdctl \
>   snapshot restore /opt/snapshot-pre-boot.db \
>   --data-dir /var/lib/etcd-from-backup
2023-07-21 19:25:32.421832 I | mvcc: restore compact to 1601
2023-07-21 19:25:32.427880 I | etcdserver/membership: added member 8e9e05c52164694d [http://localhost:2380] to cluster cdf818194e3a8c32

controlplane ~ ➜  


controlplane ~ ➜  ls -lhasp /var/lib/etcd-from-backup
total 16K
4.0K drwx------ 3 root root 4.0K Jul 21 19:25 ./
8.0K drwxr-xr-x 1 root root 4.0K Jul 21 19:25 ../
4.0K drwx------ 4 root root 4.0K Jul 21 19:25 member/

controlplane ~ ➜  







ls -lhasp /etc/kuber

ls -lhasp /etc/kubernetes/manifests/etcd.yaml 



controlplane ~ ➜  ls -lhasp /etc/kubernetes/manifests/
total 28K
4.0K drwxr-xr-x 1 root root 4.0K Jul 21 18:50 ./
8.0K drwxr-xr-x 1 root root 4.0K Jul 21 18:50 ../
4.0K -rw------- 1 root root 2.4K Jul 21 18:50 etcd.yaml
4.0K -rw------- 1 root root 3.8K Jul 21 18:50 kube-apiserver.yaml
4.0K -rw------- 1 root root 3.4K Jul 21 18:50 kube-controller-manager.yaml
4.0K -rw------- 1 root root 1.5K Jul 21 18:50 kube-scheduler.yaml

controlplane ~ ➜  ls -lhasp /etc/kubernetes/manifests/etcd.yaml 
4.0K -rw------- 1 root root 2.4K Jul 21 18:50 /etc/kubernetes/manifests/etcd.yaml

controlplane ~ ➜  cat /etc/kubernetes/manifests/etcd.yaml 
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/etcd.advertise-client-urls: https://192.1.29.3:2379
  creationTimestamp: null
  labels:
    component: etcd
    tier: control-plane
  name: etcd
  namespace: kube-system
spec:
  containers:
  - command:
    - etcd
    - --advertise-client-urls=https://192.1.29.3:2379
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt
    - --client-cert-auth=true
    - --data-dir=/var/lib/etcd
    - --experimental-initial-corrupt-check=true
    - --experimental-watch-progress-notify-interval=5s
    - --initial-advertise-peer-urls=https://192.1.29.3:2380
    - --initial-cluster=controlplane=https://192.1.29.3:2380
    - --key-file=/etc/kubernetes/pki/etcd/server.key
    - --listen-client-urls=https://127.0.0.1:2379,https://192.1.29.3:2379
    - --listen-metrics-urls=http://127.0.0.1:2381
    - --listen-peer-urls=https://192.1.29.3:2380
    - --name=controlplane
    - --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
    - --peer-client-cert-auth=true
    - --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
    - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    - --snapshot-count=10000
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    image: registry.k8s.io/etcd:3.5.7-0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /health?exclude=NOSPACE&serializable=true
        port: 2381
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: etcd
    resources:
      requests:
        cpu: 100m
        memory: 100Mi
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /health?serializable=false
        port: 2381
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /var/lib/etcd
      name: etcd-data
    - mountPath: /etc/kubernetes/pki/etcd
      name: etcd-certs
  hostNetwork: true
  priority: 2000001000
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/kubernetes/pki/etcd
      type: DirectoryOrCreate
    name: etcd-certs
  - hostPath:
      path: /var/lib/etcd
      type: DirectoryOrCreate
    name: etcd-data
status: {}

controlplane ~ ➜  








controlplane ~ ➜  vi /etc/kubernetes/manifests/etcd.yaml 

controlplane ~ ➜  vi /etc/kubernetes/manifests/etcd.yaml 

controlplane ~ ➜  
controlplane ~ ➜  cat /etc/kubernetes/manifests/etcd.yaml | tail
  volumes:
  - hostPath:
      path: /etc/kubernetes/pki/etcd
      type: DirectoryOrCreate
    name: etcd-certs
  - hostPath:
      path: /var/lib/etcd-from-backup
      type: DirectoryOrCreate
    name: etcd-data
status: {}

controlplane ~ ➜  




- Essa linha diz a origem da montagem, não necessariamente a conf em si.



controlplane ~ ➜  kubectl get pods -n kube-system
NAME                                   READY   STATUS    RESTARTS   AGE
coredns-5d78c9869d-bhmz5               1/1     Running   0          50m
coredns-5d78c9869d-h8rnh               1/1     Running   0          50m
etcd-controlplane                      1/1     Running   0          51m
kube-apiserver-controlplane            1/1     Running   0          51m
kube-controller-manager-controlplane   1/1     Running   0          51m
kube-proxy-lhtzq                       1/1     Running   0          50m
kube-scheduler-controlplane            1/1     Running   0          51m

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -n kube-system
NAME                                   READY   STATUS    RESTARTS   AGE
coredns-5d78c9869d-bhmz5               1/1     Running   0          51m
coredns-5d78c9869d-h8rnh               1/1     Running   0          51m
etcd-controlplane                      0/1     Pending   0          46s
kube-apiserver-controlplane            1/1     Running   0          51m
kube-controller-manager-controlplane   1/1     Running   1          51m
kube-proxy-lhtzq                       1/1     Running   0          51m
kube-scheduler-controlplane            1/1     Running   1          51m

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods -n kube-system --watch
NAME                                   READY   STATUS    RESTARTS   AGE
coredns-5d78c9869d-bhmz5               1/1     Running   0          52m
coredns-5d78c9869d-h8rnh               1/1     Running   0          52m
etcd-controlplane                      0/1     Pending   0          2m1s
kube-apiserver-controlplane            1/1     Running   0          53m
kube-controller-manager-controlplane   1/1     Running   1          53m
kube-proxy-lhtzq                       1/1     Running   0          52m
kube-scheduler-controlplane            1/1     Running   1          53m
