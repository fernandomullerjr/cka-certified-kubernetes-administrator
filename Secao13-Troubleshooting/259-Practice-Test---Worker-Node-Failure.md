#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "259. Practice Test - Worker Node Failure."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
##  259. Practice Test - Worker Node Failure


Fix the broken cluster

Fix node01

controlplane ~ ➜  kubectl get nodes
NAME           STATUS     ROLES           AGE   VERSION
controlplane   Ready      control-plane   16m   v1.29.0
node01         NotReady   <none>          16m   v1.29.0

controlplane ~ ➜  kubectl get nodes -o wide
NAME           STATUS     ROLES           AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready      control-plane   16m   v1.29.0   192.3.79.9    <none>        Ubuntu 22.04.4 LTS   5.4.0-1106-gcp   containerd://1.6.26
node01         NotReady   <none>          16m   v1.29.0   192.3.79.12   <none>        Ubuntu 22.04.3 LTS   5.4.0-1106-gcp   containerd://1.6.26

controlplane ~ ➜  

controlplane ~ ✖ kubectl describe node node01
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux
Annotations:        flannel.alpha.coreos.com/backend-data: {"VNI":1,"VtepMAC":"ca:90:1d:77:40:67"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 192.3.79.12
                    kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Thu, 13 Jun 2024 01:11:35 +0000
Taints:             node.kubernetes.io/unreachable:NoExecute
                    node.kubernetes.io/unreachable:NoSchedule
Unschedulable:      false
Lease:
  HolderIdentity:  node01
  AcquireTime:     <unset>
  RenewTime:       Thu, 13 Jun 2024 01:26:34 +0000
Conditions:
  Type                 Status    LastHeartbeatTime                 LastTransitionTime                Reason              Message
  ----                 ------    -----------------                 ------------------                ------              -------
  NetworkUnavailable   False     Thu, 13 Jun 2024 01:11:41 +0000   Thu, 13 Jun 2024 01:11:41 +0000   FlannelIsUp         Flannel is running on this node
  MemoryPressure       Unknown   Thu, 13 Jun 2024 01:22:20 +0000   Thu, 13 Jun 2024 01:27:18 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
  DiskPressure         Unknown   Thu, 13 Jun 2024 01:22:20 +0000   Thu, 13 Jun 2024 01:27:18 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
  PIDPressure          Unknown   Thu, 13 Jun 2024 01:22:20 +0000   Thu, 13 Jun 2024 01:27:18 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
  Ready                Unknown   Thu, 13 Jun 2024 01:22:20 +0000   Thu, 13 Jun 2024 01:27:18 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
Addresses:
  InternalIP:  192.3.79.12
  Hostname:    node01
Capacity:
  cpu:                36
  ephemeral-storage:  1016057248Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214587048Ki
  pods:               110
Allocatable:
  cpu:                36
  ephemeral-storage:  936398358207
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214484648Ki
  pods:               110
System Info:
  Machine ID:                 49e48c9673ca44dd919fd32b36f0e237
  System UUID:                e0179261-2681-56c9-cccb-fdad1af98f51
  Boot ID:                    2c6f9aaa-defc-4b0d-840a-362a251d55ac
  Kernel Version:             5.4.0-1106-gcp
  OS Image:                   Ubuntu 22.04.3 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://1.6.26
  Kubelet Version:            v1.29.0
  Kube-Proxy Version:         v1.29.0
PodCIDR:                      10.244.1.0/24
PodCIDRs:                     10.244.1.0/24
Non-terminated Pods:          (2 in total)
  Namespace                   Name                     CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                     ------------  ----------  ---------------  -------------  ---
  kube-flannel                kube-flannel-ds-j9pzr    100m (0%)     0 (0%)      50Mi (0%)        0 (0%)         16m
  kube-system                 kube-proxy-z48h8         0 (0%)        0 (0%)      0 (0%)           0 (0%)         16m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests   Limits
  --------           --------   ------
  cpu                100m (0%)  0 (0%)
  memory             50Mi (0%)  0 (0%)
  ephemeral-storage  0 (0%)     0 (0%)
  hugepages-1Gi      0 (0%)     0 (0%)
  hugepages-2Mi      0 (0%)     0 (0%)
Events:
  Type     Reason                   Age                From             Message
  ----     ------                   ----               ----             -------
  Normal   Starting                 16m                kube-proxy       
  Normal   Starting                 16m                kubelet          Starting kubelet.
  Warning  InvalidDiskCapacity      16m                kubelet          invalid capacity 0 on image filesystem
  Normal   NodeHasSufficientMemory  16m (x2 over 16m)  kubelet          Node node01 status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    16m (x2 over 16m)  kubelet          Node node01 status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     16m (x2 over 16m)  kubelet          Node node01 status is now: NodeHasSufficientPID
  Normal   NodeAllocatableEnforced  16m                kubelet          Updated Node Allocatable limit across pods
  Normal   RegisteredNode           16m                node-controller  Node node01 event: Registered Node node01 in Controller
  Normal   NodeReady                16m                kubelet          Node node01 status is now: NodeReady
  Normal   NodeNotReady             50s                node-controller  Node node01 status is now: NodeNotReady

controlplane ~ ➜  


Log

  Warning  InvalidDiskCapacity      16m                kubelet          invalid capacity 0 on image filesystem


node01 ~ ➜  df -h
Filesystem                                                    Size  Used Avail Use% Mounted on
.                                                             969G  755G  215G  78% /
tmpfs                                                         4.0M     0  4.0M   0% /sys/fs/cgroup
tmpfs                                                         1.0M     0  1.0M   0% /sys/kernel/config
tmpfs                                                         1.0M     0  1.0M   0% /sys/kernel/debug
tmpfs                                                         1.0M     0  1.0M   0% /sys/kernel/tracing
tmpfs                                                          64M     0   64M   0% /dev
shm                                                            64M     0   64M   0% /dev/shm
tmpfs                                                          64M  1.9M   63M   3% /run
tmpfs                                                         4.0M     0  4.0M   0% /run/lock
/var/lib/sysbox/shiftfs/f22fb544-b03b-477a-806f-dd9f8eaf8f8f  969G  755G  215G  78% /etc/hosts
tmpfs                                                         103G     0  103G   0% /proc/acpi
tmpfs                                                         103G     0  103G   0% /proc/scsi
tmpfs                                                         103G     0  103G   0% /sys/firmware
tmpfs                                                         205G   12K  205G   1% /var/lib/kubelet/pods/eb0129d5-131c-48ff-8689-8e6a754e5391/volumes/kubernetes.io~projected/kube-api-access-j7m8b
tmpfs                                                         205G   12K  205G   1% /var/lib/kubelet/pods/31fb4a97-f0dc-45d5-a9b3-fb32909a7eda/volumes/kubernetes.io~projected/kube-api-access-vxtll
shm                                                            64M     0   64M   0% /run/containerd/io.containerd.grpc.v1.cri/sandboxes/aad22ceb752429ca4423c62af8e2c8a376f3158c14e437643d3e2ddc81609a3c/shm
shm                                                            64M     0   64M   0% /run/containerd/io.containerd.grpc.v1.cri/sandboxes/b5c835081f97d0886e4b3863da9ea683cbaff12cc26c0d1d37b953e160c8c148/shm
overlay                                                       969G  755G  215G  78% /run/containerd/io.containerd.runtime.v2.task/k8s.io/aad22ceb752429ca4423c62af8e2c8a376f3158c14e437643d3e2ddc81609a3c/rootfs
overlay                                                       969G  755G  215G  78% /run/containerd/io.containerd.runtime.v2.task/k8s.io/b5c835081f97d0886e4b3863da9ea683cbaff12cc26c0d1d37b953e160c8c148/rootfs
overlay                                                       969G  755G  215G  78% /run/containerd/io.containerd.runtime.v2.task/k8s.io/72835967dd22170a2729d48a373a9cebce930638dea4700c8cffdb5806b4c9d6/rootfs
overlay                                                       969G  755G  215G  78% /run/containerd/io.containerd.runtime.v2.task/k8s.io/032327b0b308dfbca2104907f903f5cc137d1f99f7b4d167ff0edfdd6c7b7454/rootfs
tmpfs                                                         400M     0  400M   0% /run/user/0

node01 ~ ➜  date
Thu Jun 13 01:29:26 UTC 2024

node01 ~ ➜  

Disco OK a principio.

Verificar sobre kubelet

  DiskPressure         Unknown   Thu, 13 Jun 2024 01:22:20 +0000   Thu, 13 Jun 2024 01:27:18 +0000   NodeStatusUnknown   Kubelet stopped posting node status.



node01 ~ ➜  service kubelet status
○ kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /usr/lib/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: inactive (dead) since Thu 2024-06-13 01:26:36 UTC; 5min ago
       Docs: https://kubernetes.io/docs/
    Process: 2573 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, status=0/SUCCESS)
   Main PID: 2573 (code=exited, status=0/SUCCESS)

