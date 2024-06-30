#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "262. Practice Test - Troubleshoot Network."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
##  262. Practice Test - Troubleshoot Network



**Troubleshooting Test 1:** A simple 2 tier application is deployed in the triton namespace. It must display a green web page on success. Click on the app tab at the top of your terminal to view your application. It is currently failed. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.

DB Service working?

WebApp Service working?


~~~~bash
root@controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS              RESTARTS   AGE
kube-system   coredns-7db6d8ff4d-9tdf7               1/1     Running             0          63m
kube-system   coredns-7db6d8ff4d-qt4qp               1/1     Running             0          63m
kube-system   etcd-controlplane                      1/1     Running             0          63m
kube-system   kube-apiserver-controlplane            1/1     Running             0          63m
kube-system   kube-controller-manager-controlplane   1/1     Running             0          63m
kube-system   kube-proxy-t52mx                       1/1     Running             0          63m
kube-system   kube-scheduler-controlplane            1/1     Running             0          63m
triton        mysql                                  0/1     ContainerCreating   0          40s
triton        webapp-mysql-6b5cd9ff5c-kgvkq          0/1     ContainerCreating   0          40s

root@controlplane ~ ➜  

root@controlplane ~ ➜  kubectl get all -n triton
NAME                                READY   STATUS              RESTARTS   AGE
pod/mysql                           0/1     ContainerCreating   0          53s
pod/webapp-mysql-6b5cd9ff5c-kgvkq   0/1     ContainerCreating   0          53s

NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/mysql         ClusterIP   10.110.126.140   <none>        3306/TCP         53s
service/web-service   NodePort    10.101.79.156    <none>        8080:30081/TCP   53s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   0/1     1            0           53s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-6b5cd9ff5c   1         1         0       53s

root@controlplane ~ ➜  date
Sun Jun 30 06:57:02 PM UTC 2024

root@controlplane ~ ➜  
~~~~

https://30081-port-25be897b6c5344c9.labs.kodekloud.com/
502 Bad Gateway
nginx/1.25.2

~~~~bash

