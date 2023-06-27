

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "128. Practice Test - Cluster Upgrade."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 128. Practice Test - Cluster Upgrade


- Version?

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   56m   v1.26.0
node01         Ready    <none>          56m   v1.26.0

controlplane ~ ➜  







- How many nodes are part of this cluster?

Including controlplane and worker nodes

controlplane ~ ➜  kubectl get nodes -A
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   57m   v1.26.0
node01         Ready    <none>          56m   v1.26.0

controlplane ~ ➜  







- How many nodes can host workloads in this cluster?

Inspect the applications and taints set on the nodes.


controlplane ~ ➜  kubectl describe node controlplane
Name:               controlplane
Roles:              control-plane
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=controlplane
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/control-plane=
                    node.kubernetes.io/exclude-from-external-load-balancers=
Annotations:        flannel.alpha.coreos.com/backend-data: {"VNI":1,"VtepMAC":"e6:fb:b0:c1:92:44"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 172.25.0.77
                    kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Mon, 26 Jun 2023 21:12:34 -0400
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  controlplane
  AcquireTime:     <unset>
  RenewTime:       Mon, 26 Jun 2023 22:10:11 -0400
Conditions:
  Type                 Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----                 ------  -----------------                 ------------------                ------                       -------
  NetworkUnavailable   False   Mon, 26 Jun 2023 21:13:05 -0400   Mon, 26 Jun 2023 21:13:05 -0400   FlannelIsUp                  Flannel is running on this node
  MemoryPressure       False   Mon, 26 Jun 2023 22:09:23 -0400   Mon, 26 Jun 2023 21:12:28 -0400   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure         False   Mon, 26 Jun 2023 22:09:23 -0400   Mon, 26 Jun 2023 21:12:28 -0400   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure          False   Mon, 26 Jun 2023 22:09:23 -0400   Mon, 26 Jun 2023 21:12:28 -0400   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready                True    Mon, 26 Jun 2023 22:09:23 -0400   Mon, 26 Jun 2023 21:13:02 -0400   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  192.3.224.6
  Hostname:    controlplane
Capacity:
  cpu:                36
  ephemeral-storage:  1016057248Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214587052Ki
  pods:               110
Allocatable:
  cpu:                36
  ephemeral-storage:  936398358207
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214484652Ki
  pods:               110
System Info:
  Machine ID:                 bc1qzk3kxhdxnzkpdgdn9ueg34y08smxgfv0hxvcu3
  System UUID:                ccf22a91-925e-0514-bae9-99ef4e27a4c3
  Boot ID:                    77e6f161-e95f-42d7-8ac4-235c08643e89
  Kernel Version:             5.4.0-1106-gcp
  OS Image:                   Ubuntu 20.04.5 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://1.6.6
  Kubelet Version:            v1.26.0
  Kube-Proxy Version:         v1.26.0
PodCIDR:                      10.244.0.0/24
PodCIDRs:                     10.244.0.0/24
Non-terminated Pods:          (10 in total)
  Namespace                   Name                                    CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                                    ------------  ----------  ---------------  -------------  ---
  default                     blue-987f68cb5-lfxk2                    0 (0%)        0 (0%)      0 (0%)           0 (0%)         97s
  default                     blue-987f68cb5-wx8jt                    0 (0%)        0 (0%)      0 (0%)           0 (0%)         97s
  kube-flannel                kube-flannel-ds-v8d4q                   100m (0%)     100m (0%)   50Mi (0%)        50Mi (0%)      57m
  kube-system                 coredns-787d4945fb-4dxfq                100m (0%)     0 (0%)      70Mi (0%)        170Mi (0%)     57m
  kube-system                 coredns-787d4945fb-lhrqp                100m (0%)     0 (0%)      70Mi (0%)        170Mi (0%)     57m
  kube-system                 etcd-controlplane                       100m (0%)     0 (0%)      100Mi (0%)       0 (0%)         57m
  kube-system                 kube-apiserver-controlplane             250m (0%)     0 (0%)      0 (0%)           0 (0%)         57m
  kube-system                 kube-controller-manager-controlplane    200m (0%)     0 (0%)      0 (0%)           0 (0%)         57m
  kube-system                 kube-proxy-8rh7n                        0 (0%)        0 (0%)      0 (0%)           0 (0%)         57m
  kube-system                 kube-scheduler-controlplane             100m (0%)     0 (0%)      0 (0%)           0 (0%)         57m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                950m (2%)   100m (0%)
  memory             290Mi (0%)  390Mi (0%)
  ephemeral-storage  0 (0%)      0 (0%)
  hugepages-1Gi      0 (0%)      0 (0%)
  hugepages-2Mi      0 (0%)      0 (0%)
Events:
  Type     Reason                   Age                From             Message
  ----     ------                   ----               ----             -------
  Normal   Starting                 57m                kube-proxy       
  Normal   NodeHasNoDiskPressure    57m (x7 over 57m)  kubelet          Node controlplane status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     57m (x7 over 57m)  kubelet          Node controlplane status is now: NodeHasSufficientPID
  Normal   NodeHasSufficientMemory  57m (x8 over 57m)  kubelet          Node controlplane status is now: NodeHasSufficientMemory
  Normal   Starting                 57m                kubelet          Starting kubelet.
  Warning  InvalidDiskCapacity      57m                kubelet          invalid capacity 0 on image filesystem
  Normal   NodeHasSufficientMemory  57m                kubelet          Node controlplane status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    57m                kubelet          Node controlplane status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     57m                kubelet          Node controlplane status is now: NodeHasSufficientPID
  Normal   NodeAllocatableEnforced  57m                kubelet          Updated Node Allocatable limit across pods
  Normal   RegisteredNode           57m                node-controller  Node controlplane event: Registered Node controlplane in Controller
  Normal   NodeReady                57m                kubelet          Node controlplane status is now: NodeReady

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE     IP            NODE           NOMINATED NODE   READINESS GATES
default        blue-987f68cb5-g8766                   1/1     Running   0          2m40s   10.244.1.3    node01         <none>           <none>
default        blue-987f68cb5-h8tn5                   1/1     Running   0          2m40s   10.244.1.4    node01         <none>           <none>
default        blue-987f68cb5-lfxk2                   1/1     Running   0          2m40s   10.244.0.5    controlplane   <none>           <none>
default        blue-987f68cb5-qzrnk                   1/1     Running   0          2m40s   10.244.1.2    node01         <none>           <none>
default        blue-987f68cb5-wx8jt                   1/1     Running   0          2m40s   10.244.0.4    controlplane   <none>           <none>
kube-flannel   kube-flannel-ds-k9dw5                  1/1     Running   0          58m     192.3.224.9   node01         <none>           <none>
kube-flannel   kube-flannel-ds-v8d4q                  1/1     Running   0          58m     192.3.224.6   controlplane   <none>           <none>
kube-system    coredns-787d4945fb-4dxfq               1/1     Running   0          58m     10.244.0.2    controlplane   <none>           <none>
kube-system    coredns-787d4945fb-lhrqp               1/1     Running   0          58m     10.244.0.3    controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running   0          58m     192.3.224.6   controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running   0          58m     192.3.224.6   controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   1/1     Running   0          58m     192.3.224.6   controlplane   <none>           <none>
kube-system    kube-proxy-8rh7n                       1/1     Running   0          58m     192.3.224.6   controlplane   <none>           <none>
kube-system    kube-proxy-fpb4q                       1/1     Running   0          58m     192.3.224.9   node01         <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running   0          58m     192.3.224.6   controlplane   <none>           <none>

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe node node01
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux
Annotations:        flannel.alpha.coreos.com/backend-data: {"VNI":1,"VtepMAC":"de:8d:b0:81:15:97"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 172.25.0.4
                    kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Mon, 26 Jun 2023 21:13:08 -0400
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  node01
  AcquireTime:     <unset>
  RenewTime:       Mon, 26 Jun 2023 22:11:39 -0400
Conditions:
  Type                 Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----                 ------  -----------------                 ------------------                ------                       -------
  NetworkUnavailable   False   Mon, 26 Jun 2023 21:13:21 -0400   Mon, 26 Jun 2023 21:13:21 -0400   FlannelIsUp                  Flannel is running on this node
  MemoryPressure       False   Mon, 26 Jun 2023 22:09:46 -0400   Mon, 26 Jun 2023 21:13:08 -0400   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure         False   Mon, 26 Jun 2023 22:09:46 -0400   Mon, 26 Jun 2023 21:13:08 -0400   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure          False   Mon, 26 Jun 2023 22:09:46 -0400   Mon, 26 Jun 2023 21:13:08 -0400   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready                True    Mon, 26 Jun 2023 22:09:46 -0400   Mon, 26 Jun 2023 21:13:19 -0400   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  192.3.224.9
  Hostname:    node01
Capacity:
  cpu:                36
  ephemeral-storage:  1016057248Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214587056Ki
  pods:               110
Allocatable:
  cpu:                36
  ephemeral-storage:  936398358207
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214484656Ki
  pods:               110
System Info:
  Machine ID:                 bc1qzk3kxhdxnzkpdgdn9ueg34y08smxgfv0hxvcu3
  System UUID:                bf88a9e6-55ee-0168-e1d9-a97bfe906f74
  Boot ID:                    c7997b72-c120-44f7-9494-477df568dc7e
  Kernel Version:             5.4.0-1106-gcp
  OS Image:                   Ubuntu 20.04.5 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://1.6.6
  Kubelet Version:            v1.26.0
  Kube-Proxy Version:         v1.26.0
PodCIDR:                      10.244.1.0/24
PodCIDRs:                     10.244.1.0/24
Non-terminated Pods:          (5 in total)
  Namespace                   Name                     CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                     ------------  ----------  ---------------  -------------  ---
  default                     blue-987f68cb5-g8766     0 (0%)        0 (0%)      0 (0%)           0 (0%)         3m3s
  default                     blue-987f68cb5-h8tn5     0 (0%)        0 (0%)      0 (0%)           0 (0%)         3m3s
  default                     blue-987f68cb5-qzrnk     0 (0%)        0 (0%)      0 (0%)           0 (0%)         3m3s
  kube-flannel                kube-flannel-ds-k9dw5    100m (0%)     100m (0%)   50Mi (0%)        50Mi (0%)      58m
  kube-system                 kube-proxy-fpb4q         0 (0%)        0 (0%)      0 (0%)           0 (0%)         58m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests   Limits
  --------           --------   ------
  cpu                100m (0%)  100m (0%)
  memory             50Mi (0%)  50Mi (0%)
  ephemeral-storage  0 (0%)     0 (0%)
  hugepages-1Gi      0 (0%)     0 (0%)
  hugepages-2Mi      0 (0%)     0 (0%)
Events:
  Type     Reason                   Age   From             Message
  ----     ------                   ----  ----             -------
  Normal   Starting                 58m   kube-proxy       
  Normal   Starting                 58m   kubelet          Starting kubelet.
  Warning  InvalidDiskCapacity      58m   kubelet          invalid capacity 0 on image filesystem
  Normal   NodeHasSufficientMemory  58m   kubelet          Node node01 status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    58m   kubelet          Node node01 status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     58m   kubelet          Node node01 status is now: NodeHasSufficientPID
  Normal   NodeAllocatableEnforced  58m   kubelet          Updated Node Allocatable limit across pods
  Normal   RegisteredNode           58m   node-controller  Node node01 event: Registered Node node01 in Controller
  Normal   NodeReady                58m   kubelet          Node node01 status is now: NodeReady

controlplane ~ ➜  











- How many applications are hosted on the cluster?

Count the number of deployments in the default namespace.


controlplane ~ ➜  kubectl get deploy
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
blue   5/5     5            5           3m54s

controlplane ~ ➜  









What nodes are the pods hosted on?

controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE     IP            NODE           NOMINATED NODE   READINESS GATES
default        blue-987f68cb5-g8766                   1/1     Running   0          4m21s   10.244.1.3    node01         <none>           <none>
default        blue-987f68cb5-h8tn5                   1/1     Running   0          4m21s   10.244.1.4    node01         <none>           <none>
default        blue-987f68cb5-lfxk2                   1/1     Running   0          4m21s   10.244.0.5    controlplane   <none>           <none>
default        blue-987f68cb5-qzrnk                   1/1     Running   0          4m21s   10.244.1.2    node01         <none>           <none>
default        blue-987f68cb5-wx8jt                   1/1     Running   0          4m21s   10.244.0.4    controlplane   <none>           <none>
kube-flannel   kube-flannel-ds-k9dw5                  1/1     Running   0          59m     192.3.224.9   node01         <none>           <none>
kube-flannel   kube-flannel-ds-v8d4q                  1/1     Running   0          60m     192.3.224.6   controlplane   <none>           <none>
kube-system    coredns-787d4945fb-4dxfq               1/1     Running   0          60m     10.244.0.2    controlplane   <none>           <none>
kube-system    coredns-787d4945fb-lhrqp               1/1     Running   0          60m     10.244.0.3    controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running   0          60m     192.3.224.6   controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running   0          60m     192.3.224.6   controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   1/1     Running   0          60m     192.3.224.6   controlplane   <none>           <none>
kube-system    kube-proxy-8rh7n                       1/1     Running   0          60m     192.3.224.6   controlplane   <none>           <none>
kube-system    kube-proxy-fpb4q                       1/1     Running   0          59m     192.3.224.9   node01         <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running   0          60m     192.3.224.6   controlplane   <none>           <none>

controlplane ~ ➜  







You are tasked to upgrade the cluster. Users accessing the applications must not be impacted, and you cannot provision new VMs. What strategy would you use to upgrade the cluster?






What is the latest stable version of Kubernetes as of today?

Look at the remote version in the output of the kubeadm upgrade plan command.

controlplane ~ ➜  kubeadm upgrade plan
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks.
[upgrade] Running cluster health checks
[upgrade] Fetching available versions to upgrade to
[upgrade/versions] Cluster version: v1.26.0
[upgrade/versions] kubeadm version: v1.26.0
I0626 22:14:18.758279   17425 version.go:256] remote version is much newer: v1.27.3; falling back to: stable-1.26
[upgrade/versions] Target version: v1.26.6
[upgrade/versions] Latest version in the v1.26 series: v1.26.6

Components that must be upgraded manually after you have upgraded the control plane with 'kubeadm upgrade apply':
COMPONENT   CURRENT       TARGET
kubelet     2 x v1.26.0   v1.26.6

Upgrade to the latest version in the v1.26 series:

COMPONENT                 CURRENT   TARGET
kube-apiserver            v1.26.0   v1.26.6
kube-controller-manager   v1.26.0   v1.26.6
kube-scheduler            v1.26.0   v1.26.6
kube-proxy                v1.26.0   v1.26.6
CoreDNS                   v1.9.3    v1.9.3
etcd                      3.5.6-0   3.5.6-0

You can now apply the upgrade by executing the following command:

        kubeadm upgrade apply v1.26.6

Note: Before you can perform this upgrade, you have to update kubeadm to v1.26.6.

_____________________________________________________________________


The table below shows the current state of component configs as understood by this version of kubeadm.
Configs that have a "yes" mark in the "MANUAL UPGRADE REQUIRED" column require manual config upgrade or
resetting to kubeadm defaults before a successful upgrade can be performed. The version to manually
upgrade to is denoted in the "PREFERRED VERSION" column.

API GROUP                 CURRENT VERSION   PREFERRED VERSION   MANUAL UPGRADE REQUIRED
kubeproxy.config.k8s.io   v1alpha1          v1alpha1            no
kubelet.config.k8s.io     v1beta1           v1beta1             no
_____________________________________________________________________


controlplane ~ ➜  











What is the latest version available for an upgrade with the current version of the kubeadm tool installed?

Use the kubeadm tool

- RESPOSTA
v1.26.6




We will be upgrading the controlplane node first. Drain the controlplane node of workloads and mark it UnSchedulable

kubectl drain controlplane



controlplane ~ ➜  kubectl drain controlplane
node/controlplane cordoned
error: unable to drain node "controlplane" due to error:cannot delete DaemonSet-managed Pods (use --ignore-daemonsets to ignore): kube-flannel/kube-flannel-ds-v8d4q, kube-system/kube-proxy-8rh7n, continuing command...
There are pending nodes to be drained:
 controlplane
cannot delete DaemonSet-managed Pods (use --ignore-daemonsets to ignore): kube-flannel/kube-flannel-ds-v8d4q, kube-system/kube-proxy-8rh7n

controlplane ~ ✖ kubectl get ds
No resources found in default namespace.

controlplane ~ ➜  kubectl get ds -A
NAMESPACE      NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-flannel   kube-flannel-ds   2         2         2       2            2           <none>                   65m
kube-system    kube-proxy        2         2         2       2            2           kubernetes.io/os=linux   66m

controlplane ~ ➜  


controlplane ~ ➜  kubectl get ds kube-proxy -n kube-system
NAME         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-proxy   2         2         2       2            2           kubernetes.io/os=linux   66m

controlplane ~ ➜  kubectl get ds kube-proxy -n kube-system -o yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  annotations:
    deprecated.daemonset.template.generation: "1"
  creationTimestamp: "2023-06-27T01:12:41Z"
  generation: 1
  labels:
    k8s-app: kube-proxy
  name: kube-proxy
  namespace: kube-system
  resourceVersion: "487"
  uid: 63e46416-ee0e-46e5-9db7-0348010acc05
spec:
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      k8s-app: kube-proxy
  template:
    metadata:
      creationTimestamp: null
      labels:
        k8s-app: kube-proxy
    spec:
      containers:
      - command:
        - /usr/local/bin/kube-proxy
        - --config=/var/lib/kube-proxy/config.conf
        - --hostname-override=$(NODE_NAME)
        env:
        - name: NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        image: registry.k8s.io/kube-proxy:v1.26.0
        imagePullPolicy: IfNotPresent
        name: kube-proxy
        resources: {}
        securityContext:
          privileged: true
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /var/lib/kube-proxy
          name: kube-proxy
        - mountPath: /run/xtables.lock
          name: xtables-lock
        - mountPath: /lib/modules
          name: lib-modules
          readOnly: true
      dnsPolicy: ClusterFirst
      hostNetwork: true
      nodeSelector:
        kubernetes.io/os: linux
      priorityClassName: system-node-critical
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      serviceAccount: kube-proxy
      serviceAccountName: kube-proxy
      terminationGracePeriodSeconds: 30
      tolerations:
      - operator: Exists
      volumes:
      - configMap:
          defaultMode: 420
          name: kube-proxy
        name: kube-proxy
      - hostPath:
          path: /run/xtables.lock
          type: FileOrCreate
        name: xtables-lock
      - hostPath:
          path: /lib/modules
          type: ""
        name: lib-modules
  updateStrategy:
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
    type: RollingUpdate
status:
  currentNumberScheduled: 2
  desiredNumberScheduled: 2
  numberAvailable: 2
  numberMisscheduled: 0
  numberReady: 2
  observedGeneration: 1
  updatedNumberScheduled: 2

controlplane ~ ➜  


Ajustar o node selector do DaemonSet
de:
kubernetes.io/os: linux
para:
kubernetes.io/hostname: node01


controlplane ~ ➜  cat sample.yaml 

controlplane ~ ➜  vi ds-depois.yaml

controlplane ~ ➜  kubectl apply -f ds-depois.yaml
Warning: resource daemonsets/kube-proxy is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
daemonset.apps/kube-proxy configured

controlplane ~ ➜  kubectl get ds -A
NAMESPACE      NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                                          AGE
kube-flannel   kube-flannel-ds   2         2         2       2            2           <none>                                                 75m
kube-system    kube-proxy        1         1         1       1            1           kubernetes.io/hostname=node01,kubernetes.io/os=linux   75m

controlplane ~ ➜  



- Ajustando

DE:
~~~~YAML
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: kubernetes.io/os
                operator: In
                values:
                - linux
~~~~


PARA:
~~~~YAML
      nodeSelector:
        kubernetes.io/hostname: node01
~~~~


controlplane ~ ➜  vi ds2-depois.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f ds2-depois.yaml
daemonset.apps/kube-flannel-ds configured

controlplane ~ ➜  kubectl get ds -A
NAMESPACE      NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                                          AGE
kube-flannel   kube-flannel-ds   1         1         0       1            0           kubernetes.io/hostname=node01                          79m
kube-system    kube-proxy        1         1         1       1            1           kubernetes.io/hostname=node01,kubernetes.io/os=linux   79m

controlplane ~ ➜  


Drenando novamente:
kubectl drain controlplane

controlplane ~ ➜  kubectl drain controlplane
node/controlplane already cordoned
evicting pod kube-system/coredns-787d4945fb-lhrqp
evicting pod default/blue-987f68cb5-wx8jt
evicting pod default/blue-987f68cb5-lfxk2
evicting pod kube-system/coredns-787d4945fb-4dxfq
pod/blue-987f68cb5-lfxk2 evicted
pod/blue-987f68cb5-wx8jt evicted
pod/coredns-787d4945fb-lhrqp evicted
pod/coredns-787d4945fb-4dxfq evicted
node/controlplane drained

controlplane ~ ➜  

controlplane ~ ➜  kubectl get node
NAME           STATUS                     ROLES           AGE   VERSION
controlplane   Ready,SchedulingDisabled   control-plane   80m   v1.26.0
node01         Ready                      <none>          79m   v1.26.0

controlplane ~ ➜  









Upgrade the controlplane components to exact version v1.27.0

Upgrade the kubeadm tool (if not already), then the controlplane components, and finally the kubelet. Practice referring to the Kubernetes documentation page.

Note: While upgrading kubelet, if you hit dependency issues while running the apt-get upgrade kubelet command, use the apt install kubelet=1.27.0-00 command instead.

CHECKS:
    Controlplane Node Upgraded to v1.27.0
    Controlplane Kubelet Upgraded to v1.27.0

- DOC
https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/
<https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/>

apt update
apt-cache madison kubeadm

controlplane ~ ➜  apt update
Get:2 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]                                                               
Hit:3 https://download.docker.com/linux/ubuntu focal InRelease                                                                          
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [8,993 B]                                 
Hit:4 http://archive.ubuntu.com/ubuntu focal InRelease                                      
Get:5 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Fetched 345 kB in 1s (273 kB/s)    
Reading package lists... Done
Building dependency tree       
Reading state information... Done
84 packages can be upgraded. Run 'apt list --upgradable' to see them.

