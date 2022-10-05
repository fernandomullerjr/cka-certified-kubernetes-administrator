

# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 38. Practice Test - Services. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# # 38. Practice Test - Services


# How many Services exist on the system?
In the current(default) namespace


controlplane ~ ➜  kubectl get services
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   13m

controlplane ~ ➜  


That is a default service created by Kubernetes at launch.




# What is the type of the default kubernetes service?
ClusterIP




# What is the targetPort configured on the kubernetes service?



controlplane ~ ➜  kubectl describe service kubernetes
Name:              kubernetes
Namespace:         default
Labels:            component=apiserver
                   provider=kubernetes
Annotations:       <none>
Selector:          <none>
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.43.0.1
IPs:               10.43.0.1
Port:              https  443/TCP
TargetPort:        6443/TCP
Endpoints:         10.75.107.3:6443
Session Affinity:  None
Events:            <none>

controlplane ~ ➜  


- RESPOSTA
6443



# How many labels are configured on the kubernetes service?
- RESPOSTA
2


# How many Endpoints are attached on the kubernetes service?
1



# How many Deployments exist on the system now?
In the current(default) namespace

controlplane ~ ➜  kubectl get deploy
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
simple-webapp-deployment   4/4     4            4           9s

controlplane ~ ➜  




# What is the image used to create the pods in the deployment?


controlplane ~ ➜  kubectl describe deploy simple-webapp-deployment
Name:                   simple-webapp-deployment
Namespace:              default
CreationTimestamp:      Wed, 05 Oct 2022 00:52:34 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               name=simple-webapp
Replicas:               4 desired | 4 updated | 4 total | 4 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  name=simple-webapp
  Containers:
   simple-webapp:
    Image:        kodekloud/simple-webapp:red
    Port:         8080/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   simple-webapp-deployment-8c46cb57c (4/4 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  54s   deployment-controller  Scaled up replica set simple-webapp-deployment-8c46cb57c to 4

controlplane ~ ➜  


- RESPOSTA:
kodekloud/simple-webapp:red





# Are you able to accesss the Web App UI?
Try to access the Web Application UI using the tab simple-webapp-ui above the terminal.

<https://30080-port-1f73342bdd3e4540.labs.kodekloud.com/>
502 Bad Gateway
nginx/1.21.1





# Create a new service to access the web application using the service-definition-1.yaml file.

Name: webapp-service
Type: NodePort
targetPort: 8080
port: 8080
nodePort: 30080
selector:
  name: simple-webapp




controlplane ~ ➜  kubectl get pod
NAME                                       READY   STATUS    RESTARTS   AGE
simple-webapp-deployment-8c46cb57c-pgbfb   1/1     Running   0          4m29s
simple-webapp-deployment-8c46cb57c-mqt87   1/1     Running   0          4m29s
simple-webapp-deployment-8c46cb57c-klrnc   1/1     Running   0          4m29s
simple-webapp-deployment-8c46cb57c-pzd4j   1/1     Running   0          4m29s

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe pod simple-webapp-deployment-8c46cb57c-pgbfb
Name:         simple-webapp-deployment-8c46cb57c-pgbfb
Namespace:    default
Priority:     0
Node:         controlplane/172.25.1.3
Start Time:   Wed, 05 Oct 2022 00:52:35 +0000
Labels:       name=simple-webapp
              pod-template-hash=8c46cb57c
Annotations:  <none>
Status:       Running
IP:           10.42.0.10
IPs:
  IP:           10.42.0.10
Controlled By:  ReplicaSet/simple-webapp-deployment-8c46cb57c
Containers:
  simple-webapp:
    Container ID:   containerd://325e79ff77f8cd1146bffa88a3e3dfdf1deb4537b9d401ad69d0d64e9320e3b0
    Image:          kodekloud/simple-webapp:red
    Image ID:       docker.io/kodekloud/simple-webapp@sha256:175ba08b8986076df14c40db45c4cc1fbbb16ffff031a646d6bc98f20fb5d902
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Wed, 05 Oct 2022 00:52:40 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-fvlcs (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-fvlcs:
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
  Normal  Scheduled  4m58s  default-scheduler  Successfully assigned default/simple-webapp-deployment-8c46cb57c-pgbfb to controlplane
  Normal  Pulling    4m57s  kubelet            Pulling image "kodekloud/simple-webapp:red"
  Normal  Pulled     4m53s  kubelet            Successfully pulled image "kodekloud/simple-webapp:red" in 4.144096086s
  Normal  Created    4m53s  kubelet            Created container simple-webapp
  Normal  Started    4m53s  kubelet            Started container simple-webapp

controlplane ~ ➜  





vi service-definition-1.yaml



controlplane ~ ➜  cat service-definition-1.yaml 
---
apiVersion: v1
kind: Service
metadata:
  name:
spec:
  type:
  ports:
    - targetPort:
      port:
      nodePort:
  selector:
    name:

controlplane ~ ➜  vi service-definition-1.yaml 

controlplane ~ ➜  cat service-definition-1.yaml 
apiVersion: v1
kind: Service
metadata:
  name: webapp-service
spec:
  selector:
    name: simple-webapp
  type: NodePort
  ports:
  - protocol: TCP
    port: 8080
    targetPort: 8080
    nodePort: 30080


controlplane ~ ➜  



controlplane ~ ➜  kubectl apply -f service-definition-1.yaml 
service/webapp-service created

controlplane ~ ➜  kubectl get svc
NAME             TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
kubernetes       ClusterIP   10.43.0.1     <none>        443/TCP          24m
webapp-service   NodePort    10.43.44.89   <none>        8080:30080/TCP   4s

controlplane ~ ➜  




- Testando acesso a página:
<https://30080-port-1f73342bdd3e4540.labs.kodekloud.com/>
Abriu a página com sucesso:
    Hello from simple-webapp-deployment-8c46cb57c-klrnc!