root@controlplane ~ ➜  kubectl describe pod mysql -n triton
Name:             mysql
Namespace:        triton
Priority:         0
Service Account:  default
Node:             controlplane/192.168.121.246
Start Time:       Sun, 30 Jun 2024 18:56:05 +0000
Labels:           name=mysql
Annotations:      <none>
Status:           Pending
IP:               
IPs:              <none>
Containers:
  mysql:
    Container ID:   
    Image:          mysql:5.6
    Image ID:       
    Port:           3306/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:
      MYSQL_ROOT_PASSWORD:  paswrd
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-9xlmf (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   False 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-9xlmf:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason                  Age                 From               Message
  ----     ------                  ----                ----               -------
  Normal   Scheduled               2m9s                default-scheduler  Successfully assigned triton/mysql to controlplane
  Warning  FailedCreatePodSandBox  2m9s                kubelet            Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox "e39f04ac12dcb11b078fdb0915145c627ef81d4bbf7262f90c5fa238fea79b07": plugin type="weave-net" name="weave" failed (add): unable to allocate IP address: Post "http://127.0.0.1:6784/ip/e39f04ac12dcb11b078fdb0915145c627ef81d4bbf7262f90c5fa238fea79b07": dial tcp 127.0.0.1:6784: connect: connection refused
  Normal   SandboxChanged          4s (x10 over 2m8s)  kubelet            Pod sandbox changed, it will be killed and re-created.

root@controlplane ~ ➜  
~~~~

Verificando o erro do Pod do mysql:
Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox "e39f04ac12dcb11b078fdb0915145c627ef81d4bbf7262f90c5fa238fea79b07": plugin type="weave-net" name="weave" failed (add): unable to allocate IP address: Post "http://127.0.0.1:6784/ip/e39f04ac12dcb11b078fdb0915145c627ef81d4bbf7262f90c5fa238fea79b07"

~~~~bash
root@controlplane ~ ➜  kubectl get pods -n kube-system -o wide
NAME                                   READY   STATUS    RESTARTS   AGE   IP                NODE           NOMINATED NODE   READINESS GATES
coredns-7db6d8ff4d-9tdf7               1/1     Running   0          66m   10.50.0.2         controlplane   <none>           <none>
coredns-7db6d8ff4d-qt4qp               1/1     Running   0          66m   10.50.0.3         controlplane   <none>           <none>
etcd-controlplane                      1/1     Running   0          66m   192.168.121.246   controlplane   <none>           <none>
kube-apiserver-controlplane            1/1     Running   0          66m   192.168.121.246   controlplane   <none>           <none>
kube-controller-manager-controlplane   1/1     Running   0          66m   192.168.121.246   controlplane   <none>           <none>
kube-proxy-t52mx                       1/1     Running   0          66m   192.168.121.246   controlplane   <none>           <none>
kube-scheduler-controlplane            1/1     Running   0          66m   192.168.121.246   controlplane   <none>           <none>

root@controlplane ~ ➜  

root@controlplane ~ ➜  

root@controlplane ~ ➜  

root@controlplane ~ ➜  
~~~~

https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/weave-network-policy/

https://github.com/weaveworks/weave/blob/master/site/kubernetes/kube-addon.md#-installation

Installation

Before installing Weave Net, you should make sure the following ports are not blocked by your firewall: TCP 6783 and UDP 6783/6784. For more details, see the FAQ.

Weave Net can be installed onto your CNI-enabled Kubernetes cluster with a single command:
~~~~bash
$ kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
~~~~

Important: this configuration won't enable encryption by default. If your data plane traffic isn't secured that could allow malicious actors to access your pod network. Read on to see the alternatives.

Aplicando:
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

~~~~bash
root@controlplane ~ ➜  kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
serviceaccount/weave-net created
clusterrole.rbac.authorization.k8s.io/weave-net created
clusterrolebinding.rbac.authorization.k8s.io/weave-net created
role.rbac.authorization.k8s.io/weave-net created
rolebinding.rbac.authorization.k8s.io/weave-net created
daemonset.apps/weave-net created

root@controlplane ~ ➜  date
Sun Jun 30 07:01:08 PM UTC 2024

root@controlplane ~ ➜  
~~~~


-OK ,normalizado

~~~~bash

root@controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
kube-system   coredns-7db6d8ff4d-9tdf7               1/1     Running   0          119m
kube-system   coredns-7db6d8ff4d-qt4qp               1/1     Running   0          119m
kube-system   etcd-controlplane                      1/1     Running   0          119m
kube-system   kube-apiserver-controlplane            1/1     Running   0          119m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          119m
kube-system   kube-proxy-t52mx                       1/1     Running   0          119m
kube-system   kube-scheduler-controlplane            1/1     Running   0          119m
kube-system   weave-net-dsjbw                        2/2     Running   0          51m
triton        mysql                                  1/1     Running   0          56m
triton        webapp-mysql-6b5cd9ff5c-kgvkq          1/1     Running   0          56m

root@controlplane ~ ➜  date
Sun Jun 30 07:52:27 PM UTC 2024

root@controlplane ~ ➜  
~~~~










**Troubleshooting Test 2:** The same 2 tier application is having issues again. It must display a green web page on success. Click on the app tab at the top of your terminal to view your application. It is currently failed. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.

Fixed Issue?

https://30081-port-25be897b6c5344c9.labs.kodekloud.com/
Environment Variables: DB_Host=mysql; DB_Database=Not Set; DB_User=root; DB_Password=paswrd; 2003: Can't connect to MySQL server on 'mysql:3306' (113 Host is unreachable)

From webapp-mysql-6b5cd9ff5c-kgvkq!


~~~~bash

root@controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE
kube-system   coredns-7db6d8ff4d-9tdf7               1/1     Running   0             120m
kube-system   coredns-7db6d8ff4d-qt4qp               1/1     Running   0             120m
kube-system   etcd-controlplane                      1/1     Running   0             120m
kube-system   kube-apiserver-controlplane            1/1     Running   0             120m
kube-system   kube-controller-manager-controlplane   1/1     Running   0             120m
kube-system   kube-proxy-bbkdt                       0/1     Error     3 (40s ago)   59s
kube-system   kube-scheduler-controlplane            1/1     Running   0             120m
kube-system   weave-net-dsjbw                        2/2     Running   0             52m
triton        mysql                                  1/1     Running   0             58s
triton        webapp-mysql-6b5cd9ff5c-pvk7f          1/1     Running   0             58s

root@controlplane ~ ➜  date
Sun Jun 30 07:53:47 PM UTC 2024

root@controlplane ~ ➜  
~~~~



kube-system   kube-proxy-zcjxq                       0/1     Error               1 (2s ago)   4s
kube-system   kube-proxy-zcjxq                       0/1     CrashLoopBackOff    1 (2s ago)   5s

kube-system   kube-proxy-zcjxq                       0/1     CrashLoopBackOff    2 (13s ago)   33s
kube-system   kube-proxy-zcjxq                       0/1     Error               3 (25s ago)   45s
kube-system   kube-proxy-zcjxq                       0/1     CrashLoopBackOff    3 (13s ago)   58s
kube-system   kube-proxy-zcjxq                       0/1     Error               4 (52s ago)   97s
kube-system   kube-proxy-zcjxq                       0/1     CrashLoopBackOff    4 (13s ago)   110s
kube-system   kube-proxy-zcjxq                       0/1     Error               5 (85s ago)   3m2s
^C

~~~~bash
root@controlplane ~ ✖ kubectl describe pod kube-proxy-zcjxq -n kube-system
Name:                 kube-proxy-zcjxq
Namespace:            kube-system
Priority:             2000001000
Priority Class Name:  system-node-critical
Service Account:      kube-proxy
Node:                 controlplane/192.168.121.70
Start Time:           Sun, 30 Jun 2024 20:09:02 +0000
Labels:               controller-revision-hash=78f48dc97b
                      k8s-app=kube-proxy
                      pod-template-generation=1
Annotations:          <none>
Status:               Running
IP:                   192.168.121.70
IPs:
  IP:           192.168.121.70
Controlled By:  DaemonSet/kube-proxy
Containers:
  kube-proxy:
    Container ID:  containerd://d92da89bda81bebb8286373d17e30a4040075cd8bd4290890045c2f84145e694
    Image:         registry.k8s.io/kube-proxy:v1.26.0
    Image ID:      registry.k8s.io/kube-proxy@sha256:1e9bbe429e4e2b2ad32681c91deb98a334f1bf4135137df5f84f9d03689060fe
    Port:          <none>
    Host Port:     <none>
    Command:
      /usr/local/bin/kube-proxy
      --config=/var/lib/kube-proxy/configuration.conf
      --hostname-override=$(NODE_NAME)
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Sun, 30 Jun 2024 20:12:04 +0000
      Finished:     Sun, 30 Jun 2024 20:12:04 +0000
    Ready:          False
    Restart Count:  5
    Environment:
      NODE_NAME:   (v1:spec.nodeName)
    Mounts:
      /lib/modules from lib-modules (ro)
      /run/xtables.lock from xtables-lock (rw)
      /var/lib/kube-proxy from kube-proxy (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-skg95 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-proxy:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      kube-proxy
    Optional:  false
  xtables-lock:
    Type:          HostPath (bare host directory volume)
    Path:          /run/xtables.lock
    HostPathType:  FileOrCreate
  lib-modules:
    Type:          HostPath (bare host directory volume)
    Path:          /lib/modules
    HostPathType:  
  kube-api-access-skg95:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              kubernetes.io/os=linux
Tolerations:                 op=Exists
                             node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/network-unavailable:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists
Events:
  Type     Reason     Age                   From               Message
  ----     ------     ----                  ----               -------
  Normal   Scheduled  3m20s                 default-scheduler  Successfully assigned kube-system/kube-proxy-zcjxq to controlplane
  Normal   Pulling    3m20s                 kubelet            Pulling image "registry.k8s.io/kube-proxy:v1.26.0"
  Normal   Pulled     3m18s                 kubelet            Successfully pulled image "registry.k8s.io/kube-proxy:v1.26.0" in 1.72s (1.72s including waiting). Image size: 21536465 bytes.
  Normal   Created    103s (x5 over 3m18s)  kubelet            Created container kube-proxy
  Normal   Started    103s (x5 over 3m18s)  kubelet            Started container kube-proxy
  Normal   Pulled     103s (x4 over 3m17s)  kubelet            Container image "registry.k8s.io/kube-proxy:v1.26.0" already present on machine
  Warning  BackOff    103s (x9 over 3m16s)  kubelet            Back-off restarting failed container kube-proxy in pod kube-proxy-zcjxq_kube-system(4ebe524e-cedc-446d-afe9-078b335d9948)

root@controlplane ~ ➜  



root@controlplane ~ ➜  ps -ef | grep kube
root        2157    1979  4 19:38 ?        00:01:34 kube-apiserver --advertise-address=192.168.121.70 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root        2183    1985  0 19:38 ?        00:00:06 kube-scheduler --authentication-kubeconfig=/etc/kubernetes/scheduler.conf --authorization-kubeconfig=/etc/kubernetes/scheduler.conf --bind-address=127.0.0.1 --kubeconfig=/etc/kubernetes/scheduler.conf --leader-elect=true
root        2191    1986  1 19:38 ?        00:00:29 kube-controller-manager --allocate-node-cidrs=true --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf --bind-address=127.0.0.1 --client-ca-file=/etc/kubernetes/pki/ca.crt --cluster-cidr=10.244.0.0/16 --cluster-name=kubernetes --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt --cluster-signing-key-file=/etc/kubernetes/pki/ca.key --controllers=*,bootstrapsigner,tokencleaner --kubeconfig=/etc/kubernetes/controller-manager.conf --leader-elect=true --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --root-ca-file=/etc/kubernetes/pki/ca.crt --service-account-private-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --use-service-account-credentials=true
root        2217    1980  1 19:38 ?        00:00:35 etcd --advertise-client-urls=https://192.168.121.70:2379 --cert-file=/etc/kubernetes/pki/etcd/server.crt --client-cert-auth=true --data-dir=/var/lib/etcd --experimental-initial-corrupt-check=true --experimental-watch-progress-notify-interval=5s --initial-advertise-peer-urls=https://192.168.121.70:2380 --initial-cluster=controlplane=https://192.168.121.70:2380 --key-file=/etc/kubernetes/pki/etcd/server.key --listen-client-urls=https://127.0.0.1:2379,https://192.168.121.70:2379 --listen-metrics-urls=http://127.0.0.1:2381 --listen-peer-urls=https://192.168.121.70:2380 --name=controlplane --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt --peer-client-cert-auth=true --peer-key-file=/etc/kubernetes/pki/etcd/peer.key --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt --snapshot-count=10000 --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
root        2310       1  1 19:38 ?        00:00:33 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime-endpoint=unix:///run/containerd/containerd.sock --pod-infra-container-image=registry.k8s.io/pause:3.9
root        2338       1  0 19:38 ?        00:00:00 /usr/bin/kubectl proxy --port=8888 --address=0.0.0.0 --accept-hosts=^.*$ --kubeconfig /root/.kube/config
root        6380    6094  0 20:08 ?        00:00:00 /home/weave/kube-utils -run-reclaim-daemon -node-name=controlplane -peer-name=3a:d2:d9:ea:3c:f3 -log-level=debug
root        8406    5522  0 20:13 pts/0    00:00:00 grep --color=auto kube

root@controlplane ~ ➜  


root@controlplane ~ ✖ kubectl logs kube-proxy-zcjxq -n kube-system
E0630 20:14:52.475841       1 run.go:74] "command failed" err="failed complete: open /var/lib/kube-proxy/configuration.conf: no such file or directory"

root@controlplane ~ ➜  

root@controlplane ~ ➜  ls /var/lib/ | grep -i kub
kubelet

root@controlplane ~ ➜  date
Sun Jun 30 08:19:31 PM UTC 2024

root@controlplane ~ ➜  
~~~~


"command failed" err="failed complete: open /var/lib/kube-proxy/configuration.conf: no such file or directory"
"command failed" err="failed complete: open /var/lib/kube-proxy/configuration.conf: no such file or directory"
"command failed" err="failed complete: open /var/lib/kube-proxy/configuration.conf: no such file or directory"


kubectl describe pod kube-proxy-zcjxq -n kube-system

kubectl exec -ti kube-proxy-zcjxq -n kube-system sh


root@controlplane ~ ➜  kubectl exec -ti kube-proxy-zcjxq -n kube-system sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
error: Internal error occurred: unable to upgrade connection: container not found ("kube-proxy")

root@controlplane ~ ✖ 


root@controlplane ~ ➜  kubectl exec -ti kube-proxy-zcjxq -n kube-system sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
error: Internal error occurred: unable to upgrade connection: container not found ("kube-proxy")

root@controlplane ~ ✖ kubectl get pods -A -w
NAMESPACE     NAME                                   READY   STATUS             RESTARTS        AGE
kube-system   coredns-7db6d8ff4d-8677r               1/1     Running            0               51m
kube-system   coredns-7db6d8ff4d-rdgcc               1/1     Running            0               51m
kube-system   etcd-controlplane                      1/1     Running            0               51m
kube-system   kube-apiserver-controlplane            1/1     Running            0               51m
kube-system   kube-controller-manager-controlplane   1/1     Running            0               51m
kube-system   kube-proxy-zcjxq                       0/1     CrashLoopBackOff   8 (4m33s ago)   20m
kube-system   kube-scheduler-controlplane            1/1     Running            0               51m
kube-system   weave-net-gk4pt                        2/2     Running            0               21m
triton        mysql                                  1/1     Running            0               20m
triton        webapp-mysql-6b5cd9ff5c-bp88f          1/1     Running            0               20m
^C
root@controlplane ~ ✖ 



<https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/#is-the-kube-proxy-working>

~~~~bash

root@controlplane ~ ✖ kubectl get ds kube-proxy -n kube-system -o yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  annotations:
    deprecated.daemonset.template.generation: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"DaemonSet","metadata":{"annotations":{"deprecated.daemonset.template.generation":"1"},"creationTimestamp":"2023-01-03T14:59:22Z","generation":1,"labels":{"k8s-app":"kube-proxy"},"name":"kube-proxy","namespace":"kube-system","resourceVersion":"384","uid":"d659f145-038d-4a56-8ec3-15888682569a"},"spec":{"revisionHistoryLimit":10,"selector":{"matchLabels":{"k8s-app":"kube-proxy"}},"template":{"metadata":{"creationTimestamp":null,"labels":{"k8s-app":"kube-proxy"}},"spec":{"containers":[{"command":["/usr/local/bin/kube-proxy","--config=/var/lib/kube-proxy/configuration.conf","--hostname-override=$(NODE_NAME)"],"env":[{"name":"NODE_NAME","valueFrom":{"fieldRef":{"apiVersion":"v1","fieldPath":"spec.nodeName"}}}],"image":"registry.k8s.io/kube-proxy:v1.26.0","imagePullPolicy":"IfNotPresent","name":"kube-proxy","resources":{},"securityContext":{"privileged":true},"terminationMessagePath":"/dev/termination-log","terminationMessagePolicy":"File","volumeMounts":[{"mountPath":"/var/lib/kube-proxy","name":"kube-proxy"},{"mountPath":"/run/xtables.lock","name":"xtables-lock"},{"mountPath":"/lib/modules","name":"lib-modules","readOnly":true}]}],"dnsPolicy":"ClusterFirst","hostNetwork":true,"nodeSelector":{"kubernetes.io/os":"linux"},"priorityClassName":"system-node-critical","restartPolicy":"Always","schedulerName":"default-scheduler","securityContext":{},"serviceAccount":"kube-proxy","serviceAccountName":"kube-proxy","terminationGracePeriodSeconds":30,"tolerations":[{"operator":"Exists"}],"volumes":[{"configMap":{"defaultMode":420,"name":"kube-proxy"},"name":"kube-proxy"},{"hostPath":{"path":"/run/xtables.lock","type":"FileOrCreate"},"name":"xtables-lock"},{"hostPath":{"path":"/lib/modules","type":""},"name":"lib-modules"}]}},"updateStrategy":{"rollingUpdate":{"maxSurge":0,"maxUnavailable":1},"type":"RollingUpdate"}}}
  creationTimestamp: "2024-06-30T20:09:02Z"
  generation: 1
  labels:
    k8s-app: kube-proxy
  name: kube-proxy
  namespace: kube-system
  resourceVersion: "4313"
  uid: 85b691b3-2f13-41e7-b61e-0064b671bf19
