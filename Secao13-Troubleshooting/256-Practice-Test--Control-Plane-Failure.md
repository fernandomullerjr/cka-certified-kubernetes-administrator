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
