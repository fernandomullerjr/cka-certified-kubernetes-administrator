#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "256. Practice Test - Control Plane Failure."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
## 256. Practice Test - Control Plane Failure



The cluster is broken. We tried deploying an application but it's not working. Troubleshoot and fix the issue.

Start looking at the deployments.

Fix the cluster


controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE     VERSION
controlplane   Ready    control-plane   9m31s   v1.29.0

controlplane ~ ➜  


controlplane ~ ➜  kubectl get all -A
NAMESPACE      NAME                                       READY   STATUS             RESTARTS      AGE
default        pod/app-5646649cc9-cvmnm                   0/1     Pending            0             43s
kube-flannel   pod/kube-flannel-ds-2rpsp                  1/1     Running            0             9m33s
kube-system    pod/coredns-69f9c977-8nbbx                 1/1     Running            0             9m33s
kube-system    pod/coredns-69f9c977-xtj2l                 1/1     Running            0             9m33s
kube-system    pod/etcd-controlplane                      1/1     Running            0             9m51s
kube-system    pod/kube-apiserver-controlplane            1/1     Running            0             9m45s
kube-system    pod/kube-controller-manager-controlplane   1/1     Running            0             9m45s
kube-system    pod/kube-proxy-kt6cb                       1/1     Running            0             9m33s
kube-system    pod/kube-scheduler-controlplane            0/1     CrashLoopBackOff   2 (19s ago)   44s

NAMESPACE     NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  9m50s
kube-system   service/kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   9m47s

NAMESPACE      NAME                             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-flannel   daemonset.apps/kube-flannel-ds   1         1         1       1            1           <none>                   9m47s
kube-system    daemonset.apps/kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   9m48s

NAMESPACE     NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
default       deployment.apps/app       0/1     1            0           43s
kube-system   deployment.apps/coredns   2/2     2            2           9m47s

NAMESPACE     NAME                               DESIRED   CURRENT   READY   AGE
default       replicaset.apps/app-5646649cc9     1         1         0       43s
kube-system   replicaset.apps/coredns-69f9c977   2         2         2       9m34s

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe pod/kube-scheduler-controlplane -n kube-system
Name:                 kube-scheduler-controlplane
Namespace:            kube-system
Priority:             2000001000
Priority Class Name:  system-node-critical
Node:                 controlplane/192.2.239.6
Start Time:           Thu, 30 May 2024 01:14:43 +0000
Labels:               component=kube-scheduler
                      tier=control-plane
Annotations:          kubernetes.io/config.hash: 23ace3c8b1dea5b6d6b30e6bcbb810a7
                      kubernetes.io/config.mirror: 23ace3c8b1dea5b6d6b30e6bcbb810a7
                      kubernetes.io/config.seen: 2024-05-30T01:23:32.875874677Z
                      kubernetes.io/config.source: file
Status:               Running
SeccompProfile:       RuntimeDefault
IP:                   192.2.239.6
IPs:
  IP:           192.2.239.6