Jun 13 01:11:36 node01 kubelet[2573]: I0613 01:11:36.810119    2573 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"lib-modules\" >
Jun 13 01:11:36 node01 kubelet[2573]: I0613 01:11:36.810162    2573 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"kube-api-acces>
Jun 13 01:11:37 node01 kubelet[2573]: I0613 01:11:37.722009    2573 kuberuntime_container_linux.go:167] "No swap cgroup controller present" swapBehavior="" pod="kube-system/kube-p>
Jun 13 01:11:37 node01 kubelet[2573]: I0613 01:11:37.807815    2573 kuberuntime_container_linux.go:167] "No swap cgroup controller present" swapBehavior="" pod="kube-flannel/kube->
Jun 13 01:11:38 node01 kubelet[2573]: I0613 01:11:38.827772    2573 kuberuntime_container_linux.go:167] "No swap cgroup controller present" swapBehavior="" pod="kube-flannel/kube->
Jun 13 01:11:38 node01 kubelet[2573]: I0613 01:11:38.897056    2573 pod_startup_latency_tracker.go:102] "Observed pod startup duration" pod="kube-system/kube-proxy-z48h8" podStart>
Jun 13 01:11:39 node01 kubelet[2573]: I0613 01:11:39.122310    2573 kubelet_node_status.go:497] "Fast updating node status as it just became ready"
Jun 13 01:11:39 node01 kubelet[2573]: I0613 01:11:39.833010    2573 kuberuntime_container_linux.go:167] "No swap cgroup controller present" swapBehavior="" pod="kube-flannel/kube->
Jun 13 01:11:40 node01 kubelet[2573]: I0613 01:11:40.844748    2573 pod_startup_latency_tracker.go:102] "Observed pod startup duration" pod="kube-flannel/kube-flannel-ds-j9pzr" po>
Jun 13 01:26:36 node01 kubelet[2573]: I0613 01:26:36.202693    2573 dynamic_cafile_content.go:171] "Shutting down controller" name="client-ca-bundle::/etc/kubernetes/pki/ca.crt"

node01 ~ ✖ date
Thu Jun 13 01:31:58 UTC 2024

node01 ~ ➜  

Kubelet morto.
Parece algo devido a swap.

<https://kubernetes.io/docs/concepts/architecture/nodes/#swap-memory>



node01 ~ ➜  ps -ef | grep kubelet
root       10662    8953  0 01:33 pts/0    00:00:00 grep kubelet

node01 ~ ➜  

node01 ~ ➜  

node01 ~ ➜  cat /lib/systemd/system/kubelet.service
[Unit]
Description=kubelet: The Kubernetes Node Agent
Documentation=https://kubernetes.io/docs/
Wants=network-online.target
After=network-online.target

[Service]
ExecStart=/usr/bin/kubelet
Restart=always
StartLimitInterval=0
RestartSec=10

[Install]
WantedBy=multi-user.target

node01 ~ ➜  cat /usr/lib/systemd/system/kubelet.service.d
cat: /usr/lib/systemd/system/kubelet.service.d: Is a directory

node01 ~ ✖ ls /etc/kubernetes/
kubelet.conf  manifests  pki

node01 ~ ➜  ls /etc/kubernetes/kubelet.conf 
/etc/kubernetes/kubelet.conf

node01 ~ ➜  

node01 ~ ➜  cat /etc/kubernetes/kubelet.conf
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJYmpEWFIxRXVBMW93RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBMk1UTXdNVEExTXpSYUZ3MHpOREEyTVRFd01URXdNelJhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUNpaE80eUU2ejI1WjRpL0htby9SbmJsYXpyRC9rOGl5SnNBSjlZaGI2V2YzdTJuc1d5bWdiYzRaTWgKQmxkbnIwL003VVVQVkQ5Skl0R2pUMVFrS0VDaHdwSVR0YlBTeG01NExpUURyYVdoTkNNbUx0TkMreDhWb053SQpqaFBSUXlmSlFCckFTOUxiV0ZqZnJkZ3VyRXB1dXNuS0xZTTF2QURXMGVzSTBEeGZUNWFXOU9WRDkwNTd2bzFsCmJxZnB4czRKa1JrZW04WDBuZ09OUTQ0eVp5ZEN1UmxIdGFPZmtuM1lhSkh1a0IzYTcyRzBhNXBmL1Z5UDROaFQKb1hVMUZhaE5lK1U0TjVNT1BQVnNzcnhvVnMzS3pRWXoxS2lMMGo4dEdjSUVycmo0NEdzODQ4eEVJelR1UU9LSgpCNXJTVFl6ekRMR3RtbUtZTVU2LzhGNTI3MWhOQWdNQ
    [...........]
    NkwwNlF0STVXS0srUzY2bXVZaE56TDVGeVFCd25tK2hmMFZpWjdkZW8xbEhLZzBrVUM5OGFBUEJGSERTCnIxRGlkSUJKN1l6aXlzTWZxc0xNb2NSRnQrWngxdHZ5dStHTE01aGxnZ3psOHBhZTJrdXBVdEVocDJuMXZSQmIKUW9qN2lJVlBDQ0E4dFVuT0JoRHZPMjFIb0R3R3FIZ0Z3cGt0NkFPYTN6d0Rpd1dwUWdWUk9vb1hadmFXR254LwplVGZMdHBRYkI0R2tpa0ZKQ2t1M1FSNTN0Y3VvQWdXY3Q4dFhhVlpwdlBTZ1AyN3JCUWlxK2JpcHVxVnAzZ0gwClVCT053TkVPVVF4UlV6bzRZYzg0NWpJK3Ric0lrQSsvNm4waGRkdWZyQUh2RnV5dEFOcGVKN2gvTmgyeFgzRlMKVStQc0xhMDRtM3hiCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://controlplane:6443
  name: default-cluster
contexts:
- context:
    cluster: default-cluster
    namespace: default
    user: default-auth
  name: default-context
current-context: default-context
kind: Config
preferences: {}
users:
- name: default-auth
  user:
    client-certificate: /var/lib/kubelet/pki/kubelet-client-current.pem
    client-key: /var/lib/kubelet/pki/kubelet-client-current.pem

node01 ~ ➜  


node01 ~ ✖ free -m
               total        used        free      shared  buff/cache   available
Mem:          209557       35105       28716        1191      145736      171958
Swap:              0           0           0

node01 ~ ➜  


node01 ~ ➜  service kubelet status
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /usr/lib/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: active (running) since Thu 2024-06-13 01:36:56 UTC; 5s ago
       Docs: https://kubernetes.io/docs/
   Main PID: 12323 (kubelet)
      Tasks: 29 (limit: 251379)
     Memory: 35.7M
     CGroup: /system.slice/kubelet.service
             └─12323 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml>

Jun 13 01:36:57 node01 kubelet[12323]: I0613 01:36:57.862773   12323 apiserver.go:52] "Watching apiserver"
Jun 13 01:36:57 node01 kubelet[12323]: I0613 01:36:57.865067   12323 topology_manager.go:215] "Topology Admit Handler" podUID="eb0129d5-131c-48ff-8689-8e6a754e5391" podNamespace=">
Jun 13 01:36:57 node01 kubelet[12323]: I0613 01:36:57.865202   12323 topology_manager.go:215] "Topology Admit Handler" podUID="31fb4a97-f0dc-45d5-a9b3-fb32909a7eda" podNamespace=">
Jun 13 01:36:57 node01 kubelet[12323]: I0613 01:36:57.904483   12323 desired_state_of_world_populator.go:159] "Finished populating initial desired state of world"
Jun 13 01:36:57 node01 kubelet[12323]: I0613 01:36:57.907650   12323 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"run\" (Unique>
Jun 13 01:36:57 node01 kubelet[12323]: I0613 01:36:57.907700   12323 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"cni-plugin\" >
Jun 13 01:36:57 node01 kubelet[12323]: I0613 01:36:57.907718   12323 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"cni\" (Unique>
Jun 13 01:36:57 node01 kubelet[12323]: I0613 01:36:57.907771   12323 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"xtables-lock\>
Jun 13 01:36:57 node01 kubelet[12323]: I0613 01:36:57.907794   12323 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"xtables-lock\>
Jun 13 01:36:57 node01 kubelet[12323]: I0613 01:36:57.907869   12323 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"lib-modules\">

