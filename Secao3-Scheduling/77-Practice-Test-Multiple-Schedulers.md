
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 77. Practice Test - Multiple Schedulers"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
#  77. Practice Test - Multiple Schedulers


# What is the name of the POD that deploys the default kubernetes scheduler in this environment?

                                             

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
kube-flannel   kube-flannel-ds-bcg9n                  1/1     Running   0          6m24s
kube-system    coredns-787d4945fb-cpngd               1/1     Running   0          6m23s
kube-system    coredns-787d4945fb-gxqn8               1/1     Running   0          6m23s
kube-system    etcd-controlplane                      1/1     Running   0          6m32s
kube-system    kube-apiserver-controlplane            1/1     Running   0          6m32s
kube-system    kube-controller-manager-controlplane   1/1     Running   0          6m36s
kube-system    kube-proxy-6n28d                       1/1     Running   0          6m24s
kube-system    kube-scheduler-controlplane            1/1     Running   0          6m38s

controlplane ~ ➜  kubectl get pods -A | grep sched
kube-system    kube-scheduler-controlplane            1/1     Running   0          6m55s

controlplane ~ ➜  



- RESPOSTA:
  kube-scheduler-controlplane








# What is the image used to deploy the kubernetes scheduler?

Inspect the kubernetes scheduler pod and identify the image



controlplane ~ ➜  kubectl get pod kube-scheduler-controlplane -n kube-system -o yaml | grep image
    image: registry.k8s.io/kube-scheduler:v1.26.0
    imagePullPolicy: IfNotPresent
    image: registry.k8s.io/kube-scheduler:v1.26.0
    imageID: registry.k8s.io/kube-scheduler@sha256:34a142549f94312b41d4a6cd98e7fddabff484767a199333acb7503bf46d7410

controlplane ~ ➜  


- RESPOSTA:
registry.k8s.io/kube-scheduler:v1.26.0











# We have already created the ServiceAccount and ClusterRoleBinding that our custom scheduler will make use of.

Checkout the following Kubernetes objects:

ServiceAccount: my-scheduler (kube-system namespace)
ClusterRoleBinding: my-scheduler-as-kube-scheduler
ClusterRoleBinding: my-scheduler-as-volume-scheduler

Run the command: kubectl get serviceaccount -n kube-system and kubectl get clusterrolebinding

Note: - Don't worry if you are not familiar with these resources. We will cover it later on.


controlplane ~ ➜  kubectl get serviceaccount -n kube-system
NAME                                 SECRETS   AGE
attachdetach-controller              0         8m41s
bootstrap-signer                     0         8m41s
certificate-controller               0         8m41s
clusterrole-aggregation-controller   0         8m39s
coredns                              0         8m47s
cronjob-controller                   0         8m41s
daemon-set-controller                0         8m39s
default                              0         8m38s
deployment-controller                0         8m41s
disruption-controller                0         8m52s
endpoint-controller                  0         8m41s
endpointslice-controller             0         8m52s
endpointslicemirroring-controller    0         8m41s
ephemeral-volume-controller          0         8m41s
expand-controller                    0         8m41s
generic-garbage-collector            0         8m41s
horizontal-pod-autoscaler            0         8m51s
job-controller                       0         8m39s
kube-proxy                           0         8m47s
my-scheduler                         0         30s
namespace-controller                 0         8m41s
node-controller                      0         8m51s
persistent-volume-binder             0         8m41s
pod-garbage-collector                0         8m52s
pv-protection-controller             0         8m39s
pvc-protection-controller            0         8m40s
replicaset-controller                0         8m51s
replication-controller               0         8m52s
resourcequota-controller             0         8m39s
root-ca-cert-publisher               0         8m41s
service-account-controller           0         8m40s
service-controller                   0         8m40s
statefulset-controller               0         8m51s
token-cleaner                        0         8m41s
ttl-after-finished-controller        0         8m40s
ttl-controller                       0         8m40s

controlplane ~ ➜  



kubectl get clusterrolebinding


