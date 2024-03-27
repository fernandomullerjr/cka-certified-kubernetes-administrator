
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










Which of the names CANNOT be used to access the HR service from the test pod?





Which of the below name can be used to access the payroll service from the test application?


controlplane ~ ➜  kubectl get svc -A
NAMESPACE     NAME           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE
default       kubernetes     ClusterIP   10.96.0.1        <none>        443/TCP                  22m
default       test-service   NodePort    10.107.76.20     <none>        80:30080/TCP             16m
default       web-service    ClusterIP   10.101.222.14    <none>        80/TCP                   16m
kube-system   kube-dns       ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   22m
payroll       web-service    ClusterIP   10.103.240.216   <none>        80/TCP                   16m

controlplane ~ ➜  









Which of the below name CANNOT be used to access the payroll service from the test application?

cluster apenas não rola





We just deployed a web server - webapp - that accesses a database mysql - server. However the web server is failing to connect to the database server. Troubleshoot and fix the issue.

They could be in different namespaces. First locate the applications. The web server interface can be seen by clicking the tab Web Server at the top of your terminal.


controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        hr                                     1/1     Running   0          18m
default        simple-webapp-1                        1/1     Running   0          18m
default        simple-webapp-122                      1/1     Running   0          18m
default        test                                   1/1     Running   0          18m
default        webapp-b9548974b-24lln                 1/1     Running   0          39s
kube-flannel   kube-flannel-ds-dqnsc                  1/1     Running   0          23m
kube-system    coredns-69f9c977-hf5q5                 1/1     Running   0          23m
kube-system    coredns-69f9c977-wql52                 1/1     Running   0          23m
kube-system    etcd-controlplane                      1/1     Running   0          24m
kube-system    kube-apiserver-controlplane            1/1     Running   0          24m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          24m
kube-system    kube-proxy-zsxvv                       1/1     Running   0          23m
kube-system    kube-scheduler-controlplane            1/1     Running   0          24m
payroll        mysql                                  1/1     Running   0          39s
payroll        web                                    1/1     Running   0          18m

controlplane ~ ➜  


controlplane ~ ✖ kubectl describe pod web -n payroll
Name:             web
Namespace:        payroll
Priority:         0
Service Account:  default
Node:             controlplane/192.0.44.9
Start Time:       Mon, 25 Mar 2024 22:46:16 +0000
Labels:           name=web
Annotations:      <none>
Status:           Running
IP:               10.244.0.4
IPs:
  IP:  10.244.0.4
