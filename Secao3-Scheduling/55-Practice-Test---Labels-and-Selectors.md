

# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 55. Practice Test - Labels and Selectors"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# #




# We have deployed a number of PODs. They are labelled with tier, env and bu. How many PODs exist in the dev environment (env)?

Use selectors to filter the output


controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   local-path-provisioner-7b7dc8d6f5-n6n4j   1/1     Running     0          11m
kube-system   coredns-b96499967-hcpnw                   1/1     Running     0          11m
kube-system   helm-install-traefik-crd-cw9qg            0/1     Completed   0          11m
kube-system   helm-install-traefik-m57b7                0/1     Completed   1          11m
kube-system   svclb-traefik-5t76w                       2/2     Running     0          10m
kube-system   metrics-server-668d979685-pwz4v           1/1     Running     0          11m
kube-system   traefik-7cd4fcff68-qzkwd                  1/1     Running     0          10m
default       app-1-rvg8h                               1/1     Running     0          3m2s
default       app-1-zzxdf                               1/1     Running     0          3m1s
default       app-1-d9th5                               1/1     Running     0          3m2s
default       app-2-rz7fz                               1/1     Running     0          3m2s
default       app-1-kxj99                               1/1     Running     0          3m2s
default       db-1-jfnh9                                1/1     Running     0          3m2s
default       db-1-lr5s8                                1/1     Running     0          3m2s
default       auth                                      1/1     Running     0          3m2s
default       db-1-g7f6l                                1/1     Running     0          3m2s
default       db-1-zpcsj                                1/1     Running     0          3m2s
default       db-2-xjzvr                                1/1     Running     0          3m2s


controlplane ~ ✖ kubectl get pods -l env=dev
NAME          READY   STATUS    RESTARTS   AGE
app-1-rvg8h   1/1     Running   0          4m
app-1-d9th5   1/1     Running   0          4m
app-1-kxj99   1/1     Running   0          4m
db-1-jfnh9    1/1     Running   0          4m
db-1-lr5s8    1/1     Running   0          4m
db-1-g7f6l    1/1     Running   0          4m
db-1-zpcsj    1/1     Running   0          4m

controlplane ~ ➜  


- RESPOSTA:
7






# How many PODs are in the finance business unit (bu)?


controlplane ~ ➜  kubectl describe pods -A
Labels:       bu=finance
              env=prod
              tier=db


kubectl get pods -l env=dev
kubectl get pods -l bu=finance

kubectl get pods -l bu=finance
kubectl get pods -l bu=finance | wc


arted    7m3s   kubelet            Started container busybox

controlplane ~ ➜  kubectl get pods -l bu=finance
NAME          READY   STATUS    RESTARTS   AGE
app-1-rvg8h   1/1     Running   0          7m14s
app-1-zzxdf   1/1     Running   0          7m13s
app-1-d9th5   1/1     Running   0          7m14s
app-1-kxj99   1/1     Running   0          7m14s
auth          1/1     Running   0          7m14s
db-2-xjzvr    1/1     Running   0          7m14s

controlplane ~ ➜  kubectl get pods -l bu=finance | wc
        7        35       341

controlplane ~ ➜  

- RESPOSTA:
6







# How many objects are in the prod environment including PODs, ReplicaSets and any other objects?


controlplane ~ ➜  kubectl describe all -A | grep prod
              env=prod
Labels:       env=prod
              env=prod
              env=prod
                   env=prod
Selector:     !bu,env=prod,tier=frontend
Labels:       env=prod
  Labels:  env=prod
Selector:     env=prod,tier=db
Labels:       env=prod
           env=prod



controlplane ~ ➜  kubectl get all -A -l env=prod
NAMESPACE   NAME              READY   STATUS    RESTARTS   AGE
default     pod/app-1-zzxdf   1/1     Running   0          9m59s
default     pod/app-2-rz7fz   1/1     Running   0          10m
default     pod/auth          1/1     Running   0          10m
default     pod/db-2-xjzvr    1/1     Running   0          10m

NAMESPACE   NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
default     service/app-1   ClusterIP   10.43.209.72   <none>        3306/TCP   9m59s

NAMESPACE   NAME                    DESIRED   CURRENT   READY   AGE
default     replicaset.apps/app-2   1         1         1       10m
default     replicaset.apps/db-2    1         1         1       10m

controlplane ~ ➜  


- RESPOSTA:
7








# Identify the POD which is part of the prod environment, the finance BU and of frontend tier?


controlplane ~ ➜  kubectl describe all -A | grep frontend
              tier=frontend
              tier=frontend
              tier=frontend
              tier=frontend
              tier=frontend
Selector:     !bu,env=prod,tier=frontend
           tier=frontend
Selector:     env=dev,tier=frontend
           tier=frontend

controlplane ~ ➜  


kubectl get all -A -l env=prod,tier=frontend,bu=finance



controlplane ~ ➜  kubectl get all -A -l env=prod,tier=frontend,bu=finance
NAMESPACE   NAME              READY   STATUS    RESTARTS   AGE
default     pod/app-1-zzxdf   1/1     Running   0          11m

controlplane ~ ➜  








# A ReplicaSet definition file is given replicaset-definition-1.yaml. Try to create the replicaset. There is an issue with the file. Try to fix it.

    ReplicaSet: replicaset-1

    Replicas: 2


controlplane ~ ➜  kubectl apply -f replicaset-definition-1.yaml 
The ReplicaSet "replicaset-1" is invalid: spec.template.metadata.labels: Invalid value: map[string]string{"tier":"nginx"}: `selector` does not match template `labels`

controlplane ~ ✖ 




controlplane ~ ✖ cat replicaset-definition-1.yaml 
apiVersion: apps/v1
kind: ReplicaSet
metadata:
   name: replicaset-1
spec:
   replicas: 2
   selector:
      matchLabels:
        tier: front-end
   template:
     metadata:
       labels:
        tier: nginx
     spec:
       containers:
       - name: nginx
         image: nginx

controlplane ~ ➜  












controlplane ~ ➜  vi replicaset-definition-1.yaml 

controlplane ~ ➜  kubectl apply -f replicaset-definition-1.yaml 
error: error validating "replicaset-definition-1.yaml": error validating data: ValidationError(ReplicaSet): unknown field "template" in io.k8s.api.apps.v1.ReplicaSet; if you choose to ignore these errors, turn validation off with --validate=false

controlplane ~ ✖ 