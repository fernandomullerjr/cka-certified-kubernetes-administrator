

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