spec:
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      k8s-app: kube-proxy
  template:
    metadata:
      creationTimestamp: null
      labels:
        k8s-app: kube-proxy
    spec:
      containers:
      - command:
        - /usr/local/bin/kube-proxy
        - --config=/var/lib/kube-proxy/configuration.conf
        - --hostname-override=$(NODE_NAME)
        env:
        - name: NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        image: registry.k8s.io/kube-proxy:v1.26.0
        imagePullPolicy: IfNotPresent
        name: kube-proxy
        resources: {}
        securityContext:
          privileged: true
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /var/lib/kube-proxy
          name: kube-proxy
        - mountPath: /run/xtables.lock
          name: xtables-lock
        - mountPath: /lib/modules
          name: lib-modules
          readOnly: true
      dnsPolicy: ClusterFirst
      hostNetwork: true
      nodeSelector:
        kubernetes.io/os: linux
      priorityClassName: system-node-critical
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      serviceAccount: kube-proxy
      serviceAccountName: kube-proxy
      terminationGracePeriodSeconds: 30
      tolerations:
      - operator: Exists
      volumes:
      - configMap:
          defaultMode: 420
          name: kube-proxy
        name: kube-proxy
      - hostPath:
          path: /run/xtables.lock
          type: FileOrCreate
        name: xtables-lock
      - hostPath:
          path: /lib/modules
          type: ""
        name: lib-modules
  updateStrategy:
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
    type: RollingUpdate