Controlled By:  Node/controlplane
Containers:
  kube-scheduler:
    Container ID:  containerd://68a137b1ac5765ac4de274674ef771f9fba80907f9d79463fd71f09ddfa2c80f
    Image:         registry.k8s.io/kube-scheduler:v1.29.0
    Image ID:      registry.k8s.io/kube-scheduler@sha256:5df310234e4f9463b15d166778d697830a51c0037ff28a1759daaad2d3cde991
    Port:          <none>
    Host Port:     <none>
    Command:
      kube-schedulerrrr
      --authentication-kubeconfig=/etc/kubernetes/scheduler.conf
      --authorization-kubeconfig=/etc/kubernetes/scheduler.conf
      --bind-address=127.0.0.1
      --kubeconfig=/etc/kubernetes/scheduler.conf
      --leader-elect=true
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       StartError
      Message:      failed to create containerd task: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: "kube-schedulerrrr": executable file not found in $PATH: unknown
      Exit Code:    128
      Started:      Thu, 01 Jan 1970 00:00:00 +0000
      Finished:     Thu, 30 May 2024 01:24:41 +0000
    Ready:          False
    Restart Count:  3
    Requests:
      cpu:        100m
    Liveness:     http-get https://127.0.0.1:10259/healthz delay=10s timeout=15s period=10s #success=1 #failure=8
    Startup:      http-get https://127.0.0.1:10259/healthz delay=10s timeout=15s period=10s #success=1 #failure=24
    Environment:  <none>
    Mounts:
      /etc/kubernetes/scheduler.conf from kubeconfig (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kubeconfig:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/kubernetes/scheduler.conf
    HostPathType:  FileOrCreate
QoS Class:         Burstable
Node-Selectors:    <none>
Tolerations:       :NoExecute op=Exists
Events:
  Type     Reason   Age                 From     Message
  ----     ------   ----                ----     -------
  Normal   Pulled   16s (x4 over 73s)   kubelet  Container image "registry.k8s.io/kube-scheduler:v1.29.0" already present on machine
  Normal   Created  16s (x4 over 73s)   kubelet  Created container kube-scheduler
  Warning  Failed   16s (x4 over 72s)   kubelet  Error: failed to create containerd task: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: "kube-schedulerrrr": executable file not found in $PATH: unknown
  Warning  BackOff  13s (x10 over 71s)  kubelet  Back-off restarting failed container kube-scheduler in pod kube-scheduler-controlplane_kube-system(23ace3c8b1dea5b6d6b30e6bcbb810a7)

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  


kubectl edit pod/kube-scheduler-controlplane -n kube-system


controlplane ~ ➜  kubectl edit pod/kube-scheduler-controlplane -n kube-system
error: pods "kube-scheduler-controlplane" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-305686389.yaml"
error: Edit cancelled, no valid changes were saved.

controlplane ~ ✖ 

controlplane ~ ✖ cat /tmp/kubectl-edit-305686389.yaml
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
# pods "kube-scheduler-controlplane" was not valid:
# * spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`,`spec.initContainers[*].image`,`spec.activeDeadlineSeconds`,`spec.tolerations` (only additions to existing tolerations),`spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
#   core.PodSpec{
#       Volumes:        {{Name: "kubeconfig", VolumeSource: {HostPath: &{Path: "/etc/kubernetes/scheduler.conf", Type: &"FileOrCreate"}}}},
#       InitContainers: nil,
#       Containers: []core.Container{
#               {
#                       Name:  "kube-scheduler",
#                       Image: "registry.k8s.io/kube-scheduler:v1.29.0",
#                       Command: []string{
# -                             "kube-schedulerrrr",
# +                             "kube-scheduler",
#                               "--authentication-kubeconfig=/etc/kubernetes/scheduler.conf",
#                               "--authorization-kubeconfig=/etc/kubernetes/scheduler.conf",
#                               ... // 3 identical elements
#                       },
#                       Args:       nil,
#                       WorkingDir: "",
#                       ... // 19 identical fields
#               },
#       },
#       EphemeralContainers: nil,
#       RestartPolicy:       "Always",
#       ... // 28 identical fields
#   }

#
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubernetes.io/config.hash: 23ace3c8b1dea5b6d6b30e6bcbb810a7
    kubernetes.io/config.mirror: 23ace3c8b1dea5b6d6b30e6bcbb810a7
    kubernetes.io/config.seen: "2024-05-30T01:23:32.875874677Z"
    kubernetes.io/config.source: file
  creationTimestamp: "2024-05-30T01:23:44Z"
  labels:
    component: kube-scheduler
    tier: control-plane
  name: kube-scheduler-controlplane
  namespace: kube-system
  ownerReferences:
  - apiVersion: v1
    controller: true
    kind: Node
    name: controlplane
    uid: 7d820f6b-95c3-43cc-a023-388ab286daf0
  resourceVersion: "1287"
  uid: 561612a9-7d4a-4093-a547-8a655db736df
spec:
  containers:
  - command:
    - kube-scheduler
    - --authentication-kubeconfig=/etc/kubernetes/scheduler.conf
    - --authorization-kubeconfig=/etc/kubernetes/scheduler.conf
    - --bind-address=127.0.0.1
    - --kubeconfig=/etc/kubernetes/scheduler.conf
    - --leader-elect=true
    image: registry.k8s.io/kube-scheduler:v1.29.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10259
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 15
    name: kube-scheduler
    resources:
      requests:
        cpu: 100m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10259
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 15
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /etc/kubernetes/scheduler.conf
      name: kubeconfig
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  hostNetwork: true
  nodeName: controlplane
  preemptionPolicy: PreemptLowerPriority
  priority: 2000001000
  priorityClassName: system-node-critical
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    operator: Exists
  volumes:
  - hostPath:
      path: /etc/kubernetes/scheduler.conf
      type: FileOrCreate
    name: kubeconfig
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2024-05-30T01:23:45Z"
    status: "True"
    type: PodReadyToStartContainers
  - lastProbeTime: null
    lastTransitionTime: "2024-05-30T01:14:43Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2024-05-30T01:23:44Z"
    message: 'containers with unready status: [kube-scheduler]'
    reason: ContainersNotReady
    status: "False"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2024-05-30T01:23:44Z"
    message: 'containers with unready status: [kube-scheduler]'
    reason: ContainersNotReady
    status: "False"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2024-05-30T01:14:43Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://57d5d2282719b6ddaed9c9f5492758bfa91179c5e02e1c777c932f4dc01a8042
    image: registry.k8s.io/kube-scheduler:v1.29.0
    imageID: registry.k8s.io/kube-scheduler@sha256:5df310234e4f9463b15d166778d697830a51c0037ff28a1759daaad2d3cde991
    lastState:
      terminated:
        containerID: containerd://57d5d2282719b6ddaed9c9f5492758bfa91179c5e02e1c777c932f4dc01a8042
        exitCode: 128
        finishedAt: "2024-05-30T01:25:25Z"
        message: 'failed to create containerd task: failed to create shim task: OCI
          runtime create failed: runc create failed: unable to start container process:
          exec: "kube-schedulerrrr": executable file not found in $PATH: unknown'
        reason: StartError
        startedAt: "1970-01-01T00:00:00Z"
    name: kube-scheduler
    ready: false
    restartCount: 4
    started: false
    state:
      waiting:
        message: back-off 1m20s restarting failed container=kube-scheduler pod=kube-scheduler-controlplane_kube-system(23ace3c8b1dea5b6d6b30e6bcbb810a7)
        reason: CrashLoopBackOff
  hostIP: 192.2.239.6
  hostIPs:
  - ip: 192.2.239.6
  phase: Running
  podIP: 192.2.239.6
  podIPs:
  - ip: 192.2.239.6
  qosClass: Burstable
  startTime: "2024-05-30T01:14:43Z"

controlplane ~ ➜  


controlplane ~ ➜  kubectl apply -f /etc/kubernetes/manifests/kube-scheduler.yaml
pod/kube-scheduler created

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS     AGE
default        app-5646649cc9-cvmnm                   1/1     Running   0            9m5s
kube-flannel   kube-flannel-ds-2rpsp                  1/1     Running   0            17m
kube-system    coredns-69f9c977-8nbbx                 1/1     Running   0            17m
kube-system    coredns-69f9c977-xtj2l                 1/1     Running   0            17m
kube-system    etcd-controlplane                      1/1     Running   0            18m
kube-system    kube-apiserver-controlplane            1/1     Running   0            18m
kube-system    kube-controller-manager-controlplane   1/1     Running   0            18m
kube-system    kube-proxy-kt6cb                       1/1     Running   0            17m
kube-system    kube-scheduler                         0/1     Error     1 (2s ago)   3s
kube-system    kube-scheduler-controlplane            0/1     Running   0            10s

controlplane ~ ➜  


controlplane ~ ➜  kubectl delete pod kube-scheduler -n kube-system
pod "kube-scheduler" deleted

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        app-5646649cc9-cvmnm                   1/1     Running   0          9m40s
kube-flannel   kube-flannel-ds-2rpsp                  1/1     Running   0          18m
kube-system    coredns-69f9c977-8nbbx                 1/1     Running   0          18m
kube-system    coredns-69f9c977-xtj2l                 1/1     Running   0          18m
kube-system    etcd-controlplane                      1/1     Running   0          18m
kube-system    kube-apiserver-controlplane            1/1     Running   0          18m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          18m
kube-system    kube-proxy-kt6cb                       1/1     Running   0          18m
kube-system    kube-scheduler-controlplane            1/1     Running   0          45s

controlplane ~ ➜  date
Thu May 30 01:33:27 AM UTC 2024

controlplane ~ ➜  

- SOLUÇÃO1
pt1, ajustar o manifesto /etc/kubernetes/manifests/kube-scheduler.yaml
pt2, deletar o pod com erro.
pt3, aplicar kubectl apply -f /etc/kubernetes/manifests/kube-scheduler.yaml













Scale the deployment app to 2 pods.

Scale Deployment to 2 PODs

kubectl scale --replicas=2 deployment.apps/app



controlplane ~ ➜  kubectl scale --replicas=2 deployment.apps/app
deployment.apps/app scaled

controlplane ~ ➜  kubectl get all -A
NAMESPACE      NAME                                       READY   STATUS             RESTARTS      AGE
default        pod/app-5646649cc9-cvmnm                   1/1     Running            0             12m
kube-flannel   pod/kube-flannel-ds-2rpsp                  1/1     Running            0             21m
kube-system    pod/coredns-69f9c977-8nbbx                 1/1     Running            0             21m
kube-system    pod/coredns-69f9c977-xtj2l                 1/1     Running            0             21m
kube-system    pod/etcd-controlplane                      1/1     Running            0             21m
kube-system    pod/kube-apiserver-controlplane            1/1     Running            0             21m
kube-system    pod/kube-controller-manager-controlplane   0/1     CrashLoopBackOff   4 (20s ago)   109s
kube-system    pod/kube-proxy-kt6cb                       1/1     Running            0             21m
kube-system    pod/kube-scheduler-controlplane            1/1     Running            0             3m40s

NAMESPACE     NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  21m
kube-system   service/kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   21m

NAMESPACE      NAME                             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-flannel   daemonset.apps/kube-flannel-ds   1         1         1       1            1           <none>                   21m
kube-system    daemonset.apps/kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   21m

NAMESPACE     NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
default       deployment.apps/app       1/2     1            1           12m
kube-system   deployment.apps/coredns   2/2     2            2           21m

NAMESPACE     NAME                               DESIRED   CURRENT   READY   AGE
default       replicaset.apps/app-5646649cc9     1         1         1       12m
kube-system   replicaset.apps/coredns-69f9c977   2         2         2       21m

- SOLUÇÃO2
kubectl scale --replicas=2 deployment.apps/app







Even though the deployment was scaled to 2, the number of PODs does not seem to increase. Investigate and fix the issue.

Inspect the component responsible for managing deployments and replicasets.

Fix issue

Wait for deployment to actually scale

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS             RESTARTS      AGE
default        app-5646649cc9-cvmnm                   1/1     Running            0             13m
kube-flannel   kube-flannel-ds-2rpsp                  1/1     Running            0             22m
kube-system    coredns-69f9c977-8nbbx                 1/1     Running            0             22m
kube-system    coredns-69f9c977-xtj2l                 1/1     Running            0             22m
kube-system    etcd-controlplane                      1/1     Running            0             22m
kube-system    kube-apiserver-controlplane            1/1     Running            0             22m
kube-system    kube-controller-manager-controlplane   0/1     CrashLoopBackOff   4 (59s ago)   2m28s
kube-system    kube-proxy-kt6cb                       1/1     Running            0             22m
kube-system    kube-scheduler-controlplane            1/1     Running            0             4m19s

controlplane ~ ➜  

controlplane ~ ➜  

kubectl describe pod -n kube-system    kube-controller-manager-controlplane


controlplane ~ ➜  kubectl describe pod -n kube-system    kube-controller-manager-controlplane
Name:                 kube-controller-manager-controlplane
Namespace:            kube-system
Priority:             2000001000
Priority Class Name:  system-node-critical
Node:                 controlplane/192.2.239.6
Start Time:           Thu, 30 May 2024 01:14:43 +0000
Labels:               component=kube-controller-manager
                      tier=control-plane
Annotations:          kubernetes.io/config.hash: bdb1c9251d08619760167697af010d5c
                      kubernetes.io/config.mirror: bdb1c9251d08619760167697af010d5c
                      kubernetes.io/config.seen: 2024-05-30T01:34:16.732959733Z
                      kubernetes.io/config.source: file
Status:               Running
SeccompProfile:       RuntimeDefault
IP:                   192.2.239.6
IPs:
  IP:           192.2.239.6
Controlled By:  Node/controlplane
Containers:
  kube-controller-manager:
    Container ID:  containerd://86bcf199c1c4f376f78212c6da94eef358d6033ca6de9143a0c94463a9495d06
    Image:         registry.k8s.io/kube-controller-manager:v1.29.0
    Image ID:      registry.k8s.io/kube-controller-manager@sha256:d1e38ea25b27e57b41995ef59ad76dd33481853a5b8d1a91abb7a8be32b7e7da
    Port:          <none>
    Host Port:     <none>
    Command:
      kube-controller-manager
      --allocate-node-cidrs=true
      --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf
      --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf
      --bind-address=127.0.0.1
      --client-ca-file=/etc/kubernetes/pki/ca.crt
      --cluster-cidr=10.244.0.0/16
      --cluster-name=kubernetes
      --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
      --cluster-signing-key-file=/etc/kubernetes/pki/ca.key
      --controllers=*,bootstrapsigner,tokencleaner
      --kubeconfig=/etc/kubernetes/controller-manager-XXXX.conf
      --leader-elect=true
      --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
      --root-ca-file=/etc/kubernetes/pki/ca.crt
      --service-account-private-key-file=/etc/kubernetes/pki/sa.key
      --service-cluster-ip-range=10.96.0.0/12
      --use-service-account-credentials=true
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Thu, 30 May 2024 01:37:22 +0000
      Finished:     Thu, 30 May 2024 01:37:23 +0000
    Ready:          False
    Restart Count:  5
    Requests:
      cpu:        200m
    Liveness:     http-get https://127.0.0.1:10257/healthz delay=10s timeout=15s period=10s #success=1 #failure=8
    Startup:      http-get https://127.0.0.1:10257/healthz delay=10s timeout=15s period=10s #success=1 #failure=24
    Environment:  <none>
    Mounts:
      /etc/ca-certificates from etc-ca-certificates (ro)
      /etc/kubernetes/controller-manager.conf from kubeconfig (ro)
      /etc/kubernetes/pki from k8s-certs (ro)
      /etc/ssl/certs from ca-certs (ro)
      /usr/libexec/kubernetes/kubelet-plugins/volume/exec from flexvolume-dir (rw)
      /usr/local/share/ca-certificates from usr-local-share-ca-certificates (ro)
      /usr/share/ca-certificates from usr-share-ca-certificates (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  ca-certs:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/ssl/certs
    HostPathType:  DirectoryOrCreate
  etc-ca-certificates:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/ca-certificates
    HostPathType:  DirectoryOrCreate
  flexvolume-dir:
    Type:          HostPath (bare host directory volume)
    Path:          /usr/libexec/kubernetes/kubelet-plugins/volume/exec
    HostPathType:  DirectoryOrCreate
  k8s-certs:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/kubernetes/pki
    HostPathType:  DirectoryOrCreate
  kubeconfig:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/kubernetes/controller-manager.conf
    HostPathType:  FileOrCreate
  usr-local-share-ca-certificates:
    Type:          HostPath (bare host directory volume)
    Path:          /usr/local/share/ca-certificates
    HostPathType:  DirectoryOrCreate
  usr-share-ca-certificates:
    Type:          HostPath (bare host directory volume)
    Path:          /usr/share/ca-certificates
    HostPathType:  DirectoryOrCreate
QoS Class:         Burstable
Node-Selectors:    <none>
Tolerations:       :NoExecute op=Exists
Events:
  Type     Reason   Age                     From     Message
  ----     ------   ----                    ----     -------
  Warning  BackOff  2m39s (x10 over 3m51s)  kubelet  Back-off restarting failed container kube-controller-manager in pod kube-controller-manager-controlplane_kube-system(bdb1c9251d08619760167697af010d5c)
  Normal   Pulled   2m25s (x5 over 3m53s)   kubelet  Container image "registry.k8s.io/kube-controller-manager:v1.29.0" already present on machine
  Normal   Created  2m25s (x5 over 3m53s)   kubelet  Created container kube-controller-manager
  Normal   Started  2m25s (x5 over 3m52s)   kubelet  Started container kube-controller-manager

controlplane ~ ➜  


kubectl logs -n kube-system    kube-controller-manager-controlplane

controlplane ~ ➜  kubectl logs -n kube-system    kube-controller-manager-controlplane
I0530 01:37:23.124739       1 serving.go:380] Generated self-signed cert in-memory
E0530 01:37:23.124865       1 run.go:74] "command failed" err="stat /etc/kubernetes/controller-manager-XXXX.conf: no such file or directory"