controlplane ~ ➜  kubectl get clusterrolebinding
NAME                                                   ROLE                                                                               AGE
cluster-admin                                          ClusterRole/cluster-admin                                                          9m33s
flannel                                                ClusterRole/flannel                                                                9m24s
kubeadm:get-nodes                                      ClusterRole/kubeadm:get-nodes                                                      9m30s
kubeadm:kubelet-bootstrap                              ClusterRole/system:node-bootstrapper                                               9m30s
kubeadm:node-autoapprove-bootstrap                     ClusterRole/system:certificates.k8s.io:certificatesigningrequests:nodeclient       9m30s
kubeadm:node-autoapprove-certificate-rotation          ClusterRole/system:certificates.k8s.io:certificatesigningrequests:selfnodeclient   9m30s
kubeadm:node-proxier                                   ClusterRole/system:node-proxier                                                    9m27s
my-scheduler-as-kube-scheduler                         ClusterRole/system:kube-scheduler                                                  70s
my-scheduler-as-volume-scheduler                       ClusterRole/system:volume-scheduler                                                70s
system:basic-user                                      ClusterRole/system:basic-user                                                      9m33s
system:controller:attachdetach-controller              ClusterRole/system:controller:attachdetach-controller                              9m32s
system:controller:certificate-controller               ClusterRole/system:controller:certificate-controller                               9m32s
system:controller:clusterrole-aggregation-controller   ClusterRole/system:controller:clusterrole-aggregation-controller                   9m32s
system:controller:cronjob-controller                   ClusterRole/system:controller:cronjob-controller                                   9m32s
system:controller:daemon-set-controller                ClusterRole/system:controller:daemon-set-controller                                9m32s
system:controller:deployment-controller                ClusterRole/system:controller:deployment-controller                                9m32s
system:controller:disruption-controller                ClusterRole/system:controller:disruption-controller                                9m32s
system:controller:endpoint-controller                  ClusterRole/system:controller:endpoint-controller                                  9m32s
system:controller:endpointslice-controller             ClusterRole/system:controller:endpointslice-controller                             9m32s
system:controller:endpointslicemirroring-controller    ClusterRole/system:controller:endpointslicemirroring-controller                    9m32s
system:controller:ephemeral-volume-controller          ClusterRole/system:controller:ephemeral-volume-controller                          9m32s
system:controller:expand-controller                    ClusterRole/system:controller:expand-controller                                    9m32s
system:controller:generic-garbage-collector            ClusterRole/system:controller:generic-garbage-collector                            9m32s
system:controller:horizontal-pod-autoscaler            ClusterRole/system:controller:horizontal-pod-autoscaler                            9m32s
system:controller:job-controller                       ClusterRole/system:controller:job-controller                                       9m32s
system:controller:namespace-controller                 ClusterRole/system:controller:namespace-controller                                 9m32s
system:controller:node-controller                      ClusterRole/system:controller:node-controller                                      9m32s
system:controller:persistent-volume-binder             ClusterRole/system:controller:persistent-volume-binder                             9m32s
system:controller:pod-garbage-collector                ClusterRole/system:controller:pod-garbage-collector                                9m32s
system:controller:pv-protection-controller             ClusterRole/system:controller:pv-protection-controller                             9m32s
system:controller:pvc-protection-controller            ClusterRole/system:controller:pvc-protection-controller                            9m32s
system:controller:replicaset-controller                ClusterRole/system:controller:replicaset-controller                                9m32s
system:controller:replication-controller               ClusterRole/system:controller:replication-controller                               9m32s
system:controller:resourcequota-controller             ClusterRole/system:controller:resourcequota-controller                             9m32s
system:controller:root-ca-cert-publisher               ClusterRole/system:controller:root-ca-cert-publisher                               9m32s
system:controller:route-controller                     ClusterRole/system:controller:route-controller                                     9m32s
system:controller:service-account-controller           ClusterRole/system:controller:service-account-controller                           9m32s
system:controller:service-controller                   ClusterRole/system:controller:service-controller                                   9m32s
system:controller:statefulset-controller               ClusterRole/system:controller:statefulset-controller                               9m32s
system:controller:ttl-after-finished-controller        ClusterRole/system:controller:ttl-after-finished-controller                        9m32s
system:controller:ttl-controller                       ClusterRole/system:controller:ttl-controller                                       9m32s
system:coredns                                         ClusterRole/system:coredns                                                         9m27s
system:discovery                                       ClusterRole/system:discovery                                                       9m33s
system:kube-controller-manager                         ClusterRole/system:kube-controller-manager                                         9m33s
system:kube-dns                                        ClusterRole/system:kube-dns                                                        9m33s
system:kube-scheduler                                  ClusterRole/system:kube-scheduler                                                  9m32s
system:monitoring                                      ClusterRole/system:monitoring                                                      9m33s
system:node                                            ClusterRole/system:node                                                            9m32s
system:node-proxier                                    ClusterRole/system:node-proxier                                                    9m33s
system:public-info-viewer                              ClusterRole/system:public-info-viewer                                              9m33s
system:service-account-issuer-discovery                ClusterRole/system:service-account-issuer-discovery                                9m32s
system:volume-scheduler                                ClusterRole/system:volume-scheduler                                                9m32s

