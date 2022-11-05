
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