controlplane ~ ➜  



kubectl logs -n kube-system    kube-controller-manager-controlplane


controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-
kube-apiserver.yaml           kube-controller-manager.yaml  kube-scheduler.yaml           

controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-controller-manager.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    component: kube-controller-manager
    tier: control-plane
  name: kube-controller-manager
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-controller-manager
    - --allocate-node-cidrs=true
    - --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --bind-address=127.0.0.1
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --cluster-cidr=10.244.0.0/16
    - --cluster-name=kubernetes
    - --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
    - --cluster-signing-key-file=/etc/kubernetes/pki/ca.key
    - --controllers=*,bootstrapsigner,tokencleaner
    - --kubeconfig=/etc/kubernetes/controller-manager-XXXX.conf
    - --leader-elect=true
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --root-ca-file=/etc/kubernetes/pki/ca.crt
    - --service-account-private-key-file=/etc/kubernetes/pki/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --use-service-account-credentials=true
    image: registry.k8s.io/kube-controller-manager:v1.29.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10257
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-controller-manager
    resources:
      requests:
        cpu: 200m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10257
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /etc/ssl/certs
      name: ca-certs
      readOnly: true
    - mountPath: /etc/ca-certificates
      name: etc-ca-certificates
      readOnly: true
    - mountPath: /usr/libexec/kubernetes/kubelet-plugins/volume/exec
      name: flexvolume-dir
    - mountPath: /etc/kubernetes/pki
      name: k8s-certs
      readOnly: true
    - mountPath: /etc/kubernetes/controller-manager.conf
      name: kubeconfig
      readOnly: true
    - mountPath: /usr/local/share/ca-certificates
      name: usr-local-share-ca-certificates
      readOnly: true
    - mountPath: /usr/share/ca-certificates
      name: usr-share-ca-certificates
      readOnly: true
  hostNetwork: true
  priority: 2000001000
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/ssl/certs
      type: DirectoryOrCreate
    name: ca-certs
  - hostPath:
      path: /etc/ca-certificates
      type: DirectoryOrCreate
    name: etc-ca-certificates
  - hostPath:
      path: /usr/libexec/kubernetes/kubelet-plugins/volume/exec
      type: DirectoryOrCreate
    name: flexvolume-dir
  - hostPath:
      path: /etc/kubernetes/pki
      type: DirectoryOrCreate
    name: k8s-certs
  - hostPath:
      path: /etc/kubernetes/controller-manager.conf
      type: FileOrCreate
    name: kubeconfig
  - hostPath:
      path: /usr/local/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-local-share-ca-certificates
  - hostPath:
      path: /usr/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-share-ca-certificates
