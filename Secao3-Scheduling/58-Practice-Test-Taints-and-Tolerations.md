

# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 58. Practice Test - Taints and Tolerations"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 58. Practice Test - Taints and Tolerations


# How many nodes exist on the system?

Including the controlplane node.

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE     VERSION
controlplane   Ready    control-plane   6m55s   v1.24.0
node01         Ready    <none>          6m26s   v1.24.0

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get nodes --no-headers 
controlplane   Ready   control-plane   7m5s    v1.24.0
node01         Ready   <none>          6m36s   v1.24.0

controlplane ~ ➜  kubectl get nodes --no-headers | wc -l
2

controlplane ~ ➜  


- RESPOSTA:
2









# Do any taints exist on node01 node?

kubectl describe node node01 | grep Taint

controlplane ~ ➜  kubectl describe node node01 | grep Taint
Taints:             <none>

controlplane ~ ➜  









# Create a taint on node01 with key of spray, value of mortein and effect of NoSchedule

    Key = spray

    Value = mortein

    Effect = NoSchedule

kubectl taint nodes node1 app=blue:NoSchedule
kubectl taint nodes node01 spray=mortein:NoSchedule

controlplane ~ ➜  kubectl taint nodes node01 spray=mortein:NoSchedule
node/node01 tainted

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe node node01 | grep Taint
Taints:             spray=mortein:NoSchedule

controlplane ~ ➜  








# Create a new pod with the nginx image and pod name as mosquito.

    Image name: nginx

kubectl run mosquito --image=nginx



controlplane ~ ➜  kubectl get pods
No resources found in default namespace.

controlplane ~ ➜  

controlplane ~ ➜  kubectl run mosquito --image=nginx
pod/mosquito created

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
mosquito   0/1     Pending   0          2s

controlplane ~ ➜  








# Why do you think the pod is in a pending state?


controlplane ~ ➜  kubectl describe pod mosquito
Name:         mosquito
Namespace:    default
Priority:     0
Node:         <none>
Labels:       run=mosquito
Annotations:  <none>
Status:       Pending
IP:           
IPs:          <none>
Containers:
  mosquito:
    Image:        nginx
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-k6nsk (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  kube-api-access-k6nsk:
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
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  39s   default-scheduler  0/2 nodes are available: 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane: }, 1 node(s) had untolerated taint {spray: mortein}. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.

controlplane ~ ➜  


- RESPOSTA:
Pod não tem toleration para o Taint do Node











# Create another pod named bee with the nginx image, which has a toleration set to the taint mortein.

    Image name: nginx

    Key: spray

    Value: mortein

    Effect: NoSchedule

    Status: Running


  # Dry run; print the corresponding API objects without creating them
  kubectl run nginx --image=nginx --dry-run=client

kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml

~~~~yaml
controlplane ~ ➜  cat pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

controlplane ~ ➜  
~~~~



- Editado:

~~~~yaml
controlplane ~ ➜  cat pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  tolerations:
  - key: "spray"
    operator: "Equal"
    value: "mortein"
    effect: "NoSchedule"
status: {}

controlplane ~ ➜  
~~~~




controlplane ~ ➜  kubectl apply -f pod.yaml 
pod/nginx created

controlplane ~ ➜  kubectl get pods
NAME       READY   STATUS              RESTARTS   AGE
mosquito   0/1     Pending             0          6m15s
nginx      0/1     ContainerCreating   0          3s

controlplane ~ ➜  kubectl get pods
NAME       READY   STATUS              RESTARTS   AGE
mosquito   0/1     Pending             0          6m19s
nginx      0/1     ContainerCreating   0          7s

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
mosquito   0/1     Pending   0          6m22s
nginx      1/1     Running   0          10s

controlplane ~ ➜  




- Resultado foi:
incomplete


- Nome do Pod tá nginx ao invés de bee, necessário ajustar

- Editado:

~~~~yaml
controlplane ~ ➜  cat pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: bee
spec:
  containers:
  - image: nginx
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  tolerations:
  - key: "spray"
    operator: "Equal"
    value: "mortein"
    effect: "NoSchedule"
status: {}

controlplane ~ ➜  
~~~~



controlplane ~ ➜  vi pod.yaml 

controlplane ~ ➜  kubectl apply -f pod.yaml 
pod/bee created

controlplane ~ ➜  kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
bee        1/1     Running   0          11s
mosquito   0/1     Pending   0          7m57s
nginx      1/1     Running   0          105s

controlplane ~ ➜  











# info Notice the bee pod was scheduled on node node01 despite the taint.

controlplane ~ ➜  kubectl describe pod bee
Name:         bee
Namespace:    default
Priority:     0
Node:         node01/10.5.139.9






# Do you see any taints on controlplane node?