controlplane ~ ➜  apt-cache madison kubeadm
   kubeadm |  1.27.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.27.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.27.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.27.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.26.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.26.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.26.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.26.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.26.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.26.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.26.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.25.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.25.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.25.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.25.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.25.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.25.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.25.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.25.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.25.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.25.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.25.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.25.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.24.15-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.24.14-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.24.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.24.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.24.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.24.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.24.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.24.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.24.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.24.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.24.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.24.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.24.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.24.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.24.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.24.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.23.17-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.23.16-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.23.15-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.23.14-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.23.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.23.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.23.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.23.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.23.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.23.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.23.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.23.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.23.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.23.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.23.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.23.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.23.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.23.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.22.17-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.22.16-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.22.15-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.22.14-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.22.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.22.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.22.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.22.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.22.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.22.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.22.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.22.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.22.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.22.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.22.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.22.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.22.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.22.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.21.14-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.21.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.21.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.21.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.21.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.21.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.21.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.21.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.21.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.21.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.21.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.21.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.21.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.21.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.21.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.20.15-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.20.14-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.20.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.20.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.20.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.20.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.20.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.20.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.20.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.20.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.20.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.20.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.20.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.20.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.20.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.19.16-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.19.15-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.19.14-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.19.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.19.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.19.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.19.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.19.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.19.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.19.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.19.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.19.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.19.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.19.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.19.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.19.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.19.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.18.20-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.18.19-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.18.18-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.18.17-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.18.16-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.18.15-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.18.14-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.18.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.18.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.18.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.18.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.18.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.18.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.18.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.18.4-01 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.18.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.18.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.18.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.18.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.18.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.17.17-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.17.16-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.17.15-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.17.14-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.17.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.17.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.17.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.17.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.17.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.17.7-01 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.17.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.17.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.17.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.17.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.17.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.17.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.17.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.17.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.16.15-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.16.14-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.16.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.16.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.16.11-01 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.16.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.16.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.16.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.16.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.16.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.16.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.16.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.16.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.16.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.16.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.16.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.16.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.15.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.15.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.15.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.15.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.15.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.15.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.15.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.15.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.15.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.15.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.15.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.15.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.15.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.14.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.14.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.14.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.14.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.14.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.14.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.14.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.14.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.14.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.14.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.14.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.13.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.13.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.13.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.13.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.13.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.13.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.13.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.13.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.13.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.13.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.13.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.13.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.13.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.12.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.12.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.12.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.12.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.12.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.12.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.12.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.12.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.12.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.12.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.12.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.11.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.11.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.11.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.11.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.11.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.11.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.11.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.11.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.11.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.11.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.11.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.10.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.10.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.10.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm | 1.10.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.10.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.10.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.10.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.10.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.10.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.10.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.10.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.10.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.10.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.10.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.9.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.9.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.9.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.9.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.9.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.9.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.9.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.9.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.9.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.9.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.9.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.9.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.8.15-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.8.14-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.8.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.8.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.8.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.8.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.8.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.8.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.8.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.8.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.8.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.8.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.8.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.8.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.8.1-01 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.8.0-01 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.8.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.7.16-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.7.15-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.7.14-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.7.11-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.7.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.7.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.7.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.7.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.7.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.7.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.7.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.7.3-01 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.7.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.7.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.7.0-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.6.13-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.6.12-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.6.11-01 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |  1.6.10-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.6.9-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.6.8-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.6.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.6.6-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.6.5-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.6.4-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.6.3-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.6.2-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.6.1-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages
   kubeadm |   1.5.7-00 | http://apt.kubernetes.io kubernetes-xenial/main amd64 Packages