status: {}

controlplane ~ ➜  

vi /etc/kubernetes/manifests/kube-controller-manager.yaml 

controlplane ~ ➜  vi /etc/kubernetes/manifests/kube-controller-manager.yaml 

controlplane ~ ➜  kubectl delete -f /etc/kubernetes/manifests/kube-controller-manager.yaml 
Error from server (NotFound): error when deleting "/etc/kubernetes/manifests/kube-controller-manager.yaml": pods "kube-controller-manager" not found

controlplane ~ ✖ kubectl apply -f /etc/kubernetes/manifests/kube-controller-manager.yaml 
pod/kube-controller-manager created

controlplane ~ ➜  

controlplane ~ ✖ kubectl apply -f /etc/kubernetes/manifests/kube-controller-manager.yaml 
pod/kube-controller-manager created

controlplane ~ ➜  kubectl get all -n kube-system
NAME                                       READY   STATUS             RESTARTS      AGE
pod/coredns-69f9c977-8nbbx                 1/1     Running            0             26m
pod/coredns-69f9c977-xtj2l                 1/1     Running            0             26m
pod/etcd-controlplane                      1/1     Running            0             27m
pod/kube-apiserver-controlplane            1/1     Running            0             27m
pod/kube-controller-manager                0/1     CrashLoopBackOff   2 (14s ago)   37s
pod/kube-controller-manager-controlplane   1/1     Running            0             48s
pod/kube-proxy-kt6cb                       1/1     Running            0             26m
pod/kube-scheduler-controlplane            1/1     Running            0             9m8s

NAME               TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
service/kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   27m

NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   27m

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/coredns   2/2     2            2           27m

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/coredns-69f9c977   2         2         2       26m

controlplane ~ ➜  

- SOLUÇÃO3
Ajustar
DE:

    - --kubeconfig=/etc/kubernetes/controller-manager-XXXX.conf
