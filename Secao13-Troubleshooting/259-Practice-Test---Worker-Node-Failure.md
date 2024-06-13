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