controlplane ~ ➜  




apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.27.x-00 && \
apt-mark hold kubeadm



controlplane ~ ➜  apt-mark unhold kubeadm && \
> apt-get update && apt-get install -y kubeadm=1.27.x-00 && \
> apt-mark hold kubeadm
kubeadm was already not hold.
Hit:2 https://download.docker.com/linux/ubuntu focal InRelease                                                                          
Hit:3 http://archive.ubuntu.com/ubuntu focal InRelease                                                                                  
Hit:1 https://packages.cloud.google.com/apt kubernetes-xenial InRelease                                                              
Get:4 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Hit:5 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Get:6 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Fetched 222 kB in 1s (179 kB/s)                                     
Reading package lists... Done
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Version '1.27.x-00' for 'kubeadm' was not found

controlplane ~ ✖ 




apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.27.0-00 && \
apt-mark hold kubeadm



controlplane ~ ✖ apt-mark unhold kubeadm && \
> apt-get update && apt-get install -y kubeadm=1.27.0-00 && \
> apt-mark hold kubeadm
kubeadm was already not hold.
Hit:2 https://download.docker.com/linux/ubuntu focal InRelease                                                                
Hit:1 https://packages.cloud.google.com/apt kubernetes-xenial InRelease                                                          
Get:3 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]                                                        
Hit:4 http://archive.ubuntu.com/ubuntu focal InRelease                      
Hit:5 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Get:6 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Fetched 222 kB in 1s (152 kB/s)                                     
Reading package lists... Done
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages will be upgraded:
  kubeadm