PARA:

    - --kubeconfig=/etc/kubernetes/controller-manager.conf
    









Something is wrong with scaling again. We just tried scaling the deployment to 3 replicas. But it's not happening.

Investigate and fix the issue.

Fix Issue

Wait for deployment to actually scale

controlplane ~ ➜  kubectl get all -n kube-system
NAME                                       READY   STATUS             RESTARTS      AGE
pod/coredns-69f9c977-8nbbx                 1/1     Running            0             27m
pod/coredns-69f9c977-xtj2l                 1/1     Running            0             27m
pod/etcd-controlplane                      1/1     Running            0             28m
pod/kube-apiserver-controlplane            1/1     Running            0             27m
pod/kube-controller-manager                0/1     CrashLoopBackOff   3 (41s ago)   88s
pod/kube-controller-manager-controlplane   0/1     CrashLoopBackOff   1 (21s ago)   24s
pod/kube-proxy-kt6cb                       1/1     Running            0             27m
pod/kube-scheduler-controlplane            1/1     Running            0             9m59s

NAME               TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
service/kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   27m

NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   27m

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/coredns   2/2     2            2           27m

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/coredns-69f9c977   2         2         2       27m

controlplane ~ ➜  
controlplane ~ ✖ kubectl get pods
NAME                   READY   STATUS    RESTARTS   AGE
app-5646649cc9-cvmnm   1/1     Running   0          19m
app-5646649cc9-p8kpk   1/1     Running   0          91s

controlplane ~ ➜  
controlplane ~ ➜  kubectl get deploy
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
app    3/3     3            3           19m

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe pod/kube-controller-manager-controlplane -n kube-system
Name:                 kube-controller-manager-controlplane
Namespace:            kube-system
Priority:             2000001000
Priority Class Name:  system-node-critical
Node:                 controlplane/192.2.239.6
Start Time:           Thu, 30 May 2024 01:41:00 +0000
Labels:               component=kube-controller-manager
                      tier=control-plane
Annotations:          kubernetes.io/config.hash: f3acd5d8bac629a5bb29ac545fabcc86
                      kubernetes.io/config.mirror: f3acd5d8bac629a5bb29ac545fabcc86
                      kubernetes.io/config.seen: 2024-05-30T01:42:00.892610556Z
                      kubernetes.io/config.source: file
Status:               Running
SeccompProfile:       RuntimeDefault
IP:                   192.2.239.6
IPs:
  IP:           192.2.239.6
Controlled By:  Node/controlplane
Containers:
  kube-controller-manager:
    Container ID:  containerd://a53de020bf20b3a7713a5e1c6edd3058216c5cba44e6d9d3a7e1b702536ac7cf
    Image:         registry.k8s.io/kube-controller-manager:v1.29.0
    Image ID:      registry.k8s.io/kube-controller-manager@sha256:d1e38ea25b27e57b41995ef59ad76dd33481853a5b8d1a91abb7a8be32b7e7da
    Port:          <none>
    Host Port:     <none>
    Command:
      kube-controller-manager
      --allocate-node-cidrs=true
      --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf
      --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf
      --bind-address=127.0.0.1
      --client-ca-file=/etc/kubernetes/pki/ca.crt
      --cluster-cidr=10.244.0.0/16
      --cluster-name=kubernetes
      --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
      --cluster-signing-key-file=/etc/kubernetes/pki/ca.key
      --controllers=*,bootstrapsigner,tokencleaner
      --kubeconfig=/etc/kubernetes/controller-manager.conf
      --leader-elect=true
      --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
      --root-ca-file=/etc/kubernetes/pki/ca.crt
      --service-account-private-key-file=/etc/kubernetes/pki/sa.key
      --service-cluster-ip-range=10.96.0.0/12
      --use-service-account-credentials=true
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Thu, 30 May 2024 01:43:13 +0000
      Finished:     Thu, 30 May 2024 01:43:14 +0000
    Ready:          False
    Restart Count:  3
    Requests:
      cpu:        200m
    Liveness:     http-get https://127.0.0.1:10257/healthz delay=10s timeout=15s period=10s #success=1 #failure=8
    Startup:      http-get https://127.0.0.1:10257/healthz delay=10s timeout=15s period=10s #success=1 #failure=24
    Environment:  <none>
    Mounts:
      /etc/ca-certificates from etc-ca-certificates (ro)
      /etc/kubernetes/controller-manager.conf from kubeconfig (ro)
      /etc/kubernetes/pki from k8s-certs (ro)
      /etc/ssl/certs from ca-certs (ro)
      /usr/libexec/kubernetes/kubelet-plugins/volume/exec from flexvolume-dir (rw)
      /usr/local/share/ca-certificates from usr-local-share-ca-certificates (ro)
      /usr/share/ca-certificates from usr-share-ca-certificates (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  ca-certs:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/ssl/certs
    HostPathType:  DirectoryOrCreate
  etc-ca-certificates:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/ca-certificates
    HostPathType:  DirectoryOrCreate
  flexvolume-dir:
    Type:          HostPath (bare host directory volume)
    Path:          /usr/libexec/kubernetes/kubelet-plugins/volume/exec
    HostPathType:  DirectoryOrCreate
  k8s-certs:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/kubernetes/WRONG-PKI-DIRECTORY
    HostPathType:  DirectoryOrCreate
  kubeconfig:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/kubernetes/controller-manager.conf
    HostPathType:  FileOrCreate
  usr-local-share-ca-certificates:
    Type:          HostPath (bare host directory volume)
    Path:          /usr/local/share/ca-certificates
    HostPathType:  DirectoryOrCreate
  usr-share-ca-certificates:
    Type:          HostPath (bare host directory volume)
    Path:          /usr/share/ca-certificates
    HostPathType:  DirectoryOrCreate
QoS Class:         Burstable
Node-Selectors:    <none>
Tolerations:       :NoExecute op=Exists
Events:
  Type     Reason   Age                From     Message
  ----     ------   ----               ----     -------
  Normal   Pulled   20s (x4 over 78s)  kubelet  Container image "registry.k8s.io/kube-controller-manager:v1.29.0" already present on machine
  Normal   Created  20s (x4 over 78s)  kubelet  Created container kube-controller-manager
  Normal   Started  20s (x4 over 77s)  kubelet  Started container kube-controller-manager
  Warning  BackOff  4s (x10 over 74s)  kubelet  Back-off restarting failed container kube-controller-manager in pod kube-controller-manager-controlplane_kube-system(f3acd5d8bac629a5bb29ac545fabcc86)

controlplane ~ ➜  


controlplane ~ ➜  kubectl logs pod/kube-controller-manager-controlplane -n kube-system
I0530 01:44:00.283970       1 serving.go:380] Generated self-signed cert in-memory
E0530 01:44:00.286285       1 run.go:74] "command failed" err="failed to create listener: failed to listen on 127.0.0.1:10257: listen tcp 127.0.0.1:10257: bind: address already in use"

