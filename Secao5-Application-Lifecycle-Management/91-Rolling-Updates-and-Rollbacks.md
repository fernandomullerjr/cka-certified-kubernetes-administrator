
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 91. Rolling Updates and Rollbacks"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status





# ##############################################################################################################################################################
#  91. Rolling Updates and Rollbacks

# Rolling Updates and Rollback
  - Take me to [Video Tutorial](https://kodekloud.com/topic/rolling-updates-and-rollbacks/)
  
In this section, we will take a look at rolling updates and rollback in a deployment

## Rollout and Versioning in a Deployment

  ![rollv](../../images/rollv.PNG)
  
## Rollout commands
- You can see the status of the rollout by the below command
  ```
  $ kubectl rollout status deployment/myapp-deployment
  ```
- To see the history and revisions
  ```
  $ kubectl rollout history deployment/myapp-deployment
  ```
 
  ![rollc](../../images/rollc.PNG)
  
## Deployment Strategies
- There are 2 types of deployment strategies
  1. Recreate
  2. RollingUpdate (Default Strategy)
  
  ![dst](../../images/dst.PNG)
  
## kubectl apply
- To update a deployment, edit the deployment and make necessary changes and save it. Then run the below command.
  ```
  apiVersion: apps/v1
  kind: Deployment
  metadata:
   name: myapp-deployment
   labels:
    app: nginx
  spec:
   template:
     metadata:
       name: myap-pod
       labels:
         app: myapp
         type: front-end
     spec:
      containers:
      - name: nginx-container
        image: nginx:1.7.1
   replicas: 3
   selector:
    matchLabels:
      type: front-end       
  ```
  ```
  $ kubectl apply -f deployment-definition.yaml
  ```
- Alternate way to update a deployment say for example for updating an image.
  ```
  $ kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1
  ```
  ![ka](../../images/ka.PNG)
  
## Recreate vs RollingUpdate
  
  ![rcrl](../../images/rcrl.PNG)
  
## Upgrades

  ![up](../../images/up.PNG)
  
## Rollback
  
  ![rb](../../images/rb.PNG)
  
- To undo a change
  ```
  $ kubectl rollout undo deployment/myapp-deployment
  ```
  
## kubectl create
- To create a deployment
  ```
  $ kubectl create deployment nginx --image=nginx
  ```
## Summarize kubectl commands
```
$ kubectl create -f deployment-definition.yaml
$ kubectl get deployments
$ kubectl apply -f deployment-definition.yaml
$ kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1
$ kubectl rollout status deployment/myapp-deployment
$ kubectl rollout history deployment/myapp-deployment
$ kubectl rollout undo deployment/myapp-deployment
```

![sum](../../images/sum.PNG)
 
#### K8s Reference Docs
- https://kubernetes.io/docs/concepts/workloads/controllers/deployment
- https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment










# ##############################################################################################################################################################
#  91. Rolling Updates and Rollbacks

- O "Rollout" cria as versões e Revisions.


## Rollout commands

    You can see the status of the rollout by the below command

    $ kubectl rollout status deployment/myapp-deployment

    To see the history and revisions

    $ kubectl rollout history deployment/myapp-deployment






## Deployment Strategies

    There are 2 types of deployment strategies
        Recreate
        RollingUpdate (Default Strategy)

- A estratégia "Recreate", cria novas versões dos Pods, mas tem downtime, pois mata os Pods antigos sem esperar que os novos Pods sejam provisionados.
- A estratégia "RollingUpdate" cria 1 pod da nova versão e vai matando 1 pod antigo, aos poucos, evitando downtime. É a opção default.

## kubectl apply

    To update a deployment, edit the deployment and make necessary changes and save it. Then run the below command.

~~~~YAML
apiVersion: apps/v1
kind: Deployment
metadata:
 name: myapp-deployment
 labels:
  app: nginx
spec:
 template:
   metadata:
     name: myap-pod
     labels:
       app: myapp
       type: front-end
   spec:
    containers:
    - name: nginx-container
      image: nginx:1.7.1
 replicas: 3
 selector:
  matchLabels:
    type: front-end
~~~~    

    $ kubectl apply -f deployment-definition.yaml

    Alternate way to update a deployment say for example for updating an image.

    $ kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1







fernando@debian10x64:~$ kubectl get pods -A
NAMESPACE       NAME                                                              READY   STATUS      RESTARTS         AGE
default         event-simulator-pod                                               0/1     Error       0                3d
default         minhaapi-api-deployment-6586d4f7bc-6vcsx                          1/1     Running     5 (3d ago)       13d
default         minhaapi-mongodb-6c98c75fcc-lnq5l                                 0/1     Running     6 (3d ago)       13d
default         nginx                                                             0/1     Completed   3                11d
kube-system     coredns-78fcd69978-5xcpp                                          1/1     Running     24 (3m20s ago)   40d
kube-system     etcd-minikube                                                     1/1     Running     37 (3d ago)      40d
kube-system     kube-apiserver-minikube                                           1/1     Running     37 (3m20s ago)   40d
kube-system     kube-controller-manager-minikube                                  1/1     Running     38 (3d ago)      40d
kube-system     kube-proxy-5pc9k                                                  1/1     Running     24 (3d ago)      40d
kube-system     kube-scheduler-minikube                                           1/1     Running     33 (3m20s ago)   40d
kube-system     metrics-server-77c99ccb96-pnnwl                                   1/1     Running     2 (3d ago)       6d4h
kube-system     my-scheduler-6c595b886d-87dms                                     1/1     Running     4 (3m20s ago)    11d
kube-system     storage-provisioner                                               0/1     Error       46 (3d ago)      40d
nginx-ingress   meu-ingress-controller-ingress-nginx-controller-85685788f82hp89   0/1     Running     21 (3m20s ago)   35d
nginx-ingress   meu-ingress-controller-ingress-nginx-controller-85685788f8xpg5v   0/1     Running     21 (3m20s ago)   35d
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get deployment -A
NAMESPACE       NAME                                              READY   UP-TO-DATE   AVAILABLE   AGE
default         minhaapi-api-deployment                           1/1     1            1           28d
default         minhaapi-mongodb                                  0/1     1            0           13d
kube-system     coredns                                           1/1     1            1           40d
kube-system     metrics-server                                    1/1     1            1           6d4h
kube-system     my-scheduler                                      1/1     1            1           11d
nginx-ingress   meu-ingress-controller-ingress-nginx-controller   0/2     2            0           35d
fernando@debian10x64:~$









kubectl apply -f /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao5-Application-Lifecycle-Management/91-DEPLOYMENT-exemplo.yaml


fernando@debian10x64:~$ kubectl apply -f /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao5-Application-Lifecycle-Management/91-DEPLOYMENT-exemplo.yaml
deployment.apps/myapp-deployment created
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get deployment -A
NAMESPACE       NAME                                              READY   UP-TO-DATE   AVAILABLE   AGE
default         minhaapi-api-deployment                           1/1     1            1           28d
default         minhaapi-mongodb                                  1/1     1            1           13d
default         myapp-deployment                                  0/3     3            0           2s
kube-system     coredns                                           1/1     1            1           40d
kube-system     metrics-server                                    1/1     1            1           6d4h
kube-system     my-scheduler                                      1/1     1            1           11d
nginx-ingress   meu-ingress-controller-ingress-nginx-controller   2/2     2            2           35d
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get deployment -A
NAMESPACE       NAME                                              READY   UP-TO-DATE   AVAILABLE   AGE
default         minhaapi-api-deployment                           1/1     1            1           28d
default         minhaapi-mongodb                                  1/1     1            1           13d
default         myapp-deployment                                  0/3     3            0           9s
kube-system     coredns                                           1/1     1            1           40d
kube-system     metrics-server                                    1/1     1            1           6d4h
kube-system     my-scheduler                                      1/1     1            1           11d
nginx-ingress   meu-ingress-controller-ingress-nginx-controller   2/2     2            2           35d
fernando@debian10x64:~$ kubectl get pods -A
NAMESPACE       NAME                                                              READY   STATUS              RESTARTS         AGE
default         event-simulator-pod                                               1/1     Running             1 (6m57s ago)    3d
default         minhaapi-api-deployment-6586d4f7bc-6vcsx                          1/1     Running             5 (3d ago)       13d
default         minhaapi-mongodb-6c98c75fcc-lnq5l                                 1/1     Running             6 (3d ago)       13d
default         myapp-deployment-5c7c75f4d8-dfv6q                                 0/1     ContainerCreating   0                16s
default         myapp-deployment-5c7c75f4d8-f4bwq                                 0/1     ContainerCreating   0                16s
default         myapp-deployment-5c7c75f4d8-jxklg                                 0/1     ContainerCreating   0                16s
default         nginx                                                             1/1     Running             4                11d
kube-system     coredns-78fcd69978-5xcpp                                          1/1     Running             24 (6m57s ago)   40d
kube-system     etcd-minikube                                                     1/1     Running             37 (3d ago)      40d
kube-system     kube-apiserver-minikube                                           1/1     Running             37 (6m57s ago)   40d
kube-system     kube-controller-manager-minikube                                  1/1     Running             38 (3d ago)      40d
kube-system     kube-proxy-5pc9k                                                  1/1     Running             24 (3d ago)      40d
kube-system     kube-scheduler-minikube                                           1/1     Running             33 (6m57s ago)   40d
kube-system     metrics-server-77c99ccb96-pnnwl                                   1/1     Running             2 (3d ago)       6d4h
kube-system     my-scheduler-6c595b886d-87dms                                     1/1     Running             4 (6m57s ago)    11d
kube-system     storage-provisioner                                               1/1     Running             47               40d
nginx-ingress   meu-ingress-controller-ingress-nginx-controller-85685788f82hp89   1/1     Running             22 (3m10s ago)   35d
nginx-ingress   meu-ingress-controller-ingress-nginx-controller-85685788f8xpg5v   1/1     Running             22 (3m10s ago)   35d
fernando@debian10x64:~$




fernando@debian10x64:~$ kubectl get pods -l app=myapp
NAME                                READY   STATUS    RESTARTS   AGE
myapp-deployment-5c7c75f4d8-dfv6q   1/1     Running   0          61s
myapp-deployment-5c7c75f4d8-f4bwq   1/1     Running   0          61s
myapp-deployment-5c7c75f4d8-jxklg   1/1     Running   0          61s
fernando@debian10x64:~$












## Version / Revision

- Mudando o Deployment, trocando a image para:
nginx:1.9.1

~~~~YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-deployment
  labels:
    app: nginx
spec:
  template:
    metadata:
      name: myap-pod
      labels:
        app: myapp
        type: front-end
    spec:
      containers:
        - name: nginx-container
          image: nginx:1.9.1
  replicas: 3
  selector:
    matchLabels:
      type: front-end
~~~~


- Aplicando:

kubectl apply -f /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao5-Application-Lifecycle-Management/91-DEPLOYMENT-exemplo.yaml



    You can see the status of the rollout by the below command

    $ kubectl rollout status deployment/myapp-deployment

    To see the history and revisions

    $ kubectl rollout history deployment/myapp-deployment


fernando@debian10x64:~$ kubectl apply -f /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao5-Application-Lifecycle-Management/91-DEPLOYMENT-exemplo.yaml
deployment.apps/myapp-deployment configured
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get pods -l app=myapp
NAME                                READY   STATUS              RESTARTS   AGE
myapp-deployment-5c7c75f4d8-dfv6q   1/1     Running             0          3m27s
myapp-deployment-5c7c75f4d8-f4bwq   1/1     Running             0          3m27s
myapp-deployment-5c7c75f4d8-jxklg   1/1     Running             0          3m27s
myapp-deployment-dbd96b5f8-w2dn7    0/1     ContainerCreating   0          4s
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get pods -l app=myapp
NAME                                READY   STATUS              RESTARTS   AGE
myapp-deployment-5c7c75f4d8-dfv6q   1/1     Running             0          3m33s
myapp-deployment-5c7c75f4d8-f4bwq   1/1     Running             0          3m33s
myapp-deployment-5c7c75f4d8-jxklg   1/1     Running             0          3m33s
myapp-deployment-dbd96b5f8-w2dn7    0/1     ContainerCreating   0          10s
fernando@debian10x64:~$ ^C
fernando@debian10x64:~$ ^C
fernando@debian10x64:~$ ^C
fernando@debian10x64:~$ ^C
fernando@debian10x64:~$ ^C
fernando@debian10x64:~$ ^C
fernando@debian10x64:~$ ^C
fernando@debian10x64:~$ kubectl get pods -l app=myapp
NAME                               READY   STATUS    RESTARTS   AGE
myapp-deployment-dbd96b5f8-mhv68   1/1     Running   0          33s
myapp-deployment-dbd96b5f8-q2w46   1/1     Running   0          31s
myapp-deployment-dbd96b5f8-w2dn7   1/1     Running   0          45s
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl rollout status deployment/myapp-deployment
deployment "myapp-deployment" successfully rolled out
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl rollout history deployment/myapp-deployment
deployment.apps/myapp-deployment
REVISION  CHANGE-CAUSE
1         <none>
2         <none>

fernando@debian10x64:~$






kubectl describe deployment/myapp-deployment


fernando@debian10x64:~$ kubectl describe deployment/myapp-deployment
Name:                   myapp-deployment
Namespace:              default
CreationTimestamp:      Sat, 11 Feb 2023 00:54:03 -0300
Labels:                 app=nginx
Annotations:            deployment.kubernetes.io/revision: 2
Selector:               type=front-end
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=myapp
           type=front-end
  Containers:
   nginx-container:
    Image:        nginx:1.9.1
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   myapp-deployment-dbd96b5f8 (3/3 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  5m56s  deployment-controller  Scaled up replica set myapp-deployment-5c7c75f4d8 to 3
  Normal  ScalingReplicaSet  2m33s  deployment-controller  Scaled up replica set myapp-deployment-dbd96b5f8 to 1
  Normal  ScalingReplicaSet  2m21s  deployment-controller  Scaled down replica set myapp-deployment-5c7c75f4d8 to 2
  Normal  ScalingReplicaSet  2m21s  deployment-controller  Scaled up replica set myapp-deployment-dbd96b5f8 to 2
  Normal  ScalingReplicaSet  2m19s  deployment-controller  Scaled down replica set myapp-deployment-5c7c75f4d8 to 1
  Normal  ScalingReplicaSet  2m19s  deployment-controller  Scaled up replica set myapp-deployment-dbd96b5f8 to 3
  Normal  ScalingReplicaSet  2m9s   deployment-controller  Scaled down replica set myapp-deployment-5c7c75f4d8 to 0
fernando@debian10x64:~$





- Verificando apenas detalhes da estratégia:

fernando@debian10x64:~$ kubectl describe deployment/myapp-deployment | grep Strategy
StrategyType:           RollingUpdate
RollingUpdateStrategy:  25% max unavailable, 25% max surge
fernando@debian10x64:~$



- Por debaixo dos panos o Kubernetes cria um replicaset adicional.








# To undo a change

$ kubectl rollout undo deployment/myapp-deployment



- ANTES:

fernando@debian10x64:~$ kubectl describe deployment/myapp-deployment | grep -i image
    Image:        nginx:1.9.1
fernando@debian10x64:~$

fernando@debian10x64:~$ kubectl get replicasets | grep myapp
myapp-deployment-5c7c75f4d8          0         0         0       8m41s
myapp-deployment-dbd96b5f8           3         3         3       5m18s
fernando@debian10x64:~$






- Efetuando Rollback:
kubectl rollout undo deployment/myapp-deployment


- DEPOIS:

fernando@debian10x64:~$ kubectl rollout undo deployment/myapp-deployment
deployment.apps/myapp-deployment rolled back
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl describe deployment/myapp-deployment | grep -i image
    Image:        nginx:1.7.1
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get replicasets | grep myapp
myapp-deployment-5c7c75f4d8          3         3         3       9m58s
myapp-deployment-dbd96b5f8           0         0         0       6m35s
fernando@debian10x64:~$












# kubectl create

    To create a deployment

    $ kubectl create deployment nginx --image=nginx

# Summarize kubectl commands

$ kubectl create -f deployment-definition.yaml
$ kubectl get deployments
$ kubectl apply -f deployment-definition.yaml
$ kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1
$ kubectl rollout status deployment/myapp-deployment
$ kubectl rollout history deployment/myapp-deployment
$ kubectl rollout undo deployment/myapp-deployment
