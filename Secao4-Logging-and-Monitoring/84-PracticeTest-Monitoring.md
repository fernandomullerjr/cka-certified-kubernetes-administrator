
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 84. Practice Test - Monitoring"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
#  84. Practice Test - Monitoring




## 1

We have deployed a few PODs running workloads. Inspect them.

Wait for the pods to be ready before proceeding to the next question.

~~~~bash                                                      
controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        elephant                               1/1     Running   0          115s
default        lion                                   1/1     Running   0          115s
default        rabbit                                 1/1     Running   0          115s
kube-flannel   kube-flannel-ds-dl4ph                  1/1     Running   0          11m
kube-flannel   kube-flannel-ds-wqgst                  1/1     Running   0          11m
kube-system    coredns-787d4945fb-hn6hq               1/1     Running   0          11m
kube-system    coredns-787d4945fb-jdvl6               1/1     Running   0          11m
kube-system    etcd-controlplane                      1/1     Running   0          11m
kube-system    kube-apiserver-controlplane            1/1     Running   0          11m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          11m
kube-system    kube-proxy-644rj                       1/1     Running   0          11m
kube-system    kube-proxy-8mf4m                       1/1     Running   0          11m
kube-system    kube-scheduler-controlplane            1/1     Running   0          11m

controlplane ~ ➜  kubectl describe pod elephant
Name:             elephant
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/10.6.76.6
Start Time:       Tue, 07 Feb 2023 21:20:32 -0500
Labels:           <none>
Annotations:      <none>
Status:           Running
IP:               10.244.0.6
IPs:
  IP:  10.244.0.6