1 upgraded, 0 newly installed, 0 to remove and 83 not upgraded.
Need to get 9,931 kB of archives.
After this operation, 1,393 kB of additional disk space will be used.
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubeadm amd64 1.27.0-00 [9,931 kB]
Fetched 9,931 kB in 1s (8,244 kB/s)  
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 20428 files and directories currently installed.)
Preparing to unpack .../kubeadm_1.27.0-00_amd64.deb ...
Unpacking kubeadm (1.27.0-00) over (1.26.0-00) ...
Setting up kubeadm (1.27.0-00) ...
kubeadm set on hold.

controlplane ~ ➜  



controlplane ~ ➜  kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"27", GitVersion:"v1.27.0", GitCommit:"bc1qzk3kxhdxnzkpdgdn9ueg34y08smxgfv0hxvcu3", GitTreeState:"clean", BuildDate:"2023-04-11T17:09:06Z", GoVersion:"go1.20.3", Compiler:"gc", Platform:"linux/amd64"}

controlplane ~ ➜  


controlplane ~ ➜  kubeadm upgrade plan
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks.
[upgrade] Running cluster health checks
[upgrade] Fetching available versions to upgrade to
[upgrade/versions] Cluster version: v1.26.0
[upgrade/versions] kubeadm version: v1.27.0
[upgrade/versions] Target version: v1.27.3
[upgrade/versions] Latest version in the v1.26 series: v1.26.6
W0626 22:38:19.391803   25557 compute.go:307] [upgrade/versions] could not find officially supported version of etcd for Kubernetes v1.27.3, falling back to the nearest etcd version (3.5.7-0)

Components that must be upgraded manually after you have upgraded the control plane with 'kubeadm upgrade apply':
COMPONENT   CURRENT       TARGET
kubelet     2 x v1.26.0   v1.26.6

Upgrade to the latest version in the v1.26 series:

COMPONENT                 CURRENT   TARGET
kube-apiserver            v1.26.0   v1.26.6
kube-controller-manager   v1.26.0   v1.26.6
kube-scheduler            v1.26.0   v1.26.6
kube-proxy                v1.26.0   v1.26.6
CoreDNS                   v1.9.3    v1.10.1
etcd                      3.5.6-0   3.5.7-0

You can now apply the upgrade by executing the following command:

        kubeadm upgrade apply v1.26.6

_____________________________________________________________________

Components that must be upgraded manually after you have upgraded the control plane with 'kubeadm upgrade apply':
COMPONENT   CURRENT       TARGET
kubelet     2 x v1.26.0   v1.27.3

Upgrade to the latest stable version:

COMPONENT                 CURRENT   TARGET
kube-apiserver            v1.26.0   v1.27.3
kube-controller-manager   v1.26.0   v1.27.3
kube-scheduler            v1.26.0   v1.27.3
kube-proxy                v1.26.0   v1.27.3
CoreDNS                   v1.9.3    v1.10.1
etcd                      3.5.6-0   3.5.7-0

You can now apply the upgrade by executing the following command:

        kubeadm upgrade apply v1.27.3

Note: Before you can perform this upgrade, you have to update kubeadm to v1.27.3.

_____________________________________________________________________


The table below shows the current state of component configs as understood by this version of kubeadm.
Configs that have a "yes" mark in the "MANUAL UPGRADE REQUIRED" column require manual config upgrade or
resetting to kubeadm defaults before a successful upgrade can be performed. The version to manually
upgrade to is denoted in the "PREFERRED VERSION" column.

API GROUP                 CURRENT VERSION   PREFERRED VERSION   MANUAL UPGRADE REQUIRED
kubeproxy.config.k8s.io   v1alpha1          v1alpha1            no
kubelet.config.k8s.io     v1beta1           v1beta1             no
_____________________________________________________________________