node01 ~ ➜  



controlplane ~ ➜  kubectl get nodes -o wide
NAME           STATUS   ROLES           AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane   26m   v1.29.0   192.3.79.9    <none>        Ubuntu 22.04.4 LTS   5.4.0-1106-gcp   containerd://1.6.26
node01         Ready    <none>          25m   v1.29.0   192.3.79.12   <none>        Ubuntu 22.04.3 LTS   5.4.0-1106-gcp   containerd://1.6.26

controlplane ~ ➜  date
Thu Jun 13 01:37:23 AM UTC 2024

controlplane ~ ➜  


- SOLUÇÃO1
iniciar kubelet
service kubelet start














The cluster is broken again. Investigate and fix the issue.

Fix cluster

controlplane ~ ➜  kubectl get nodes
NAME           STATUS     ROLES           AGE   VERSION
controlplane   Ready      control-plane   27m   v1.29.0
node01         NotReady   <none>          27m   v1.29.0

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe node node01
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux
Annotations:        flannel.alpha.coreos.com/backend-data: {"VNI":1,"VtepMAC":"ca:90:1d:77:40:67"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 192.3.79.12
                    kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Thu, 13 Jun 2024 01:11:35 +0000
Taints:             node.kubernetes.io/unreachable:NoExecute
                    node.kubernetes.io/unreachable:NoSchedule
Unschedulable:      false
Lease:
  HolderIdentity:  node01
  AcquireTime:     <unset>
  RenewTime:       Thu, 13 Jun 2024 01:37:37 +0000
Conditions:
  Type                 Status    LastHeartbeatTime                 LastTransitionTime                Reason              Message
  ----                 ------    -----------------                 ------------------                ------              -------
  NetworkUnavailable   False     Thu, 13 Jun 2024 01:11:41 +0000   Thu, 13 Jun 2024 01:11:41 +0000   FlannelIsUp         Flannel is running on this node
  MemoryPressure       Unknown   Thu, 13 Jun 2024 01:37:07 +0000   Thu, 13 Jun 2024 01:38:18 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
  DiskPressure         Unknown   Thu, 13 Jun 2024 01:37:07 +0000   Thu, 13 Jun 2024 01:38:18 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
  PIDPressure          Unknown   Thu, 13 Jun 2024 01:37:07 +0000   Thu, 13 Jun 2024 01:38:18 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
  Ready                Unknown   Thu, 13 Jun 2024 01:37:07 +0000   Thu, 13 Jun 2024 01:38:18 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
Addresses:
  InternalIP:  192.3.79.12
  Hostname:    node01
Capacity:
  cpu:                36
  ephemeral-storage:  1016057248Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214587048Ki
  pods:               110
Allocatable:
  cpu:                36
  ephemeral-storage:  936398358207
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214484648Ki
  pods:               110
System Info:
  Machine ID:                 49e48c9673ca44dd919fd32b36f0e237
  System UUID:                e0179261-2681-56c9-cccb-fdad1af98f51
  Boot ID:                    2c6f9aaa-defc-4b0d-840a-362a251d55ac
  Kernel Version:             5.4.0-1106-gcp
  OS Image:                   Ubuntu 22.04.3 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://1.6.26
  Kubelet Version:            v1.29.0
  Kube-Proxy Version:         v1.29.0
PodCIDR:                      10.244.1.0/24
PodCIDRs:                     10.244.1.0/24
Non-terminated Pods:          (2 in total)
  Namespace                   Name                     CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                     ------------  ----------  ---------------  -------------  ---
  kube-flannel                kube-flannel-ds-j9pzr    100m (0%)     0 (0%)      50Mi (0%)        0 (0%)         27m
  kube-system                 kube-proxy-z48h8         0 (0%)        0 (0%)      0 (0%)           0 (0%)         27m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests   Limits
  --------           --------   ------
  cpu                100m (0%)  0 (0%)
  memory             50Mi (0%)  0 (0%)
  ephemeral-storage  0 (0%)     0 (0%)
  hugepages-1Gi      0 (0%)     0 (0%)
  hugepages-2Mi      0 (0%)     0 (0%)
Events:
  Type     Reason                   Age                  From             Message
  ----     ------                   ----                 ----             -------
  Normal   Starting                 27m                  kube-proxy       
  Normal   NodeHasSufficientMemory  27m (x2 over 27m)    kubelet          Node node01 status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    27m (x2 over 27m)    kubelet          Node node01 status is now: NodeHasNoDiskPressure
  Normal   Starting                 27m                  kubelet          Starting kubelet.
  Warning  InvalidDiskCapacity      27m                  kubelet          invalid capacity 0 on image filesystem
  Normal   NodeHasSufficientPID     27m (x2 over 27m)    kubelet          Node node01 status is now: NodeHasSufficientPID
  Normal   NodeAllocatableEnforced  27m                  kubelet          Updated Node Allocatable limit across pods
  Normal   RegisteredNode           27m                  node-controller  Node node01 event: Registered Node node01 in Controller
  Normal   NodeReady                27m                  kubelet          Node node01 status is now: NodeReady
  Normal   Starting                 111s                 kubelet          Starting kubelet.
  Warning  InvalidDiskCapacity      111s                 kubelet          invalid capacity 0 on image filesystem
  Normal   NodeHasSufficientMemory  110s (x3 over 110s)  kubelet          Node node01 status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    110s (x3 over 110s)  kubelet          Node node01 status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     110s (x3 over 110s)  kubelet          Node node01 status is now: NodeHasSufficientPID
  Normal   NodeNotReady             110s                 kubelet          Node node01 status is now: NodeNotReady
  Normal   NodeAllocatableEnforced  110s                 kubelet          Updated Node Allocatable limit across pods
  Normal   NodeReady                110s                 kubelet          Node node01 status is now: NodeReady
  Normal   NodeNotReady             29s (x2 over 11m)    node-controller  Node node01 status is now: NodeNotReady

controlplane ~ ➜  


controlplane ~ ➜  ssh node01
Last login: Thu Jun 13 01:28:55 2024 from 192.3.79.9

node01 ~ ➜  

node01 ~ ➜  df -h
Filesystem                                                    Size  Used Avail Use% Mounted on
.                                                             969G  733G  237G  76% /
tmpfs                                                         4.0M     0  4.0M   0% /sys/fs/cgroup
tmpfs                                                         1.0M     0  1.0M   0% /sys/kernel/config
tmpfs                                                         1.0M     0  1.0M   0% /sys/kernel/debug
tmpfs                                                         1.0M     0  1.0M   0% /sys/kernel/tracing
tmpfs                                                          64M     0   64M   0% /dev
shm                                                            64M     0   64M   0% /dev/shm
tmpfs                                                          64M  2.7M   62M   5% /run
tmpfs                                                         4.0M     0  4.0M   0% /run/lock
/var/lib/sysbox/shiftfs/f22fb544-b03b-477a-806f-dd9f8eaf8f8f  969G  733G  237G  76% /etc/hosts
tmpfs                                                         103G     0  103G   0% /proc/acpi
tmpfs                                                         103G     0  103G   0% /proc/scsi
tmpfs                                                         103G     0  103G   0% /sys/firmware
tmpfs                                                         205G   12K  205G   1% /var/lib/kubelet/pods/eb0129d5-131c-48ff-8689-8e6a754e5391/volumes/kubernetes.io~projected/kube-api-access-j7m8b
tmpfs                                                         205G   12K  205G   1% /var/lib/kubelet/pods/31fb4a97-f0dc-45d5-a9b3-fb32909a7eda/volumes/kubernetes.io~projected/kube-api-access-vxtll
shm                                                            64M     0   64M   0% /run/containerd/io.containerd.grpc.v1.cri/sandboxes/aad22ceb752429ca4423c62af8e2c8a376f3158c14e437643d3e2ddc81609a3c/shm
shm                                                            64M     0   64M   0% /run/containerd/io.containerd.grpc.v1.cri/sandboxes/b5c835081f97d0886e4b3863da9ea683cbaff12cc26c0d1d37b953e160c8c148/shm
overlay                                                       969G  733G  237G  76% /run/containerd/io.containerd.runtime.v2.task/k8s.io/aad22ceb752429ca4423c62af8e2c8a376f3158c14e437643d3e2ddc81609a3c/rootfs
overlay                                                       969G  733G  237G  76% /run/containerd/io.containerd.runtime.v2.task/k8s.io/b5c835081f97d0886e4b3863da9ea683cbaff12cc26c0d1d37b953e160c8c148/rootfs
overlay                                                       969G  733G  237G  76% /run/containerd/io.containerd.runtime.v2.task/k8s.io/72835967dd22170a2729d48a373a9cebce930638dea4700c8cffdb5806b4c9d6/rootfs
overlay                                                       969G  733G  237G  76% /run/containerd/io.containerd.runtime.v2.task/k8s.io/032327b0b308dfbca2104907f903f5cc137d1f99f7b4d167ff0edfdd6c7b7454/rootfs
tmpfs                                                         400M     0  400M   0% /run/user/0

node01 ~ ➜  date
Thu Jun 13 01:39:30 UTC 2024

node01 ~ ➜  service kubelet status
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /usr/lib/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: activating (auto-restart) (Result: exit-code) since Thu 2024-06-13 01:39:31 UTC; 4s ago
       Docs: https://kubernetes.io/docs/
    Process: 14248 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, status=1/FAILURE)
   Main PID: 14248 (code=exited, status=1/FAILURE)

