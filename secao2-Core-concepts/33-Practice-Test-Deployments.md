# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 33. Practice Test - Deployments. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 33. Practice Test - Deployments



controlplane ~ ➜  kubectl get pods
No resources found in default namespace.

controlplane ~ ➜  






# How many ReplicaSets exist on the system?

In the current(default) namespace.

controlplane ~ ➜  kubectl get rs
No resources found in default namespace.

controlplane ~ ➜  



# How many Deployments exist on the system?

In the current(default) namespace.

controlplane ~ ➜  kubectl get deploy
No resources found in default namespace.

controlplane ~ ➜  




# How many Deployments exist on the system now?

We just created a Deployment! Check again!

controlplane ~ ➜  kubectl get deploy
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
frontend-deployment   0/4     4            0           10s

controlplane ~ ➜  




# How many ReplicaSets exist on the system now?

controlplane ~ ➜  kubectl get rs
NAME                             DESIRED   CURRENT   READY   AGE
frontend-deployment-6d8c45b946   4         4         0       26s

controlplane ~ ➜  





# How many PODs exist on the system now?

controlplane ~ ➜  kubectl get pods
NAME                                   READY   STATUS             RESTARTS   AGE
frontend-deployment-6d8c45b946-cz9t9   0/1     ImagePullBackOff   0          54s
frontend-deployment-6d8c45b946-csqbm   0/1     ImagePullBackOff   0          54s
frontend-deployment-6d8c45b946-sffx7   0/1     ErrImagePull       0          54s
frontend-deployment-6d8c45b946-jpbmb   0/1     ErrImagePull       0          54s

controlplane ~ ➜  




# Out of all the existing PODs, how many are ready?

controlplane ~ ➜  kubectl get pods
NAME                                   READY   STATUS             RESTARTS   AGE
frontend-deployment-6d8c45b946-csqbm   0/1     ErrImagePull       0          71s
frontend-deployment-6d8c45b946-cz9t9   0/1     ImagePullBackOff   0          71s
frontend-deployment-6d8c45b946-jpbmb   0/1     ImagePullBackOff   0          71s
frontend-deployment-6d8c45b946-sffx7   0/1     ImagePullBackOff   0          71s

controlplane ~ ➜  

controlplane ~ ➜  


Resposta:
0





# What is the image used to create the pods in the new deployment?


controlplane ~ ➜  kubectl describe deployment frontend-deployment
Name:                   frontend-deployment
Namespace:              default
CreationTimestamp:      Tue, 27 Sep 2022 00:28:22 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               name=busybox-pod
Replicas:               4 desired | 4 updated | 4 total | 0 available | 4 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  name=busybox-pod
  Containers:
   busybox-container:
    Image:      busybox888
    Port:       <none>
    Host Port:  <none>
    Command:
      sh
      -c
      echo Hello Kubernetes! && sleep 3600
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      False   MinimumReplicasUnavailable
  Progressing    True    ReplicaSetUpdated