controlplane ~ ➜  



sudo kubeadm upgrade apply v1.27.x
sudo kubeadm upgrade apply v1.27.0




controlplane ~ ➜  sudo kubeadm upgrade apply v1.27.0
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks.
[upgrade] Running cluster health checks
[upgrade/version] You have chosen to change the cluster version to "v1.27.0"
[upgrade/versions] Cluster version: v1.26.0
[upgrade/versions] kubeadm version: v1.27.0
[upgrade] Are you sure you want to proceed? [y/N]: y
[upgrade/prepull] Pulling images required for setting up a Kubernetes cluster
[upgrade/prepull] This might take a minute or two, depending on the speed of your internet connection
[upgrade/prepull] You can also perform this action in beforehand using 'kubeadm config images pull'
W0626 22:39:07.847798   25773 images.go:80] could not find officially supported version of etcd for Kubernetes v1.27.0, falling back to the nearest etcd version (3.5.7-0)
W0626 22:39:18.436625   25773 checks.go:835] detected that the sandbox image "k8s.gcr.io/pause:3.6" of the container runtime is inconsistent with that used by kubeadm. It is recommended that using "registry.k8s.io/pause:3.9" as the CRI sandbox image.
[upgrade/apply] Upgrading your Static Pod-hosted control plane to version "v1.27.0" (timeout: 5m0s)...
[upgrade/etcd] Upgrading to TLS for etcd
W0626 22:39:27.924568   25773 staticpods.go:305] [upgrade/etcd] could not find officially supported version of etcd for Kubernetes v1.27.0, falling back to the nearest etcd version (3.5.7-0)
W0626 22:39:27.929572   25773 images.go:80] could not find officially supported version of etcd for Kubernetes v1.27.0, falling back to the nearest etcd version (3.5.7-0)
[upgrade/staticpods] Preparing for "etcd" upgrade
[upgrade/staticpods] Renewing etcd-server certificate
[upgrade/staticpods] Renewing etcd-peer certificate
[upgrade/staticpods] Renewing etcd-healthcheck-client certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/etcd.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2023-06-26-22-39-27/etcd.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
[apiclient] Found 1 Pods for label selector component=etcd
[upgrade/staticpods] Component "etcd" upgraded successfully!
[upgrade/etcd] Waiting for etcd to become available
[upgrade/staticpods] Writing new Static Pod manifests to "/etc/kubernetes/tmp/kubeadm-upgraded-manifests1358475464"
[upgrade/staticpods] Preparing for "kube-apiserver" upgrade
[upgrade/staticpods] Renewing apiserver certificate
[upgrade/staticpods] Renewing apiserver-kubelet-client certificate
[upgrade/staticpods] Renewing front-proxy-client certificate
[upgrade/staticpods] Renewing apiserver-etcd-client certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-apiserver.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2023-06-26-22-39-27/kube-apiserver.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
[apiclient] Found 1 Pods for label selector component=kube-apiserver
[upgrade/staticpods] Component "kube-apiserver" upgraded successfully!
[upgrade/staticpods] Preparing for "kube-controller-manager" upgrade
[upgrade/staticpods] Renewing controller-manager.conf certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-controller-manager.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2023-06-26-22-39-27/kube-controller-manager.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
[apiclient] Found 1 Pods for label selector component=kube-controller-manager
[upgrade/staticpods] Component "kube-controller-manager" upgraded successfully!
[upgrade/staticpods] Preparing for "kube-scheduler" upgrade
[upgrade/staticpods] Renewing scheduler.conf certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-scheduler.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2023-06-26-22-39-27/kube-scheduler.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
[apiclient] Found 1 Pods for label selector component=kube-scheduler
[upgrade/staticpods] Component "kube-scheduler" upgraded successfully!
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[upgrade] Backing up kubelet config file to /etc/kubernetes/tmp/kubeadm-kubelet-config2825646681/config.yaml
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

[upgrade/successful] SUCCESS! Your cluster was upgraded to "v1.27.0". Enjoy!

[upgrade/kubelet] Now that your control plane is upgraded, please proceed with upgrading your kubelets if you haven't already done so.

controlplane ~ ➜  


kubectl drain controlplane --ignore-daemonsets

controlplane ~ ➜  kubectl drain controlplane --ignore-daemonsets
node/controlplane already cordoned
Warning: ignoring DaemonSet-managed Pods: kube-system/kube-proxy-2b6sw
node/controlplane drained

controlplane ~ ➜  

Upgrade kubelet and kubectl

Upgrade the kubelet and kubectl:

    Ubuntu, Debian or HypriotOS
    CentOS, RHEL or Fedora

# replace x in 1.27.x-00 with the latest patch version
apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.27.x-00 kubectl=1.27.x-00 && \
apt-mark hold kubelet kubectl


apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.27.0-00 kubectl=1.27.0-00 && \
apt-mark hold kubelet kubectl

sudo systemctl daemon-reload
sudo systemctl restart kubelet

Uncordon the node

Bring the node back online by marking it schedulable:

# replace <node-to-uncordon> with the name of your node
kubectl uncordon <node-to-uncordon>
kubectl uncordon controlplane


controlplane ~ ➜  sudo systemctl daemon-reload


controlplane ~ ➜  sudo systemctl restart kubelet

controlplane ~ ➜  kubectl uncordon controlplane
node/controlplane uncordoned

controlplane ~ ➜  kubectl get node
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   92m   v1.27.0
node01         Ready    <none>          91m   v1.26.0

controlplane ~ ➜  















Next is the worker node. Drain the worker node of the workloads and mark it UnSchedulable

    Worker node: Unschedulable

controlplane ~ ➜  kubectl get node
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   92m   v1.27.0
node01         Ready    <none>          92m   v1.26.0

controlplane ~ ➜  kubectl drain node01
node/node01 cordoned
error: unable to drain node "node01" due to error:cannot delete DaemonSet-managed Pods (use --ignore-daemonsets to ignore): kube-flannel/kube-flannel-ds-sj5c8, kube-system/kube-proxy-r887n, continuing command...
There are pending nodes to be drained:
 node01
cannot delete DaemonSet-managed Pods (use --ignore-daemonsets to ignore): kube-flannel/kube-flannel-ds-sj5c8, kube-system/kube-proxy-r887n

controlplane ~ ✖ 


controlplane ~ ✖ kubectl get ds -A
NAMESPACE      NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                   AGE
kube-flannel   kube-flannel-ds   1         1         1       1            1           kubernetes.io/hostname=node01   94m
kube-system    kube-proxy        2         2         2       2            2           kubernetes.io/os=linux          94m

controlplane ~ ➜  kubectl get ds kube-proxy
Error from server (NotFound): daemonsets.apps "kube-proxy" not found

controlplane ~ ✖ kubectl get ds kube-proxy -n kube-system -o yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  annotations:
    deprecated.daemonset.template.generation: "3"
  creationTimestamp: "2023-06-27T01:12:41Z"
  generation: 3
  labels:
    k8s-app: kube-proxy
  name: kube-proxy
  namespace: kube-system
  resourceVersion: "8389"
  uid: 63e46416-ee0e-46e5-9db7-0348010acc05