controlplane ~ ➜  


controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-controller-manager.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    component: kube-controller-manager
    tier: control-plane
  name: kube-controller-manager
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-controller-manager
    - --allocate-node-cidrs=true
    - --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --bind-address=127.0.0.1
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --cluster-cidr=10.244.0.0/16
    - --cluster-name=kubernetes
    - --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
    - --cluster-signing-key-file=/etc/kubernetes/pki/ca.key
    - --controllers=*,bootstrapsigner,tokencleaner
    - --kubeconfig=/etc/kubernetes/controller-manager.conf
    - --leader-elect=true
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --root-ca-file=/etc/kubernetes/pki/ca.crt
    - --service-account-private-key-file=/etc/kubernetes/pki/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --use-service-account-credentials=true
    image: registry.k8s.io/kube-controller-manager:v1.29.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10257
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-controller-manager
    resources:
      requests:
        cpu: 200m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10257
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /etc/ssl/certs
      name: ca-certs
      readOnly: true
    - mountPath: /etc/ca-certificates
      name: etc-ca-certificates
      readOnly: true
    - mountPath: /usr/libexec/kubernetes/kubelet-plugins/volume/exec
      name: flexvolume-dir
    - mountPath: /etc/kubernetes/pki
      name: k8s-certs
      readOnly: true
    - mountPath: /etc/kubernetes/controller-manager.conf
      name: kubeconfig
      readOnly: true
    - mountPath: /usr/local/share/ca-certificates
      name: usr-local-share-ca-certificates
      readOnly: true
    - mountPath: /usr/share/ca-certificates
      name: usr-share-ca-certificates
      readOnly: true
  hostNetwork: true
  priority: 2000001000
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/ssl/certs
      type: DirectoryOrCreate
    name: ca-certs
  - hostPath:
      path: /etc/ca-certificates
      type: DirectoryOrCreate
    name: etc-ca-certificates
  - hostPath:
      path: /usr/libexec/kubernetes/kubelet-plugins/volume/exec
      type: DirectoryOrCreate
    name: flexvolume-dir
  - hostPath:
      path: /etc/kubernetes/WRONG-PKI-DIRECTORY
      type: DirectoryOrCreate
    name: k8s-certs
  - hostPath:
      path: /etc/kubernetes/controller-manager.conf
      type: FileOrCreate
    name: kubeconfig
  - hostPath:
      path: /usr/local/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-local-share-ca-certificates
  - hostPath:
      path: /usr/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-share-ca-certificates
status: {}

controlplane ~ ➜  

controlplane ~ ➜  ss -tulp
Netid   State    Recv-Q   Send-Q     Local Address:Port         Peer Address:Port  Process                                      
udp     UNCONN   0        0          127.0.0.53%lo:domain            0.0.0.0:*      users:(("systemd-resolve",pid=576,fd=13))   
udp     UNCONN   0        0                0.0.0.0:8472              0.0.0.0:*                                                  
udp     UNCONN   0        0             127.0.0.11:43419             0.0.0.0:*                                                  
tcp     LISTEN   0        4096           127.0.0.1:10248             0.0.0.0:*      users:(("kubelet",pid=4280,fd=12))          
tcp     LISTEN   0        4096           127.0.0.1:10249             0.0.0.0:*      users:(("kube-proxy",pid=4867,fd=8))        
tcp     LISTEN   0        4096         192.2.239.6:2379              0.0.0.0:*      users:(("etcd",pid=3719,fd=9))              
tcp     LISTEN   0        4096           127.0.0.1:2379              0.0.0.0:*      users:(("etcd",pid=3719,fd=8))              
tcp     LISTEN   0        4096         192.2.239.6:2380              0.0.0.0:*      users:(("etcd",pid=3719,fd=7))              
tcp     LISTEN   0        4096           127.0.0.1:2381              0.0.0.0:*      users:(("etcd",pid=3719,fd=16))             
tcp     LISTEN   0        128              0.0.0.0:http-alt          0.0.0.0:*      users:(("ttyd",pid=1246,fd=12))             
tcp     LISTEN   0        4096           127.0.0.1:10257             0.0.0.0:*      users:(("kube-controller",pid=26196,fd=3))  
tcp     LISTEN   0        4096           127.0.0.1:10259             0.0.0.0:*      users:(("kube-scheduler",pid=16145,fd=3))   
tcp     LISTEN   0        4096           127.0.0.1:45203             0.0.0.0:*      users:(("containerd",pid=1252,fd=16))       
tcp     LISTEN   0        4096       127.0.0.53%lo:domain            0.0.0.0:*      users:(("systemd-resolve",pid=576,fd=14))   
tcp     LISTEN   0        4096          127.0.0.11:37045             0.0.0.0:*                                                  
tcp     LISTEN   0        128              0.0.0.0:ssh               0.0.0.0:*      users:(("sshd",pid=1266,fd=3))              
tcp     LISTEN   0        4096                   *:10250                   *:*      users:(("kubelet",pid=4280,fd=20))          
tcp     LISTEN   0        4096                   *:6443                    *:*      users:(("kube-apiserver",pid=3716,fd=3))    
tcp     LISTEN   0        4096                   *:10256                   *:*      users:(("kube-proxy",pid=4867,fd=16))       
tcp     LISTEN   0        128                 [::]:ssh                  [::]:*      users:(("sshd",pid=1266,fd=4))              
tcp     LISTEN   0        4096                   *:8888                    *:*      users:(("kubectl",pid=4524,fd=3))           

controlplane ~ ➜  


controlplane ~ ➜  kubectl logs pod/kube-controller-manager-controlplane -n kube-system
I0530 01:44:00.283970       1 serving.go:380] Generated self-signed cert in-memory
E0530 01:44:00.286285       1 run.go:74] "command failed" err="failed to create listener: failed to listen on 127.0.0.1:10257: listen tcp 127.0.0.1:10257: bind: address already in use"