controlplane ~ ➜  














# Let's create a configmap that the new scheduler will employ using the concept of ConfigMap as a volume.
We have already given a configMap definition file called my-scheduler-configmap.yaml at /root/ path that will create a configmap with name my-scheduler-config using the content of file /root/my-scheduler-config.yaml.

    ConfigMap my-scheduler-config created ?


controlplane ~ ➜  kubectl get configmap -A
NAMESPACE         NAME                                 DATA   AGE
default           kube-root-ca.crt                     1      10m
kube-flannel      kube-flannel-cfg                     2      10m
kube-flannel      kube-root-ca.crt                     1      10m
kube-node-lease   kube-root-ca.crt                     1      10m
kube-public       cluster-info                         2      10m
kube-public       kube-root-ca.crt                     1      10m
kube-system       coredns                              1      10m
kube-system       extension-apiserver-authentication   6      10m
kube-system       kube-proxy                           2      10m
kube-system       kube-root-ca.crt                     1      10m
kube-system       kubeadm-config                       1      10m
kube-system       kubelet-config                       1      10m

controlplane ~ ➜  ls
my-scheduler-configmap.yaml  my-scheduler-config.yaml  my-scheduler.yaml  nginx-pod.yaml

controlplane ~ ➜  pwd
/root

controlplane ~ ➜  kubectl apply -f my-scheduler-configmap.yaml
configmap/my-scheduler-config created

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get configmap -A
NAMESPACE         NAME                                 DATA   AGE
default           kube-root-ca.crt                     1      10m
kube-flannel      kube-flannel-cfg                     2      10m
kube-flannel      kube-root-ca.crt                     1      10m
kube-node-lease   kube-root-ca.crt                     1      10m
kube-public       cluster-info                         2      10m
kube-public       kube-root-ca.crt                     1      10m
kube-system       coredns                              1      10m
kube-system       extension-apiserver-authentication   6      10m
kube-system       kube-proxy                           2      10m
kube-system       kube-root-ca.crt                     1      10m
kube-system       kubeadm-config                       1      10m
kube-system       kubelet-config                       1      10m
kube-system       my-scheduler-config                  1      5s

controlplane ~ ➜  










# Deploy an additional scheduler to the cluster following the given specification.

Use the manifest file provided at /root/my-scheduler.yaml. Use the same image as used by the default kubernetes scheduler.

    Name: my-scheduler

    Status: Running

    Correct image used?


controlplane ~ ➜  ls
my-scheduler-configmap.yaml  my-scheduler-config.yaml  my-scheduler.yaml  nginx-pod.yaml

controlplane ~ ➜  cat my-scheduler.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: my-scheduler
  name: my-scheduler
  namespace: kube-system
spec:
  serviceAccountName: my-scheduler
  containers:
  - command:
    - /usr/local/bin/kube-scheduler
    - --config=/etc/kubernetes/my-scheduler/my-scheduler-config.yaml
    image: <use-correct-image>
    livenessProbe:
      httpGet:
        path: /healthz
        port: 10259
        scheme: HTTPS
      initialDelaySeconds: 15
    name: kube-second-scheduler
    readinessProbe:
      httpGet:
        path: /healthz
        port: 10259
        scheme: HTTPS
    resources:
      requests:
        cpu: '0.1'
    securityContext:
      privileged: false
    volumeMounts:
      - name: config-volume
        mountPath: /etc/kubernetes/my-scheduler
  hostNetwork: false
  hostPID: false
  volumes:
    - name: config-volume
      configMap:
        name: my-scheduler-config

controlplane ~ ➜  

controlplane ~ ➜  vi my-scheduler.yaml