Containers:
  web:
    Container ID:  containerd://ee73d018bdfc565615dfe555770168e237976b4daf6acfb3e3b9d17ce3d09a95
    Image:         nicolaka/netshoot:v0.11
    Image ID:      docker.io/nicolaka/netshoot@sha256:a7c92e1a2fb9287576a16e107166fee7f9925e15d2c1a683dbb1f4370ba9bfe8
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/sh
    Args:
      -c
      while true; do echo -e "HTTP/1.1 200 OK\n\n This is the PayRoll server!" | nc -l -p 80 -q 1; done
    State:          Running
      Started:      Mon, 25 Mar 2024 22:46:28 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-26dmz (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-26dmz:
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
  Normal  Scheduled  19m   default-scheduler  Successfully assigned payroll/web to controlplane
  Normal  Pulling    19m   kubelet            Pulling image "nicolaka/netshoot:v0.11"
  Normal  Pulled     19m   kubelet            Successfully pulled image "nicolaka/netshoot:v0.11" in 10.78s (10.78s including waiting)
  Normal  Created    19m   kubelet            Created container web
  Normal  Started    19m   kubelet            Started container web

controlplane ~ ➜  

UI com erro
https://30082-port-1d4e1c8c80224d61.labs.kodekloud.com/
 Environment Variables: DB_Host=mysql; DB_Database=Not Set; DB_User=root; DB_Password=paswrd; 2003: Can't connect to MySQL server on 'mysql:3306' (-2 Name does not resolve)

From webapp-b9548974b-24lln!


controlplane ~ ➜  kubectl get svc -A
NAMESPACE     NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE
default       kubernetes       ClusterIP   10.96.0.1        <none>        443/TCP                  26m
default       test-service     NodePort    10.107.76.20     <none>        80:30080/TCP             20m
default       web-service      ClusterIP   10.101.222.14    <none>        80/TCP                   20m
default       webapp-service   NodePort    10.102.212.10    <none>        8080:30082/TCP           2m46s
kube-system   kube-dns         ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   26m
payroll       mysql            ClusterIP   10.104.10.217    <none>        3306/TCP                 2m46s
payroll       web-service      ClusterIP   10.103.240.216   <none>        80/TCP                   20m

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe service mysql -n payroll
Name:              mysql
Namespace:         payroll
Labels:            <none>
Annotations:       <none>
Selector:          name=mysql
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.104.10.217
IPs:               10.104.10.217
Port:              <unset>  3306/TCP
TargetPort:        3306/TCP
Endpoints:         10.244.0.10:3306
Session Affinity:  None
Events:            <none>

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe pod mysql -n payroll
Name:             mysql
Namespace:        payroll
Priority:         0
Service Account:  default
Node:             controlplane/192.0.44.9
Start Time:       Mon, 25 Mar 2024 23:04:19 +0000
Labels:           name=mysql
Annotations:      <none>
Status:           Running
IP:               10.244.0.10
IPs:
  IP:  10.244.0.10
Containers:
  mysql:
    Container ID:   containerd://27fba79924fe7889086aec40779a8387ee997f356404be5e615adcaa2d365808
    Image:          mysql:5.6
    Image ID:       docker.io/library/mysql@sha256:20575ecebe6216036d25dab5903808211f1e9ba63dc7825ac20cb975e34cfcae
    Port:           3306/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 25 Mar 2024 23:04:30 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      MYSQL_ROOT_PASSWORD:  paswrd
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-gcwjd (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-gcwjd:
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
  Normal  Scheduled  3m46s  default-scheduler  Successfully assigned payroll/mysql to controlplane
  Normal  Pulling    3m45s  kubelet            Pulling image "mysql:5.6"
  Normal  Pulled     3m35s  kubelet            Successfully pulled image "mysql:5.6" in 6.649s (10.031s including waiting)
  Normal  Created    3m35s  kubelet            Created container mysql
  Normal  Started    3m35s  kubelet            Started container mysql

controlplane ~ ➜  

Erro na UI diz algo sobre não resolver nomes
Can't connect to MySQL server on 'mysql:3306' (-2 Name does not resolve) 

Revisando se o Pod do coredns está ok

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        hr                                     1/1     Running   0          22m
default        simple-webapp-1                        1/1     Running   0          22m
default        simple-webapp-122                      1/1     Running   0          22m
default        test                                   1/1     Running   0          22m
default        webapp-b9548974b-24lln                 1/1     Running   0          4m36s
kube-flannel   kube-flannel-ds-dqnsc                  1/1     Running   0          27m
kube-system    coredns-69f9c977-hf5q5                 1/1     Running   0          27m
kube-system    coredns-69f9c977-wql52                 1/1     Running   0          27m
kube-system    etcd-controlplane                      1/1     Running   0          28m
kube-system    kube-apiserver-controlplane            1/1     Running   0          28m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          28m
kube-system    kube-proxy-zsxvv                       1/1     Running   0          27m
kube-system    kube-scheduler-controlplane            1/1     Running   0          28m
payroll        mysql                                  1/1     Running   0          4m36s
payroll        web                                    1/1     Running   0          22m

controlplane ~ ➜  


controlplane ~ ➜  kubectl exec -n payroll -ti web sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
~ # 
~ # ps
PID   USER     TIME  COMMAND
    1 root      0:00 /bin/sh -c while true; do echo -e "HTTP/1.1 200 OK\n\n This is the PayRoll server!" | nc -l -p 80 -q 1; done
   57 root      0:00 nc -l -p 80 -q 1
   58 root      0:00 sh
   64 root      0:00 ps
~ # ls
motd
~ # nslookup mysql
Server:         10.96.0.10
Address:        10.96.0.10#53

Name:   mysql.payroll.svc.cluster.local
Address: 10.104.10.217

~ # 


controlplane ~ ➜  kubectl exec -ti simple-webapp-1 sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
/opt/webapp # ls
Dockerfile        app.py            requirements.txt  templates
/opt/webapp # ps
PID   USER     TIME  COMMAND
    1 root      0:00 python /opt/webapp/app.py
   56 root      0:00 sh
   63 root      0:00 ps
/opt/webapp # cat /opt/webapp/app.py
from flask import Flask
from flask import render_template, request
import socket
import os
import time

app = Flask(__name__)

# Get start delay from Environment variable
DELAY_FROM_ENV = os.environ.get('APP_START_DELAY') or 0
FROZEN = False


def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()


@app.route("/")
def main():
    if not FROZEN:
        # return 'Hello'
        return render_template('hello.html', name=socket.gethostname(), color='#16a085')


@app.route("/hostname")
def hostname():
    if not FROZEN:
        return socket.gethostname()


@app.route("/ready")
def ready():
    if not FROZEN:
        return "Message from {0} : I am ready!".format(socket.gethostname())


@app.route("/live")
def live():
    if not FROZEN:
        return "Message from {0} : I am live!".format(socket.gethostname())


@app.route("/crash")
def crash():
    shutdown_server()
    print("Message from {0} : Mayday! Mayday! Going to crash!".format(socket.gethostname()))
    return "Message from {0} : Mayday! Mayday! Going to crash!".format(socket.gethostname())


@app.route("/freeze")
def freeze():
    global FROZEN
    FROZEN = True
    while True:
        print("Message from {0} : Bad Code! I am stuck!".format(socket.gethostname()))
        time.sleep(2)


if __name__ == "__main__":

    if DELAY_FROM_ENV:
        print("Warming Up Application. Will take {0} seconds to finish.".format(DELAY_FROM_ENV))
        time.sleep(int(DELAY_FROM_ENV))

    print("Application Ready!")
    # Run Flask Application
    app.run(host="0.0.0.0", port=8080)/opt/webapp # 

    
/opt/webapp # env
KUBERNETES_SERVICE_PORT=443
KUBERNETES_PORT=tcp://10.96.0.1:443
HOSTNAME=simple-webapp-1
PYTHON_PIP_VERSION=18.1
SHLVL=1
WEB_SERVICE_PORT=tcp://10.101.222.14:80
WEB_SERVICE_SERVICE_PORT=80
HOME=/root
GPG_KEY=0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D
TEST_SERVICE_SERVICE_HOST=10.107.76.20
WEB_SERVICE_PORT_80_TCP_ADDR=10.101.222.14
WEB_SERVICE_PORT_80_TCP_PORT=80
WEB_SERVICE_PORT_80_TCP_PROTO=tcp
TEST_SERVICE_SERVICE_PORT=80
TEST_SERVICE_PORT=tcp://10.107.76.20:80
TERM=xterm
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
KUBERNETES_PORT_443_TCP_PORT=443
TEST_SERVICE_PORT_80_TCP_ADDR=10.107.76.20
KUBERNETES_PORT_443_TCP_PROTO=tcp
LANG=C.UTF-8
WEB_SERVICE_PORT_80_TCP=tcp://10.101.222.14:80
TEST_SERVICE_PORT_80_TCP_PORT=80
TEST_SERVICE_PORT_80_TCP_PROTO=tcp
PYTHON_VERSION=3.7.1
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_SERVICE_HOST=10.96.0.1
PWD=/opt/webapp
TEST_SERVICE_PORT_80_TCP=tcp://10.107.76.20:80
WEB_SERVICE_SERVICE_HOST=10.101.222.14
/opt/webapp # 


controlplane ~ ➜  kubectl exec -ti webapp-b9548974b-24lln sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
/opt/webapp-mysql # ls
Dockerfile        app.py            kube-files        requirements.txt  static            templates
/opt/webapp-mysql # ls -lhasp
total 36
     4 drwxr-xr-x    1 root     root        4.0K Aug  4  2018 ./
     8 drwxr-xr-x    1 root     root        4.0K Aug  4  2018 ../
     4 -rw-rw-r--    1 root     root         214 Aug  4  2018 Dockerfile
     4 -rw-rw-r--    1 root     root        1.5K Aug  4  2018 app.py
     4 drwxrwxr-x    2 root     root        4.0K Aug  4  2018 kube-files/
     4 -rw-rw-r--    1 root     root          29 Aug  4  2018 requirements.txt
     4 drwxrwxr-x    3 root     root        4.0K Aug  4  2018 static/
     4 drwxrwxr-x    2 root     root        4.0K Aug  4  2018 templates/
/opt/webapp-mysql # ps
PID   USER     TIME  COMMAND
    1 root      0:00 python /opt/webapp-mysql/app.py
   61 root      0:00 sh
   69 root      0:00 ps
/opt/webapp-mysql # env
KUBERNETES_SERVICE_PORT=443
KUBERNETES_PORT=tcp://10.96.0.1:443
WEBAPP_SERVICE_PORT_8080_TCP=tcp://10.102.212.10:8080
HOSTNAME=webapp-b9548974b-24lln
PYTHON_PIP_VERSION=18.0
SHLVL=1
WEB_SERVICE_SERVICE_PORT=80
WEB_SERVICE_PORT=tcp://10.101.222.14:80
HOME=/root
GPG_KEY=0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D
TEST_SERVICE_SERVICE_HOST=10.107.76.20
WEB_SERVICE_PORT_80_TCP_ADDR=10.101.222.14
DB_Host=mysql
WEB_SERVICE_PORT_80_TCP_PORT=80
DB_User=root
WEB_SERVICE_PORT_80_TCP_PROTO=tcp
TEST_SERVICE_PORT=tcp://10.107.76.20:80
TEST_SERVICE_SERVICE_PORT=80
TERM=xterm
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
KUBERNETES_PORT_443_TCP_PORT=443
DB_Password=paswrd
TEST_SERVICE_PORT_80_TCP_ADDR=10.107.76.20
KUBERNETES_PORT_443_TCP_PROTO=tcp
LANG=C.UTF-8
WEB_SERVICE_PORT_80_TCP=tcp://10.101.222.14:80
TEST_SERVICE_PORT_80_TCP_PORT=80
TEST_SERVICE_PORT_80_TCP_PROTO=tcp
PYTHON_VERSION=3.7.0
WEBAPP_SERVICE_PORT_8080_TCP_ADDR=10.102.212.10
WEBAPP_SERVICE_SERVICE_HOST=10.102.212.10
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
KUBERNETES_SERVICE_PORT_HTTPS=443
WEBAPP_SERVICE_PORT_8080_TCP_PORT=8080
WEBAPP_SERVICE_PORT_8080_TCP_PROTO=tcp
KUBERNETES_SERVICE_HOST=10.96.0.1
PWD=/opt/webapp-mysql
TEST_SERVICE_PORT_80_TCP=tcp://10.107.76.20:80
WEBAPP_SERVICE_SERVICE_PORT=8080
WEBAPP_SERVICE_PORT=tcp://10.102.212.10:8080
WEB_SERVICE_SERVICE_HOST=10.101.222.14
/opt/webapp-mysql # 


/opt/webapp-mysql # export DB_Host=mysql.payroll


/opt/webapp-mysql # env | grep -i db_
DB_Host=mysql.payroll
DB_User=root
DB_Password=paswrd
/opt/webapp-mysql # 


controlplane ~ ➜  kubectl get svc -A
NAMESPACE     NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE
default       kubernetes       ClusterIP   10.96.0.1        <none>        443/TCP                  35m
default       test-service     NodePort    10.107.76.20     <none>        80:30080/TCP             30m
default       web-service      ClusterIP   10.101.222.14    <none>        80/TCP                   30m
default       webapp-service   NodePort    10.102.212.10    <none>        8080:30082/TCP           12m
kube-system   kube-dns         ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   35m
payroll       mysql            ClusterIP   10.104.10.217    <none>        3306/TCP                 12m
payroll       web-service      ClusterIP   10.103.240.216   <none>        80/TCP                   30m

controlplane ~ ➜  
Environment Variables: DB_Host=mysql; DB_Database=Not Set; DB_User=root; DB_Password=paswrd; 2003: Can't connect to MySQL server on 'mysql:3306' (-2 Name does not resolve)

From webapp-b9548974b-24lln!

controlplane ~ ➜  kubectl get configmap -A
NAMESPACE         NAME                                                   DATA   AGE
default           kube-root-ca.crt                                       1      37m
hr                kube-root-ca.crt                                       1      31m
kube-flannel      kube-flannel-cfg                                       2      37m
kube-flannel      kube-root-ca.crt                                       1      37m
kube-node-lease   kube-root-ca.crt                                       1      37m
kube-public       cluster-info                                           2      37m
kube-public       kube-root-ca.crt                                       1      37m
kube-system       coredns                                                1      37m
kube-system       extension-apiserver-authentication                     6      37m
kube-system       kube-apiserver-legacy-service-account-token-tracking   1      37m
kube-system       kube-proxy                                             2      37m
kube-system       kube-root-ca.crt                                       1      37m
kube-system       kubeadm-config                                         1      37m
kube-system       kubelet-config                                         1      37m
payroll           kube-root-ca.crt                                       1      31m

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe pod webapp-b9548974b-24lln
Name:             webapp-b9548974b-24lln
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.0.44.9
Start Time:       Mon, 25 Mar 2024 23:04:19 +0000
Labels:           name=webapp
                  pod-template-hash=b9548974b
Annotations:      <none>
Status:           Running
IP:               10.244.0.9
IPs:
  IP:           10.244.0.9
Controlled By:  ReplicaSet/webapp-b9548974b
Containers:
  simple-webapp-mysql:
    Container ID:   containerd://b24f1b0e09e9bfb42afcdcbaafec9219c46e88ba9a0d19cab2ac50f3e809f3af
    Image:          mmumshad/simple-webapp-mysql
    Image ID:       docker.io/mmumshad/simple-webapp-mysql@sha256:d4d0c03fcb76cee6ae2511fa7f3f6b7090f0c5e0cb3f276687f9ddf2c689cc09
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 25 Mar 2024 23:04:23 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      DB_Host:      mysql
      DB_User:      root
      DB_Password:  paswrd
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-gdbcm (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-gdbcm:
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
  Normal  Scheduled  14m   default-scheduler  Successfully assigned default/webapp-b9548974b-24lln to controlplane
  Normal  Pulling    14m   kubelet            Pulling image "mmumshad/simple-webapp-mysql"
  Normal  Pulled     14m   kubelet            Successfully pulled image "mmumshad/simple-webapp-mysql" in 3.427s (3.427s including waiting)
  Normal  Created    14m   kubelet            Created container simple-webapp-mysql
  Normal  Started    14m   kubelet            Started container simple-webapp-mysql

controlplane ~ ➜  


controlplane ~ ➜  kubectl get all
NAME                         READY   STATUS    RESTARTS   AGE
pod/hr                       1/1     Running   0          32m
pod/simple-webapp-1          1/1     Running   0          32m
pod/simple-webapp-122        1/1     Running   0          32m
pod/test                     1/1     Running   0          32m
pod/webapp-b9548974b-24lln   1/1     Running   0          14m

NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.96.0.1       <none>        443/TCP          38m
service/test-service     NodePort    10.107.76.20    <none>        80:30080/TCP     32m
service/web-service      ClusterIP   10.101.222.14   <none>        80/TCP           32m
service/webapp-service   NodePort    10.102.212.10   <none>        8080:30082/TCP   14m

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp   1/1     1            1           14m

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-b9548974b   1         1         1       14m

controlplane ~ ➜  kubectl edit deployment webapp
deployment.apps/webapp edited

controlplane ~ ➜  

- OK após ajuste da variavel no Deployment, para "mysql.payroll":
Environment Variables: DB_Host=mysql.payroll; DB_Database=Not Set; DB_User=root; DB_Password=paswrd;

From webapp-744595c5c5-825r2!
















From the hr pod nslookup the mysql service and redirect the output to a file /root/CKA/nslookup.out

controlplane ~ ➜  kubectl exec -ti hr sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
~ # 
~ # 
~ # nslookup mysql > /root/CKA/nslookup.out
sh: can't create /root/CKA/nslookup.out: nonexistent directory
~ # mkdir /root/CKA
~ # 
~ # 
~ # nslookup mysql > /root/CKA/nslookup.out
~ # 



controlplane ~ ➜  kubectl exec hr nslookup mysql > /root/CKA/nslookup.out
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
command terminated with exit code 1

controlplane ~ ✖ cat /root/CKA/nslookup.out
Server:         10.96.0.10
Address:        10.96.0.10#53

** server can't find mysql: NXDOMAIN


controlplane ~ ➜  
controlplane ~ ➜  kubectl exec -ti hr sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
~ # 
~ # nslookup mysql.payroll > /root/CKA/nslookup.out
~ # 
~ # cat /root/CKA/nslookup.out 
Server:         10.96.0.10
Address:        10.96.0.10#53

Name:   mysql.payroll.svc.cluster.local
Address: 10.104.10.217

~ # date
Mon Mar 25 23:22:42 UTC 2024
~ # 
controlplane ~ ➜  kubectl exec hr nslookup mysql.payroll > /root/CKA/nslookup.out
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.

controlplane ~ ➜  cat /root/CKA/nslookup.out
Server:         10.96.0.10
Address:        10.96.0.10#53

Name:   mysql.payroll.svc.cluster.local
Address: 10.104.10.217


controlplane ~ ➜  