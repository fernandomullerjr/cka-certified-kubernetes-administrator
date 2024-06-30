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

$ kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

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