
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 29 - Practice Test - ReplicaSets. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 29 - Practice Test - ReplicaSets



controlplane ~ ➜  kubectl get pods
No resources found in default namespace.

controlplane ~ ➜  kubectl get rs
No resources found in default namespace.

controlplane ~ ➜  


controlplane ~ ➜  kubectl get rs -A
NAMESPACE     NAME                                DESIRED   CURRENT   READY   AGE
kube-system   local-path-provisioner-7b7dc8d6f5   1         1         1       19m
kube-system   coredns-b96499967                   1         1         1       19m
kube-system   metrics-server-668d979685           1         1         1       19m
kube-system   traefik-7cd4fcff68                  1         1         1       18m
default       new-replica-set                     4         4         0       11s

controlplane ~ ➜  



What is the image used to create the pods in the new-replica-set?


controlplane ~ ➜  kubectl describe pods new-replica-set-57bp2
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  71s                default-scheduler  Successfully assigned default/new-replica-set-57bp2 to controlplane
  Normal   Pulling    36s (x3 over 71s)  kubelet            Pulling image "busybox777"
  Warning  Failed     35s (x3 over 70s)  kubelet            Failed to pull image "busybox777": rpc error: code = Unknown desc = failed to pull and unpack image "docker.io/library/busybox777:latest": failed to resolve reference "docker.io/library/busybox777:latest": pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed
  Warning  Failed     35s (x3 over 70s)  kubelet            Error: ErrImagePull
  Normal   BackOff    13s (x4 over 69s)  kubelet            Back-off pulling image "busybox777"
  Warning  Failed     13s (x4 over 69s)  kubelet            Error: ImagePullBackOff

controlplane ~ ➜  



How many PODs are READY in the new-replica-set

controlplane ~ ➜  kubectl get rs
NAME              DESIRED   CURRENT   READY   AGE
new-replica-set   4         4         0       3m28s

controlplane ~ ➜  


controlplane ~ ✖ kubectl delete pod new-replica-set-57bp2
pod "new-replica-set-57bp2" deleted

controlplane ~ ➜  kubectl get pods
NAME                    READY   STATUS             RESTARTS   AGE
new-replica-set-96ntm   0/1     ImagePullBackOff   0          4m46s
new-replica-set-dbpdg   0/1     ImagePullBackOff   0          4m46s
new-replica-set-5scdx   0/1     ImagePullBackOff   0          4m46s
new-replica-set-s2vhm   0/1     ErrImagePull       0          9s

controlplane ~ ➜  






- Create a ReplicaSet using the replicaset-definition-1.yaml file located at /root/.

There is an issue with the file, so try to fix it.
    Name: replicaset-1


controlplane ~ ➜  kubectl apply -f /root/replicaset-definition-1.yaml 
error: resource mapping not found for name: "replicaset-1" namespace: "" from "/root/replicaset-definition-1.yaml": no matches for kind "ReplicaSet" in version "v1"
ensure CRDs are installed first

controlplane ~ ✖ 


controlplane ~ ➜  cat /root/replicaset-definition-1.yaml 
apiVersion: v1
kind: ReplicaSet
metadata:
  name: replicaset-1
spec:
  replicas: 2
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: frontend
    spec:
      containers:
      - name: nginx
        image: nginx




# SOLUÇÃO

- Foi adicionado o apps/ no apiVersion:

controlplane ~ ➜  cat /root/replicaset-definition-1.yaml 
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: replicaset-1
spec:
  replicas: 2
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: frontend
    spec:
      containers:
      - name: nginx
        image: nginx


controlplane ~ ➜  


controlplane ~ ➜  kubectl apply -f /root/replicaset-definition-1.yaml 
replicaset.apps/replicaset-1 created

controlplane ~ ➜  kubectl get rs
NAME              DESIRED   CURRENT   READY   AGE
new-replica-set   4         4         0       11m
replicaset-1      2         2         0       5s