node01 ~ ✖ 


journalctl

Jun 13 01:38:40 node01 kubelet[13663]: Flag --pod-infra-container-image has been deprecated, will be removed in a future release. Image garbage collector will get sandbox image in>
Jun 13 01:38:40 node01 kubelet[13663]: I0613 01:38:40.096043   13663 server.go:204] "--pod-infra-container-image will not be pruned by the image garbage collector in kubelet and s>
Jun 13 01:38:40 node01 kubelet[13663]: E0613 01:38:40.098341   13663 run.go:74] "command failed" err="failed to construct kubelet dependencies: unable to load client CA file /etc/>
Jun 13 01:38:50 node01 kubelet[13732]: Flag --container-runtime-endpoint has been deprecated, This parameter should be set via the config file specified by the Kubelet's --config >
Jun 13 01:38:50 node01 kubelet[13732]: Flag --pod-infra-container-image has been deprecated, will be removed in a future release. Image garbage collector will get sandbox image in>
Jun 13 01:38:50 node01 kubelet[13732]: I0613 01:38:50.275173   13732 server.go:204] "--pod-infra-container-image will not be pruned by the image garbage collector in kubelet and s>
Jun 13 01:38:50 node01 kubelet[13732]: E0613 01:38:50.276816   13732 run.go:74] "command failed" err="failed to construct kubelet dependencies: unable to load client CA file /etc/>
Jun 13 01:39:00 node01 kubelet[13800]: Flag --container-runtime-endpoint has been deprecated, This parameter should be set via the config file specified by the Kubelet's --config >
Jun 13 01:39:00 node01 kubelet[13800]: Flag --pod-infra-container-image has been deprecated, will be removed in a future release. Image garbage collector will get sandbox image in>
Jun 13 01:39:00 node01 kubelet[13800]: I0613 01:39:00.530669   13800 server.go:204] "--pod-infra-container-image will not be pruned by the image garbage collector in kubelet and s>
Jun 13 01:39:00 node01 kubelet[13800]: E0613 01:39:00.532161   13800 run.go:74] "command failed" err="failed to construct kubelet dependencies: unable to load client CA file /etc/>
Jun 13 01:39:10 node01 kubelet[13865]: Flag --container-runtime-endpoint has been deprecated, This parameter should be set via the config file specified by the Kubelet's --config >
Jun 13 01:39:10 node01 kubelet[13865]: Flag --pod-infra-container-image has been deprecated, will be removed in a future release. Image garbage collector will get sandbox image in>
Jun 13 01:39:10 node01 kubelet[13865]: I0613 01:39:10.800684   13865 server.go:204] "--pod-infra-container-image will not be pruned by the image garbage collector in kubelet and s>
Jun 13 01:39:10 node01 kubelet[13865]: E0613 01:39:10.802067   13865 run.go:74] "command failed" err="failed to construct kubelet dependencies: unable to load client CA file /etc/>
Jun 13 01:39:19 node01 sshd[13918]: Accepted publickey for root from 192.3.79.9 port 54284 ssh2: RSA SHA256:V0BVqDYSivETJWWwUsjyRlH8P6ok8Q+N/7QqKzB5OVs
Jun 13 01:39:19 node01 sshd[13918]: pam_unix(sshd:session): session opened for user root(uid=0) by (uid=0)
Jun 13 01:39:19 node01 systemd-logind[1175]: New session 8213 of user root.
Jun 13 01:39:19 node01 systemd[13946]: pam_unix(systemd-user:session): session opened for user root(uid=0) by (uid=0)
Jun 13 01:39:19 node01 systemd[13946]: Queued start job for default target Main User Target.
Jun 13 01:39:19 node01 systemd[13946]: Created slice User Application Slice.
Jun 13 01:39:19 node01 systemd[13946]: Reached target Paths.
Jun 13 01:39:19 node01 systemd[13946]: Reached target Timers.
Jun 13 01:39:19 node01 systemd[13946]: Listening on GnuPG cryptographic agent and passphrase cache (access for web browsers).
Jun 13 01:39:19 node01 systemd[13946]: Listening on GnuPG cryptographic agent and passphrase cache (restricted).
Jun 13 01:39:19 node01 systemd[13946]: Listening on GnuPG cryptographic agent (ssh-agent emulation).
Jun 13 01:39:19 node01 systemd[13946]: Listening on GnuPG cryptographic agent and passphrase cache.
Jun 13 01:39:19 node01 systemd[13946]: Listening on debconf communication socket.
Jun 13 01:39:19 node01 systemd[13946]: Reached target Sockets.
Jun 13 01:39:19 node01 systemd[13946]: Reached target Basic System.
Jun 13 01:39:19 node01 systemd[13946]: Reached target Main User Target.
Jun 13 01:39:19 node01 systemd[13946]: Startup finished in 89ms.
Jun 13 01:39:21 node01 kubelet[14098]: Flag --container-runtime-endpoint has been deprecated, This parameter should be set via the config file specified by the Kubelet's --config >
Jun 13 01:39:21 node01 kubelet[14098]: Flag --pod-infra-container-image has been deprecated, will be removed in a future release. Image garbage collector will get sandbox image in>
Jun 13 01:39:21 node01 kubelet[14098]: I0613 01:39:21.010736   14098 server.go:204] "--pod-infra-container-image will not be pruned by the image garbage collector in kubelet and s>
Jun 13 01:39:21 node01 kubelet[14098]: E0613 01:39:21.012219   14098 run.go:74] "command failed" err="failed to construct kubelet dependencies: unable to load client CA file /etc/>
Jun 13 01:39:31 node01 kubelet[14248]: Flag --container-runtime-endpoint has been deprecated, This parameter should be set via the config file specified by the Kubelet's --config >
Jun 13 01:39:31 node01 kubelet[14248]: Flag --pod-infra-container-image has been deprecated, will be removed in a future release. Image garbage collector will get sandbox image in>
Jun 13 01:39:31 node01 kubelet[14248]: I0613 01:39:31.257170   14248 server.go:204] "--pod-infra-container-image will not be pruned by the image garbage collector in kubelet and s>
Jun 13 01:39:31 node01 kubelet[14248]: E0613 01:39:31.258729   14248 run.go:74] "command failed" err="failed to construct kubelet dependencies: unable to load client CA file /etc/>
Jun 13 01:39:41 node01 kubelet[14371]: Flag --container-runtime-endpoint has been deprecated, This parameter should be set via the config file specified by the Kubelet's --config >
Jun 13 01:39:41 node01 kubelet[14371]: Flag --pod-infra-container-image has been deprecated, will be removed in a future release. Image garbage collector will get sandbox image in>
Jun 13 01:39:41 node01 kubelet[14371]: I0613 01:39:41.509976   14371 server.go:204] "--pod-infra-container-image will not be pruned by the image garbage collector in kubelet and s>
Jun 13 01:39:41 node01 kubelet[14371]: E0613 01:39:41.511435   14371 run.go:74] "command failed" err="failed to construct kubelet dependencies: unable to load client CA file /etc/>
Jun 13 01:39:54 node01 kubelet[14454]: Flag --container-runtime-endpoint has been deprecated, This parameter should be set via the config file specified by the Kubelet's --config >
Jun 13 01:39:54 node01 kubelet[14454]: Flag --pod-infra-container-image has been deprecated, will be removed in a future release. Image garbage collector will get sandbox image in>
Jun 13 01:39:54 node01 kubelet[14454]: I0613 01:39:54.013326   14454 server.go:204] "--pod-infra-container-image will not be pruned by the image garbage collector in kubelet and s>
Jun 13 01:39:54 node01 kubelet[14454]: E0613 01:39:54.015587   14454 run.go:74] "command failed" err="failed to construct kubelet dependencies: unable to load client CA file /etc/>
Jun 13 01:40:04 node01 kubelet[14522]: Flag --container-runtime-endpoint has been deprecated, This parameter should be set via the config file specified by the Kubelet's --config >
Jun 13 01:40:04 node01 kubelet[14522]: Flag --pod-infra-container-image has been deprecated, will be removed in a future release. Image garbage collector will get sandbox image in>
Jun 13 01:40:04 node01 kubelet[14522]: I0613 01:40:04.257455   14522 server.go:204] "--pod-infra-container-image will not be pruned by the image garbage collector in kubelet and s>
Jun 13 01:40:04 node01 kubelet[14522]: E0613 01:40:04.258785   14522 run.go:74] "command failed" err="failed to construct kubelet dependencies: unable to load client CA file /etc/>
Jun 13 01:40:14 node01 kubelet[14631]: Flag --container-runtime-endpoint has been deprecated, This parameter should be set via the config file specified by the Kubelet's --config >
Jun 13 01:40:14 node01 kubelet[14631]: Flag --pod-infra-container-image has been deprecated, will be removed in a future release. Image garbage collector will get sandbox image in>
Jun 13 01:40:14 node01 kubelet[14631]: I0613 01:40:14.506243   14631 server.go:204] "--pod-infra-container-image will not be pruned by the image garbage collector in kubelet and s>
Jun 13 01:40:14 node01 kubelet[14631]: E0613 01:40:14.507794   14631 run.go:74] "command failed" err="failed to construct kubelet dependencies: unable to load client CA file /etc/>
lines 1812-1867/1867 (END)



