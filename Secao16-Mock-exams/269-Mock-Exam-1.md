#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "269. Mock Exam - 1."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
##  269. Mock Exam - 1


### 1 / 12
Weight: 6

Deploy a pod named nginx-pod using the nginx:alpine image.

Once done, click on the Next Question button in the top right corner of this panel. You may navigate back and forth freely between all questions. Once done with all questions, click on End Exam. Your work will be validated at the end and score shown. Good Luck!

Name: nginx-pod

Image: nginx:alpine


~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    ports:
    - containerPort: 80
~~~~

controlplane ~ ➜  vi pod.yaml

controlplane ~ ➜  kubectl apply -f pod.yaml
pod/nginx-pod created

controlplane ~ ➜  







### 2 / 12
Weight: 8

Deploy a messaging pod using the redis:alpine image with the labels set to tier=msg.

Pod Name: messaging

Image: redis:alpine

Labels: tier=msg


Exemplo

For example, here's a manifest for a Pod that has two labels environment: production and app: nginx:
~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: label-demo
  labels:
    environment: production
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
~~~~

- Ajustado:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: messaging
  labels:
    tier: msg
spec:
  containers:
  - name: redis
    image: redis:alpine
~~~~

controlplane ~ ➜  vi pod2.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod2.yaml
pod/messaging created

controlplane ~ ➜  
controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        messaging                              1/1     Running   0          12s
default        nginx-pod                              1/1     Running   0          4m1s
kube-flannel   kube-flannel-ds-m5kjn                  1/1     Running   0          60m
kube-system    coredns-77d6fd4654-65pnt               1/1     Running   0          60m
kube-system    coredns-77d6fd4654-vst2t               1/1     Running   0          60m
kube-system    etcd-controlplane                      1/1     Running   0          60m
kube-system    kube-apiserver-controlplane            1/1     Running   0          60m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          60m
kube-system    kube-proxy-784nm                       1/1     Running   0          60m
kube-system    kube-scheduler-controlplane            1/1     Running   0          60m

controlplane ~ ➜  









### 3 / 12
Weight: 4

Create a namespace named apx-x9984574.

Namespace: apx-x9984574


kubectl create ns apx-x9984574


controlplane ~ ➜  kubectl create ns apx-x9984574
namespace/apx-x9984574 created

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get ns
NAME              STATUS   AGE
apx-x9984574      Active   4s
default           Active   62m
kube-flannel      Active   62m
kube-node-lease   Active   62m
kube-public       Active   62m
kube-system       Active   62m

controlplane ~ ➜  






### 4 / 12
Weight: 7

Get the list of nodes in JSON format and store it in a file at /opt/outputs/nodes-z3444kd9.json.

Task completed


kubectl get nodes -o json > /opt/outputs/nodes-z3444kd9.json


controlplane ~ ➜  kubectl get nodes -o json > /opt/outputs/nodes-z3444kd9.json

controlplane ~ ➜  






### 5 / 12
Weight: 12

Create a service messaging-service to expose the messaging application within the cluster on port 6379.

Use imperative commands.

Service: messaging-service

Port: 6379

Type: ClusterIp

Use the right labels


Exemplo:

apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app.kubernetes.io/name: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376

- Ajustado:

~~~~yaml
apiVersion: v1
kind: Service
metadata:
  name: messaging-service
spec:
  selector:
    tier: msg
  ports:
    - protocol: TCP
      port: 6379
      targetPort: 6379
~~~~



controlplane ~ ➜  vi service.yaml

controlplane ~ ➜  kubectl apply -f service.yaml
service/messaging-service created

controlplane ~ ➜  








### 6 / 12
Weight: 11

Create a deployment named hr-web-app using the image kodekloud/webapp-color with 2 replicas.

Name: hr-web-app

Image: kodekloud/webapp-color

Replicas: 2


Exemplo:

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80



- Ajustado:

~~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hr-web-app
  labels:
    app: hr-web
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hr-web
  template:
    metadata:
      labels:
        app: hr-web
    spec:
      containers:
      - name: hr-web
        image: kodekloud/webapp-color
        resources:
          limits:
            memory: "512Mi"
            cpu: "500m"
          requests:
            memory: "256Mi"
            cpu: "250m"

~~~~

controlplane ~ ➜  vi deployment.yaml

controlplane ~ ➜  kubectl apply -f deployment.yaml
deployment.apps/hr-web-app created

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        hr-web-app-7db4688c6c-22jt9            1/1     Running   0          6s
default        hr-web-app-7db4688c6c-vlg45            1/1     Running   0          6s
default        messaging                              1/1     Running   0          9m27s
default        nginx-pod                              1/1     Running   0          13m
kube-flannel   kube-flannel-ds-m5kjn                  1/1     Running   0          69m
kube-system    coredns-77d6fd4654-65pnt               1/1     Running   0          69m
kube-system    coredns-77d6fd4654-vst2t               1/1     Running   0          69m
kube-system    etcd-controlplane                      1/1     Running   0          69m
kube-system    kube-apiserver-controlplane            1/1     Running   0          70m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          69m
kube-system    kube-proxy-784nm                       1/1     Running   0          69m
kube-system    kube-scheduler-controlplane            1/1     Running   0          70m

controlplane ~ ➜  date
Fri Nov  1 12:48:50 AM UTC 2024

controlplane ~ ➜  








### 7 / 12
Weight: 8

Create a static pod named static-busybox on the controlplane node that uses the busybox image and the command sleep 1000.

Name: static-busybox

Image: busybox


<https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/>

Choose a directory, say /etc/kubernetes/manifests and place a web server Pod definition there, for example /etc/kubernetes/manifests/static-web.yaml:

# Run this command on the node where kubelet is running
mkdir -p /etc/kubernetes/manifests/
cat <<EOF >/etc/kubernetes/manifests/static-web.yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-busybox
  labels:
    role: myrole
spec:
  containers:
    - name: busybox
      image: busybox
EOF



controlplane ~ ➜  mkdir -p /etc/kubernetes/manifests/
cat <<EOF >/etc/kubernetes/manifests/static-web.yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-busybox
  labels:
    role: myrole
spec:
  containers:
    - name: busybox
      image: busybox
EOF