controlplane ~ ➜  kubectl get pods -o wide
NAME                   READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
app-5646649cc9-cvmnm   1/1     Running   0          24m     10.244.0.4   controlplane   <none>           <none>
app-5646649cc9-p8kpk   1/1     Running   0          7m12s   10.244.0.5   controlplane   <none>           <none>
app-5646649cc9-t7qt6   1/1     Running   0          5m29s   10.244.0.6   controlplane   <none>           <none>

controlplane ~ ➜  kubectl get pods -o wide -A
NAMESPACE      NAME                                   READY   STATUS             RESTARTS        AGE     IP            NODE           NOMINATED NODE   READINESS GATES
default        app-5646649cc9-cvmnm                   1/1     Running            0               24m     10.244.0.4    controlplane   <none>           <none>
default        app-5646649cc9-p8kpk                   1/1     Running            0               7m16s   10.244.0.5    controlplane   <none>           <none>
default        app-5646649cc9-t7qt6                   1/1     Running            0               5m33s   10.244.0.6    controlplane   <none>           <none>
kube-flannel   kube-flannel-ds-2rpsp                  1/1     Running            0               33m     192.2.239.6   controlplane   <none>           <none>
kube-system    coredns-69f9c977-8nbbx                 1/1     Running            0               33m     10.244.0.2    controlplane   <none>           <none>
kube-system    coredns-69f9c977-xtj2l                 1/1     Running            0               33m     10.244.0.3    controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running            0               34m     192.2.239.6   controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running            0               34m     192.2.239.6   controlplane   <none>           <none>
kube-system    kube-controller-manager                1/1     Running            4 (6m46s ago)   7m33s   192.2.239.6   controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   0/1     CrashLoopBackOff   6 (32s ago)     6m29s   192.2.239.6   controlplane   <none>           <none>
kube-system    kube-proxy-kt6cb                       1/1     Running            0               33m     192.2.239.6   controlplane   <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running            0               16m     192.2.239.6   controlplane   <none>           <none>

controlplane ~ ➜  


kubectl delete pod -nkube-system    kube-controller-manager



controlplane ~ ➜  kubectl delete pod -nkube-system    kube-controller-manager
pod "kube-controller-manager" deleted

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  ss -tulp
Netid   State    Recv-Q   Send-Q     Local Address:Port         Peer Address:Port  Process                                      
udp     UNCONN   0        0          127.0.0.53%lo:domain            0.0.0.0:*      users:(("systemd-resolve",pid=576,fd=13))   
udp     UNCONN   0        0                0.0.0.0:8472              0.0.0.0:*                                                  
udp     UNCONN   0        0             127.0.0.11:43419             0.0.0.0:*                                                  
tcp     LISTEN   0        4096           127.0.0.1:10248             0.0.0.0:*      users:(("kubelet",pid=4280,fd=12))          
tcp     LISTEN   0        4096           127.0.0.1:10249             0.0.0.0:*      users:(("kube-proxy",pid=4867,fd=8))        
tcp     LISTEN   0        4096         192.2.239.6:2379              0.0.0.0:*      users:(("etcd",pid=3719,fd=9))              
tcp     LISTEN   0        4096           127.0.0.1:2379              0.0.0.0:*      users:(("etcd",pid=3719,fd=8))              
tcp     LISTEN   0        4096         192.2.239.6:2380              0.0.0.0:*      users:(("etcd",pid=3719,fd=7))              
tcp     LISTEN   0        4096           127.0.0.1:2381              0.0.0.0:*      users:(("etcd",pid=3719,fd=16))             
tcp     LISTEN   0        128              0.0.0.0:http-alt          0.0.0.0:*      users:(("ttyd",pid=1246,fd=12))             
tcp     LISTEN   0        4096           127.0.0.1:10259             0.0.0.0:*      users:(("kube-scheduler",pid=16145,fd=3))   
tcp     LISTEN   0        4096           127.0.0.1:45203             0.0.0.0:*      users:(("containerd",pid=1252,fd=16))       
tcp     LISTEN   0        4096       127.0.0.53%lo:domain            0.0.0.0:*      users:(("systemd-resolve",pid=576,fd=14))   
tcp     LISTEN   0        4096          127.0.0.11:37045             0.0.0.0:*                                                  
tcp     LISTEN   0        128              0.0.0.0:ssh               0.0.0.0:*      users:(("sshd",pid=1266,fd=3))              
tcp     LISTEN   0        4096                   *:10250                   *:*      users:(("kubelet",pid=4280,fd=20))          
tcp     LISTEN   0        4096                   *:6443                    *:*      users:(("kube-apiserver",pid=3716,fd=3))    
tcp     LISTEN   0        4096                   *:10256                   *:*      users:(("kube-proxy",pid=4867,fd=16))       
tcp     LISTEN   0        128                 [::]:ssh                  [::]:*      users:(("sshd",pid=1266,fd=4))              
tcp     LISTEN   0        4096                   *:8888                    *:*      users:(("kubectl",pid=4524,fd=3))           

controlplane ~ ➜  


controlplane ~ ➜  kubectl delete pod -nkube-system   kube-controller-manager-controlplane
pod "kube-controller-manager-controlplane" deleted

controlplane ~ ➜  kubectl delete -f /etc/kubernetes/manifests/kube-controller-manager.yaml 
Error from server (NotFound): error when deleting "/etc/kubernetes/manifests/kube-controller-manager.yaml": pods "kube-controller-manager" not found

controlplane ~ ✖ kubectl apply -f /etc/kubernetes/manifests/kube-controller-manager.yaml 
pod/kube-controller-manager created

controlplane ~ ➜  kubectl get pods -o wide -A
NAMESPACE      NAME                                   READY   STATUS             RESTARTS        AGE     IP            NODE           NOMINATED NODE   READINESS GATES
default        app-5646649cc9-cvmnm                   1/1     Running            0               26m     10.244.0.4    controlplane   <none>           <none>
default        app-5646649cc9-p8kpk                   1/1     Running            0               8m58s   10.244.0.5    controlplane   <none>           <none>
default        app-5646649cc9-t7qt6                   1/1     Running            0               7m15s   10.244.0.6    controlplane   <none>           <none>
kube-flannel   kube-flannel-ds-2rpsp                  1/1     Running            0               35m     192.2.239.6   controlplane   <none>           <none>
kube-system    coredns-69f9c977-8nbbx                 1/1     Running            0               35m     10.244.0.2    controlplane   <none>           <none>
kube-system    coredns-69f9c977-xtj2l                 1/1     Running            0               35m     10.244.0.3    controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running            0               35m     192.2.239.6   controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running            0               35m     192.2.239.6   controlplane   <none>           <none>
kube-system    kube-controller-manager                0/1     Error              0               4s      192.2.239.6   controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   0/1     CrashLoopBackOff   6 (2m14s ago)   20s     192.2.239.6   controlplane   <none>           <none>
kube-system    kube-proxy-kt6cb                       1/1     Running            0               35m     192.2.239.6   controlplane   <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running            0               17m     192.2.239.6   controlplane   <none>           <none>