controlplane ~ ➜  







# 2

Fix the issue in the replicaset-definition-2.yaml file and create a ReplicaSet using it.
This file is located at /root/.
Name: replicaset-2


controlplane ~ ➜  cat /root/replicaset-definition-2.yaml 
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: replicaset-2
spec:
  replicas: 2
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: nginx
    spec:
      containers:
      - name: nginx
        image: nginx


controlplane ~ ➜  



# SOLUÇÃO

- Ajustado o Label do template do Pod:

controlplane ~ ➜  cat /root/replicaset-definition-2.yaml 
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: replicaset-2
spec:
  replicas: 2
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: frontend
    spec:
      containers:
      - name: nginx
        image: nginx


controlplane ~ ➜  kubectl apply -f /root/replicaset-definition-2.yaml 
replicaset.apps/replicaset-2 created

controlplane ~ ➜  kubectl get rs
NAME              DESIRED   CURRENT   READY   AGE
new-replica-set   4         4         0       13m
replicaset-1      2         2         2       2m11s
replicaset-2      2         2         0       6s

controlplane ~ ➜  




Delete the two newly created ReplicaSets - replicaset-1 and replicaset-2

    Delete: replicaset-2

    Delete: replicaset-1

controlplane ~ ➜  kubectl delete rs replicaset-1
replicaset.apps "replicaset-1" deleted

controlplane ~ ➜  kubectl delete rs replicaset-2
replicaset.apps "replicaset-2" deleted

controlplane ~ ➜  





Fix the original replica set new-replica-set to use the correct busybox image.

Either delete and recreate the ReplicaSet or Update the existing ReplicaSet and then delete all PODs, so new ones with the correct image will be created.


controlplane ~ ➜  kubectl edit replicaset new-replica-set
replicaset.apps/new-replica-set edited

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods
NAME                    READY   STATUS             RESTARTS   AGE
new-replica-set-s2vhm   0/1     ImagePullBackOff   0          10m
new-replica-set-5scdx   0/1     ImagePullBackOff   0          15m
new-replica-set-96ntm   0/1     ImagePullBackOff   0          15m
new-replica-set-dbpdg   0/1     ImagePullBackOff   0          15m

controlplane ~ ➜  kubectl delete pods
error: resource(s) were provided, but no name was specified

controlplane ~ ✖ kubectl delete pods new-replica-set-s2vhm
pod "new-replica-set-s2vhm" deleted

controlplane ~ ➜  kubectl delete pods new-replica-set-5scdx
pod "new-replica-set-5scdx" deleted

controlplane ~ ➜  kubectl delete pods new-replica-set-96ntm
pod "new-replica-set-96ntm" deleted

controlplane ~ ➜  kubectl delete pods new-replica-set-dbpdg
pod "new-replica-set-dbpdg" deleted

controlplane ~ ➜  kubectl get pods
NAME                    READY   STATUS    RESTARTS   AGE
new-replica-set-8xhm6   1/1     Running   0          29s
new-replica-set-mm924   1/1     Running   0          19s
new-replica-set-9c75t   1/1     Running   0          12s
new-replica-set-7lldh   1/1     Running   0          5s

controlplane ~ ➜  





Scale the ReplicaSet to 5 PODs.
Use kubectl scale command or edit the replicaset using kubectl edit replicaset.

kubectl scale --replicas=5 replicaset new-replica-set


controlplane ~ ➜  kubectl scale --replicas=5 replicaset new-replica-set

replicaset.apps/new-replica-set scaled

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods
NAME                    READY   STATUS    RESTARTS   AGE
new-replica-set-8xhm6   1/1     Running   0          116s
new-replica-set-mm924   1/1     Running   0          106s
new-replica-set-9c75t   1/1     Running   0          99s
new-replica-set-7lldh   1/1     Running   0          92s
new-replica-set-zccmc   1/1     Running   0          5s

controlplane ~ ➜  