controlplane ~ ➜  cat ^[[200~>/etc/kubernetes/manifests/static-web.yaml~^C

controlplane ~ ✖ cat /etc/kubernetes/manifests/static-web.yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-busybox
  labels:
    role: myrole
spec:
  containers:
    - name: busybox
      image: busybox

controlplane ~ ➜  












### 8 / 12
Weight: 12

Create a POD in the finance namespace named temp-bus with the image redis:alpine.

Name: temp-bus

Image Name: redis:alpine



controlplane ~ ➜  vi pod3.yaml

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod3.yaml
pod/temp-bus created

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS      RESTARTS      AGE
default        hr-web-app-7db4688c6c-22jt9            1/1     Running     0             5m5s
default        hr-web-app-7db4688c6c-vlg45            1/1     Running     0             5m5s
default        messaging                              1/1     Running     0             14m
default        nginx-pod                              1/1     Running     0             18m
default        static-busybox-controlplane            0/1     Completed   4 (55s ago)   109s
finance        temp-bus                               1/1     Running     0             4s
kube-flannel   kube-flannel-ds-m5kjn                  1/1     Running     0             74m
kube-system    coredns-77d6fd4654-65pnt               1/1     Running     0             74m
kube-system    coredns-77d6fd4654-vst2t               1/1     Running     0             74m
kube-system    etcd-controlplane                      1/1     Running     0             74m
kube-system    kube-apiserver-controlplane            1/1     Running     0             74m
kube-system    kube-controller-manager-controlplane   1/1     Running     0             74m
kube-system    kube-proxy-784nm                       1/1     Running     0             74m
kube-system    kube-scheduler-controlplane            1/1     Running     0             74m

controlplane ~ ➜  











### 9 / 12
Weight: 8

A new application orange is deployed. There is something wrong with it. Identify and fix the issue.

Issue fixed



controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS                  RESTARTS      AGE
default        hr-web-app-7db4688c6c-22jt9            1/1     Running                 0             5m39s
default        hr-web-app-7db4688c6c-vlg45            1/1     Running                 0             5m39s
default        messaging                              1/1     Running                 0             15m
default        nginx-pod                              1/1     Running                 0             18m
default        orange                                 0/1     Init:CrashLoopBackOff   1 (12s ago)   15s
default        static-busybox-controlplane            0/1     CrashLoopBackOff        4 (48s ago)   2m23s
finance        temp-bus                               1/1     Running                 0             38s
kube-flannel   kube-flannel-ds-m5kjn                  1/1     Running                 0             75m
kube-system    coredns-77d6fd4654-65pnt               1/1     Running                 0             75m
kube-system    coredns-77d6fd4654-vst2t               1/1     Running                 0             75m
kube-system    etcd-controlplane                      1/1     Running                 0             75m
kube-system    kube-apiserver-controlplane            1/1     Running                 0             75m
kube-system    kube-controller-manager-controlplane   1/1     Running                 0             75m
kube-system    kube-proxy-784nm                       1/1     Running                 0             75m
kube-system    kube-scheduler-controlplane            1/1     Running                 0             75m

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe pod orange
Name:             orange
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.1.16.9
Start Time:       Fri, 01 Nov 2024 00:54:05 +0000
Labels:           <none>
Annotations:      <none>
Status:           Pending
IP:               10.244.0.10
IPs:
  IP:  10.244.0.10
Init Containers:
  init-myservice:
    Container ID:  containerd://d2bfde1be6a1b1403fe5d4f8bc4963e3116741743813ae0a88337170f39e0a63
    Image:         busybox
    Image ID:      docker.io/library/busybox@sha256:768e5c6f5cb6db0794eec98dc7a967f40631746c32232b78a3105fb946f3ab83
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      sleeeep 2;
    State:          Terminated
      Reason:       Error
      Exit Code:    127
      Started:      Fri, 01 Nov 2024 00:54:25 +0000
      Finished:     Fri, 01 Nov 2024 00:54:25 +0000
    Last State:     Terminated
      Reason:       Error
      Exit Code:    127
      Started:      Fri, 01 Nov 2024 00:54:08 +0000
      Finished:     Fri, 01 Nov 2024 00:54:08 +0000
    Ready:          False
    Restart Count:  2
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-n69wx (ro)
Containers:
  orange-container:
    Container ID:  
    Image:         busybox:1.28
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      echo The app is running! && sleep 3600
    State:          Waiting
      Reason:       PodInitializing
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-n69wx (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 False 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-n69wx:
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
  Type     Reason     Age               From               Message
  ----     ------     ----              ----               -------
  Normal   Scheduled  27s               default-scheduler  Successfully assigned default/orange to controlplane
  Normal   Pulled     26s               kubelet            Successfully pulled image "busybox" in 260ms (260ms including waiting). Image size: 2166802 bytes.
  Normal   Pulling    8s (x3 over 26s)  kubelet            Pulling image "busybox"
  Normal   Created    7s (x3 over 26s)  kubelet            Created container init-myservice
  Normal   Started    7s (x3 over 25s)  kubelet            Started container init-myservice
  Normal   Pulled     7s (x2 over 25s)  kubelet            Successfully pulled image "busybox" in 171ms (171ms including waiting). Image size: 2166802 bytes.
  Warning  BackOff    7s (x3 over 24s)  kubelet            Back-off restarting failed container init-myservice in pod orange_default(6fef656e-cf16-479a-a809-740c02376fcb)

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pod orange -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2024-11-01T00:54:05Z"
  name: orange
  namespace: default
  resourceVersion: "6545"
  uid: 6fef656e-cf16-479a-a809-740c02376fcb
spec:
  containers:
  - command:
    - sh
    - -c
    - echo The app is running! && sleep 3600
    image: busybox:1.28
    imagePullPolicy: IfNotPresent
    name: orange-container
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-n69wx
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  initContainers:
  - command:
    - sh
    - -c
    - sleeeep 2;
    image: busybox
    imagePullPolicy: Always
    name: init-myservice
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-n69wx
      readOnly: true
  nodeName: controlplane
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: kube-api-access-n69wx
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2024-11-01T00:54:07Z"
    status: "True"
    type: PodReadyToStartContainers
  - lastProbeTime: null
    lastTransitionTime: "2024-11-01T00:54:05Z"
    message: 'containers with incomplete status: [init-myservice]'
    reason: ContainersNotInitialized
    status: "False"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2024-11-01T00:54:05Z"
    message: 'containers with unready status: [orange-container]'
    reason: ContainersNotReady
    status: "False"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2024-11-01T00:54:05Z"
    message: 'containers with unready status: [orange-container]'
    reason: ContainersNotReady
    status: "False"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2024-11-01T00:54:05Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - image: busybox:1.28
    imageID: ""
    lastState: {}
    name: orange-container
    ready: false
    restartCount: 0
    started: false
    state:
      waiting:
        reason: PodInitializing
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-n69wx
      readOnly: true
      recursiveReadOnly: Disabled
  hostIP: 192.1.16.9
  hostIPs:
  - ip: 192.1.16.9
  initContainerStatuses:
  - containerID: containerd://7f93cb17eb71dbf9b763cf914eb03edb4d943d8708ef8c08943a3ade50aff8a2
    image: docker.io/library/busybox:latest
    imageID: docker.io/library/busybox@sha256:768e5c6f5cb6db0794eec98dc7a967f40631746c32232b78a3105fb946f3ab83
    lastState:
      terminated:
        containerID: containerd://7f93cb17eb71dbf9b763cf914eb03edb4d943d8708ef8c08943a3ade50aff8a2
        exitCode: 127
        finishedAt: "2024-11-01T00:54:55Z"
        reason: Error
        startedAt: "2024-11-01T00:54:55Z"
    name: init-myservice
    ready: false
    restartCount: 3
    started: false
    state:
      waiting:
        message: back-off 40s restarting failed container=init-myservice pod=orange_default(6fef656e-cf16-479a-a809-740c02376fcb)
        reason: CrashLoopBackOff
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-n69wx
      readOnly: true
      recursiveReadOnly: Disabled
  phase: Pending
  podIP: 10.244.0.10
  podIPs:
  - ip: 10.244.0.10
  qosClass: BestEffort
  startTime: "2024-11-01T00:54:05Z"

controlplane ~ ➜  




  initContainers:
  - command:
    - sh
    - -c
    - sleeeep 2;




ease edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
# pods "orange" was not valid:
# * spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`,`spec.initContainers[*].image`,`spec.activeDeadlineSeconds`,`spec.tolerations` (only additions to existing tolerations),`spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
#   core.PodSpec{
#     Volumes: {{Name: "kube-api-access-n69wx", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}}},
#     InitContainers: []core.Container{
#       {
#         Name:  "init-myservice",
#         Image: "busybox",
#         Command: []string{
#           "sh",
#           "-c",
# -         "sleeeep 2;",
# +         "sleep 2",
#         },
#         Args:       nil,
#         WorkingDir: "",
#         ... // 19 identical fields
#       },
#     },
#     Containers:          {{Name: "orange-container", Image: "busybox:1.28", Command: {"sh", "-c", "echo The app is running! && sleep 3600"}, VolumeMounts: {{Name: "kube-api-access-n69wx", ReadOnly: true, MountPath: "/var/run/secrets/kubernetes.io/serviceaccount"}}, ...}},
#     EphemeralContainers: nil,
#     ... // 29 identical fields
#   }




controlplane ~ ✖ kubectl edit pod orange 
error: pods "orange" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-2650043151.yaml"
error: Edit cancelled, no valid changes were saved.

controlplane ~ ✖ vi pod9.yaml

controlplane ~ ➜  kubectl delete pod orange 
pod "orange" deleted
^[[A^[[A
controlplane ~ ➜  kubectl apply -f pod9.yaml
pod/orange created

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS             RESTARTS        AGE
default        hr-web-app-7db4688c6c-22jt9            1/1     Running            0               11m
default        hr-web-app-7db4688c6c-vlg45            1/1     Running            0               11m
default        messaging                              1/1     Running            0               20m
default        nginx-pod                              1/1     Running            0               24m
default        orange                                 1/1     Running            0               16s
default        static-busybox-controlplane            0/1     CrashLoopBackOff   6 (2m29s ago)   8m17s
finance        temp-bus                               1/1     Running            0               6m32s
kube-flannel   kube-flannel-ds-m5kjn                  1/1     Running            0               81m
kube-system    coredns-77d6fd4654-65pnt               1/1     Running            0               81m
kube-system    coredns-77d6fd4654-vst2t               1/1     Running            0               81m
kube-system    etcd-controlplane                      1/1     Running            0               81m
kube-system    kube-apiserver-controlplane            1/1     Running            0               81m
kube-system    kube-controller-manager-controlplane   1/1     Running            0               81m
kube-system    kube-proxy-784nm                       1/1     Running            0               81m
kube-system    kube-scheduler-controlplane            1/1     Running            0               81m

controlplane ~ ➜  












### 10 / 12
Weight: 10

Expose the hr-web-app created in the previous task as a service named hr-web-app-service, accessible on port 30082 on the nodes of the cluster.

The web application listens on port 8080.

Name: hr-web-app-service

Type: NodePort

Endpoints: 2

Port: 8080

NodePort: 30082



controlplane ~ ➜  vi service10.yaml

controlplane ~ ➜  kubectl apply -f service10.yaml
Error from server (BadRequest): error when creating "service10.yaml": Service in version "v1" cannot be handled as a Service: strict decoding error: unknown field "spec.Type"

controlplane ~ ✖ vi service10.yaml

controlplane ~ ➜  kubectl apply -f service10.yaml
service/hr-web-app-service created

controlplane ~ ➜  

controlplane ~ ➜  kubectl get svc
NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
hr-web-app-service   NodePort    10.99.93.197   <none>        8080:30082/TCP   15s
kubernetes           ClusterIP   10.96.0.1      <none>        443/TCP          85m
messaging-service    ClusterIP   10.109.60.51   <none>        6379/TCP         18m

controlplane ~ ➜  







### 11 / 12
Weight: 6

Use JSON PATH query to retrieve the osImages of all the nodes and store it in a file /opt/outputs/nodes_os_x43kj56.txt.

The osImage are under the nodeInfo section under status of each node.

Task Completed


/opt/outputs/nodes_os_x43kj56.txt

controlplane ~ ➜  

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   86m   v1.31.0

controlplane ~ ➜  kubectl get nodes -o json
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "v1",
            "kind": "Node",
            "metadata": {
                "annotations": {
                    "flannel.alpha.coreos.com/backend-data": "{\"VNI\":1,\"VtepMAC\":\"ca:d0:13:74:eb:9e\"}",
                    "flannel.alpha.coreos.com/backend-type": "vxlan",
                    "flannel.alpha.coreos.com/kube-subnet-manager": "true",
                    "flannel.alpha.coreos.com/public-ip": "192.1.16.9",
                    "kubeadm.alpha.kubernetes.io/cri-socket": "unix:///var/run/containerd/containerd.sock",
                    "node.alpha.kubernetes.io/ttl": "0",
                    "volumes.kubernetes.io/controller-managed-attach-detach": "true"
                },
                "creationTimestamp": "2024-10-31T23:38:46Z",
                "labels": {
                    "beta.kubernetes.io/arch": "amd64",
                    "beta.kubernetes.io/os": "linux",
                    "kubernetes.io/arch": "amd64",
                    "kubernetes.io/hostname": "controlplane",
                    "kubernetes.io/os": "linux",
                    "node-role.kubernetes.io/control-plane": "",
                    "node.kubernetes.io/exclude-from-external-load-balancers": ""
                },
                "name": "controlplane",
                "resourceVersion": "6992",
                "uid": "df23008f-5278-4925-8d87-e8707c78199c"
            },
            "spec": {
                "podCIDR": "10.244.0.0/24",
                "podCIDRs": [
                    "10.244.0.0/24"
                ]
            },
            "status": {
                "addresses": [
                    {
                        "address": "192.1.16.9",
                        "type": "InternalIP"
                    },
                    {
                        "address": "controlplane",
                        "type": "Hostname"
                    }
                ],
                "allocatable": {
                    "cpu": "36",
                    "ephemeral-storage": "936398358207",
                    "hugepages-1Gi": "0",
                    "hugepages-2Mi": "0",
                    "memory": "214484656Ki",
                    "pods": "110"
                },
                "capacity": {
                    "cpu": "36",
                    "ephemeral-storage": "1016057248Ki",
                    "hugepages-1Gi": "0",
                    "hugepages-2Mi": "0",
                    "memory": "214587056Ki",
                    "pods": "110"
                },
                "conditions": [
                    {
                        "lastHeartbeatTime": "2024-10-31T23:39:02Z",
                        "lastTransitionTime": "2024-10-31T23:39:02Z",
                        "message": "Flannel is running on this node",
                        "reason": "FlannelIsUp",
                        "status": "False",
                        "type": "NetworkUnavailable"
                    },
                    {
                        "lastHeartbeatTime": "2024-11-01T01:00:26Z",
                        "lastTransitionTime": "2024-10-31T23:38:43Z",
                        "message": "kubelet has sufficient memory available",
                        "reason": "KubeletHasSufficientMemory",
                        "status": "False",
                        "type": "MemoryPressure"
                    },
                    {
                        "lastHeartbeatTime": "2024-11-01T01:00:26Z",
                        "lastTransitionTime": "2024-10-31T23:38:43Z",
                        "message": "kubelet has no disk pressure",
                        "reason": "KubeletHasNoDiskPressure",
                        "status": "False",
                        "type": "DiskPressure"
                    },
                    {
                        "lastHeartbeatTime": "2024-11-01T01:00:26Z",
                        "lastTransitionTime": "2024-10-31T23:38:43Z",
                        "message": "kubelet has sufficient PID available",
                        "reason": "KubeletHasSufficientPID",
                        "status": "False",
                        "type": "PIDPressure"
                    },
                    {
                        "lastHeartbeatTime": "2024-11-01T01:00:26Z",
                        "lastTransitionTime": "2024-10-31T23:39:00Z",
                        "message": "kubelet is posting ready status",
                        "reason": "KubeletReady",
                        "status": "True",
                        "type": "Ready"
                    }
                ],
                "daemonEndpoints": {
                    "kubeletEndpoint": {
                        "Port": 10250
                    }
                },
                "images": [
                    {
                        "names": [
                            "docker.io/kodekloud/fluent-ui-running@sha256:78fd68ba8a79adcd3e58897a933492886200be513076ba37f843008cc0168f81",
                            "docker.io/kodekloud/fluent-ui-running:latest"
                        ],
                        "sizeBytes": 389734636
                    },
                    {
                        "names": [
                            "docker.io/library/nginx@sha256:04ba374043ccd2fc5c593885c0eacddebabd5ca375f9323666f28dfd5a9710e3",
                            "docker.io/library/nginx:latest"
                        ],
                        "sizeBytes": 71027698
                    },
                    {
                        "names": [
                            "registry.k8s.io/etcd@sha256:a6dc63e6e8cfa0307d7851762fa6b629afb18f28d8aa3fab5a6e91b4af60026a",
                            "registry.k8s.io/etcd:3.5.15-0"
                        ],
                        "sizeBytes": 56909194
                    },
                    {
                        "names": [
                            "docker.io/kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423",
                            "docker.io/kodekloud/webapp-color:latest"
                        ],
                        "sizeBytes": 31777918
                    },
                    {
                        "names": [
                            "docker.io/weaveworks/weave-kube@sha256:d797338e7beb17222e10757b71400d8471bdbd9be13b5da38ce2ebf597fb4e63",
                            "docker.io/weaveworks/weave-kube:2.8.1"
                        ],
                        "sizeBytes": 30924173
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-proxy@sha256:c727efb1c6f15a68060bf7f207f5c7a765355b7e3340c513e582ec819c5cd2fe",
                            "registry.k8s.io/kube-proxy:v1.31.0"
                        ],
                        "sizeBytes": 30207900
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-apiserver@sha256:470179274deb9dc3a81df55cfc24823ce153147d4ebf2ed649a4f271f51eaddf",
                            "registry.k8s.io/kube-apiserver:v1.31.0"
                        ],
                        "sizeBytes": 28063421
                    },
                    {
                        "names": [
                            "docker.io/flannel/flannel@sha256:c951947891d7811a4da6bf6f2f4dcd09e33c6e1eb6a95022f3f621d00ed4615e",
                            "docker.io/flannel/flannel:v0.23.0"
                        ],
                        "sizeBytes": 28051548
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-controller-manager@sha256:f6f3c33dda209e8434b83dacf5244c03b59b0018d93325ff21296a142b68497d",
                            "registry.k8s.io/kube-controller-manager:v1.31.0"
                        ],
                        "sizeBytes": 26240868
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-scheduler@sha256:96ddae9c9b2e79342e0551e2d2ec422c0c02629a74d928924aaa069706619808",
                            "registry.k8s.io/kube-scheduler:v1.31.0"
                        ],
                        "sizeBytes": 20196722
                    },
                    {
                        "names": [
                            "docker.io/library/nginx@sha256:a5127daff3d6f4606be3100a252419bfa84fd6ee5cd74d0feaca1a5068f97dcf",
                            "docker.io/library/nginx:alpine"
                        ],
                        "sizeBytes": 18593388
                    },
                    {
                        "names": [
                            "registry.k8s.io/coredns/coredns@sha256:1eeb4c7316bacb1d4c8ead65571cd92dd21e27359f0d4917f1a5822a73b75db1",
                            "registry.k8s.io/coredns/coredns:v1.11.1"
                        ],
                        "sizeBytes": 18182961
                    },
                    {
                        "names": [
                            "docker.io/library/redis@sha256:de13e74e14b98eb96bdf886791ae47686c3c5d29f9d5f85ea55206843e3fce26",
                            "docker.io/library/redis:alpine"
                        ],
                        "sizeBytes": 17180115
                    },
                    {
                        "names": [
                            "registry.k8s.io/coredns/coredns@sha256:a0ead06651cf580044aeb0a0feba63591858fb2e43ade8c9dea45a6a89ae7e5e",
                            "registry.k8s.io/coredns/coredns:v1.10.1"
                        ],
                        "sizeBytes": 16190758
                    },
                    {
                        "names": [
                            "docker.io/weaveworks/weave-npc@sha256:38d3e30a97a2260558f8deb0fc4c079442f7347f27c86660dbfc8ca91674f14c",
                            "docker.io/weaveworks/weave-npc:2.8.1"
                        ],
                        "sizeBytes": 12814131
                    },
                    {
                        "names": [
                            "docker.io/flannel/flannel-cni-plugin@sha256:ca6779c6ad63b77af8a00151cefc08578241197b9a6fe144b0e55484bc52b852",
                            "docker.io/flannel/flannel-cni-plugin:v1.2.0"
                        ],
                        "sizeBytes": 3879095
                    },
                    {
                        "names": [
                            "docker.io/library/busybox@sha256:768e5c6f5cb6db0794eec98dc7a967f40631746c32232b78a3105fb946f3ab83",
                            "docker.io/library/busybox:latest"
                        ],
                        "sizeBytes": 2166802
                    },
                    {
                        "names": [
                            "docker.io/library/busybox@sha256:c230832bd3b0be59a6c47ed64294f9ce71e91b327957920b6929a0caa8353140"
                        ],
                        "sizeBytes": 2163277
                    },
                    {
                        "names": [
                            "docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47",
                            "docker.io/library/busybox:1.28"
                        ],
                        "sizeBytes": 727869
                    },
                    {
                        "names": [
                            "registry.k8s.io/pause@sha256:ee6521f290b2168b6e0935a181d4cff9be1ac3f505666ef0e3c98fae8199917a",
                            "registry.k8s.io/pause:3.10"
                        ],
                        "sizeBytes": 320368
                    },
                    {
                        "names": [
                            "registry.k8s.io/pause@sha256:3d380ca8864549e74af4b29c10f9cb0956236dfb01c40ca076fb6c37253234db",
                            "registry.k8s.io/pause:3.6"
                        ],
                        "sizeBytes": 301773
                    }
                ],
                "nodeInfo": {
                    "architecture": "amd64",
                    "bootID": "7dfd1956-c4d6-4e17-8dc1-b662b84ef39a",
                    "containerRuntimeVersion": "containerd://1.6.26",
                    "kernelVersion": "5.4.0-1106-gcp",
                    "kubeProxyVersion": "",
                    "kubeletVersion": "v1.31.0",
                    "machineID": "132e3d2451f947fe9214456160254717",
                    "operatingSystem": "linux",
                    "osImage": "Ubuntu 22.04.4 LTS",
                    "systemUUID": "1a5d0c79-cc3c-637d-7715-d451121a5c1d"
                }
            }
        }
    ],
    "kind": "List",
    "metadata": {
        "resourceVersion": ""
    }
}