controlplane ~ ➜  




controlplane ~ ➜  kubectl get pods -n kube-system
NAME                                   READY   STATUS             RESTARTS      AGE
coredns-69f9c977-8nbbx                 1/1     Running            0             38m
coredns-69f9c977-xtj2l                 1/1     Running            0             38m
etcd-controlplane                      1/1     Running            0             38m
kube-apiserver-controlplane            1/1     Running            0             38m
kube-controller-manager                0/1     CrashLoopBackOff   4 (69s ago)   2m50s
kube-controller-manager-controlplane   0/1     CrashLoopBackOff   6 (5m ago)    3m6s
kube-proxy-kt6cb                       1/1     Running            0             38m
kube-scheduler-controlplane            1/1     Running            0             20m

controlplane ~ ➜  kubectl logs kube-controller-manager -n kube-system
I0530 01:52:02.082789       1 serving.go:380] Generated self-signed cert in-memory
E0530 01:52:03.046036       1 run.go:74] "command failed" err="unable to load client CA provider: open /etc/kubernetes/pki/ca.crt: no such file or directory"


controlplane ~ ➜  kubectl logs -n kube-system kube-controller-manager-controlplane
I0530 01:53:24.673559       1 serving.go:380] Generated self-signed cert in-memory
E0530 01:53:25.262415       1 run.go:74] "command failed" err="unable to load client CA provider: open /etc/kubernetes/pki/ca.crt: no such file or directory"

controlplane ~ ➜  


controlplane ~ ➜  ls /etc/kubernetes/pki
apiserver.crt              apiserver.key                 ca.crt  front-proxy-ca.crt      front-proxy-client.key
apiserver-etcd-client.crt  apiserver-kubelet-client.crt  ca.key  front-proxy-ca.key      sa.key
apiserver-etcd-client.key  apiserver-kubelet-client.key  etcd    front-proxy-client.crt  sa.pub

controlplane ~ ➜  


cat /etc/kubernetes/manifests/kube-controller-manager.yaml 
cat /etc/kubernetes/manifests/kube-controller-manager.yaml | grep ca
vi /etc/kubernetes/manifests/kube-controller-manager.yaml 


controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-controller-manager.yaml | grep ca
    - --allocate-node-cidrs=true
    - --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
    - --cluster-signing-key-file=/etc/kubernetes/pki/ca.key
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --root-ca-file=/etc/kubernetes/pki/ca.crt
      name: ca-certs
    - mountPath: /etc/ca-certificates
      name: etc-ca-certificates
    - mountPath: /usr/local/share/ca-certificates
      name: usr-local-share-ca-certificates
    - mountPath: /usr/share/ca-certificates
      name: usr-share-ca-certificates
  priorityClassName: system-node-critical
    name: ca-certs
      path: /etc/ca-certificates
    name: etc-ca-certificates
      path: /usr/local/share/ca-certificates
    name: usr-local-share-ca-certificates
      path: /usr/share/ca-certificates
    name: usr-share-ca-certificates

controlplane ~ ➜  kubectl delete pod  -n kube-system kube-controller-manager-controlplane
pod "kube-controller-manager-controlplane" deleted

controlplane ~ ➜  kubectl delete pod  -n kube-system kube-controller-manage
Error from server (NotFound): pods "kube-controller-manage" not found

controlplane ~ ✖ kubectl delete pod  -n kube-system kube-controller-manager
pod "kube-controller-manager" deleted

controlplane ~ ➜  kubectl get pods -n kube-system
NAME                                   READY   STATUS             RESTARTS     AGE
coredns-69f9c977-8nbbx                 1/1     Running            0            41m
coredns-69f9c977-xtj2l                 1/1     Running            0            41m
etcd-controlplane                      1/1     Running            0            41m
kube-apiserver-controlplane            1/1     Running            0            41m
kube-controller-manager-controlplane   0/1     CrashLoopBackOff   7 (3m ago)   12s
kube-proxy-kt6cb                       1/1     Running            0            41m
kube-scheduler-controlplane            1/1     Running            0            23m

controlplane ~ ➜  


controlplane ~ ➜  kubectl logs -n kube-system kube-controller-manager-controlplane
I0530 01:53:24.673559       1 serving.go:380] Generated self-signed cert in-memory
E0530 01:53:25.262415       1 run.go:74] "command failed" err="unable to load client CA provider: open /etc/kubernetes/pki/ca.crt: no such file or directory"

controlplane ~ ➜  

re visar


    name: flexvolume-dir
  - hostPath:
      path: /etc/kubernetes/WRONG-PKI-DIRECTORY
      type: DirectoryOrCreate



cat /etc/kubernetes/manifests/kube-controller-manager.yaml 
cat /etc/kubernetes/manifests/kube-controller-manager.yaml | grep ca
vi /etc/kubernetes/manifests/kube-controller-manager.yaml 

controlplane ~ ➜  vi /etc/kubernetes/manifests/kube-controller-manager.yaml 

controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-controller-manager.yaml | grep pki
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
    - --cluster-signing-key-file=/etc/kubernetes/pki/ca.key
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --root-ca-file=/etc/kubernetes/pki/ca.crt
    - --service-account-private-key-file=/etc/kubernetes/pki/sa.key
    - mountPath: /etc/kubernetes/pki
      path: /etc/kubernetes/pki

controlplane ~ ➜  



controlplane ~ ➜  kubectl get pod  -n kube-system kube-controller-manager-controlplane
NAME                                   READY   STATUS    RESTARTS   AGE
kube-controller-manager-controlplane   0/1     Running   0          15s

controlplane ~ ➜  date
Thu May 30 01:59:17 AM UTC 2024

controlplane ~ ➜  

- SOLUÇÃO4
AJUSTAR O path
path: /etc/kubernetes/WRONG-PKI-DIRECTORY
vi /etc/kubernetes/manifests/kube-controller-manager.yaml 




