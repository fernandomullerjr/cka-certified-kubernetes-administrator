
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 62. Practice Test - Node Affinity"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 62. Practice Test - Node Affinity






# How many Labels exist on node node01?

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE     VERSION
controlplane   Ready    control-plane   4m26s   v1.24.0
node01         Ready    <none>          3m58s   v1.24.0

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get nodes -o wide
NAME           STATUS   ROLES           AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane   4m29s   v1.24.0   10.39.133.6   <none>        Ubuntu 18.04.6 LTS   5.4.0-1092-gcp   containerd://1.6.6
node01         Ready    <none>          4m1s    v1.24.0   10.39.133.9   <none>        Ubuntu 18.04.6 LTS   5.4.0-1092-gcp   containerd://1.6.6

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe node node01
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux
Annotations:        flannel.alpha.coreos.com/backend-data: {"VNI":1,"VtepMAC":"de:cc:f4:71:b6:8c"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 10.39.133.9
                    kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Sat, 05 Nov 2022 17:16:07 +0000
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  node01
  AcquireTime:     <unset>
  RenewTime:       Sat, 05 Nov 2022 17:20:23 +0000
Conditions:
  Type                 Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----                 ------  -----------------                 ------------------                ------                       -------
  NetworkUnavailable   False   Sat, 05 Nov 2022 17:16:15 +0000   Sat, 05 Nov 2022 17:16:15 +0000   FlannelIsUp                  Flannel is running on this node
  MemoryPressure       False   Sat, 05 Nov 2022 17:16:38 +0000   Sat, 05 Nov 2022 17:16:07 +0000   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure         False   Sat, 05 Nov 2022 17:16:38 +0000   Sat, 05 Nov 2022 17:16:07 +0000   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure          False   Sat, 05 Nov 2022 17:16:38 +0000   Sat, 05 Nov 2022 17:16:07 +0000   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready                True    Sat, 05 Nov 2022 17:16:38 +0000   Sat, 05 Nov 2022 17:16:18 +0000   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  10.39.133.9
  Hostname:    node01
Capacity:
  cpu:                36
  ephemeral-storage:  507930276Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214587072Ki
  pods:               110
Allocatable:
  cpu:                36
  ephemeral-storage:  468108541587
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214484672Ki
  pods:               110
System Info:
  Machine ID:                 01b3ebe7155a41d896f091d525a2c927
  System UUID:                569de7d6-f951-3446-9d95-05800ba5d263
  Boot ID:                    7ba8082e-b960-4eed-9075-6dc2ec3ccdc2
  Kernel Version:             5.4.0-1092-gcp
  OS Image:                   Ubuntu 18.04.6 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://1.6.6
  Kubelet Version:            v1.24.0
  Kube-Proxy Version:         v1.24.0
PodCIDR:                      10.244.1.0/24
PodCIDRs:                     10.244.1.0/24
Non-terminated Pods:          (2 in total)
  Namespace                   Name                     CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                     ------------  ----------  ---------------  -------------  ---
  kube-system                 kube-flannel-ds-tzr64    100m (0%)     100m (0%)   50Mi (0%)        300Mi (0%)     4m21s
  kube-system                 kube-proxy-8ppqf         0 (0%)        0 (0%)      0 (0%)           0 (0%)         4m21s
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests   Limits
  --------           --------   ------
  cpu                100m (0%)  100m (0%)
  memory             50Mi (0%)  300Mi (0%)
  ephemeral-storage  0 (0%)     0 (0%)
  hugepages-1Gi      0 (0%)     0 (0%)
  hugepages-2Mi      0 (0%)     0 (0%)
Events:
  Type     Reason                   Age                    From             Message
  ----     ------                   ----                   ----             -------
  Normal   Starting                 4m15s                  kube-proxy       
  Warning  InvalidDiskCapacity      4m21s                  kubelet          invalid capacity 0 on image filesystem
  Normal   NodeHasSufficientMemory  4m21s (x2 over 4m21s)  kubelet          Node node01 status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    4m21s (x2 over 4m21s)  kubelet          Node node01 status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     4m21s (x2 over 4m21s)  kubelet          Node node01 status is now: NodeHasSufficientPID
  Normal   Starting                 4m21s                  kubelet          Starting kubelet.
  Normal   NodeAllocatableEnforced  4m20s                  kubelet          Updated Node Allocatable limit across pods
  Normal   RegisteredNode           4m19s                  node-controller  Node node01 event: Registered Node node01 in Controller
  Normal   NodeReady                4m10s                  kubelet          Node node01 status is now: NodeReady

controlplane ~ ➜  



- RESPOSTA:
5








# What is the value set to the label key beta.kubernetes.io/arch on node01?

- RESPOSTA:
amd64






# Apply a label color=blue to node node01
    color = blue

kubectl label nodes node01 color=blue


controlplane ~ ➜  kubectl describe node node01 | grep color

controlplane ~ ✖ 

controlplane ~ ✖ kubectl label nodes node01 color=blue
node/node01 labeled

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe node node01 | grep color
                    color=blue

controlplane ~ ➜  








# Create a new deployment named blue with the nginx image and 3 replicas.

    Name: blue

    Replicas: 3

    Image: nginx


Examples:
  # Create a deployment named my-dep that runs the busybox image
  kubectl create deployment my-dep --image=busybox

  # Create a deployment with a command
  kubectl create deployment my-dep --image=busybox -- date

  # Create a deployment named my-dep that runs the nginx image with 3 replicas
  kubectl create deployment my-dep --image=nginx --replicas=3

  # Create a deployment named my-dep that runs the busybox image and expose port 5701
  kubectl create deployment my-dep --image=busybox --port=5701


kubectl create deployment blue --image=nginx --replicas=3



controlplane ~ ➜  

controlplane ~ ➜  kubectl get deployments
No resources found in default namespace.

controlplane ~ ➜  kubectl get deployments -A
NAMESPACE     NAME      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   coredns   2/2     2            2           28m

controlplane ~ ➜  

controlplane ~ ➜  kubectl create deployment blue --image=nginx --replicas=3
deployment.apps/blue created

controlplane ~ ➜  kubectl get deployments -A
NAMESPACE     NAME      READY   UP-TO-DATE   AVAILABLE   AGE
default       blue      0/3     3            0           2s
kube-system   coredns   2/2     2            2           28m

controlplane ~ ➜  

controlplane ~ ➜  kubectl get deployments -A
NAMESPACE     NAME      READY   UP-TO-DATE   AVAILABLE   AGE
default       blue      3/3     3            3           10s
kube-system   coredns   2/2     2            2           28m

controlplane ~ ➜  









# Which nodes can the pods for the blue deployment be placed on?

Make sure to check taints on both nodes!



controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
default       blue-795455cfcb-6drfs                  1/1     Running   0          45s
default       blue-795455cfcb-kkbrd                  1/1     Running   0          45s
default       blue-795455cfcb-x6sdz                  1/1     Running   0          45s
kube-system   coredns-6d4b75cb6d-52k7s               1/1     Running   0          29m
kube-system   coredns-6d4b75cb6d-96c9q               1/1     Running   0          29m
kube-system   etcd-controlplane                      1/1     Running   0          29m
kube-system   kube-apiserver-controlplane            1/1     Running   0          29m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          29m
kube-system   kube-flannel-ds-njs64                  1/1     Running   0          29m
kube-system   kube-flannel-ds-tzr64                  1/1     Running   0          28m
kube-system   kube-proxy-79hzx                       1/1     Running   0          29m
kube-system   kube-proxy-8ppqf                       1/1     Running   0          28m
kube-system   kube-scheduler-controlplane            1/1     Running   0          29m

controlplane ~ ➜  kubectl describe pod blue-795455cfcb-6drfs
Name:         blue-795455cfcb-6drfs
Namespace:    default
Priority:     0
Node:         node01/10.39.133.9
Start Time:   Sat, 05 Nov 2022 17:44:14 +0000
Labels:       app=blue
              pod-template-hash=795455cfcb
Annotations:  <none>
Status:       Running
IP:           10.244.1.2
IPs:
  IP:           10.244.1.2
Controlled By:  ReplicaSet/blue-795455cfcb
Containers:
  nginx:
    Container ID:   containerd://1ba677a987ebcad5f7a7d855b63ed3568ec76ca14701b078b2cd5a585a03dfd2
    Image:          nginx
    Image ID:       docker.io/library/nginx@sha256:943c25b4b66b332184d5ba6bb18234273551593016c0e0ae906bab111548239f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sat, 05 Nov 2022 17:44:21 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-q6dlw (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-q6dlw:
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
  Normal  Scheduled  51s   default-scheduler  Successfully assigned default/blue-795455cfcb-6drfs to node01
  Normal  Pulling    50s   kubelet            Pulling image "nginx"
  Normal  Pulled     45s   kubelet            Successfully pulled image "nginx" in 5.397849455s
  Normal  Created    45s   kubelet            Created container nginx
  Normal  Started    44s   kubelet            Started container nginx

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe pod blue-795455cfcb-6drfs | grep Taint

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   29m   v1.24.0
node01         Ready    <none>          29m   v1.24.0

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe node node01 | grep Taint
Taints:             <none>

controlplane ~ ➜  kubectl describe node controlplane | grep Taint
Taints:             <none>

controlplane ~ ➜  



- RESPOSTA:
ambos nodes, pois eles não tem Taint









# Set Node Affinity to the deployment to place the pods on node01 only.

    Name: blue

    Replicas: 3

    Image: nginx

    NodeAffinity: requiredDuringSchedulingIgnoredDuringExecution

    Key: color

    value: blue

kubectl create deployment blue --image=nginx --replicas=3 --dry-run=client -o yaml > deployment.yaml




controlplane ~ ➜  kubectl create deployment blue --image=nginx --replicas=3 --dry-run=client -o yaml > deployment.yaml

controlplane ~ ➜  ls
deployment.yaml  sample.yaml

controlplane ~ ➜  cat deployment.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: blue
  name: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: blue
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: blue
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
status: {}

controlplane ~ ➜  








    NodeAffinity: requiredDuringSchedulingIgnoredDuringExecution

    Key: color

    value: blue


~~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: blue
  name: blue
spec:
  replicas: 3
  affinity:
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: color
                operator: Equal
                values:
                - blue
  selector:
    matchLabels:
      app: blue
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: blue
    spec:
      containers:
      - image: nginx
        name: nginx
~~~~



- ANTES:

controlplane ~ ➜  kubectl get deployments -A
NAMESPACE     NAME      READY   UP-TO-DATE   AVAILABLE   AGE
default       blue      3/3     3            3           11m
kube-system   coredns   2/2     2            2           40m

controlplane ~ ➜  




controlplane ~ ➜  vi deployment-editado.yaml

controlplane ~ ➜  kubectl apply -f deployment-editado.yaml
error: error validating "deployment-editado.yaml": error validating data: ValidationError(Deployment.spec): unknown field "affinity" in io.k8s.api.apps.v1.DeploymentSpec; if you choose to ignore these errors, turn validation off with --validate=false

controlplane ~ ✖ 






- Editando denovo


~~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: blue
  name: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: blue
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: blue
    spec:
      affinity:
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: color
                operator: Equal
                values:
                - blue
      containers:
      - image: nginx
        name: nginx
~~~~



controlplane ~ ✖ vi deployment-editado.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f deployment-editado.yaml
error: error validating "deployment-editado.yaml": error validating data: ValidationError(Deployment.spec.template.spec.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution[0]): missing required field "topologyKey" in io.k8s.api.core.v1.PodAffinityTerm; if you choose to ignore these errors, turn validation off with --validate=false

controlplane ~ ✖ 




<https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/>
You express the topology domain (X) using a topologyKey, which is the key for the node label that the system uses to denote the domain. For examples, see Well-Known Labels, Annotations and Taints.
Note: Pod anti-affinity requires nodes to be consistently labelled, in other words, every node in the cluster must have an appropriate label matching topologyKey. If some or all nodes are missing the specified topologyKey label, it can lead to unintended behavior.

In principle, the topologyKey can be any allowed label key with the following exceptions for performance and security reasons:

    For Pod affinity and anti-affinity, an empty topologyKey field is not allowed in both requiredDuringSchedulingIgnoredDuringExecution and preferredDuringSchedulingIgnoredDuringExecution.
    For requiredDuringSchedulingIgnoredDuringExecution Pod anti-affinity rules, the admission controller LimitPodHardAntiAffinityTopology limits topologyKey to kubernetes.io/hostname. You can modify or disable the admission controller if you want to allow custom topologies.

In addition to labelSelector and topologyKey, you can optionally specify a list of namespaces which the labelSelector should match against using the namespaces field at the same level as labelSelector and topologyKey. If omitted or empty, namespaces defaults to the namespace of the Pod where the affinity/anti-affinity definition appears.
Names





- Editando denovo pt3


~~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: blue
  name: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: blue
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: blue
    spec:
      affinity:
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: color
                operator: Equal
                values:
                - blue
            topologyKey: "kubernetes.io/hostname"
      containers:
      - image: nginx
        name: nginx
~~~~



controlplane ~ ✖ vi deployment-editado.yaml

controlplane ~ ➜  kubectl apply -f deployment-editado.yaml
Warning: resource deployments/blue is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
The Deployment "blue" is invalid: spec.template.spec.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchExpressions[0].operator: Invalid value: "Equal": not a valid selector operator

controlplane ~ ✖ 








kubectl delete deployment blue


controlplane ~ ✖ kubectl delete deployment blue
deployment.apps "blue" deleted

controlplane ~ ➜  kubectl apply -f deployment-editado.yaml
The Deployment "blue" is invalid: spec.template.spec.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchExpressions[0].operator: Invalid value: "Equal": not a valid selector operator

controlplane ~ ✖ 







- Editando denovo pt4


~~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: blue
  name: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: blue
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: blue
    spec:
      affinity:
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: color
                operator: In
                values:
                - blue
            topologyKey: "kubernetes.io/hostname"
      containers:
      - image: nginx
        name: nginx
~~~~




controlplane ~ ✖ vi deployment-editado.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f deployment-editado.yaml
deployment.apps/blue created

controlplane ~ ➜  











- PODS NÃO FICARAM OK
- PODS NÃO FICARAM OK
- PODS NÃO FICARAM OK

controlplane ~ ➜  kubectl get deployments -A
NAMESPACE     NAME      READY   UP-TO-DATE   AVAILABLE   AGE
default       blue      0/3     3            0           19s
kube-system   coredns   2/2     2            2           47m

controlplane ~ ➜  



Events:
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  112s  default-scheduler  0/2 nodes are available: 2 node(s) didn't match pod affinity rules. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.

controlplane ~ ➜  









- Outro exemplo, testar:

<https://kubernetes.io/blog/2017/03/advanced-scheduling-in-kubernetes/>

For example, if we want to require scheduling on a node that is in the us-central1-a GCE zone of a multi-zone Kubernetes cluster, we can specify the following affinity rule as part of the Pod spec:

  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
            - key: "failure-domain.beta.kubernetes.io/zone"
              operator: In
              values: ["us-central1-a"]




~~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: blue
  name: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: blue
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: blue
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - key: color
                  operator: In
                  values: 
                  - blue
      containers:
      - image: nginx
        name: nginx
~~~~







controlplane ~ ➜  vi deployment-editado.yaml 

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  cat deployment-editado.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: blue
  name: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: blue
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: blue
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - key: color
                  operator: In
                  values: 
                  - blue
      containers:
      - image: nginx
        name: nginx

controlplane ~ ➜  kubectl apply -f deployment-editado.yaml 
deployment.apps/blue created

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   57m   v1.24.0
node01         Ready    <none>          56m   v1.24.0

controlplane ~ ➜  kubectl get deployment -A
NAMESPACE     NAME      READY   UP-TO-DATE   AVAILABLE   AGE
default       blue      3/3     3            3           11s
kube-system   coredns   2/2     2            2           57m

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
default       blue-6d7486c96b-b7lgb                  1/1     Running   0          17s
default       blue-6d7486c96b-sf6qf                  1/1     Running   0          17s
default       blue-6d7486c96b-vn7pf                  1/1     Running   0          17s
kube-system   coredns-6d4b75cb6d-52k7s               1/1     Running   0          57m
kube-system   coredns-6d4b75cb6d-96c9q               1/1     Running   0          57m
kube-system   etcd-controlplane                      1/1     Running   0          57m
kube-system   kube-apiserver-controlplane            1/1     Running   0          57m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          57m
kube-system   kube-flannel-ds-njs64                  1/1     Running   0          57m
kube-system   kube-flannel-ds-tzr64                  1/1     Running   0          57m
kube-system   kube-proxy-79hzx                       1/1     Running   0          57m
kube-system   kube-proxy-8ppqf                       1/1     Running   0          57m
kube-system   kube-scheduler-controlplane            1/1     Running   0          57m

controlplane ~ ➜  

controlplane ~ ➜  

















# Which nodes are the pods placed on now?


controlplane ~ ➜  kubectl describe pods blue-6d7486c96b-b7lgb
Name:         blue-6d7486c96b-b7lgb
Namespace:    default
Priority:     0
Node:         node01/10.39.133.9
Start Time:   Sat, 05 Nov 2022 18:12:


controlplane ~ ➜  kubectl describe pods blue-6d7486c96b-sf6qf | head
Name:         blue-6d7486c96b-sf6qf
Namespace:    default
Priority:     0
Node:         node01/10.39.133.9
Start Time:   Sat, 05 Nov 2022 18:12:51 +0000
Labels:       app=blue
              pod-template-hash=6d7486c96b
Annotations:  <none>
Status:       Running
IP:           10.244.1.5

controlplane ~ ➜  kubectl describe pods blue-6d7486c96b-vn7pf | head
Name:         blue-6d7486c96b-vn7pf
Namespace:    default
Priority:     0
Node:         node01/10.39.133.9
Start Time:   Sat, 05 Nov 2022 18:12:51 +0000
Labels:       app=blue
              pod-template-hash=6d7486c96b
Annotations:  <none>
Status:       Running
IP:           10.244.1.6

controlplane ~ ➜  











# Create a new deployment named red with the nginx image and 2 replicas, and ensure it gets placed on the controlplane node only.

Use the label key - node-role.kubernetes.io/control-plane - which is already set on the controlplane node.

    Name: red

    Replicas: 2

    Image: nginx

    NodeAffinity: requiredDuringSchedulingIgnoredDuringExecution

    Key: node-role.kubernetes.io/control-plane

    Use the right operator