OldReplicaSets:  <none>
NewReplicaSet:   frontend-deployment-6d8c45b946 (4/4 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  2m    deployment-controller  Scaled up replica set frontend-deployment-6d8c45b946 to 4

controlplane ~ ➜  


resposta:
busybox888





# Why do you think the deployment is not ready?

Events:
  Type     Reason     Age                  From               Message
  ----     ------     ----                 ----               -------
  Normal   Scheduled  2m58s                default-scheduler  Successfully assigned default/frontend-deployment-6d8c45b946-sffx7 to controlplane
  Normal   Pulling    97s (x4 over 2m58s)  kubelet            Pulling image "busybox888"
  Warning  Failed     96s (x4 over 2m57s)  kubelet            Failed to pull image "busybox888": rpc error: code = Unknown desc = failed to pull and unpack image "docker.io/library/busybox888:latest": failed to resolve reference "docker.io/library/busybox888:latest": pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed
  Warning  Failed     96s (x4 over 2m57s)  kubelet            Error: ErrImagePull
  Warning  Failed     73s (x6 over 2m57s)  kubelet            Error: ImagePullBackOff
  Normal   BackOff    59s (x7 over 2m57s)  kubelet            Back-off pulling image "busybox888"

controlplane ~ ➜  


Resposta:
busybox888 não existe






# Create a new Deployment using the deployment-definition-1.yaml file located at /root/.

There is an issue with the file, so try to fix it.

    Name: deployment-1

controlplane ~ ➜  ls /root
deployment-definition-1.yaml  sample.yaml

controlplane ~ ➜  

controlplane ~ ➜  kubectl create -f /root/deployment-definition-1.yaml 
Error from server (BadRequest): error when creating "/root/deployment-definition-1.yaml": deployment in version "v1" cannot be handled as a Deployment: no kind "deployment" is registered for version "apps/v1" in scheme "k8s.io/apimachinery@v1.24.1-k3s1/pkg/runtime/scheme.go:100"

controlplane ~ ✖ 


controlplane ~ ✖ cat /root/deployment-definition-1.yaml
---
apiVersion: apps/v1
kind: deployment
metadata:
  name: deployment-1
spec:
  replicas: 2
  selector:
    matchLabels:
      name: busybox-pod
  template:
    metadata:
      labels:
        name: busybox-pod
    spec:
      containers:
      - name: busybox-container
        image: busybox888
        command:
        - sh
        - "-c"
        - echo Hello Kubernetes! && sleep 3600


controlplane ~ ➜  


controlplane ~ ➜  vi /root/deployment-definition-1.yaml

controlplane ~ ➜  cat /root/deployment-definition-1.yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deployment-1
spec:
  replicas: 2
  selector:
    matchLabels:
      name: busybox-pod
  template:
    metadata:
      labels:
        name: busybox-pod
    spec:
      containers:
      - name: busybox-container
        image: busybox
        command:
        - sh
        - "-c"
        - echo Hello Kubernetes! && sleep 3600


controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl create -f /root/deployment-definition-1.yaml 
deployment.apps/deployment-1 created

controlplane ~ ➜  kubectl get deployment
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
frontend-deployment   0/4     4            0           5m23s
deployment-1          2/2     2            2           5s

controlplane ~ ➜  



Ajustado o nome do kind.
Ajustada a imagem busybox.







# Create a new Deployment with the below attributes using your own deployment definition file.

Name: httpd-frontend;
Replicas: 3;
Image: httpd:2.4-alpine

    Name: httpd-frontend

    Replicas: 3

    Image: httpd:2.4-alpine



controlplane ~ ➜  kubectl create deployment --dry-run=client -o yaml --replicas=3 --name=httpd-frontend --image=httpd:2.4-alpine
error: unknown flag: --name
See 'kubectl create deployment --help' for usage.

controlplane ~ ✖ 


kubectl create deployment --dry-run=client -o yaml --replicas=3 httpd-frontend --image=httpd:2.4-alpine



controlplane ~ ✖ kubectl create deployment --dry-run=client -o yaml --replicas=3 httpd-frontend --image=httpd:2.4-alpine
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: httpd-frontend
  name: httpd-frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: httpd-frontend
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: httpd-frontend
    spec:
      containers:
      - image: httpd:2.4-alpine
        name: httpd
        resources: {}
status: {}

controlplane ~ ➜  


controlplane ~ ➜  kubectl create deployment --dry-run=client -o yaml --replicas=3 httpd-frontend --image=httpd:2.4-alpine > deploy.yaml

controlplane ~ ➜  kubectl apply -f deploy.yaml
deployment.apps/httpd-frontend created

controlplane ~ ➜  kubectl get deployment
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
frontend-deployment   0/4     4            0           9m47s
deployment-1          2/2     2            2           4m29s
httpd-frontend        0/3     3            0           4s

controlplane ~ ➜  


controlplane ~ ➜  kubectl get deployment
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment-1          2/2     2            2           4m58s
httpd-frontend        3/3     3            3           33s
frontend-deployment   0/4     4            0           10m

controlplane ~ ➜  kubectl get pods
NAME                                   READY   STATUS             RESTARTS   AGE
deployment-1-7c65c4d9dd-96pqt          1/1     Running            0          5m3s
deployment-1-7c65c4d9dd-8vg7s          1/1     Running            0          5m3s
frontend-deployment-6d8c45b946-sffx7   0/1     ImagePullBackOff   0          10m
frontend-deployment-6d8c45b946-cz9t9   0/1     ImagePullBackOff   0          10m
frontend-deployment-6d8c45b946-jpbmb   0/1     ImagePullBackOff   0          10m
frontend-deployment-6d8c45b946-csqbm   0/1     ImagePullBackOff   0          10m
httpd-frontend-6f67496c45-p8k5z        1/1     Running            0          38s
httpd-frontend-6f67496c45-ppmt7        1/1     Running            0          38s
httpd-frontend-6f67496c45-lbbm4        1/1     Running            0          38s

controlplane ~ ➜  



# push
git status
git add .
git commit -m "Aula 33. Practice Test - Deployments. pt2"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status