controlplane ~ ➜  







kubectl get nodes -o json 


kubectl get pods -o=jsonpath='{.items[0].metadata.name}'

controlplane ~ ➜  kubectl get pods -o=jsonpath='{.items[0].metadata.name}'
hr-web-app-7db4688c6c-22jt9
controlplane ~ ➜  

kubectl get nodes -o=jsonpath='{.items[0].status.nodeInfo.osImage}'


controlplane ~ ➜  kubectl get nodes -o=jsonpath='{.items[0].status.nodeInfo.osImage}'
Ubuntu 22.04.4 LTS
controlplane ~ ➜  


kubectl get nodes -o=jsonpath='{.items[0].status.nodeInfo.osImage}' > /opt/outputs/nodes_os_x43kj56.txt


















### 12 / 12
Weight: 8

Create a Persistent Volume with the given specification: -

Volume name: pv-analytics

Storage: 100Mi

Access mode: ReadWriteMany

Host path: /pv/data-analytics

Is the volume name set?

Is the storage capacity set?

Is the accessMode set?

Is the hostPath set?


Persistent Volumes

Each PV contains a spec and status, which is the specification and status of the volume. The name of a PersistentVolume object must be a valid DNS subdomain name.

apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv0003
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: slow
  mountOptions:
    - hard
    - nfsvers=4.1
  nfs:
    path: /tmp
    server: 172.17.0.2




controlplane ~ ➜  vi pv.yaml

controlplane ~ ➜  kubectl apply -f pv.yaml
persistentvolume/pv-analytics created

controlplane ~ ➜  kubectl get pv
NAME           CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pv-analytics   100Mi      RWX            Retain           Available                          <unset>                          3s

controlplane ~ ➜  