err="failed to construct kubelet dependencies: unable to load client CA file



node01 ~ ➜  ps -ef | grep kubelet
root       15313   13986  0 01:41 pts/0    00:00:00 grep kubelet

node01 ~ ➜  

node01 ~ ➜  

node01 ~ ➜  ls /etc/kubernetes/
kubelet.conf  manifests  pki

node01 ~ ➜  ls /etc/kubernetes/
kubelet.conf  manifests  pki

node01 ~ ➜  cat /etc/kubernetes/kubelet.conf 
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJYmpEWFIxRXVBMW93RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBMk1UTXdNVEExTXpSYUZ3MHpOREEyTVRFd01URXdNelJhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUNpaE80eUU2ejI1WjRpL0htby9SbmJsYXpyRC9rOGl5SnNBSjlZaGI2V2YzdTJuc1d5bWdiYzRaTWgKQmxkbnIwL003VVVQVkQ5Skl0R2pUMVFrS0VDaHdwSVR0YlBTeG01NExpUURyYVdoTkNNbUx0TkMreDhWb053SQpqaFBSUXlmSlFCckFTOUxiV0ZqZn
    [.........]
    254LwplVGZMdHBRYkI0R2tpa0ZKQ2t1M1FSNTN0Y3VvQWdXY3Q4dFhhVlpwdlBTZ1AyN3JCUWlxK2JpcHVxVnAzZ0gwClVCT053TkVPVVF4UlV6bzRZYzg0NWpJK3Ric0lrQSsvNm4waGRkdWZyQUh2RnV5dEFOcGVKN2gvTmgyeFgzRlMKVStQc0xhMDRtM3hiCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://controlplane:6443
  name: default-cluster
contexts:
- context:
    cluster: default-cluster
    namespace: default
    user: default-auth
  name: default-context
current-context: default-context
kind: Config
preferences: {}
users:
- name: default-auth
  user:
    client-certificate: /var/lib/kubelet/pki/kubelet-client-current.pem
    client-key: /var/lib/kubelet/pki/kubelet-client-current.pem

node01 ~ ➜  




node01 ~ ➜  ls /etc/kubernetes/pki/
ca.crt

node01 ~ ➜  ls /var/lib/kubelet/
config.yaml  cpu_manager_state  device-plugins  kubeadm-flags.env  memory_manager_state  pki  plugins  plugins_registry  pod-resources  pods

node01 ~ ➜  ls /var/lib/kubelet/pki/
kubelet-client-2024-06-13-01-11-35.pem  kubelet-client-current.pem  kubelet.crt  kubelet.key

node01 ~ ➜  cat /var/lib/kubelet/config.yaml 
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    cacheTTL: 0s
    enabled: true
  x509:
    clientCAFile: /etc/kubernetes/pki/WRONG-CA-FILE.crt
authorization:
  mode: Webhook
  webhook:
    cacheAuthorizedTTL: 0s
    cacheUnauthorizedTTL: 0s
cgroupDriver: systemd
clusterDNS:
- 10.96.0.10
clusterDomain: cluster.local
containerRuntimeEndpoint: ""
cpuManagerReconcilePeriod: 0s
evictionPressureTransitionPeriod: 0s
fileCheckFrequency: 0s
healthzBindAddress: 127.0.0.1
healthzPort: 10248
httpCheckFrequency: 0s
imageMaximumGCAge: 0s
imageMinimumGCAge: 0s
kind: KubeletConfiguration
logging:
  flushFrequency: 0
  options:
    json:
      infoBufferSize: "0"
  verbosity: 0
memorySwap: {}
nodeStatusReportFrequency: 0s
nodeStatusUpdateFrequency: 0s
resolvConf: /run/systemd/resolve/resolv.conf
rotateCertificates: true
runtimeRequestTimeout: 0s
shutdownGracePeriod: 0s
shutdownGracePeriodCriticalPods: 0s
staticPodPath: /etc/kubernetes/manifests
streamingConnectionIdleTimeout: 0s
syncFrequency: 0s
volumeStatsAggPeriod: 0s

node01 ~ ➜  

node01 ~ ➜  which kubelet
/usr/bin/kubelet

node01 ~ ➜  


- Ajustando config do kubelet:

~~~~yaml
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    cacheTTL: 0s
    enabled: true
  x509:
    clientCAFile: /etc/kubernetes/pki/ca.crt
authorization:
  mode: Webhook
  webhook:
    cacheAuthorizedTTL: 0s
    cacheUnauthorizedTTL: 0s
cgroupDriver: systemd
clusterDNS:
- 10.96.0.10
clusterDomain: cluster.local
containerRuntimeEndpoint: ""
cpuManagerReconcilePeriod: 0s
evictionPressureTransitionPeriod: 0s
fileCheckFrequency: 0s
healthzBindAddress: 127.0.0.1
healthzPort: 10248
httpCheckFrequency: 0s
imageMaximumGCAge: 0s
imageMinimumGCAge: 0s
kind: KubeletConfiguration
logging:
  flushFrequency: 0
  options:
    json:
      infoBufferSize: "0"
  verbosity: 0
memorySwap: {}
nodeStatusReportFrequency: 0s
nodeStatusUpdateFrequency: 0s
resolvConf: /run/systemd/resolve/resolv.conf
rotateCertificates: true
runtimeRequestTimeout: 0s
shutdownGracePeriod: 0s
shutdownGracePeriodCriticalPods: 0s
staticPodPath: /etc/kubernetes/manifests
streamingConnectionIdleTimeout: 0s
syncFrequency: 0s
volumeStatsAggPeriod: 0s
~~~~


node01 ~ ➜  vi /var/lib/kubelet/config.yaml 

node01 ~ ➜  

node01 ~ ➜  

node01 ~ ➜  

node01 ~ ➜  

node01 ~ ➜  service kubelet status
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /usr/lib/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: active (running) since Thu 2024-06-13 01:47:04 UTC; 1s ago
       Docs: https://kubernetes.io/docs/
   Main PID: 18733 (kubelet)
      Tasks: 24 (limit: 251379)
     Memory: 34.0M
     CGroup: /system.slice/kubelet.service
             └─18733 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml>

