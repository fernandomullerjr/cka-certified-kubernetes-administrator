
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "228. Practice Test - Explore DNS."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##   228. Practice Test - Explore DNS


Identify the DNS solution implemented in this cluster.


controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        hr                                     1/1     Running   0          46s
default        simple-webapp-1                        1/1     Running   0          33s
default        simple-webapp-122                      1/1     Running   0          33s
default        test                                   1/1     Running   0          46s
kube-flannel   kube-flannel-ds-dqnsc                  1/1     Running   0          5m57s
kube-system    coredns-69f9c977-hf5q5                 1/1     Running   0          5m57s
kube-system    coredns-69f9c977-wql52                 1/1     Running   0          5m57s
kube-system    etcd-controlplane                      1/1     Running   0          6m11s
kube-system    kube-apiserver-controlplane            1/1     Running   0          6m11s
kube-system    kube-controller-manager-controlplane   1/1     Running   0          6m13s
kube-system    kube-proxy-zsxvv                       1/1     Running   0          5m57s
kube-system    kube-scheduler-controlplane            1/1     Running   0          6m11s
payroll        web                                    1/1     Running   0          47s

controlplane ~ ➜  






How many pods of the DNS server are deployed?









What is the name of the service created for accessing CoreDNS?


controlplane ~ ➜  kubectl get svc -A
NAMESPACE     NAME           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE
default       kubernetes     ClusterIP   10.96.0.1        <none>        443/TCP                  6m52s
default       test-service   NodePort    10.107.76.20     <none>        80:30080/TCP             84s
default       web-service    ClusterIP   10.101.222.14    <none>        80/TCP                   84s
kube-system   kube-dns       ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   6m48s
payroll       web-service    ClusterIP   10.103.240.216   <none>        80/TCP                   84s

controlplane ~ ➜  





What is the IP of the CoreDNS server that should be configured on PODs to resolve services?

10.96.0.10









Where is the configuration file located for configuring the CoreDNS service?


controlplane ~ ➜  kubectl describe pod coredns-69f9c977-hf5q5 -n kube-system
Name:                 coredns-69f9c977-hf5q5
Namespace:            kube-system
Priority:             2000000000
Priority Class Name:  system-cluster-critical
Service Account:      coredns
Node:                 controlplane/192.0.44.9
Start Time:           Mon, 25 Mar 2024 22:41:07 +0000
Labels:               k8s-app=kube-dns
                      pod-template-hash=69f9c977
Annotations:          <none>
Status:               Running
IP:                   10.244.0.3
IPs:
  IP:           10.244.0.3
Controlled By:  ReplicaSet/coredns-69f9c977
Containers:
  coredns:
    Container ID:  containerd://7a2145106a6bc85b7362ffa0b158b7658a0ac3b8dc36d49043cb8b668d1638ee
    Image:         registry.k8s.io/coredns/coredns:v1.10.1
    Image ID:      registry.k8s.io/coredns/coredns@sha256:a0ead06651cf580044aeb0a0feba63591858fb2e43ade8c9dea45a6a89ae7e5e
    Ports:         53/UDP, 53/TCP, 9153/TCP
    Host Ports:    0/UDP, 0/TCP, 0/TCP
    Args:
      -conf
      /etc/coredns/Corefile
    State:          Running
      Started:      Mon, 25 Mar 2024 22:41:23 +0000
    Ready:          True
    Restart Count:  0
    Limits:
      memory:  170Mi
    Requests:
      cpu:        100m
      memory:     70Mi
    Liveness:     http-get http://:8080/health delay=60s timeout=5s period=10s #success=1 #failure=5
    Readiness:    http-get http://:8181/ready delay=0s timeout=1s period=10s #success=1 #failure=3
    Environment:  <none>
    Mounts:
      /etc/coredns from config-volume (ro)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-9pmj8 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  config-volume:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      coredns
    Optional:  false
  kube-api-access-9pmj8:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              kubernetes.io/os=linux
Tolerations:                 CriticalAddonsOnly op=Exists
                             node-role.kubernetes.io/control-plane:NoSchedule
                             node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason                  Age    From               Message
  ----     ------                  ----   ----               -------
  Warning  FailedScheduling        8m43s  default-scheduler  0/1 nodes are available: 1 node(s) had untolerated taint {node.kubernetes.io/not-ready: }. preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling.
  Normal   Scheduled               8m41s  default-scheduler  Successfully assigned kube-system/coredns-69f9c977-hf5q5 to controlplane
  Warning  FailedCreatePodSandBox  8m40s  kubelet            Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox "1c5275838d3a8aefbe65da77769fc2984070a0f6c3fba07f25e460b72f301af8": plugin type="flannel" failed (add): loadFlannelSubnetEnv failed: open /run/flannel/subnet.env: no such file or directory
  Normal   Pulled                  8m25s  kubelet            Container image "registry.k8s.io/coredns/coredns:v1.10.1" already present on machine
  Normal   Created                 8m25s  kubelet            Created container coredns
  Normal   Started                 8m25s  kubelet            Started container coredns

controlplane ~ ➜  


controlplane ~ ➜  kubectl get configmap
NAME               DATA   AGE
kube-root-ca.crt   1      9m13s

controlplane ~ ➜  kubectl get configmap -A
NAMESPACE         NAME                                                   DATA   AGE
default           kube-root-ca.crt                                       1      9m15s
hr                kube-root-ca.crt                                       1      4m4s
kube-flannel      kube-flannel-cfg                                       2      9m28s
kube-flannel      kube-root-ca.crt                                       1      9m15s
kube-node-lease   kube-root-ca.crt                                       1      9m15s
kube-public       cluster-info                                           2      9m29s
kube-public       kube-root-ca.crt                                       1      9m15s
kube-system       coredns                                                1      9m27s
kube-system       extension-apiserver-authentication                     6      9m32s
kube-system       kube-apiserver-legacy-service-account-token-tracking   1      9m32s
kube-system       kube-proxy                                             2      9m29s
kube-system       kube-root-ca.crt                                       1      9m15s
kube-system       kubeadm-config                                         1      9m30s
kube-system       kubelet-config                                         1      9m30s
payroll           kube-root-ca.crt                                       1      4m4s

controlplane ~ ➜  
controlplane ~ ➜  kubectl describe configmap coredns -n kube-system
Name:         coredns
Namespace:    kube-system
Labels:       <none>
Annotations:  <none>

Data
====
Corefile:
----
.:53 {
    errors
    health {
       lameduck 5s
    }
    ready
    kubernetes cluster.local in-addr.arpa ip6.arpa {
       pods insecure
       fallthrough in-addr.arpa ip6.arpa
       ttl 30
    }
    prometheus :9153
    forward . /etc/resolv.conf {
       max_concurrent 1000
    }
    cache 30
    loop
    reload
    loadbalance
}


BinaryData
====

Events:  <none>

controlplane ~ ➜  


/etc/coredns/Corefile