spec:
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      k8s-app: kube-proxy
  template:
    metadata:
      creationTimestamp: null
      labels:
        k8s-app: kube-proxy
    spec:
      containers:
      - command:
        - /usr/local/bin/kube-proxy
        - --config=/var/lib/kube-proxy/config.conf
        - --hostname-override=$(NODE_NAME)
        env:
        - name: NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        image: registry.k8s.io/kube-proxy:v1.27.0
        imagePullPolicy: IfNotPresent
        name: kube-proxy
        resources: {}
        securityContext:
          privileged: true
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /var/lib/kube-proxy
          name: kube-proxy
        - mountPath: /run/xtables.lock
          name: xtables-lock
        - mountPath: /lib/modules
          name: lib-modules
          readOnly: true
      dnsPolicy: ClusterFirst
      hostNetwork: true
      nodeSelector:
        kubernetes.io/os: linux
      priorityClassName: system-node-critical
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      serviceAccount: kube-proxy
      serviceAccountName: kube-proxy
      terminationGracePeriodSeconds: 30
      tolerations:
      - operator: Exists
      volumes:
      - configMap:
          defaultMode: 420
          name: kube-proxy
        name: kube-proxy
      - hostPath:
          path: /run/xtables.lock
          type: FileOrCreate
        name: xtables-lock
      - hostPath:
          path: /lib/modules
          type: ""
        name: lib-modules
  updateStrategy:
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
    type: RollingUpdate
status:
  currentNumberScheduled: 2
  desiredNumberScheduled: 2
  numberAvailable: 2
  numberMisscheduled: 0
  numberReady: 2
  observedGeneration: 3
  updatedNumberScheduled: 2

controlplane ~ ➜  


controlplane ~ ➜  vi ds-depois2.yaml

controlplane ~ ➜  kubectl apply -f  ds-depois2.yaml
Warning: resource daemonsets/kube-proxy is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
daemonset.apps/kube-proxy configured

controlplane ~ ➜  



controlplane ~ ➜  kubectl get ds -A
NAMESPACE      NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                                                AGE
kube-flannel   kube-flannel-ds   1         1         1       1            1           kubernetes.io/hostname=node01                                96m
kube-system    kube-proxy        1         1         1       1            1           kubernetes.io/hostname=controlplane,kubernetes.io/os=linux   96m

controlplane ~ ➜  kubectl get ds kube-flannel-ds -n kube-flannel -o yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  annotations:
    deprecated.daemonset.template.generation: "2"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"DaemonSet","metadata":{"annotations":{"deprecated.daemonset.template.generation":"1"},"generation":1,"labels":{"app":"flannel","tier":"node"},"name":"kube-flannel-ds","namespace":"kube-flannel","resourceVersion":"537"},"spec":{"revisionHistoryLimit":10,"selector":{"matchLabels":{"app":"flannel"}},"template":{"metadata":{"creationTimestamp":null,"labels":{"app":"flannel","tier":"node"}},"spec":{"containers":[{"args":["--ip-masq","--kube-subnet-mgr"],"command":["/opt/bin/flanneld"],"env":[{"name":"POD_NAME","valueFrom":{"fieldRef":{"apiVersion":"v1","fieldPath":"metadata.name"}}},{"name":"POD_NAMESPACE","valueFrom":{"fieldRef":{"apiVersion":"v1","fieldPath":"metadata.namespace"}}},{"name":"EVENT_QUEUE_DEPTH","value":"5000"}],"image":"docker.io/rancher/mirrored-flannelcni-flannel:v0.19.2","imagePullPolicy":"IfNotPresent","name":"kube-flannel","resources":{"limits":{"cpu":"100m","memory":"50Mi"},"requests":{"cpu":"100m","memory":"50Mi"}},"securityContext":{"capabilities":{"add":["NET_ADMIN","NET_RAW"]},"privileged":false},"terminationMessagePath":"/dev/termination-log","terminationMessagePolicy":"File","volumeMounts":[{"mountPath":"/run/flannel","name":"run"},{"mountPath":"/etc/kube-flannel/","name":"flannel-cfg"},{"mountPath":"/run/xtables.lock","name":"xtables-lock"}]}],"dnsPolicy":"ClusterFirst","hostNetwork":true,"initContainers":[{"args":["-f","/flannel","/opt/cni/bin/flannel"],"command":["cp"],"image":"docker.io/rancher/mirrored-flannelcni-flannel-cni-plugin:v1.1.0","imagePullPolicy":"IfNotPresent","name":"install-cni-plugin","resources":{},"terminationMessagePath":"/dev/termination-log","terminationMessagePolicy":"File","volumeMounts":[{"mountPath":"/opt/cni/bin","name":"cni-plugin"}]},{"args":["-f","/etc/kube-flannel/cni-conf.json","/etc/cni/net.d/10-flannel.conflist"],"command":["cp"],"image":"docker.io/rancher/mirrored-flannelcni-flannel:v0.19.2","imagePullPolicy":"IfNotPresent","name":"install-cni","resources":{},"terminationMessagePath":"/dev/termination-log","terminationMessagePolicy":"File","volumeMounts":[{"mountPath":"/etc/cni/net.d","name":"cni"},{"mountPath":"/etc/kube-flannel/","name":"flannel-cfg"}]}],"nodeSelector":{"kubernetes.io/hostname":"node01"},"priorityClassName":"system-node-critical","restartPolicy":"Always","schedulerName":"default-scheduler","securityContext":{},"serviceAccount":"flannel","serviceAccountName":"flannel","terminationGracePeriodSeconds":30,"tolerations":[{"effect":"NoSchedule","operator":"Exists"}],"volumes":[{"hostPath":{"path":"/run/flannel","type":""},"name":"run"},{"hostPath":{"path":"/opt/cni/bin","type":""},"name":"cni-plugin"},{"hostPath":{"path":"/etc/cni/net.d","type":""},"name":"cni"},{"configMap":{"defaultMode":420,"name":"kube-flannel-cfg"},"name":"flannel-cfg"},{"hostPath":{"path":"/run/xtables.lock","type":"FileOrCreate"},"name":"xtables-lock"}]}},"updateStrategy":{"rollingUpdate":{"maxSurge":0,"maxUnavailable":1},"type":"RollingUpdate"}},"status":{"currentNumberScheduled":2,"desiredNumberScheduled":2,"numberAvailable":2,"numberMisscheduled":0,"numberReady":2,"observedGeneration":1,"updatedNumberScheduled":2}}
  creationTimestamp: "2023-06-27T01:12:45Z"
  generation: 2
  labels:
    app: flannel
    tier: node
  name: kube-flannel-ds
  namespace: kube-flannel
  resourceVersion: "7341"
  uid: 3964a0d4-8e20-46d1-937e-af269e1d39c2
spec:
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: flannel
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: flannel
        tier: node
    spec:
      containers:
      - args:
        - --ip-masq
        - --kube-subnet-mgr
        command:
        - /opt/bin/flanneld
        env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.name
        - name: POD_NAMESPACE
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
        - name: EVENT_QUEUE_DEPTH
          value: "5000"
        image: docker.io/rancher/mirrored-flannelcni-flannel:v0.19.2
        imagePullPolicy: IfNotPresent
        name: kube-flannel
        resources:
          limits:
            cpu: 100m
            memory: 50Mi
          requests:
            cpu: 100m
            memory: 50Mi
        securityContext:
          capabilities:
            add:
            - NET_ADMIN
            - NET_RAW
          privileged: false
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /run/flannel
          name: run
        - mountPath: /etc/kube-flannel/
          name: flannel-cfg
        - mountPath: /run/xtables.lock
          name: xtables-lock
      dnsPolicy: ClusterFirst
      hostNetwork: true
      initContainers:
      - args:
        - -f
        - /flannel
        - /opt/cni/bin/flannel
        command:
        - cp
        image: docker.io/rancher/mirrored-flannelcni-flannel-cni-plugin:v1.1.0
        imagePullPolicy: IfNotPresent
        name: install-cni-plugin
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /opt/cni/bin
          name: cni-plugin
      - args:
        - -f
        - /etc/kube-flannel/cni-conf.json
        - /etc/cni/net.d/10-flannel.conflist
        command:
        - cp
        image: docker.io/rancher/mirrored-flannelcni-flannel:v0.19.2
        imagePullPolicy: IfNotPresent
        name: install-cni
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /etc/cni/net.d
          name: cni
        - mountPath: /etc/kube-flannel/
          name: flannel-cfg
      nodeSelector:
        kubernetes.io/hostname: node01
      priorityClassName: system-node-critical
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      serviceAccount: flannel
      serviceAccountName: flannel
      terminationGracePeriodSeconds: 30
      tolerations:
      - effect: NoSchedule
        operator: Exists
      volumes:
      - hostPath:
          path: /run/flannel
          type: ""
        name: run
      - hostPath:
          path: /opt/cni/bin
          type: ""
        name: cni-plugin
      - hostPath:
          path: /etc/cni/net.d
          type: ""
        name: cni
      - configMap:
          defaultMode: 420
          name: kube-flannel-cfg
        name: flannel-cfg
      - hostPath:
          path: /run/xtables.lock
          type: FileOrCreate
        name: xtables-lock
  updateStrategy:
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
    type: RollingUpdate