controlplane ~ ➜  kubectl apply -f my-scheduler.yaml
pod/my-scheduler created

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
kube-flannel   kube-flannel-ds-bcg9n                  1/1     Running   0          12m
kube-system    coredns-787d4945fb-cpngd               1/1     Running   0          12m
kube-system    coredns-787d4945fb-gxqn8               1/1     Running   0          12m
kube-system    etcd-controlplane                      1/1     Running   0          12m
kube-system    kube-apiserver-controlplane            1/1     Running   0          12m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          12m
kube-system    kube-proxy-6n28d                       1/1     Running   0          12m
kube-system    kube-scheduler-controlplane            1/1     Running   0          12m
kube-system    my-scheduler                           1/1     Running   0          5s

controlplane ~ ➜  















# A POD definition file is given. Use it to create a POD with the new custom scheduler.

File is located at /root/nginx-pod.yaml

    Uses custom scheduler

    Status: Running



- Exemplo do meu rascunho:

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    - image: nginx
      name: nginx
  schedulerName: my-scheduler
~~~~



controlplane ~ ➜  ls
my-scheduler-configmap.yaml  my-scheduler-config.yaml  my-scheduler.yaml  nginx-pod.yaml

controlplane ~ ➜  cat nginx-pod.yaml
apiVersion: v1 
kind: Pod 
metadata:
  name: nginx 
spec:
  containers:
  - image: nginx
    name: nginx

controlplane ~ ➜  vi nginx-pod.yaml

controlplane ~ ➜  kubectl apply -f^Cginx-pod.yaml

controlplane ~ ✖ cat nginx-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    - image: nginx
      name: nginx
  schedulerName: my-scheduler


controlplane ~ ➜  kubectl apply -f nginx-pod.yaml
pod/nginx created

controlplane ~ ➜  


controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS              RESTARTS   AGE
default        nginx                                  0/1     ContainerCreating   0          8s
kube-flannel   kube-flannel-ds-bcg9n                  1/1     Running             0          14m
kube-system    coredns-787d4945fb-cpngd               1/1     Running             0          14m
kube-system    coredns-787d4945fb-gxqn8               1/1     Running             0          14m
kube-system    etcd-controlplane                      1/1     Running             0          14m
kube-system    kube-apiserver-controlplane            1/1     Running             0          14m
kube-system    kube-controller-manager-controlplane   1/1     Running             0          14m
kube-system    kube-proxy-6n28d                       1/1     Running             0          14m
kube-system    kube-scheduler-controlplane            1/1     Running             0          14m
kube-system    my-scheduler                           1/1     Running             0          118s

controlplane ~ ➜  kubectl get pods -A | grep nginx
default        nginx                                  1/1     Running   0          17s

controlplane ~ ➜  kubectl get pods -A -o wide | grep nginx
default        nginx                                  1/1     Running   0          22s     10.244.0.5    controlplane   <none>           <none>

controlplane ~ ➜  kubectl get events
LAST SEEN   TYPE      REASON                    OBJECT              MESSAGE
15m         Normal    NodeHasSufficientMemory   node/controlplane   Node controlplane status is now: NodeHasSufficientMemory
15m         Normal    NodeHasNoDiskPressure     node/controlplane   Node controlplane status is now: NodeHasNoDiskPressure
15m         Normal    NodeHasSufficientPID      node/controlplane   Node controlplane status is now: NodeHasSufficientPID
15m         Normal    NodeAllocatableEnforced   node/controlplane   Updated Node Allocatable limit across pods
14m         Normal    Starting                  node/controlplane   Starting kubelet.
14m         Warning   InvalidDiskCapacity       node/controlplane   invalid capacity 0 on image filesystem
14m         Normal    NodeHasSufficientMemory   node/controlplane   Node controlplane status is now: NodeHasSufficientMemory
14m         Normal    NodeHasNoDiskPressure     node/controlplane   Node controlplane status is now: NodeHasNoDiskPressure
14m         Normal    NodeHasSufficientPID      node/controlplane   Node controlplane status is now: NodeHasSufficientPID
14m         Normal    NodeAllocatableEnforced   node/controlplane   Updated Node Allocatable limit across pods
14m         Normal    RegisteredNode            node/controlplane   Node controlplane event: Registered Node controlplane in Controller
14m         Normal    Starting                  node/controlplane   
14m         Normal    NodeReady                 node/controlplane   Node controlplane status is now: NodeReady
31s         Normal    Scheduled                 pod/nginx           Successfully assigned default/nginx to controlplane
29s         Normal    Pulling                   pod/nginx           Pulling image "nginx"
23s         Normal    Pulled                    pod/nginx           Successfully pulled image "nginx" in 5.685410981s (5.685428703s including waiting)
23s         Normal    Created                   pod/nginx           Created container nginx
22s         Normal    Started                   pod/nginx           Started container nginx