Jun 13 01:47:05 node01 kubelet[18733]: I0613 01:47:05.564866   18733 apiserver.go:52] "Watching apiserver"
Jun 13 01:47:05 node01 kubelet[18733]: I0613 01:47:05.567129   18733 topology_manager.go:215] "Topology Admit Handler" podUID="eb0129d5-131c-48ff-8689-8e6a754e5391" podNamespace=">
Jun 13 01:47:05 node01 kubelet[18733]: I0613 01:47:05.567223   18733 topology_manager.go:215] "Topology Admit Handler" podUID="31fb4a97-f0dc-45d5-a9b3-fb32909a7eda" podNamespace=">
Jun 13 01:47:05 node01 kubelet[18733]: I0613 01:47:05.604632   18733 desired_state_of_world_populator.go:159] "Finished populating initial desired state of world"
Jun 13 01:47:05 node01 kubelet[18733]: I0613 01:47:05.613771   18733 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"lib-modules\">
Jun 13 01:47:05 node01 kubelet[18733]: I0613 01:47:05.613820   18733 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"run\" (Unique>
Jun 13 01:47:05 node01 kubelet[18733]: I0613 01:47:05.613838   18733 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"cni-plugin\" >
Jun 13 01:47:05 node01 kubelet[18733]: I0613 01:47:05.613859   18733 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"cni\" (Unique>
Jun 13 01:47:05 node01 kubelet[18733]: I0613 01:47:05.613880   18733 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"xtables-lock\>
Jun 13 01:47:05 node01 kubelet[18733]: I0613 01:47:05.614056   18733 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"xtables-lock\>

node01 ~ ➜  date
Thu Jun 13 01:47:08 UTC 2024

node01 ~ ➜  

controlplane ~ ✖ kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   36m   v1.29.0
node01         Ready    <none>          36m   v1.29.0

controlplane ~ ➜  

- SOLUÇÃO2:
Ajustar config do yaml do kubelet.
vi /var/lib/kubelet/config.yaml 









The cluster is broken again. Investigate and fix the issue.

Fix Cluster



controlplane ~ ➜  kubectl get nodes
NAME           STATUS     ROLES           AGE   VERSION
controlplane   Ready      control-plane   38m   v1.29.0
node01         NotReady   <none>          37m   v1.29.0

controlplane ~ ➜  date
Thu Jun 13 01:48:57 AM UTC 2024

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
Annotations:        flannel.alpha.coreos.com/backend-data: {"VNI":1,"VtepMAC":"ca:90:1d:77:40:67"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 192.3.79.12
                    kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Thu, 13 Jun 2024 01:11:35 +0000
Taints:             node.kubernetes.io/unreachable:NoExecute
                    node.kubernetes.io/unreachable:NoSchedule
Unschedulable:      false
Lease:
  HolderIdentity:  node01
  AcquireTime:     <unset>
  RenewTime:       Thu, 13 Jun 2024 01:47:55 +0000
Conditions:
  Type                 Status    LastHeartbeatTime                 LastTransitionTime                Reason              Message
  ----                 ------    -----------------                 ------------------                ------              -------
  NetworkUnavailable   False     Thu, 13 Jun 2024 01:11:41 +0000   Thu, 13 Jun 2024 01:11:41 +0000   FlannelIsUp         Flannel is running on this node
  MemoryPressure       Unknown   Thu, 13 Jun 2024 01:47:14 +0000   Thu, 13 Jun 2024 01:48:38 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
  DiskPressure         Unknown   Thu, 13 Jun 2024 01:47:14 +0000   Thu, 13 Jun 2024 01:48:38 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
  PIDPressure          Unknown   Thu, 13 Jun 2024 01:47:14 +0000   Thu, 13 Jun 2024 01:48:38 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
  Ready                Unknown   Thu, 13 Jun 2024 01:47:14 +0000   Thu, 13 Jun 2024 01:48:38 +0000   NodeStatusUnknown   Kubelet stopped posting node status.
Addresses:
  InternalIP:  192.3.79.12
  Hostname:    node01
Capacity:
  cpu:                36
  ephemeral-storage:  1016057248Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214587048Ki
  pods:               110
Allocatable:
  cpu:                36
  ephemeral-storage:  936398358207
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214484648Ki
  pods:               110
System Info:
  Machine ID:                 49e48c9673ca44dd919fd32b36f0e237
  System UUID:                e0179261-2681-56c9-cccb-fdad1af98f51
  Boot ID:                    2c6f9aaa-defc-4b0d-840a-362a251d55ac
  Kernel Version:             5.4.0-1106-gcp
  OS Image:                   Ubuntu 22.04.3 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://1.6.26
  Kubelet Version:            v1.29.0
  Kube-Proxy Version:         v1.29.0
PodCIDR:                      10.244.1.0/24
PodCIDRs:                     10.244.1.0/24
Non-terminated Pods:          (2 in total)
  Namespace                   Name                     CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                     ------------  ----------  ---------------  -------------  ---
  kube-flannel                kube-flannel-ds-j9pzr    100m (0%)     0 (0%)      50Mi (0%)        0 (0%)         37m
  kube-system                 kube-proxy-z48h8         0 (0%)        0 (0%)      0 (0%)           0 (0%)         37m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests   Limits
  --------           --------   ------
  cpu                100m (0%)  0 (0%)
  memory             50Mi (0%)  0 (0%)
  ephemeral-storage  0 (0%)     0 (0%)
  hugepages-1Gi      0 (0%)     0 (0%)
  hugepages-2Mi      0 (0%)     0 (0%)
Events:
  Type     Reason                   Age                  From             Message
  ----     ------                   ----                 ----             -------
  Normal   Starting                 37m                  kube-proxy       
  Normal   Starting                 37m                  kubelet          Starting kubelet.
  Warning  InvalidDiskCapacity      37m                  kubelet          invalid capacity 0 on image filesystem
  Normal   NodeHasSufficientMemory  37m (x2 over 37m)    kubelet          Node node01 status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    37m (x2 over 37m)    kubelet          Node node01 status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     37m (x2 over 37m)    kubelet          Node node01 status is now: NodeHasSufficientPID
  Normal   NodeAllocatableEnforced  37m                  kubelet          Updated Node Allocatable limit across pods
  Normal   RegisteredNode           37m                  node-controller  Node node01 event: Registered Node node01 in Controller
  Normal   NodeReady                37m                  kubelet          Node node01 status is now: NodeReady
  Warning  InvalidDiskCapacity      12m                  kubelet          invalid capacity 0 on image filesystem
  Normal   Starting                 12m                  kubelet          Starting kubelet.
  Normal   NodeHasSufficientMemory  12m (x3 over 12m)    kubelet          Node node01 status is now: NodeHasSufficientMemory
  Normal   NodeReady                12m                  kubelet          Node node01 status is now: NodeReady
  Normal   NodeHasNoDiskPressure    12m (x3 over 12m)    kubelet          Node node01 status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     12m (x3 over 12m)    kubelet          Node node01 status is now: NodeHasSufficientPID
  Normal   NodeNotReady             12m                  kubelet          Node node01 status is now: NodeNotReady
  Normal   NodeAllocatableEnforced  12m                  kubelet          Updated Node Allocatable limit across pods
  Normal   Starting                 2m4s                 kubelet          Starting kubelet.
  Warning  InvalidDiskCapacity      2m4s                 kubelet          invalid capacity 0 on image filesystem
  Normal   NodeHasSufficientMemory  2m4s (x3 over 2m4s)  kubelet          Node node01 status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    2m4s (x3 over 2m4s)  kubelet          Node node01 status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     2m4s (x3 over 2m4s)  kubelet          Node node01 status is now: NodeHasSufficientPID
  Normal   NodeNotReady             2m4s                 kubelet          Node node01 status is now: NodeNotReady
  Normal   NodeReady                2m4s                 kubelet          Node node01 status is now: NodeReady
  Normal   NodeAllocatableEnforced  2m4s                 kubelet          Updated Node Allocatable limit across pods
  Normal   NodeNotReady             30s (x3 over 21m)    node-controller  Node node01 status is now: NodeNotReady

controlplane ~ ➜  



controlplane ~ ➜  ssh node01
Last login: Thu Jun 13 01:39:19 2024 from 192.3.79.9

node01 ~ ➜  

node01 ~ ➜  

node01 ~ ➜  service kubelet status
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /usr/lib/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: active (running) since Thu 2024-06-13 01:47:57 UTC; 3min 37s ago
       Docs: https://kubernetes.io/docs/
   Main PID: 19337 (kubelet)
      Tasks: 36 (limit: 251379)
     Memory: 44.1M
     CGroup: /system.slice/kubelet.service
             └─19337 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml>

Jun 13 01:51:26 node01 kubelet[19337]: I0613 01:51:26.496822   19337 kubelet_node_status.go:73] "Attempting to register node" node="node01"
Jun 13 01:51:26 node01 kubelet[19337]: E0613 01:51:26.498098   19337 kubelet_node_status.go:96] "Unable to register node with API server" err="Post \"https://controlplane:6553/api>
Jun 13 01:51:27 node01 kubelet[19337]: E0613 01:51:27.145684   19337 event.go:355] "Unable to write event (may retry after sleeping)" err="Post \"https://controlplane:6553/api/v1/>
Jun 13 01:51:27 node01 kubelet[19337]: E0613 01:51:27.145758   19337 event.go:294] "Unable to write event (retry limit exceeded!)" event="&Event{ObjectMeta:{node01.17d86d284775575>
Jun 13 01:51:27 node01 kubelet[19337]: E0613 01:51:27.146823   19337 event.go:355] "Unable to write event (may retry after sleeping)" err="Post \"https://controlplane:6553/api/v1/>
Jun 13 01:51:27 node01 kubelet[19337]: E0613 01:51:27.554573   19337 event.go:355] "Unable to write event (may retry after sleeping)" err="Post \"https://controlplane:6553/api/v1/>
Jun 13 01:51:27 node01 kubelet[19337]: E0613 01:51:27.762833   19337 eviction_manager.go:282] "Eviction manager: failed to get summary stats" err="failed to get node info: node \">
Jun 13 01:51:33 node01 kubelet[19337]: E0613 01:51:33.280079   19337 controller.go:145] "Failed to ensure lease exists, will retry" err="Get \"https://controlplane:6553/apis/coord>
Jun 13 01:51:33 node01 kubelet[19337]: I0613 01:51:33.499516   19337 kubelet_node_status.go:73] "Attempting to register node" node="node01"
Jun 13 01:51:33 node01 kubelet[19337]: E0613 01:51:33.500646   19337 kubelet_node_status.go:96] "Unable to register node with API server" err="Post \"https://controlplane:6553/api>