Containers:
  mem-stress:
    Container ID:  containerd://9bf44494b5b738b11bc04e33f2dd84475efb163b9616142dffd3d47414271a73
    Image:         polinux/stress
    Image ID:      docker.io/polinux/stress@sha256:b6144f84f9c15dac80deb48d3a646b55c7043ab1d83ea0a697c09097aaad21aa
    Port:          <none>
    Host Port:     <none>
    Command:
      stress
    Args:
      --vm
      1
      --vm-bytes
      30M
      --vm-hang
      1
    State:          Running
      Started:      Tue, 07 Feb 2023 21:20:44 -0500
    Ready:          True
    Restart Count:  0
    Limits:
      memory:  40Mi
    Requests:
      memory:     40Mi
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-xkw4r (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-xkw4r:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason   Age   From     Message
  ----    ------   ----  ----     -------
  Normal  Pulling  2m6s  kubelet  Pulling image "polinux/stress"
  Normal  Pulled   119s  kubelet  Successfully pulled image "polinux/stress" in 283.634255ms (7.223163714s including waiting)
  Normal  Created  119s  kubelet  Created container mem-stress
  Normal  Started  118s  kubelet  Started container mem-stress

controlplane ~ ➜  
~~~~











## 2

Let us deploy metrics-server to monitor the PODs and Nodes. Pull the git repository for the deployment files.


Run: git clone https://github.com/kodekloudhub/kubernetes-metrics-server.git


git clone https://github.com/kodekloudhub/kubernetes-metrics-server.git


~~~~bash
controlplane ~ ➜  git clone https://github.com/kodekloudhub/kubernetes-metrics-server.git
Cloning into 'kubernetes-metrics-server'...
remote: Enumerating objects: 28, done.
remote: Counting objects: 100% (16/16), done.
remote: Compressing objects: 100% (16/16), done.
remote: Total 28 (delta 6), reused 0 (delta 0), pack-reused 12
Unpacking objects: 100% (28/28), 7.38 KiB | 1.05 MiB/s, done.

controlplane ~ ➜  ls
kubernetes-metrics-server  sample.yaml

controlplane ~ ➜  
~~~~







## 3

Deploy the metrics-server by creating all the components downloaded.

Run the kubectl create -f . command from within the downloaded repository.

    Metrics server deployed?


~~~~bash
controlplane ~ ➜  ls
kubernetes-metrics-server  sample.yaml

controlplane ~ ➜  cd kubernetes-metrics-server/

controlplane kubernetes-metrics-server on  master ➜  

controlplane kubernetes-metrics-server on  master ➜  kubectl create -f .
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator created
rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created
serviceaccount/metrics-server created
deployment.apps/metrics-server created
service/metrics-server created
clusterrole.rbac.authorization.k8s.io/system:metrics-server created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server created

controlplane kubernetes-metrics-server on  master ➜  

controlplane kubernetes-metrics-server on  master ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        elephant                               1/1     Running   0          9m1s
default        lion                                   1/1     Running   0          9m1s
default        rabbit                                 1/1     Running   0          9m1s
kube-flannel   kube-flannel-ds-dl4ph                  1/1     Running   0          18m
kube-flannel   kube-flannel-ds-wqgst                  1/1     Running   0          18m
kube-system    coredns-787d4945fb-hn6hq               1/1     Running   0          18m
kube-system    coredns-787d4945fb-jdvl6               1/1     Running   0          18m
kube-system    etcd-controlplane                      1/1     Running   0          18m
kube-system    kube-apiserver-controlplane            1/1     Running   0          18m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          18m
kube-system    kube-proxy-644rj                       1/1     Running   0          18m
kube-system    kube-proxy-8mf4m                       1/1     Running   0          18m
kube-system    kube-scheduler-controlplane            1/1     Running   0          18m
kube-system    metrics-server-c4cdc7cc9-rb9sf         1/1     Running   0          41s

controlplane kubernetes-metrics-server on  master ➜  
~~~~









## 4

It takes a few minutes for the metrics server to start gathering data.

Run the kubectl top node command and wait for a valid output.

~~~~bash
controlplane kubernetes-metrics-server on  master ➜  kubectl top node
NAME           CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
controlplane   313m         0%     1238Mi          0%        
node01         36m          0%     333Mi           0%        

controlplane kubernetes-metrics-server on  master ➜  
~~~~





## 5
Identify the node that consumes the most CPU.

~~~~bash
controlplane kubernetes-metrics-server on  master ➜  kubectl top node
NAME           CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
controlplane   297m         0%     1244Mi          0%        
node01         34m          0%     341Mi           0%        

controlplane kubernetes-metrics-server on  master ➜  
~~~~






## 6

Identify the node that consumes the most Memory.

~~~~bash
controlplane ~ ✖ kubectl top node
NAME           CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
controlplane   301m         0%     1255Mi          0%        
node01         36m          0%     339Mi           0%        

controlplane ~ ➜  
~~~~



## 7 

Identify the POD that consumes the most Memory.

~~~~bash
controlplane ~ ➜  kubectl top pod -A
NAMESPACE      NAME                                   CPU(cores)   MEMORY(bytes)   
default        elephant                               20m          32Mi            
default        lion                                   1m           18Mi            
default        rabbit                                 129m         252Mi           
kube-flannel   kube-flannel-ds-dl4ph                  3m           37Mi            
kube-flannel   kube-flannel-ds-wqgst                  3m           37Mi            
kube-system    coredns-787d4945fb-hn6hq               2m           21Mi            
kube-system    coredns-787d4945fb-jdvl6               2m           21Mi            
kube-system    etcd-controlplane                      27m          46Mi            
kube-system    kube-apiserver-controlplane            45m          274Mi           
kube-system    kube-controller-manager-controlplane   19m          56Mi            
kube-system    kube-proxy-644rj                       1m           39Mi            
kube-system    kube-proxy-8mf4m                       1m           38Mi            
kube-system    kube-scheduler-controlplane            5m           25Mi            
kube-system    metrics-server-c4cdc7cc9-rb9sf         2m           21Mi            

controlplane ~ ➜  
~~~~





## 8

Identify the POD that consumes the least CPU.

~~~~bash

controlplane ~ ➜  kubectl top pod -A
NAMESPACE      NAME                                   CPU(cores)   MEMORY(bytes)   
default        elephant                               21m          32Mi            
default        lion                                   1m           18Mi            
default        rabbit                                 172m         252Mi           
kube-flannel   kube-flannel-ds-dl4ph                  3m           37Mi            
kube-flannel   kube-flannel-ds-wqgst                  0m           37Mi            
kube-system    coredns-787d4945fb-hn6hq               1m           21Mi            
kube-system    coredns-787d4945fb-jdvl6               2m           21Mi            
kube-system    etcd-controlplane                      18m          46Mi            
kube-system    kube-apiserver-controlplane            37m          274Mi           
kube-system    kube-controller-manager-controlplane   17m          57Mi            
kube-system    kube-proxy-644rj                       1m           39Mi            
kube-system    kube-proxy-8mf4m                       5m           39Mi            
kube-system    kube-scheduler-controlplane            4m           25Mi            
kube-system    metrics-server-c4cdc7cc9-rb9sf         3m           21Mi            

controlplane ~ ➜  
~~~~



Coloquei a resposta como Lion, mas acusou como errada.
Rabbit e Elephant também acusou como errada.
Colocando uma outra opção que nem existi, também acusou erro.
Reportado no final do Lab