status:
  currentNumberScheduled: 1
  desiredNumberScheduled: 1
  numberAvailable: 1
  numberMisscheduled: 0
  numberReady: 1
  observedGeneration: 2
  updatedNumberScheduled: 1

controlplane ~ ➜  


controlplane ~ ➜  vi ds2-depois2.yaml

controlplane ~ ➜  kubectl apply -f ds2-depois2.yaml
daemonset.apps/kube-flannel-ds configured

controlplane ~ ➜  kubectl get ds -A
NAMESPACE      NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                                                AGE
kube-flannel   kube-flannel-ds   1         1         1       1            1           kubernetes.io/hostname=controlplane                          97m
kube-system    kube-proxy        1         1         1       1            1           kubernetes.io/hostname=controlplane,kubernetes.io/os=linux   97m

controlplane ~ ➜  


controlplane ~ ➜  kubectl drain node01
node/node01 already cordoned
evicting pod kube-system/coredns-5d78c9869d-xslnj
evicting pod default/blue-987f68cb5-h8tn5
evicting pod default/blue-987f68cb5-g8766
evicting pod kube-system/coredns-5d78c9869d-pjkcr
evicting pod default/blue-987f68cb5-mxbj5
evicting pod default/blue-987f68cb5-qzrnk
evicting pod default/blue-987f68cb5-kz2wb
pod/blue-987f68cb5-kz2wb evicted
pod/blue-987f68cb5-mxbj5 evicted
pod/blue-987f68cb5-h8tn5 evicted
pod/blue-987f68cb5-g8766 evicted
pod/blue-987f68cb5-qzrnk evicted
pod/coredns-5d78c9869d-pjkcr evicted
pod/coredns-5d78c9869d-xslnj evicted
node/node01 drained

controlplane ~ ➜  
controlplane ~ ➜  kubectl get node
NAME           STATUS                     ROLES           AGE   VERSION
controlplane   Ready                      control-plane   98m   v1.27.0
node01         Ready,SchedulingDisabled   <none>          98m   v1.26.0

controlplane ~ ➜  












- Upgrade the worker node to the exact version v1.27.0

    Worker Node Upgraded to v1.27.0

    Worker Node Ready

https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/#upgrade-worker-nodes
<https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/#upgrade-worker-nodes>

controlplane ~ ➜  kubectl get nodes
NAME           STATUS                     ROLES           AGE   VERSION
controlplane   Ready                      control-plane   99m   v1.27.0
node01         Ready,SchedulingDisabled   <none>          98m   v1.26.0


controlplane ~ ➜  

https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/
https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/
<https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/>

apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.27.0-00 && \
apt-mark hold kubeadm


controlplane ~ ➜  apt-mark unhold kubeadm && \
> apt-get update && apt-get install -y kubeadm=1.27.0-00 && \
> apt-mark hold kubeadm
Canceled hold on kubeadm.
Hit:1 https://packages.cloud.google.com/apt kubernetes-xenial InRelease                    
Hit:2 https://download.docker.com/linux/ubuntu focal InRelease                                                  
Get:3 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]                                       
Hit:4 http://archive.ubuntu.com/ubuntu focal InRelease   
Hit:5 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Get:6 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Fetched 222 kB in 1s (184 kB/s)                                     
Reading package lists... Done
Reading package lists... Done
Building dependency tree       
Reading state information... Done
kubeadm is already the newest version (1.27.0-00).
0 upgraded, 0 newly installed, 0 to remove and 83 not upgraded.
kubeadm set on hold.

controlplane ~ ➜  


sudo kubeadm upgrade node
sudo kubeadm upgrade node
controlplane ~ ✖ sudo kubeadm upgrade node
[upgrade] Reading configuration from the cluster...
[upgrade] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
W0626 22:54:57.057376   38433 images.go:80] could not find officially supported version of etcd for Kubernetes v1.27.0, falling back to the nearest etcd version (3.5.7-0)
W0626 22:54:57.642749   38433 checks.go:835] detected that the sandbox image "k8s.gcr.io/pause:3.6" of the container runtime is inconsistent with that used by kubeadm. It is recommended that using "registry.k8s.io/pause:3.9" as the CRI sandbox image.
[upgrade] Upgrading your Static Pod-hosted control plane instance to version "v1.27.0"...
[upgrade/etcd] Upgrading to TLS for etcd
W0626 22:54:58.377905   38433 staticpods.go:305] [upgrade/etcd] could not find officially supported version of etcd for Kubernetes v1.27.0, falling back to the nearest etcd version (3.5.7-0)
W0626 22:54:58.382492   38433 images.go:80] could not find officially supported version of etcd for Kubernetes v1.27.0, falling back to the nearest etcd version (3.5.7-0)
[upgrade/staticpods] Preparing for "etcd" upgrade
[upgrade/staticpods] Current and new manifests of etcd are equal, skipping upgrade
[upgrade/etcd] Waiting for etcd to become available
[upgrade/staticpods] Writing new Static Pod manifests to "/etc/kubernetes/tmp/kubeadm-upgraded-manifests3412483745"
[upgrade/staticpods] Preparing for "kube-apiserver" upgrade
[upgrade/staticpods] Current and new manifests of kube-apiserver are equal, skipping upgrade
[upgrade/staticpods] Preparing for "kube-controller-manager" upgrade
[upgrade/staticpods] Current and new manifests of kube-controller-manager are equal, skipping upgrade
[upgrade/staticpods] Preparing for "kube-scheduler" upgrade
[upgrade/staticpods] Current and new manifests of kube-scheduler are equal, skipping upgrade
[upgrade] The control plane instance for this node was successfully updated!
[upgrade] Backing up kubelet config file to /etc/kubernetes/tmp/kubeadm-kubelet-config3398489509/config.yaml
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[upgrade] The configuration for this node was successfully updated!
[upgrade] Now you should go ahead and upgrade the kubelet package using your package manager.

controlplane ~ ➜  


kubectl drain node01
controlplane ~ ➜  kubectl drain node01
node/node01 already cordoned
node/node01 drained

controlplane ~ ➜  

apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.27.0-00 kubectl=1.27.0-00 && \
apt-mark hold kubelet kubectl



controlplane ~ ➜  apt-mark unhold kubelet kubectl && \
> apt-get update && apt-get install -y kubelet=1.27.0-00 kubectl=1.27.0-00 && \
> apt-mark hold kubelet kubectl
Canceled hold on kubelet.
Canceled hold on kubectl.
Get:2 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]                                                               
Hit:3 https://download.docker.com/linux/ubuntu focal InRelease                                                                          
Hit:1 https://packages.cloud.google.com/apt kubernetes-xenial InRelease                                                                 
Hit:4 http://archive.ubuntu.com/ubuntu focal InRelease                         
Hit:5 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Get:6 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Fetched 222 kB in 1s (176 kB/s)    
Reading package lists... Done
Reading package lists... Done
Building dependency tree       
Reading state information... Done
kubectl is already the newest version (1.27.0-00).
kubelet is already the newest version (1.27.0-00).
0 upgraded, 0 newly installed, 0 to remove and 82 not upgraded.
kubelet set on hold.
kubectl set on hold.