status:
  currentNumberScheduled: 1
  desiredNumberScheduled: 1
  numberMisscheduled: 0
  numberReady: 0
  numberUnavailable: 1
  observedGeneration: 1
  updatedNumberScheduled: 1

root@controlplane ~ ➜  
~~~~



<https://github.com/kubernetes/kube-proxy>

<https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-reconfigure/>

Applying kube-proxy configuration changes
Updating the KubeProxyConfiguration

During cluster creation and upgrade, kubeadm writes its KubeProxyConfiguration in a ConfigMap in the kube-system namespace called kube-proxy.

This ConfigMap is used by the kube-proxy DaemonSet in the kube-system namespace.

To change a particular option in the KubeProxyConfiguration, you can edit the ConfigMap with this command:

kubectl edit cm -n kube-system kube-proxy

The configuration is located under the data.config.conf key.
Reflecting the kube-proxy changes

Once the kube-proxy ConfigMap is updated, you can restart all kube-proxy Pods:

Obtain the Pod names:

kubectl get po -n kube-system | grep kube-proxy

Delete a Pod with:

kubectl delete po -n kube-system <pod-name>

New Pods that use the updated ConfigMap will be created.
Note:
Because kubeadm deploys kube-proxy as a DaemonSet, node specific configuration is unsupported.



kubectl get cm -n kube-system kube-proxy

~~~~bash


root@controlplane ~ ➜  kubectl get cm -n kube-system kube-proxy
NAME         DATA   AGE
kube-proxy   2      67m

root@controlplane ~ ➜  date
Sun Jun 30 08:46:00 PM UTC 2024

root@controlplane ~ ➜  
~~~~

kubectl edit cm -n kube-system kube-proxy
