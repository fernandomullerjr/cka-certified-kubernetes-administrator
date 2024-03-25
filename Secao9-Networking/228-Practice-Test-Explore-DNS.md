
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







How is the Corefile passed into the CoreDNS POD?



What is the name of the ConfigMap object created for Corefile?




What is the root domain/zone configured for this kubernetes cluster?

cluster.local









We have deployed a set of PODs and Services in the default and payroll namespaces. Inspect them and go to the next question.





What name can be used to access the hr web server from the test Application?

You can execute a curl command on the test pod to test. Alternatively, the test Application also has a UI. Access it using the tab at the top of your terminal named test-app.


controlplane ~ ✖ kubectl describe pod hr
Name:             hr
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.0.44.9
Start Time:       Mon, 25 Mar 2024 22:46:16 +0000
Labels:           name=hr
Annotations:      <none>
Status:           Running
IP:               10.244.0.5
IPs:
  IP:  10.244.0.5
Containers:
  web:
    Container ID:  containerd://180ddc8eb5464a5ba495e2cd12accd8571a5e3082071405cc6c4730d9a94997d
    Image:         nicolaka/netshoot:v0.11
    Image ID:      docker.io/nicolaka/netshoot@sha256:a7c92e1a2fb9287576a16e107166fee7f9925e15d2c1a683dbb1f4370ba9bfe8
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/sh
    Args:
      -c
      while true; do echo -e "HTTP/1.1 200 OK\n\n This is the HR server!" | nc -l -p 80 -q 1; done
    State:          Running
      Started:      Mon, 25 Mar 2024 22:46:28 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-whj5m (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-whj5m:
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
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  9m33s  default-scheduler  Successfully assigned default/hr to controlplane
  Normal  Pulling    9m32s  kubelet            Pulling image "nicolaka/netshoot:v0.11"
  Normal  Pulled     9m21s  kubelet            Successfully pulled image "nicolaka/netshoot:v0.11" in 318ms (10.887s including waiting)
  Normal  Created    9m21s  kubelet            Created container web
  Normal  Started    9m21s  kubelet            Started container web

controlplane ~ ➜  kubectl describe pod test
Name:             test
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.0.44.9
Start Time:       Mon, 25 Mar 2024 22:46:16 +0000
Labels:           name=test
Annotations:      <none>
Status:           Running
IP:               10.244.0.6
IPs:
  IP:  10.244.0.6
Containers:
  test:
    Container ID:   containerd://89de54e4f127d3f953fd4bbc98bdf6ee04d55821ef50c9f2c752ba2df5c71048
    Image:          kodekloud/webapp-conntest:web
    Image ID:       docker.io/kodekloud/webapp-conntest@sha256:9deb1325274bcdf0256629133c693ed9fb4899cff147c9169f905d7b273d0a99
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 25 Mar 2024 22:46:34 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      APP_NAME:  Test Application
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-mkvl9 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-mkvl9:
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
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  9m36s  default-scheduler  Successfully assigned default/test to controlplane
  Normal  Pulling    9m35s  kubelet            Pulling image "kodekloud/webapp-conntest:web"
  Normal  Pulled     9m18s  kubelet            Successfully pulled image "kodekloud/webapp-conntest:web" in 5.9s (16.693s including waiting)
  Normal  Created    9m18s  kubelet            Created container test
  Normal  Started    9m18s  kubelet            Started container test

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get svc -A
NAMESPACE     NAME           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE
default       kubernetes     ClusterIP   10.96.0.1        <none>        443/TCP                  15m
default       test-service   NodePort    10.107.76.20     <none>        80:30080/TCP             10m
default       web-service    ClusterIP   10.101.222.14    <none>        80/TCP                   10m
kube-system   kube-dns       ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   15m
payroll       web-service    ClusterIP   10.103.240.216   <none>        80/TCP                   10m

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pod hr
NAME   READY   STATUS    RESTARTS   AGE
hr     1/1     Running   0          11m

controlplane ~ ➜  kubectl get pod hr -o wide
NAME   READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
hr     1/1     Running   0          11m   10.244.0.5   controlplane   <none>           <none>

controlplane ~ ➜  kubectl describe pod hr
Name:             hr
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.0.44.9
Start Time:       Mon, 25 Mar 2024 22:46:16 +0000
Labels:           name=hr
Annotations:      <none>
Status:           Running
IP:               10.244.0.5
IPs:
  IP:  10.244.0.5
Containers:
  web:
    Container ID:  containerd://180ddc8eb5464a5ba495e2cd12accd8571a5e3082071405cc6c4730d9a94997d
    Image:         nicolaka/netshoot:v0.11
    Image ID:      docker.io/nicolaka/netshoot@sha256:a7c92e1a2fb9287576a16e107166fee7f9925e15d2c1a683dbb1f4370ba9bfe8
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/sh
    Args:
      -c
      while true; do echo -e "HTTP/1.1 200 OK\n\n This is the HR server!" | nc -l -p 80 -q 1; done
    State:          Running
      Started:      Mon, 25 Mar 2024 22:46:28 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-whj5m (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-whj5m:
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
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  11m   default-scheduler  Successfully assigned default/hr to controlplane
  Normal  Pulling    11m   kubelet            Pulling image "nicolaka/netshoot:v0.11"
  Normal  Pulled     11m   kubelet            Successfully pulled image "nicolaka/netshoot:v0.11" in 318ms (10.887s including waiting)
  Normal  Created    11m   kubelet            Created container web
  Normal  Started    11m   kubelet            Started container web

controlplane ~ ➜  
controlplane ~ ➜  kubectl describe service web-service
Name:              web-service
Namespace:         default
Labels:            <none>
Annotations:       <none>
Selector:          name=hr
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.101.222.14
IPs:               10.101.222.14
Port:              <unset>  80/TCP
TargetPort:        80/TCP
Endpoints:         10.244.0.5:80
Session Affinity:  None
Events:            <none>

controlplane ~ ➜  


- Pela UI nao funcionou
https://30080-port-1d4e1c8c80224d61.labs.kodekloud.com/#!/view1
sem comunicacao com "web-service"

- Via terminal foi:

controlplane ~ ➜  kubectl exec -ti test sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
/opt/webapp-conntest # 
/opt/webapp-conntest # 
/opt/webapp-conntest # 
/opt/webapp-conntest # curl web-service
 This is the HR server!
/opt/webapp-conntest # 