controlplane ~ ➜  

sudo systemctl daemon-reload
sudo systemctl restart kubelet





- Update the node configuration for the new kubelet version
  ```
  $ kubeadm upgrade node config --kubelet-version v1.27.0
  ```
- Restart the kubelet service
  ```
  $ systemctl restart kubelet
  ```
- Mark the node back to schedulable
  ```
  $ kubectl uncordon node-1




# PENDENTE
- Preciso ver como conectar no worker node:
node01

- Terminal está no controlplane

controlplane ~ ➜  





https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/#upgrading-worker-nodes
<https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/#upgrading-worker-nodes>


apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.27.0-00 && \
apt-mark hold kubeadm

sudo kubeadm upgrade node

apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.27.0-00 kubectl=1.27.0-00 && \
apt-mark hold kubelet kubectl



controlplane ~ ➜  ssh node01
Warning: Permanently added the ECDSA host key for IP address '192.3.224.8' to the list of known hosts.

root@node01 ~ ➜  

root@node01 ~ ➜  apt-mark unhold kubeadm && \
> apt-get update && apt-get install -y kubeadm=1.27.0-00 && \
> apt-mark hold kubeadm
Canceled hold on kubeadm.
Get:2 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]                                                               
Get:3 https://download.docker.com/linux/ubuntu focal InRelease [57.7 kB]                                                                
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [8993 B]                                                        
Get:4 https://download.docker.com/linux/ubuntu focal/stable amd64 Packages [35.7 kB]                                   
Get:5 http://archive.ubuntu.com/ubuntu focal InRelease [265 kB]
Get:6 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 Packages [67.3 kB]
Get:7 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 Packages [28.5 kB]
Get:8 http://security.ubuntu.com/ubuntu focal-security/restricted amd64 Packages [2416 kB]
Get:9 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Get:10 http://security.ubuntu.com/ubuntu focal-security/main amd64 Packages [2820 kB]
Get:11 http://security.ubuntu.com/ubuntu focal-security/universe amd64 Packages [1064 kB]
Get:12 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]      
Get:13 http://archive.ubuntu.com/ubuntu focal/restricted amd64 Packages [33.4 kB]
Get:14 http://archive.ubuntu.com/ubuntu focal/universe amd64 Packages [11.3 MB]
Get:15 http://archive.ubuntu.com/ubuntu focal/multiverse amd64 Packages [177 kB]
Get:16 http://archive.ubuntu.com/ubuntu focal/main amd64 Packages [1275 kB]
Get:17 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [1360 kB]
Get:18 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [3299 kB]
Get:19 http://archive.ubuntu.com/ubuntu focal-updates/restricted amd64 Packages [2554 kB]
Get:20 http://archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 Packages [31.2 kB]
Get:21 http://archive.ubuntu.com/ubuntu focal-backports/universe amd64 Packages [28.6 kB]
Get:22 http://archive.ubuntu.com/ubuntu focal-backports/main amd64 Packages [55.2 kB]
Fetched 27.3 MB in 4s (7403 kB/s)                            
Reading package lists... Done
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages will be upgraded:
  kubeadm
1 upgraded, 0 newly installed, 0 to remove and 91 not upgraded.
Need to get 9931 kB of archives.
After this operation, 1393 kB of additional disk space will be used.
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubeadm amd64 1.27.0-00 [9931 kB]
Fetched 9931 kB in 0s (22.5 MB/s)
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 14818 files and directories currently installed.)
Preparing to unpack .../kubeadm_1.27.0-00_amd64.deb ...
Unpacking kubeadm (1.27.0-00) over (1.26.0-00) ...
Setting up kubeadm (1.27.0-00) ...
kubeadm set on hold.

root@node01 ~ ➜  sudo kubeadm upgrade node
[upgrade] Reading configuration from the cluster...
[upgrade] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
W0626 23:05:40.515808   25727 configset.go:78] Warning: No kubeproxy.config.k8s.io/v1alpha1 config is loaded. Continuing without it: configmaps "kube-proxy" is forbidden: User "system:node:node01" cannot get resource "configmaps" in API group "" in the namespace "kube-system": no relationship found between node 'node01' and this object
[preflight] Running pre-flight checks
[preflight] Skipping prepull. Not a control plane node.
[upgrade] Skipping phase. Not a control plane node.
[upgrade] Backing up kubelet config file to /etc/kubernetes/tmp/kubeadm-kubelet-config258140729/config.yaml
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[upgrade] The configuration for this node was successfully updated!
[upgrade] Now you should go ahead and upgrade the kubelet package using your package manager.

root@node01 ~ ➜  

root@node01 ~ ➜  apt-mark unhold kubelet kubectl && \
> apt-get update && apt-get install -y kubelet=1.27.0-00 kubectl=1.27.0-00 && \
> apt-mark hold kubelet kubectl
Canceled hold on kubelet.
Canceled hold on kubectl.
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [8993 B]                                              
Hit:2 https://download.docker.com/linux/ubuntu focal InRelease                                                                                                               
Hit:3 http://security.ubuntu.com/ubuntu focal-security InRelease                                                                            
Hit:4 http://archive.ubuntu.com/ubuntu focal InRelease                      
Hit:5 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Hit:6 http://archive.ubuntu.com/ubuntu focal-backports InRelease
Fetched 8993 B in 1s (8845 B/s)
Reading package lists... Done
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages will be upgraded:
  kubectl kubelet
2 upgraded, 0 newly installed, 0 to remove and 90 not upgraded.
Need to get 29.0 MB of archives.
After this operation, 13.9 MB disk space will be freed.
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubectl amd64 1.27.0-00 [10.2 MB]
Get:2 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubelet amd64 1.27.0-00 [18.8 MB]
Fetched 29.0 MB in 1s (29.8 MB/s)  
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 14818 files and directories currently installed.)
Preparing to unpack .../kubectl_1.27.0-00_amd64.deb ...
Unpacking kubectl (1.27.0-00) over (1.26.0-00) ...
Preparing to unpack .../kubelet_1.27.0-00_amd64.deb ...
/usr/sbin/policy-rc.d returned 101, not running 'stop kubelet.service'
Unpacking kubelet (1.27.0-00) over (1.26.0-00) ...
Setting up kubectl (1.27.0-00) ...
Setting up kubelet (1.27.0-00) ...
/usr/sbin/policy-rc.d returned 101, not running 'start kubelet.service'
kubelet set on hold.
kubectl set on hold.

root@node01 ~ ➜  

sudo systemctl daemon-reload
sudo systemctl restart kubelet

kubectl uncordon node01


root@node01 ~ ➜  sudo systemctl restart kubelet

root@node01 ~ ➜  kubectl uncordon node01
E0626 23:06:52.954121   27579 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0626 23:06:52.954757   27579 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0626 23:06:52.956499   27579 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0626 23:06:52.958225   27579 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
The connection to the server localhost:8080 was refused - did you specify the right host or port?

root@node01 ~ ✖ ssh controlplane
The authenticity of host 'controlplane (192.3.224.5)' can't be established.
ECDSA key fingerprint is SHA256:OPETmaNJ0hWLTFdZdCyl6UDuSceGsIuUxJtJr9utTSs.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'controlplane,192.3.224.5' (ECDSA) to the list of known hosts.
root@controlplane's password: 


root@node01 ~ ✖ exit
logout
Connection to node01 closed.

controlplane ~ ✖ kubectl uncordon node01
node/node01 uncordoned

controlplane ~ ➜  

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE    VERSION
controlplane   Ready    control-plane   114m   v1.27.0
node01         Ready    <none>          114m   v1.27.0

controlplane ~ ➜  





Remove the restriction and mark the worker node as schedulable again.

    Worker Node: Schedulable


CONGRATULATIONS!!!!

You have successfully completed the quiz. 