node01 ~ ➜  

Problema parece ser no API Server.


node01 ~ ➜  ls /etc/kubernetes/
kubelet.conf  manifests  pki

node01 ~ ➜  ls /etc/kubernetes/manifests/

node01 ~ ➜  ls /var/lib/kubelet/
config.yaml  cpu_manager_state  device-plugins  kubeadm-flags.env  memory_manager_state  pki  plugins  plugins_registry  pod-resources  pods

node01 ~ ➜  ps -ef | grep kube
root        2967    2719  0 01:11 ?        00:00:00 /usr/local/bin/kube-proxy --config=/var/lib/kube-proxy/config.conf --hostname-override=node01
root        3400    2733  0 01:11 ?        00:00:03 /opt/bin/flanneld --ip-masq --kube-subnet-mgr --iface=eth0
root       19337       1  0 01:47 ?        00:00:07 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock --pod-infra-container-image=registry.k8s.io/pause:3.9
root       21109   20413  0 01:52 pts/0    00:00:00 grep kube

node01 ~ ➜  

Verificando o controlplane
validando as portas


controlplane ~ ➜  ss -tulp
Netid        State          Recv-Q         Send-Q                 Local Address:Port                     Peer Address:Port        Process                                           
udp          UNCONN         0              0                         127.0.0.11:49335                         0.0.0.0:*                                                             
udp          UNCONN         0              0                      127.0.0.53%lo:domain                        0.0.0.0:*            users:(("systemd-resolve",pid=638,fd=13))        
udp          UNCONN         0              0                            0.0.0.0:8472                          0.0.0.0:*                                                             
tcp          LISTEN         0              4096                       127.0.0.1:37373                         0.0.0.0:*            users:(("containerd",pid=1303,fd=16))            
tcp          LISTEN         0              4096                      127.0.0.11:36669                         0.0.0.0:*                                                             
tcp          LISTEN         0              4096                       127.0.0.1:10248                         0.0.0.0:*            users:(("kubelet",pid=4361,fd=26))               
tcp          LISTEN         0              4096                       127.0.0.1:10249                         0.0.0.0:*            users:(("kube-proxy",pid=5061,fd=9))             
tcp          LISTEN         0              4096                       127.0.0.1:2379                          0.0.0.0:*            users:(("etcd",pid=3825,fd=9))                   
tcp          LISTEN         0              4096                      192.3.79.9:2379                          0.0.0.0:*            users:(("etcd",pid=3825,fd=8))                   
tcp          LISTEN         0              4096                      192.3.79.9:2380                          0.0.0.0:*            users:(("etcd",pid=3825,fd=7))                   
tcp          LISTEN         0              4096                       127.0.0.1:2381                          0.0.0.0:*            users:(("etcd",pid=3825,fd=15))                  
tcp          LISTEN         0              128                          0.0.0.0:http-alt                      0.0.0.0:*            users:(("ttyd",pid=1300,fd=12))                  
tcp          LISTEN         0              4096                       127.0.0.1:10257                         0.0.0.0:*            users:(("kube-controller",pid=3814,fd=3))        
tcp          LISTEN         0              4096                       127.0.0.1:10259                         0.0.0.0:*            users:(("kube-scheduler",pid=3805,fd=3))         
tcp          LISTEN         0              4096                   127.0.0.53%lo:domain                        0.0.0.0:*            users:(("systemd-resolve",pid=638,fd=14))        
tcp          LISTEN         0              128                          0.0.0.0:ssh                           0.0.0.0:*            users:(("sshd",pid=1304,fd=3))                   
tcp          LISTEN         0              4096                               *:10250                               *:*            users:(("kubelet",pid=4361,fd=9))                
tcp          LISTEN         0              4096                               *:6443                                *:*            users:(("kube-apiserver",pid=3804,fd=3))         
tcp          LISTEN         0              4096                               *:10256                               *:*            users:(("kube-proxy",pid=5061,fd=12))            
tcp          LISTEN         0              128                             [::]:ssh                              [::]:*            users:(("sshd",pid=1304,fd=4))                   
tcp          LISTEN         0              4096                               *:8888                                *:*            users:(("kubectl",pid=4580,fd=3))                

controlplane ~ ➜  date
Thu Jun 13 01:53:46 AM UTC 2024

controlplane ~ ➜  

Parece que o apiserver escuta numa porta diferente do que está configurado no kubelet
          
tcp          LISTEN         0              4096                               *:6443                                *:*            users:(("kube-apiserver",pid=3804,fd=3))   


node01 ~ ➜  cat /var/lib/kubelet/config.yaml 
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    cacheTTL: 0s
    enabled: true
  x509:
    clientCAFile: /etc/kubernetes/pki/ca.crt
authorization:
  mode: Webhook
  webhook:
    cacheAuthorizedTTL: 0s
    cacheUnauthorizedTTL: 0s
cgroupDriver: systemd
clusterDNS:
- 10.96.0.10
clusterDomain: cluster.local
containerRuntimeEndpoint: ""
cpuManagerReconcilePeriod: 0s
evictionPressureTransitionPeriod: 0s
fileCheckFrequency: 0s
healthzBindAddress: 127.0.0.1
healthzPort: 10248
httpCheckFrequency: 0s
imageMaximumGCAge: 0s
imageMinimumGCAge: 0s
kind: KubeletConfiguration
logging:
  flushFrequency: 0
  options:
    json:
      infoBufferSize: "0"
  verbosity: 0
memorySwap: {}
nodeStatusReportFrequency: 0s
nodeStatusUpdateFrequency: 0s
resolvConf: /run/systemd/resolve/resolv.conf
rotateCertificates: true
runtimeRequestTimeout: 0s
shutdownGracePeriod: 0s
shutdownGracePeriodCriticalPods: 0s
staticPodPath: /etc/kubernetes/manifests
streamingConnectionIdleTimeout: 0s
syncFrequency: 0s
volumeStatsAggPeriod: 0s

node01 ~ ➜  


node01 ~ ➜  ps -ef | grep kube
root        2967    2719  0 01:11 ?        00:00:00 /usr/local/bin/kube-proxy --config=/var/lib/kube-proxy/config.conf --hostname-override=node01
root        3400    2733  0 01:11 ?        00:00:04 /opt/bin/flanneld --ip-masq --kube-subnet-mgr --iface=eth0
root       19337       1  0 01:47 ?        00:00:11 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock --pod-infra-container-image=registry.k8s.io/pause:3.9
root       22057   21842  0 01:55 pts/0    00:00:00 grep kube