controlplane ~ ➜  kubectl get events -o wide
LAST SEEN   TYPE      REASON                    OBJECT              SUBOBJECT                SOURCE                                    MESSAGE                                                                              FIRST SEEN   COUNT   NAME
15m         Normal    NodeHasSufficientMemory   node/controlplane                            kubelet, controlplane                     Node controlplane status is now: NodeHasSufficientMemory                             15m          8       controlplane.173f93c8a5c398dd
15m         Normal    NodeHasNoDiskPressure     node/controlplane                            kubelet, controlplane                     Node controlplane status is now: NodeHasNoDiskPressure                               15m          7       controlplane.173f93c8a5c3bee2
15m         Normal    NodeHasSufficientPID      node/controlplane                            kubelet, controlplane                     Node controlplane status is now: NodeHasSufficientPID                                15m          7       controlplane.173f93c8a5c3e86d
15m         Normal    NodeAllocatableEnforced   node/controlplane                            kubelet, controlplane                     Updated Node Allocatable limit across pods                                           15m          1       controlplane.173f93c8b68c89da
15m         Normal    Starting                  node/controlplane                            kubelet, controlplane                     Starting kubelet.                                                                    15m          1       controlplane.173f93cca2b16635
15m         Warning   InvalidDiskCapacity       node/controlplane                            kubelet, controlplane                     invalid capacity 0 on image filesystem                                               15m          1       controlplane.173f93cca646b79b
15m         Normal    NodeHasSufficientMemory   node/controlplane                            kubelet, controlplane                     Node controlplane status is now: NodeHasSufficientMemory                             15m          1       controlplane.173f93ccac5e0e5f
15m         Normal    NodeHasNoDiskPressure     node/controlplane                            kubelet, controlplane                     Node controlplane status is now: NodeHasNoDiskPressure                               15m          1       controlplane.173f93ccac5e31f8
15m         Normal    NodeHasSufficientPID      node/controlplane                            kubelet, controlplane                     Node controlplane status is now: NodeHasSufficientPID                                15m          1       controlplane.173f93ccac5e47ff
15m         Normal    NodeAllocatableEnforced   node/controlplane                            kubelet, controlplane                     Updated Node Allocatable limit across pods                                           15m          1       controlplane.173f93cce2646c32
15m         Normal    RegisteredNode            node/controlplane                            node-controller                           Node controlplane event: Registered Node controlplane in Controller                  15m          1       controlplane.173f93cea0e78df3
15m         Normal    Starting                  node/controlplane                            kube-proxy, kube-proxy-controlplane                                                                                            15m          1       controlplane.173f93cf6d557ba2
14m         Normal    NodeReady                 node/controlplane                            kubelet, controlplane                     Node controlplane status is now: NodeReady                                           14m          1       controlplane.173f93d097f71587
46s         Normal    Scheduled                 pod/nginx                                    my-scheduler, my-scheduler-my-scheduler   Successfully assigned default/nginx to controlplane                                  46s          1       nginx.173f94964f24e4be
44s         Normal    Pulling                   pod/nginx           spec.containers{nginx}   kubelet, controlplane                     Pulling image "nginx"                                                                44s          1       nginx.173f94970dfd69e5
38s         Normal    Pulled                    pod/nginx           spec.containers{nginx}   kubelet, controlplane                     Successfully pulled image "nginx" in 5.685410981s (5.685428703s including waiting)   38s          1       nginx.173f949860dec78b
38s         Normal    Created                   pod/nginx           spec.containers{nginx}   kubelet, controlplane                     Created container nginx                                                              38s          1       nginx.173f9498679d42d4
37s         Normal    Started                   pod/nginx           spec.containers{nginx}   kubelet, controlplane                     Started container nginx                                                              37s          1       nginx.173f94987c47db2c

controlplane ~ ➜  