node01 ~ ➜  cat /etc/kubernetes/bootstrap-kubelet.conf
cat: /etc/kubernetes/bootstrap-kubelet.conf: No such file or directory

node01 ~ ✖ cat /etc/kubernetes/kubelet.conf
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJYmpEWFIxRXVBMW93RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBMk1UTXdNVEExTXpSYUZ3MHpOREEyTVRFd01URXdNelJhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUNpaE80eUU2ejI1WjRpL0htby9SbmJsYXpyRC9rOGl5SnNBSjlZaGI2V2YzdTJuc1d5bWdiYzRaTWgKQmxkbnIwL003VVVQVkQ5Skl0R2pUMVFrS0VDaHdwSVR0YlBTeG01NExpUURyYVdoTkNNbUx0TkMreDhWb053SQpqaFBSUXlmSlFCckFTOUxiV0ZqZnJkZ3VyRXB1dXNuS0xZTTF2QURXMGVzSTBEeGZUNWFXOU9WRDkwNTd2bzFsCmJxZnB4czRKa1JrZW04WDBuZ09OUTQ0eVp5ZEN1UmxIdGFPZmtuM1lhSkh1a0IzYTcyRzBhNXBmL1Z5UDROaFQKb1hVMUZhaE5lK1U0TjVNT1BQVnNzcnhvVnMzS3pRWXoxS2lMMGo4dEdjSUVycmo0NEdzODQ4eEVJelR1UU9LSgpCNXJTVFl6ekRMR3RtbUtZTVU2LzhGNTI3MWhOQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJUSmtOUDltZ1ZVbUlabmlLMjEyUDJiRnJ3Z0FUQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQlFFajRBYWJlTApSN2JiNkwwNlF0STVXS0srUzY2bXVZaE56TDVGeVFCd25tK2hmMFZpWjdkZW8xbEhLZzBrVUM5OGFBUEJGSERTCnIxRGlkSUJKN1l6aXlzTWZxc0xNb2NSRnQrWngxdHZ5dStHTE01aGxnZ3psOHBhZTJrdXBVdEVocDJuMXZSQmIKUW9qN2lJVlBDQ0E4dFVuT0JoRHZPMjFIb0R3R3FIZ0Z3cGt0NkFPYTN6d0Rpd1dwUWdWUk9vb1hadmFXR254LwplVGZMdHBRYkI0R2tpa0ZKQ2t1M1FSNTN0Y3VvQWdXY3Q4dFhhVlpwdlBTZ1AyN3JCUWlxK2JpcHVxVnAzZ0gwClVCT053TkVPVVF4UlV6bzRZYzg0NWpJK3Ric0lrQSsvNm4waGRkdWZyQUh2RnV5dEFOcGVKN2gvTmgyeFgzRlMKVStQc0xhMDRtM3hiCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://controlplane:6553
  name: default-cluster
contexts:
- context:
    cluster: default-cluster
    namespace: default
    user: default-auth
  name: default-context
current-context: default-context
kind: Config
preferences: {}
users:
- name: default-auth
  user:
    client-certificate: /var/lib/kubelet/pki/kubelet-client-current.pem
    client-key: /var/lib/kubelet/pki/kubelet-client-current.pem

node01 ~ ➜  



node01 ~ ➜  

node01 ~ ➜  vi /etc/kubernetes/kubelet.conf

node01 ~ ➜  

node01 ~ ➜  

node01 ~ ➜  

node01 ~ ➜  cat /etc/kubernetes/kubelet.conf | grep control
    server: https://controlplane:6443

node01 ~ ➜  date
Thu Jun 13 01:56:05 UTC 2024

node01 ~ ➜  


node01 ~ ➜  service kubelet status
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /usr/lib/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: active (running) since Thu 2024-06-13 01:47:57 UTC; 8min ago
       Docs: https://kubernetes.io/docs/
   Main PID: 19337 (kubelet)
      Tasks: 37 (limit: 251379)
     Memory: 49.0M
     CGroup: /system.slice/kubelet.service
             └─19337 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml>

Jun 13 01:56:00 node01 kubelet[19337]: E0613 01:56:00.547495   19337 event.go:355] "Unable to write event (may retry after sleeping)" err="Post \"https://controlplane:6553/api/v1/>
Jun 13 01:56:06 node01 kubelet[19337]: E0613 01:56:06.360331   19337 controller.go:145] "Failed to ensure lease exists, will retry" err="Get \"https://controlplane:6553/apis/coord>
Jun 13 01:56:07 node01 kubelet[19337]: I0613 01:56:07.343426   19337 kubelet_node_status.go:73] "Attempting to register node" node="node01"
Jun 13 01:56:07 node01 kubelet[19337]: E0613 01:56:07.344764   19337 kubelet_node_status.go:96] "Unable to register node with API server" err="Post \"https://controlplane:6553/api>
Jun 13 01:56:07 node01 kubelet[19337]: E0613 01:56:07.785429   19337 eviction_manager.go:282] "Eviction manager: failed to get summary stats" err="failed to get node info: node \">
Jun 13 01:56:10 node01 kubelet[19337]: E0613 01:56:10.549335   19337 event.go:355] "Unable to write event (may retry after sleeping)" err="Post \"https://controlplane:6553/api/v1/>
Jun 13 01:56:13 node01 kubelet[19337]: E0613 01:56:13.362102   19337 controller.go:145] "Failed to ensure lease exists, will retry" err="Get \"https://controlplane:6553/apis/coord>
Jun 13 01:56:14 node01 kubelet[19337]: I0613 01:56:14.345793   19337 kubelet_node_status.go:73] "Attempting to register node" node="node01"
Jun 13 01:56:14 node01 kubelet[19337]: E0613 01:56:14.347046   19337 kubelet_node_status.go:96] "Unable to register node with API server" err="Post \"https://controlplane:6553/api>
Jun 13 01:56:17 node01 kubelet[19337]: E0613 01:56:17.786091   19337 eviction_manager.go:282] "Eviction manager: failed to get summary stats" err="failed to get node info: node \">

node01 ~ ➜  service kubelet restart

node01 ~ ➜  

node01 ~ ➜  

node01 ~ ➜  service kubelet status
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /usr/lib/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: active (running) since Thu 2024-06-13 01:56:23 UTC; 1s ago
       Docs: https://kubernetes.io/docs/
   Main PID: 23062 (kubelet)
      Tasks: 23 (limit: 251379)
     Memory: 32.6M
     CGroup: /system.slice/kubelet.service
             └─23062 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml>

Jun 13 01:56:24 node01 kubelet[23062]: I0613 01:56:24.836077   23062 apiserver.go:52] "Watching apiserver"
Jun 13 01:56:24 node01 kubelet[23062]: I0613 01:56:24.839259   23062 topology_manager.go:215] "Topology Admit Handler" podUID="eb0129d5-131c-48ff-8689-8e6a754e5391" podNamespace=">
Jun 13 01:56:24 node01 kubelet[23062]: I0613 01:56:24.839358   23062 topology_manager.go:215] "Topology Admit Handler" podUID="31fb4a97-f0dc-45d5-a9b3-fb32909a7eda" podNamespace=">
Jun 13 01:56:24 node01 kubelet[23062]: I0613 01:56:24.846876   23062 desired_state_of_world_populator.go:159] "Finished populating initial desired state of world"
Jun 13 01:56:24 node01 kubelet[23062]: I0613 01:56:24.907122   23062 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"cni-plugin\" >
Jun 13 01:56:24 node01 kubelet[23062]: I0613 01:56:24.907166   23062 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"xtables-lock\>
Jun 13 01:56:24 node01 kubelet[23062]: I0613 01:56:24.907183   23062 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"lib-modules\">
Jun 13 01:56:24 node01 kubelet[23062]: I0613 01:56:24.907219   23062 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"run\" (Unique>
Jun 13 01:56:24 node01 kubelet[23062]: I0613 01:56:24.907233   23062 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"cni\" (Unique>
Jun 13 01:56:24 node01 kubelet[23062]: I0613 01:56:24.907351   23062 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"xtables-lock\>

node01 ~ ➜  



controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   45m   v1.29.0
node01         Ready    <none>          45m   v1.29.0

controlplane ~ ➜  date
Thu Jun 13 01:56:49 AM UTC 2024

controlplane ~ ➜  