

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "134. Practice Test Backup and Restore Methods 2."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 134. Practice Test Backup and Restore Methods 2


info

In this lab environment, you will get to work with multiple kubernetes clusters where we will practice backing up and restoring the ETCD database.












You will notice that, you are logged in to the student-node (instead of the controlplane).


The student-node has the kubectl client and has access to all the Kubernetes clusters that are configured in this lab environment.

Before proceeding to the next question, explore the student-node and the clusters it has access to. 



student-node ~ ➜  kubectl get nodes
NAME                    STATUS   ROLES           AGE   VERSION
cluster1-controlplane   Ready    control-plane   51m   v1.24.0
cluster1-node01         Ready    <none>          50m   v1.24.0

student-node ~ ➜  kubectl get nodes -A
NAME                    STATUS   ROLES           AGE   VERSION
cluster1-controlplane   Ready    control-plane   51m   v1.24.0
cluster1-node01         Ready    <none>          51m   v1.24.0

student-node ~ ➜  kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   51m











How many clusters are defined in the kubeconfig on the student-node?

You can make use of the kubectl config command.


student-node ~ ✖ kubectl config get-clusters
NAME
cluster1
cluster2

student-node ~ ➜  












How many nodes (both controlplane and worker) are part of cluster1?

Make sure to switch the context to cluster1:

kubectl config use-context cluster1



student-node ~ ➜  kubectl config use-context cluster1
Switched to context "cluster1".

student-node ~ ➜  

student-node ~ ➜  

student-node ~ ➜  kubectl get nodes
NAME                    STATUS   ROLES           AGE   VERSION
cluster1-controlplane   Ready    control-plane   53m   v1.24.0
cluster1-node01         Ready    <none>          52m   v1.24.0

student-node ~ ➜  






What is the name of the controlplane node in cluster2?

Make sure to switch the context to cluster2:

kubectl config use-context cluster2

student-node ~ ➜  kubectl config use-context cluster2
Switched to context "cluster2".

student-node ~ ➜  

student-node ~ ➜  kubectl get nodes
NAME                    STATUS   ROLES           AGE   VERSION
cluster2-controlplane   Ready    control-plane   53m   v1.24.0
cluster2-node01         Ready    <none>          53m   v1.24.0

student-node ~ ➜  
















You can SSH to all the nodes (of both clusters) from the student-node.


For example:

student-node ~ ➜  ssh cluster1-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1086-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

cluster1-controlplane ~ ➜ 

To get back to the student node, use the logout or exit command, or, hit Control +D

cluster1-controlplane ~ ➜  logout
Connection to cluster1-controlplane closed.

student-node ~ ➜  

student-node ~ ➜  ssh cluster1-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

cluster1-controlplane ~ ➜  exit
logout
Connection to cluster1-controlplane closed.

student-node ~ ➜  

student-node ~ ➜  

student-node ~ ➜  

student-node ~ ➜  ssh cluster2-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

cluster2-controlplane ~ ➜  exit
logout
Connection to cluster2-controlplane closed.

student-node ~ ➜  

student-node ~ ➜  

student-node ~ ➜  





















How is ETCD configured for cluster1?

Remember, you can access the clusters from student-node using the kubectl tool. You can also ssh to the cluster nodes from the student-node.


Make sure to switch the context to cluster1:

kubectl config use-context cluster1


student-node ~ ➜  ssh cluster1-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.
Last login: Sat Jul 29 01:55:43 2023 from 192.2.217.6

cluster1-controlplane ~ ➜  

cluster1-controlplane ~ ➜  

cluster1-controlplane ~ ➜  

cluster1-controlplane ~ ➜  ls /etc
adduser.conf            dbus-1          gshadow-     ld.so.conf      modprobe.d      profile.d    security     sysctl.d
alternatives            debconf.conf    gss          ld.so.conf.d    modules         protocols    selinux      systemd
apparmor.d              debian_version  host.conf    legal           modules-load.d  python3      services     terminfo
apt                     default         hostname     libaudit.conf   mtab            python3.6    shadow       tmpfiles.d
bash.bashrc             deluser.conf    hosts        locale.alias    nanorc          rc0.d        shadow-      ucf.conf
bash_completion         depmod.d        hosts.allow  locale.gen      network         rc1.d        shells       udev
bash_completion.d       dhcp            hosts.deny   logcheck        networks        rc2.d        skel         ufw
bindresvport.blacklist  dpkg            init.d       login.defs      nsswitch.conf   rc3.d        ssh          update-motd.d
binfmt.d                environment     inputrc      logrotate.d     opt             rc4.d        ssl          vim
ca-certificates         ethertypes      iproute2     lsb-release     os-release      rc5.d        subgid       wgetrc
ca-certificates.conf    fstab           issue        machine-id      pam.conf        rc6.d        subgid-      X11
calendar                gai.conf        issue.net    mailcap         pam.d           rcS.d        subuid       xdg
cni                     groff           kernel       mailcap.order   passwd          resolv.conf  subuid-
containerd              group           kubernetes   manpath.config  passwd-         rmt          sudoers
cron.daily              group-          ldap         mime.types      perl            rpc          sudoers.d
cron.weekly             gshadow         ld.so.cache  mke2fs.conf     profile         securetty    sysctl.conf

cluster1-controlplane ~ ➜  ls /etc/kubernetes/
admin.conf  controller-manager.conf  kubelet.conf  manifests  pki  scheduler.conf

cluster1-controlplane ~ ➜  ls /etc/kubernetes/manifests/etcd.yaml 
/etc/kubernetes/manifests/etcd.yaml

cluster1-controlplane ~ ➜  cat /etc/kubernetes/manifests/etcd.yaml 
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/etcd.advertise-client-urls: https://192.2.217.8:2379
  creationTimestamp: null
  labels:
    component: etcd
    tier: control-plane
  name: etcd
  namespace: kube-system
spec:
  containers:
  - command:
    - etcd
    - --advertise-client-urls=https://192.2.217.8:2379
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt
    - --client-cert-auth=true
    - --data-dir=/var/lib/etcd
    - --experimental-initial-corrupt-check=true
    - --initial-advertise-peer-urls=https://192.2.217.8:2380
    - --initial-cluster=cluster1-controlplane=https://192.2.217.8:2380
    - --key-file=/etc/kubernetes/pki/etcd/server.key
    - --listen-client-urls=https://127.0.0.1:2379,https://192.2.217.8:2379
    - --listen-metrics-urls=http://127.0.0.1:2381
    - --listen-peer-urls=https://192.2.217.8:2380
    - --name=cluster1-controlplane
    - --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
    - --peer-client-cert-auth=true
    - --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
    - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    - --snapshot-count=10000
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    image: k8s.gcr.io/etcd:3.5.3-0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /health
        port: 2381
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: etcd
    resources:
      requests:
        cpu: 100m
        memory: 100Mi
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /health
        port: 2381
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /var/lib/etcd
      name: etcd-data
    - mountPath: /etc/kubernetes/pki/etcd
      name: etcd-certs
  hostNetwork: true
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/kubernetes/pki/etcd
      type: DirectoryOrCreate
    name: etcd-certs
  - hostPath:
      path: /var/lib/etcd
      type: DirectoryOrCreate
    name: etcd-data
status: {}

cluster1-controlplane ~ ➜  ^C


RESPOSTA:
STACKED ETCD












How is ETCD configured for cluster2?

Remember, you can access the clusters from student-node using the kubectl tool. You can also ssh to the cluster nodes from the student-node.


Make sure to switch the context to cluster2:

kubectl config use-context cluster2


student-node ~ ✖ kubectl config use-context cluster2
Switched to context "cluster2".

student-node ~ ➜  

student-node ~ ➜  

student-node ~ ➜  kubectl get nodes
NAME                    STATUS   ROLES           AGE   VERSION
cluster2-controlplane   Ready    control-plane   59m   v1.24.0
cluster2-node01         Ready    <none>          59m   v1.24.0

student-node ~ ➜  

R: 
EXTERNAL ETCD










What is the IP address of the External ETCD datastore used in cluster2?
What is the IP address of the External ETCD datastore used in cluster2?


cluster2-controlplane ~ ➜  systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Sat 2023-07-29 01:01:12 UTC; 1h 5min ago
     Docs: https://kubernetes.io/docs/home/
 Main PID: 2111 (kubelet)
    Tasks: 47 (limit: 251379)
   CGroup: /system.slice/kubelet.service
           └─2111 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.co
nf --config=/var/lib/kubelet/config.yaml --container-runtime=remote --container-runtime-endpoint=unix:///var/run/containerd/containerd.s
ock --pod-infra-container-image=k8s.gcr.io/pause:3.7

Jul 29 01:01:28 cluster2-controlplane kubelet[2111]: E0729 01:01:28.857774    2111 kubelet.go:2344] "Container runtime network not ready
" networkReady="NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized"
Jul 29 01:01:29 cluster2-controlplane kubelet[2111]: E0729 01:01:29.669580    2111 gcpcredential.go:74] while reading 'google-dockercfg-
url' metadata: http status code: 404 while fetching url http://metadata.google.internal./computeMetadata/v1/instance/attributes/google-d
ockercfg-url
Jul 29 01:01:33 cluster2-controlplane kubelet[2111]: E0729 01:01:33.858854    2111 kubelet.go:2344] "Container runtime network not ready
" networkReady="NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized"
Jul 29 01:01:37 cluster2-controlplane kubelet[2111]: I0729 01:01:37.985531    2111 scope.go:110] "RemoveContainer" containerID="cab35513
b21733123c4ecbfb1ef3c5d13dc498d6245cd73ac2a2820e430a35ae"
Jul 29 01:01:44 cluster2-controlplane kubelet[2111]: I0729 01:01:44.548942    2111 topology_manager.go:200] "Topology Admit Handler"
Jul 29 01:01:44 cluster2-controlplane kubelet[2111]: I0729 01:01:44.550534    2111 topology_manager.go:200] "Topology Admit Handler"
Jul 29 01:01:44 cluster2-controlplane kubelet[2111]: I0729 01:01:44.692673    2111 reconciler.go:270] "operationExecutor.VerifyControlle
rAttachedVolume started for volume \"kube-api-access-bk69s\" (UniqueName: \"kubernetes.io/projected/ecd28022-7881-43c5-a87b-0f263c2f88e0
-kube-api-access-bk69s\") pod \"coredns-6d4b75cb6d-zh4m9\" (UID: \"ecd28022-7881-43c5-a87b-0f263c2f88e0\") " pod="kube-system/coredns-6d
4b75cb6d-zh4m9"
Jul 29 01:01:44 cluster2-controlplane kubelet[2111]: I0729 01:01:44.692721    2111 reconciler.go:270] "operationExecutor.VerifyControlle
rAttachedVolume started for volume \"config-volume\" (UniqueName: \"kubernetes.io/configmap/5b10e008-c8d2-465a-99d5-e6925fa3d419-config-
volume\") pod \"coredns-6d4b75cb6d-4tmfz\" (UID: \"5b10e008-c8d2-465a-99d5-e6925fa3d419\") " pod="kube-system/coredns-6d4b75cb6d-4tmfz"
Jul 29 01:01:44 cluster2-controlplane kubelet[2111]: I0729 01:01:44.692741    2111 reconciler.go:270] "operationExecutor.VerifyControlle
rAttachedVolume started for volume \"config-volume\" (UniqueName: \"kubernetes.io/configmap/ecd28022-7881-43c5-a87b-0f263c2f88e0-config-
volume\") pod \"coredns-6d4b75cb6d-zh4m9\" (UID: \"ecd28022-7881-43c5-a87b-0f263c2f88e0\") " pod="kube-system/coredns-6d4b75cb6d-zh4m9"
Jul 29 01:01:44 cluster2-controlplane kubelet[2111]: I0729 01:01:44.692761    2111 reconciler.go:270] "operationExecutor.VerifyControlle
rAttachedVolume started for volume \"kube-api-access-ckgqb\" (UniqueName: \"kubernetes.io/projected/5b10e008-c8d2-465a-99d5-e6925fa3d419
-kube-api-access-ckgqb\") pod \"coredns-6d4b75cb6d-4tmfz\" (UID: \"5b10e008-c8d2-465a-99d5-e6925fa3d419\") " pod="kube-system/coredns-6d
4b75cb6d-4tmfz"

cluster2-controlplane ~ ➜  cat /var/lib/kubelet/config.yaml
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
cpuManagerReconcilePeriod: 0s
evictionPressureTransitionPeriod: 0s
fileCheckFrequency: 0s
healthzBindAddress: 127.0.0.1
healthzPort: 10248
httpCheckFrequency: 0s
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

cluster2-controlplane ~ ➜  cat /etc/kubernetes/kubelet.co
cat: /etc/kubernetes/kubelet.co: No such file or directory

cluster2-controlplane ~ ✖ nf
-bash: nf: command not found

cluster2-controlplane ~ ✖ cat /etc/kubernetes/kubelet.conf 
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMvakNDQWVhZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJek1EY3lPVEF4TURBMU5Wb1hEVE16TURjeU5qQXhNREExTlZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTlI0Ckd5N0FJbS8wTS9iS1c1dDlpTVpxRFpxRWtURlpFbURZei9tMVlzY2Q4M1RqSS9zZnJmM2JRenBCcTY5MWZxN2oKd2pYTkRHcGlXT0pEL1M5YmVENFZ3MGZ3RW1jTDRWbDU3MWNxRDZMaGR5d0tENmNmUG52RFozOGwwb2FTc1JFNgo0eHlJM0JoUkFpUzNOLzlBdy9Xanpoamh4dUNFMmtHSEcxTms1Y1ZUQngvQ0I1VTNQdU1aMzBSL0dDZWdrMHBpClJJYjcxU0s3eWN4QVJsTUkyNzF3M2JNUVMwN1FtSU9RNmUyUytJWVBHOFB5K2lreXFuSGZLTFlDKzBWbENnSVoKNDY1eEJWWCsyZ01vTkRUOTNEUGdwU3lvdUl2eUo0ZUd5c3l0QWkxS3E0U1E3MHhJblBVWXdudGlUTEF4Z2M5WgpKMmo2ZmhXWHZnbEo4dUd0cGpjQ0F3RUFBYU5aTUZjd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZFTi9IUjRlTTgrNnBpaHpsY1ZRV0dHdlNBSERNQlVHQTFVZEVRUU8KTUF5Q0NtdDFZbVZ5Ym1WMFpYTXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSW1GbncxM2tkMDVHRkdoVXJ1awpvMXhVNUl6V2IxN21CZ0w1ZndwaU9HOGZKeHY3RTFhRjRsRm5mOGs1L0pvZE9XeUpERFNxemNDKzlVN3RGYTYxClFrNmRNOE43aXR4b3dTTGJBcTBwVUc1alRCeXBsNytrSDRTaHAvN1FwdlZOcTRsbTV0VlZkbnMwNnk1dkVpRjUKMlEvZ3c0b3IyTVYvdTFReE9LV0J1UUtkVEwzdm5wbkVLTkVZSmNqZUlsMFJSekM1emdlOWVQYmtMNkVtNFNTYwpFMFBlN1paSS93ZWdjQWd6dTUyWEdiUUNlVUdiR1loVkNzYlJEVFVJYXhIVDEwWkRDRExEMmhwNENjWFpUdnBCClRGS1FCZGlrNUlKcWJIdUNtclhMQ3F1UFd4eUs1ZkQ1M3VTOGl4eHBGWFFIVUlPMTNvY0VRSG10OEIvRkkvYlYKSTJFPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    server: https://192.2.217.10:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: system:node:cluster2-controlplane
  name: system:node:cluster2-controlplane@kubernetes
current-context: system:node:cluster2-controlplane@kubernetes
kind: Config
preferences: {}
users:
- name: system:node:cluster2-controlplane
  user:
    client-certificate: /var/lib/kubelet/pki/kubelet-client-current.pem
    client-key: /var/lib/kubelet/pki/kubelet-client-current.pem

cluster2-controlplane ~ ➜  


cluster2-controlplane ~ ✖  docker ps | grep etcd
-bash: docker: command not found

cluster2-controlplane ~ ✖ docker ps
-bash: docker: command not found

cluster2-controlplane ~ ✖ crictl ps
WARN[0000] runtime connect using default endpoints: [unix:///var/run/dockershim.sock unix:///run/containerd/containerd.sock unix:///run/crio/crio.sock unix:///var/run/cri-dockerd.sock]. As the default settings are now deprecated, you should set the endpoint instead. 
ERRO[0000] unable to determine runtime API version: rpc error: code = Unavailable desc = connection error: desc = "transport: Error while dialing dial unix /var/run/dockershim.sock: connect: no such file or directory" 
WARN[0000] image connect using default endpoints: [unix:///var/run/dockershim.sock unix:///run/containerd/containerd.sock unix:///run/crio/crio.sock unix:///var/run/cri-dockerd.sock]. As the default settings are now deprecated, you should set the endpoint instead. 
ERRO[0000] unable to determine image API version: rpc error: code = Unavailable desc = connection error: desc = "transport: Error while dialing dial unix /var/run/dockershim.sock: connect: no such file or directory" 
CONTAINER           IMAGE               CREATED             STATE               NAME                      ATTEMPT             POD ID              POD
a49c7d5c2b955       a4ca41631cc7a       About an hour ago   Running             coredns                   0                   29498d3b5118e       coredns-6d4b75cb6d-4tmfz
e7dce446f051f       a4ca41631cc7a       About an hour ago   Running             coredns                   0                   0af545609caa1       coredns-6d4b75cb6d-zh4m9
de452e2e3fedb       df29c0a4002c0       About an hour ago   Running             weave                     1                   160351d8907d0       weave-net-cw6kh
e2bca2f99f46e       7f92d556d4ffe       About an hour ago   Running             weave-npc                 0                   160351d8907d0       weave-net-cw6kh
a6af441bb192e       77b49675beae1       About an hour ago   Running             kube-proxy                0                   85f8cf576ab81       kube-proxy-j7nml
113a4c8501b81       88784fb4ac2f6       About an hour ago   Running             kube-controller-manager   0                   ae286de22ef60       kube-controller-manager-cluster2-controlplane
e89149db49ba7       529072250ccc6       About an hour ago   Running             kube-apiserver            0                   1c4dddd20d04c       kube-apiserver-cluster2-controlplane
ab52e4779324b       e3ed7dee73e93       About an hour ago   Running             kube-scheduler            0                   56ae949c5422e       kube-scheduler-cluster2-controlplane

cluster2-controlplane ~ ➜  




cluster2-controlplane ~ ➜  etcdctl cluster-health
cluster may be unhealthy: failed to list members
Error:  client: etcd cluster is unavailable or misconfigured; error #0: dial tcp 127.0.0.1:2379: connect: connection refused
; error #1: dial tcp 127.0.0.1:4001: connect: connection refused

error #0: dial tcp 127.0.0.1:2379: connect: connection refused
error #1: dial tcp 127.0.0.1:4001: connect: connection refused


cluster2-controlplane ~ ✖ 

R:
IP final 18
acertei por ordem de exclusão.




















What is the default data directory used the for ETCD datastore used in cluster1?
Remember, this cluster uses a Stacked ETCD topology.

Make sure to switch the context to cluster1:

kubectl config use-context cluster1


cluster2-controlplane ~ ➜  exit
logout
Connection to cluster2-controlplane closed.

student-node ~ ➜  ssh cluster1-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.
Last login: Sat Jul 29 01:58:36 2023 from 192.2.217.4

cluster1-controlplane ~ ➜  

cluster1-controlplane ~ ➜  

cluster1-controlplane ~ ➜  

cluster1-controlplane ~ ➜  cat /etc/kubernetes/manifests/etcd.yaml | grep listen
    - --listen-client-urls=https://127.0.0.1:2379,https://192.2.217.8:2379
    - --listen-metrics-urls=http://127.0.0.1:2381
    - --listen-peer-urls=https://192.2.217.8:2380

cluster1-controlplane ~ ➜  

cluster1-controlplane ~ ➜  cat /etc/kubernetes/manifests/etcd.yaml | grep /etcd
    kubeadm.kubernetes.io/etcd.advertise-client-urls: https://192.2.217.8:2379
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt
    - --data-dir=/var/lib/etcd
    - --key-file=/etc/kubernetes/pki/etcd/server.key
    - --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
    - --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
    - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    image: k8s.gcr.io/etcd:3.5.3-0
    - mountPath: /var/lib/etcd
    - mountPath: /etc/kubernetes/pki/etcd
      path: /etc/kubernetes/pki/etcd
      path: /var/lib/etcd

cluster1-controlplane ~ ➜  






















For the subsequent questions, you would need to login to the External ETCD server.

To do this, open a new terminal (using the + button located above the default terminal).

From the new terminal you can now SSH from the student-node to either the IP of the ETCD datastore (that you identified in the previous questions) OR the hostname etcd-server:

 ssh cluster2-controlplane

cluster2-controlplane ~ ➜  ps -ef | grep etcd
root        1756    1358  4 01:01 ?        00:03:08 kube-apiserver --advertise-address=192.2.217.10 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.pem --etcd-certfile=/etc/kubernetes/pki/etcd/etcd.pem --etcd-keyfile=/etc/kubernetes/pki/etcd/etcd-key.pem --etcd-servers=https://192.2.217.18:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root       11491   11395  0 02:20 pts/0    00:00:00 grep etcd

cluster2-controlplane ~ ➜  

--etcd-servers=https://192.2.217.18:2379 


















What is the default data directory used the for ETCD datastore used in cluster2?
Remember, this cluster uses an External ETCD topology.

ssh 192.2.217.18


cluster2-controlplane ~ ➜  ssh 192.2.217.18
The authenticity of host '192.2.217.18 (192.2.217.18)' can't be established.
ECDSA key fingerprint is SHA256:nmcGSKcoR7KiJ1V0dP8eAM8R8UIDCgF8j4UtJ0p3i2A.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.2.217.18' (ECDSA) to the list of known hosts.
root@192.2.217.18's password: 


cluster2-controlplane ~ ✖ exit
logout
Connection to cluster2-controlplane closed.

student-node ~ ✖ ssh ssh 192.2.217.18
ssh: Could not resolve hostname ssh: Name or service not known

student-node ~ ✖ ssh etcd-server
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

etcd-server ~ ➜  

etcd-server ~ ➜  

etcd-server ~ ➜  



etcd-server ~ ➜  ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 01:00 ?        00:00:00 /sbin/init --log-level=err
root         237       1  0 01:00 ?        00:00:00 /lib/systemd/systemd-journald
root         318       1  0 01:00 ?        00:00:00 /lib/systemd/systemd-udevd
systemd+     444       1  0 01:00 ?        00:00:00 /lib/systemd/systemd-resolved
root         654       1  0 01:00 ?        00:00:00 /usr/bin/ttyd -p 8080 --ping-interval 30 -t fontSize=16 -t theme={"foreground": "#ef
message+     656       1  0 01:00 ?        00:00:00 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-acti
root         668       1  0 01:00 ?        00:00:00 /lib/systemd/systemd-logind
root         669       1  0 01:00 ?        00:00:00 /usr/sbin/sshd -D
etcd         860       1  1 01:00 ?        00:01:07 /usr/local/bin/etcd --name etcd-server --data-dir=/var/lib/etcd-data --cert-file=/et
root        1003     669  0 02:21 ?        00:00:00 sshd: root@pts/0
root        1014    1003  0 02:21 pts/0    00:00:00 -bash
root        1186    1014  0 02:22 pts/0    00:00:00 ps -ef

etcd-server ~ ➜  


--data-dir=/var/lib/etcd-data





















How many nodes are part of the ETCD cluster that etcd-server is a part of?


etcd-server ~ ➜  etcdctl member list
{"level":"warn","ts":"2023-07-29T02:24:18.026Z","caller":"clientv3/retry_interceptor.go:62","msg":"retrying of unary invoker failed","target":"endpoint://client-93cf8af8-64e9-45db-9833-3da43ee7c129/127.0.0.1:2379","attempt":0,"error":"rpc error: code = DeadlineExceeded desc = latest balancer error: all SubConns are in TransientFailure, latest connection error: connection closed"}
Error: context deadline exceeded

etcd-server ~ ✖ 












Take a backup of etcd on cluster1 and save it on the student-node at the path /opt/cluster1.db


If needed, make sure to set the context to cluster1 (on the student-node):

student-node ~ ➜  kubectl config use-context cluster1
Switched to context "cluster1".

student-node ~ ➜  


student-node ~ ✖ ssh cluster1-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.
Last login: Sat Jul 29 02:18:00 2023 from 192.2.217.4

cluster1-controlplane ~ ➜  ls /etc/kubernetes/
admin.conf  controller-manager.conf  kubelet.conf  manifests  pki  scheduler.conf

cluster1-controlplane ~ ➜  ls /etc/kubernetes/pki/
apiserver.crt              apiserver.key                 ca.crt  front-proxy-ca.crt      front-proxy-client.key
apiserver-etcd-client.crt  apiserver-kubelet-client.crt  ca.key  front-proxy-ca.key      sa.key
apiserver-etcd-client.key  apiserver-kubelet-client.key  etcd    front-proxy-client.crt  sa.pub

cluster1-controlplane ~ ➜  cat /etc/kubernetes/manifests/etcd.yaml | grep list
    - --listen-client-urls=https://127.0.0.1:2379,https://192.2.217.8:2379
    - --listen-metrics-urls=http://127.0.0.1:2381
    - --listen-peer-urls=https://192.2.217.8:2380

cluster1-controlplane ~ ➜  


- Editando:

ETCDCTL_API=3 etcdctl snapshot save --endpoints=192.2.217.8:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  /opt/cluster1.db




ETCDCTL_API=3 etcdctl snapshot save --endpoints=192.2.217.8:2379 \
  /opt/cluster1.db


ETCDCTL_API=3 etcdctl snapshot save --endpoints=192.2.217.8:2379 \
  /opt/cluster1.db
cluster1-controlplane ~ ➜  ETCDCTL_API=3 etcdctl snapshot save --endpoints=192.2.217.8:2379 \
>   --cacert=/etc/kubernetes/pki/etcd/ca.crt \
>   --cert=/etc/kubernetes/pki/etcd/server.crt \
>   --key=/etc/kubernetes/pki/etcd/server.key \
>   /opt/cluster1.db
Snapshot saved at /opt/cluster1.db

cluster1-controlplane ~ ➜  exit
logout
Connection to cluster1-controlplane closed.

student-node ~ ➜  kubectl config use-context cluster1Switched to context "cluster1".

student-node ~ ➜  

student-node ~ ➜  

student-node ~ ➜  

student-node ~ ➜  

student-node ~ ➜  

student-node ~ ➜  ETCDCTL_API=3 etcdctl snapshot save --endpoints=192.2.217.8:2379 \
>   --cacert=/etc/kubernetes/pki/etcd/ca.crt \
>   --cert=/etc/kubernetes/pki/etcd/server.crt \
>   --key=/etc/kubernetes/pki/etcd/server.key \
>   /opt/cluster1.db
Error: open /etc/kubernetes/pki/etcd/server.crt: no such file or directory

student-node ~ ✖ ETCDCTL_API=3 etcdctl snapshot save --endpoints=192.2.217.8:2379   --cacert=/etc/kubernetes/pki/etcd/ca.crt   --cert=/etc/kubernetes/pki/etcd/server.crt   --key=/etc/kubernetes/pki/etcd/server.key   /o^C/cluster1.db

student-node ~ ✖ 

student-node ~ ✖ ETCDCTL_API=3 etcdctl snapshot save --endpoints=192.2.217.8:2379 \
>   /opt/cluster1.db
Error: rpc error: code = Unavailable desc = transport is closing

student-node ~ ✖ 





student-node ~ ✖ kubectl config use-context cluster1Switched to context "cluster1".

student-node ~ ➜  

student-node ~ ➜  

student-node ~ ➜  

student-node ~ ➜   kubectl get all --all-namespaces -o yaml > all-deploy-services.yaml

student-node ~ ➜  




ETCDCTL_API=3 etcdctl snapshot save snapshot.db


student-node ~ ✖ ETCDCTL_API=3 etcdctl snapshot save snapshot.db
Error: dial tcp 127.0.0.1:2379: connect: connection refused

student-node ~ ✖ 







# ########################################################################################################################################
# ########################################################################################################################################
# ########################################################################################################################################
# ########################################################################################################################################
# ########################################################################################################################################
# ########################################################################################################################################
## PENDENTE

- Ver sobre questão "How is ETCD configured for cluster2?", porque é EXTERNAL ETCD?
- Revisar a questão "What is the IP address of the External ETCD datastore used in cluster2?", como foi verificado o ip???
- Ver porque a questão "How many nodes are part of the ETCD cluster that etcd-server is a part of?" a resposta era 1.
- Ver como fazer backup no node local, na questão "Take a backup of etcd on cluster1 and save it on the student-node at the path /opt/cluster1.db".
- Refazer o teste prático da questão 134.












# ########################################################################################################################################
# ########################################################################################################################################
# ########################################################################################################################################
# ########################################################################################################################################
# ########################################################################################################################################
# ########################################################################################################################################
## Dia 07/08/2023

- 2º tentativa do teste prático



In this lab environment, you will get to work with multiple kubernetes clusters where we will practice backing up and restoring the ETCD database.








You will notice that, you are logged in to the student-node (instead of the controlplane).


The student-node has the kubectl client and has access to all the Kubernetes clusters that are configured in this lab environment.

Before proceeding to the next question, explore the student-node and the clusters it has access to. 


student-node ~ ➜  kubectl get nodes
NAME                    STATUS   ROLES           AGE   VERSION
cluster1-controlplane   Ready    control-plane   65m   v1.24.0
cluster1-node01         Ready    <none>          65m   v1.24.0

student-node ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                            READY   STATUS    RESTARTS      AGE
kube-system   coredns-6d4b75cb6d-2nvtk                        1/1     Running   0             65m
kube-system   coredns-6d4b75cb6d-f7mrk                        1/1     Running   0             65m
kube-system   etcd-cluster1-controlplane                      1/1     Running   0             65m
kube-system   kube-apiserver-cluster1-controlplane            1/1     Running   0             65m
kube-system   kube-controller-manager-cluster1-controlplane   1/1     Running   0             65m
kube-system   kube-proxy-5wzbj                                1/1     Running   0             65m
kube-system   kube-proxy-6xcxg                                1/1     Running   0             65m
kube-system   kube-scheduler-cluster1-controlplane            1/1     Running   0             65m
kube-system   weave-net-wfbrs                                 2/2     Running   0             65m
kube-system   weave-net-zbwbc                                 2/2     Running   1 (65m ago)   65m

student-node ~ ➜  

student-node ~ ➜  date
Tue Aug  8 02:25:13 UTC 2023

student-node ~ ➜  
















How many clusters are defined in the kubeconfig on the student-node?

You can make use of the kubectl config command.


student-node ~ ➜  kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://cluster1-controlplane:6443
  name: cluster1
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://192.4.53.22:6443
  name: cluster2
contexts:
- context:
    cluster: cluster1
    user: cluster1
  name: cluster1
- context:
    cluster: cluster2
    user: cluster2
  name: cluster2
current-context: cluster1
kind: Config
preferences: {}
users:
- name: cluster1
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
- name: cluster2
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED

student-node ~ ➜  












How many nodes (both controlplane and worker) are part of cluster1?

Make sure to switch the context to cluster1:

kubectl config use-context cluster1

student-node ~ ➜  kubectl get nodes -A
NAME                    STATUS   ROLES           AGE   VERSION
cluster1-controlplane   Ready    control-plane   68m   v1.24.0
cluster1-node01         Ready    <none>          67m   v1.24.0

student-node ~ ➜  











What is the name of the controlplane node in cluster2?

Make sure to switch the context to cluster2:

kubectl config use-context cluster2


student-node ~ ➜  kubectl config use-context cluster2
Switched to context "cluster2".

student-node ~ ➜  kubectl get nodes -A
NAME                    STATUS   ROLES           AGE   VERSION
cluster2-controlplane   Ready    control-plane   68m   v1.24.0
cluster2-node01         Ready    <none>          68m   v1.24.0

student-node ~ ➜  














You can SSH to all the nodes (of both clusters) from the student-node.


For example:

student-node ~ ➜  ssh cluster1-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1086-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

cluster1-controlplane ~ ➜ 

To get back to the student node, use the logout or exit command, or, hit Control +D

cluster1-controlplane ~ ➜  logout
Connection to cluster1-controlplane closed.

student-node ~ ➜  




















How is ETCD configured for cluster1?

Remember, you can access the clusters from student-node using the kubectl tool. You can also ssh to the cluster nodes from the student-node.


Make sure to switch the context to cluster1:

kubectl config use-context cluster1


student-node ~ ➜  kubectl config use-context cluster1
Switched to context "cluster1".

student-node ~ ➜  

student-node ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                            READY   STATUS    RESTARTS      AGE
kube-system   coredns-6d4b75cb6d-2nvtk                        1/1     Running   0             69m
kube-system   coredns-6d4b75cb6d-f7mrk                        1/1     Running   0             69m
kube-system   etcd-cluster1-controlplane                      1/1     Running   0             69m
kube-system   kube-apiserver-cluster1-controlplane            1/1     Running   0             69m
kube-system   kube-controller-manager-cluster1-controlplane   1/1     Running   0             69m
kube-system   kube-proxy-5wzbj                                1/1     Running   0             69m
kube-system   kube-proxy-6xcxg                                1/1     Running   0             68m
kube-system   kube-scheduler-cluster1-controlplane            1/1     Running   0             69m
kube-system   weave-net-wfbrs                                 2/2     Running   0             68m
kube-system   weave-net-zbwbc                                 2/2     Running   1 (69m ago)   69m

student-node ~ ➜  


-R:
Stacked ETCD













How is ETCD configured for cluster2?

Remember, you can access the clusters from student-node using the kubectl tool. You can also ssh to the cluster nodes from the student-node.


Make sure to switch the context to cluster2:

kubectl config use-context cluster2


student-node ~ ➜  kubectl config use-context cluster2
Switched to context "cluster2".

student-node ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                            READY   STATUS    RESTARTS      AGE
critical      critical-deployment-240616-5bf45c9459-m9dsl     1/1     Running   0             6m43s
critical      critical-deployment-240616-5bf45c9459-t29p5     1/1     Running   0             6m43s
kube-system   coredns-6d4b75cb6d-9sn4z                        1/1     Running   0             71m
kube-system   coredns-6d4b75cb6d-tpt5p                        1/1     Running   0             71m
kube-system   kube-apiserver-cluster2-controlplane            1/1     Running   0             71m
kube-system   kube-controller-manager-cluster2-controlplane   1/1     Running   1 (64m ago)   71m
kube-system   kube-proxy-g4p62                                1/1     Running   0             71m
kube-system   kube-proxy-khv29                                1/1     Running   0             71m
kube-system   kube-scheduler-cluster2-controlplane            1/1     Running   1 (64m ago)   71m
kube-system   weave-net-fcpwg                                 2/2     Running   0             71m
kube-system   weave-net-l8g8l                                 2/2     Running   1 (71m ago)   71m

student-node ~ ➜  

student-node ~ ➜  ssh cluster2-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

cluster2-controlplane ~ ➜  ps -ef | grep etcd
root        1780    1385  9 01:19 ?        00:04:02 kube-apiserver --advertise-address=192.4.53.22 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.pem --etcd-certfile=/etc/kubernetes/pki/etcd/etcd.pem --etcd-keyfile=/etc/kubernetes/pki/etcd/etcd-key.pem --etcd-servers=https://192.4.53.12:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root        9459    9357  0 02:31 pts/0    00:00:00 grep etcd

cluster2-controlplane ~ ➜  
cluster2-controlplane ~ ➜  ls /etc/kubernetes/
admin.conf               controller-manager.conf  kubelet.conf             manifests/               pki/                     scheduler.conf

cluster2-controlplane ~ ➜  ls /etc/kubernetes/manifests/
kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml

cluster2-controlplane ~ ➜  






















What is the IP address of the External ETCD datastore used in cluster2?

What is the default data directory used the for ETCD datastore used in cluster1?
Remember, this cluster uses a Stacked ETCD topology.

Make sure to switch the context to cluster1:

kubectl config use-context cluster1


student-node ~ ➜  kubectl config use-context cluster1
Switched to context "cluster1".

student-node ~ ➜  kubectl get pods -n kube-system
NAME                                            READY   STATUS    RESTARTS      AGE
coredns-6d4b75cb6d-2nvtk                        1/1     Running   0             75m
coredns-6d4b75cb6d-f7mrk                        1/1     Running   0             75m
etcd-cluster1-controlplane                      1/1     Running   0             75m
kube-apiserver-cluster1-controlplane            1/1     Running   0             75m
kube-controller-manager-cluster1-controlplane   1/1     Running   0             75m
kube-proxy-5wzbj                                1/1     Running   0             75m
kube-proxy-6xcxg                                1/1     Running   0             74m
kube-scheduler-cluster1-controlplane            1/1     Running   0             75m
weave-net-wfbrs                                 2/2     Running   0             74m
weave-net-zbwbc                                 2/2     Running   1 (75m ago)   75m

student-node ~ ➜  kubectl describe pod etcd-cluster1-controlplane -n kube-system 
Name:                 etcd-cluster1-controlplane
Namespace:            kube-system
Priority:             2000001000
Priority Class Name:  system-node-critical
Node:                 cluster1-controlplane/192.4.53.19
Start Time:           Tue, 08 Aug 2023 01:19:17 +0000
Labels:               component=etcd
                      tier=control-plane
Annotations:          kubeadm.kubernetes.io/etcd.advertise-client-urls: https://192.4.53.19:2379
                      kubernetes.io/config.hash: 739f139c858312d902ba6eb6a36a2e32
                      kubernetes.io/config.mirror: 739f139c858312d902ba6eb6a36a2e32
                      kubernetes.io/config.seen: 2023-08-08T01:19:16.622419070Z
                      kubernetes.io/config.source: file
                      seccomp.security.alpha.kubernetes.io/pod: runtime/default
Status:               Running
IP:                   192.4.53.19
IPs:
  IP:           192.4.53.19
Controlled By:  Node/cluster1-controlplane
Containers:
  etcd:
    Container ID:  containerd://b632bf6a13d060aeca239f077016fc168463e776f2219c24fbc7c8753a7fbd96
    Image:         k8s.gcr.io/etcd:3.5.3-0
    Image ID:      k8s.gcr.io/etcd@sha256:13f53ed1d91e2e11aac476ee9a0269fdda6cc4874eba903efd40daf50c55eee5
    Port:          <none>
    Host Port:     <none>
    Command:
      etcd
      --advertise-client-urls=https://192.4.53.19:2379
      --cert-file=/etc/kubernetes/pki/etcd/server.crt
      --client-cert-auth=true
      --data-dir=/var/lib/etcd
      --experimental-initial-corrupt-check=true
      --initial-advertise-peer-urls=https://192.4.53.19:2380
      --initial-cluster=cluster1-controlplane=https://192.4.53.19:2380
      --key-file=/etc/kubernetes/pki/etcd/server.key
      --listen-client-urls=https://127.0.0.1:2379,https://192.4.53.19:2379
      --listen-metrics-urls=http://127.0.0.1:2381
      --listen-peer-urls=https://192.4.53.19:2380
      --name=cluster1-controlplane
      --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
      --peer-client-cert-auth=true
      --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
      --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
      --snapshot-count=10000
      --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    State:          Running
      Started:      Tue, 08 Aug 2023 01:19:06 +0000
    Ready:          True
    Restart Count:  0
    Requests:
      cpu:        100m
      memory:     100Mi
    Liveness:     http-get http://127.0.0.1:2381/health delay=10s timeout=15s period=10s #success=1 #failure=8
    Startup:      http-get http://127.0.0.1:2381/health delay=10s timeout=15s period=10s #success=1 #failure=24
    Environment:  <none>
    Mounts:
      /etc/kubernetes/pki/etcd from etcd-certs (rw)
      /var/lib/etcd from etcd-data (rw)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  etcd-certs:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/kubernetes/pki/etcd
    HostPathType:  DirectoryOrCreate
  etcd-data:
    Type:          HostPath (bare host directory volume)
    Path:          /var/lib/etcd
    HostPathType:  DirectoryOrCreate
QoS Class:         Burstable
Node-Selectors:    <none>
Tolerations:       :NoExecute op=Exists
Events:            <none>

student-node ~ ➜  














For the subsequent questions, you would need to login to the External ETCD server.

To do this, open a new terminal (using the + button located above the default terminal).

From the new terminal you can now SSH from the student-node to either the IP of the ETCD datastore (that you identified in the previous questions) OR the hostname etcd-server:

etcd3

student-node ~ ➜  ssh etcd-server
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

etcd-server ~ ➜  

















What is the default data directory used the for ETCD datastore used in cluster2?
Remember, this cluster uses an External ETCD topology.

etcd-server ~ ➜  ls /etc/kub
ls: cannot access '/etc/kub': No such file or directory

etcd-server ~ ✖ ps -ef | grep etcd
etcd         917       1  3 01:26 ?        00:01:24 /usr/local/bin/etcd --name etcd-server --data-dir=/var/lib/etcd-data --cert-file=/etc/etcd/pki/etcd.pem --key-file=/etc/etcd/pki/etcd-key.pem --peer-cert-file=/etc/etcd/pki/etcd.pem --peer-key-file=/etc/etcd/pki/etcd-key.pem --trusted-ca-file=/etc/etcd/pki/ca.pem --peer-trusted-ca-file=/etc/etcd/pki/ca.pem --peer-client-cert-auth --client-cert-auth --initial-advertise-peer-urls https://192.4.53.12:2380 --listen-peer-urls https://192.4.53.12:2380 --advertise-client-urls https://192.4.53.12:2379 --listen-client-urls https://192.4.53.12:2379,https://127.0.0.1:2379 --initial-cluster-token etcd-cluster-1 --initial-cluster etcd-server=https://192.4.53.12:2380 --initial-cluster-state new
root        1156    1023  0 02:37 pts/0    00:00:00 grep etcd

etcd-server ~ ➜  
















How many nodes are part of the ETCD cluster that etcd-server is a part of?

- ERROS

etcd-server ~ ➜  etcdctl member list
{"level":"warn","ts":"2023-08-08T02:38:30.356Z","caller":"clientv3/retry_interceptor.go:62","msg":"retrying of unary invoker failed","target":"endpoint://client-c3b067cd-fe4a-422f-ae04-e6c89e47302b/127.0.0.1:2379","attempt":0,"error":"rpc error: code = DeadlineExceeded desc = latest balancer error: all SubConns are in TransientFailure, latest connection error: connection closed"}
Error: context deadline exceeded

etcd-server ~ ✖ ETCDCTL_API=3 etcdctl member list
{"level":"warn","ts":"2023-08-08T02:39:00.939Z","caller":"clientv3/retry_interceptor.go:62","msg":"retrying of unary invoker failed","target":"endpoint://client-506b9439-6d90-45f2-8f96-133cc30b2ecf/127.0.0.1:2379","attempt":0,"error":"rpc error: code = DeadlineExceeded desc = latest balancer error: all SubConns are in TransientFailure, latest connection error: connection closed"}
Error: context deadline exceeded

etcd-server ~ ✖ 



etcd-server ~ ✖ ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 01:18 ?        00:00:00 /sbin/init --log-level=err
root         238       1  0 01:18 ?        00:00:00 /lib/systemd/systemd-journald
root         332       1  0 01:18 ?        00:00:00 /lib/systemd/systemd-udevd
systemd+     486       1  0 01:18 ?        00:00:00 /lib/systemd/systemd-resolved
message+     645       1  0 01:18 ?        00:00:00 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activ
root         659       1  0 01:18 ?        00:00:00 /usr/bin/ttyd -p 8080 --ping-interval 30 -t fontSize=16 -t theme={"foreground": "#eff
root         660       1  0 01:18 ?        00:00:00 /lib/systemd/systemd-logind
root         661       1  0 01:18 ?        00:00:00 /usr/sbin/sshd -D
etcd         917       1  3 01:26 ?        00:01:28 /usr/local/bin/etcd --name etcd-server --data-dir=/var/lib/etcd-data --cert-file=/etc
root        1012     661  0 02:36 ?        00:00:00 sshd: root@pts/0
root        1023    1012  0 02:36 pts/0    00:00:00 -bash
root        1403    1023  0 02:40 pts/0    00:00:00 ps -ef

etcd-server ~ ➜  ps -ef | grep etcd
etcd         917       1  3 01:26 ?        00:01:28 /usr/local/bin/etcd --name etcd-server --data-dir=/var/lib/etcd-data --cert-file=/etc/etcd/pki/etcd.pem --key-file=/etc/etcd/pki/etcd-key.pem --peer-cert-file=/etc/etcd/pki/etcd.pem --peer-key-file=/etc/etcd/pki/etcd-key.pem --trusted-ca-file=/etc/etcd/pki/ca.pem --peer-trusted-ca-file=/etc/etcd/pki/ca.pem --peer-client-cert-auth --client-cert-auth --initial-advertise-peer-urls https://192.4.53.12:2380 --listen-peer-urls https://192.4.53.12:2380 --advertise-client-urls https://192.4.53.12:2379 --listen-client-urls https://192.4.53.12:2379,https://127.0.0.1:2379 --initial-cluster-token etcd-cluster-1 --initial-cluster etcd-server=https://192.4.53.12:2380 --initial-cluster-state new
root        1460    1023  0 02:40 pts/0    00:00:00 grep etcd

etcd-server ~ ➜  


- OK, agora trouxe:

ETCDCTL_API=3 etcdctl --endpoints=127.0.0.1:2379 --cacert=/etc/etcd/pki/ca.pem --cert=/etc/etcd/pki/etcd.pem --key=/etc/etcd/pki/etcd-key.pem member list

etcd-server ~ ➜  ETCDCTL_API=3 etcdctl --endpoints=127.0.0.1:2379 --cacert=/etc/etcd/pki/ca.pem --cert=/etc/etcd/pki/etcd.pem --key=/etc/etcd/pki/etcd-key.pem member list
5eefd60ca2e37a45, started, etcd-server, https://192.4.53.12:2380, https://192.4.53.12:2379, false

etcd-server ~ ➜  







Take a backup of etcd on cluster1 and save it on the student-node at the path /opt/cluster1.db


If needed, make sure to set the context to cluster1 (on the student-node):

student-node ~ ➜  kubectl config use-context cluster1
Switched to context "cluster1".

student-node ~ ➜  

    task completed?



student-node ~ ➜  kubectl config use-context cluster1
Switched to context "cluster1".

student-node ~ ➜  ssh cluster1-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

cluster1-controlplane ~ ➜  

cluster1-controlplane ~ ➜  ETCDCTL_API=3 etcdctl snapshot save \
>   --cacert /etc/kubernetes/pki/etcd/ca.crt \
>   --cert /etc/kubernetes/pki/etcd/server.crt \
>   --key /etc/kubernetes/pki/etcd/server.key \
>   cluster1.db
Snapshot saved at cluster1.db

cluster1-controlplane ~ ➜  exit
logout
Connection to cluster1-controlplane closed.

student-node ~ ➜  scp cluster1-controlplane:~/cluster1.db /opt/
cluster1.db                                                                                            100% 2092KB 146.4MB/s   00:00    

student-node ~ ➜  ls /opt
cluster1.db

student-node ~ ➜  

























An ETCD backup for cluster2 is stored at /opt/cluster2.db. Use this snapshot file to carryout a restore on cluster2 to a new path /var/lib/etcd-data-new.


Once the restore is complete, ensure that the controlplane components on cluster2 are running.


The snapshot was taken when there were objects created in the critical namespace on cluster2. These objects should be available post restore.


If needed, make sure to set the context to cluster2 (on the student-node):

student-node ~ ➜  kubectl config use-context cluster2
Switched to context "cluster2".

student-node ~ ➜  

    etcd restored to the new directory ?

    kube-apiserver running on cluster2?

    objects restored?


student-node ~ ➜  kubectl config use-context cluster2
Switched to context "cluster2".

student-node ~ ➜  ls /opt
cluster1.db  cluster2.db

student-node ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                            READY   STATUS    RESTARTS      AGE
kube-system   coredns-6d4b75cb6d-9sn4z                        1/1     Running   0             90m
kube-system   coredns-6d4b75cb6d-tpt5p                        1/1     Running   0             90m
kube-system   kube-apiserver-cluster2-controlplane            1/1     Running   0             90m
kube-system   kube-controller-manager-cluster2-controlplane   1/1     Running   1 (83m ago)   90m
kube-system   kube-proxy-g4p62                                1/1     Running   0             90m
kube-system   kube-proxy-khv29                                1/1     Running   0             90m
kube-system   kube-scheduler-cluster2-controlplane            1/1     Running   1 (83m ago)   90m
kube-system   weave-net-fcpwg                                 2/2     Running   0             90m
kube-system   weave-net-l8g8l                                 2/2     Running   1 (90m ago)   90m

student-node ~ ➜  


student-node ~ ➜  scp /opt/cluster2.db cluster2-controlplane:/root
cluster2.db                                                                                            100% 2104KB  73.8MB/s   00:00    

student-node ~ ➜  ssh cluster2-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.
Last login: Tue Aug  8 02:31:33 2023 from 192.4.53.10

cluster2-controlplane ~ ➜  ls /root
cluster2.db  install-etcd.sh

cluster2-controlplane ~ ➜  pwd
/root

cluster2-controlplane ~ ➜  ls
cluster2.db  install-etcd.sh

cluster2-controlplane ~ ➜  

https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#restoring-an-etcd-cluster

ETCDCTL_API=3 etcdctl snapshot restore --data-dir <data-dir-location> snapshotdb
ETCDCTL_API=3 etcdctl snapshot restore --data-dir /var/lib/etcd-data-new cluster2.db

cluster2-controlplane ~ ➜  ls /etc/kubernetes/
admin.conf  controller-manager.conf  kubelet.conf  manifests  pki  scheduler.conf

cluster2-controlplane ~ ➜  ls /etc/kubernetes/manifests/
kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml

cluster2-controlplane ~ ➜  ETCDCTL_API=3 etcdctl snapshot restore --data-dir /var/lib/etcd-data-new cluster2.db
2023-08-08 02:53:35.133066 I | mvcc: restore compact to 6734
2023-08-08 02:53:35.140442 I | etcdserver/membership: added member 8e9e05c52164694d [http://localhost:2380] to cluster cdf818194e3a8c32

cluster2-controlplane ~ ➜  



cluster2-controlplane ~ ➜  systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Tue 2023-08-08 01:19:12 UTC; 1h 35min ago
     Docs: https://kubernetes.io/docs/home/
 Main PID: 2128 (kubelet)
    Tasks: 47 (limit: 251379)
   CGroup: /system.slice/kubelet.service
           └─2128 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.con
f --config=/var/lib/kubelet/config.yaml --container-runtime=remote --container-runtime-endpoint=unix:///var/run/containerd/containerd.soc
k --pod-infra-container-image=k8s.gcr.io/pause:3.7

Aug 08 01:19:34 cluster2-controlplane kubelet[2128]: E0808 01:19:34.585290    2128 kuberuntime_manager.go:815] "CreatePodSandbox for pod 
failed" err="rpc error: code = Unknown desc = failed to setup network for sandbox \"8d0336f7ea31d797140762e4edde0190046fe2ced2e3ba7b4a35f
441583e9c5a\": plugin type=\"weave-net\" name=\"weave\" failed (add): unable to allocate IP address: Post \"http://127.0.0.1:6784/ip/8d03
36f7ea31d797140762e4edde0190046fe2ced2e3ba7b4a35f441583e9c5a\": dial tcp 127.0.0.1:6784: connect: connection refused" pod="kube-system/co
redns-6d4b75cb6d-tpt5p"
Aug 08 01:19:34 cluster2-controlplane kubelet[2128]: E0808 01:19:34.585364    2128 pod_workers.go:951] "Error syncing pod, skipping" err=
"failed to \"CreatePodSandbox\" for \"coredns-6d4b75cb6d-tpt5p_kube-system(3164da41-8a55-4167-a6e6-37d50f0bb7ef)\" with CreatePodSandboxE
rror: \"Failed to create sandbox for pod \\\"coredns-6d4b75cb6d-tpt5p_kube-system(3164da41-8a55-4167-a6e6-37d50f0bb7ef)\\\": rpc error: c
ode = Unknown desc = failed to setup network for sandbox \\\"8d0336f7ea31d797140762e4edde0190046fe2ced2e3ba7b4a35f441583e9c5a\\\": plugin
 type=\\\"weave-net\\\" name=\\\"weave\\\" failed (add): unable to allocate IP address: Post \\\"http://127.0.0.1:6784/ip/8d0336f7ea31d79
7140762e4edde0190046fe2ced2e3ba7b4a35f441583e9c5a\\\": dial tcp 127.0.0.1:6784: connect: connection refused\"" pod="kube-system/coredns-6
d4b75cb6d-tpt5p" podUID=3164da41-8a55-4167-a6e6-37d50f0bb7ef
Aug 08 01:19:34 cluster2-controlplane kubelet[2128]: E0808 01:19:34.892255    2128 remote_runtime.go:201] "RunPodSandbox from runtime ser
vice failed" err="rpc error: code = Unknown desc = failed to setup network for sandbox \"f453c354061501bb5b5ea8fc9befc7a84813d1fd38b05d5b
55bb51a28c38244f\": plugin type=\"weave-net\" name=\"weave\" failed (add): unable to allocate IP address: Post \"http://127.0.0.1:6784/ip
/f453c354061501bb5b5ea8fc9befc7a84813d1fd38b05d5b55bb51a28c38244f\": dial tcp 127.0.0.1:6784: connect: connection refused"
Aug 08 01:19:34 cluster2-controlplane kubelet[2128]: E0808 01:19:34.892338    2128 kuberuntime_sandbox.go:70] "Failed to create sandbox f
or pod" err="rpc error: code = Unknown desc = failed to setup network for sandbox \"f453c354061501bb5b5ea8fc9befc7a84813d1fd38b05d5b55bb5
1a28c38244f\": plugin type=\"weave-net\" name=\"weave\" failed (add): unable to allocate IP address: Post \"http://127.0.0.1:6784/ip/f453
c354061501bb5b5ea8fc9befc7a84813d1fd38b05d5b55bb51a28c38244f\": dial tcp 127.0.0.1:6784: connect: connection refused" pod="kube-system/co
redns-6d4b75cb6d-9sn4z"
Aug 08 01:19:34 cluster2-controlplane kubelet[2128]: E0808 01:19:34.892368    2128 kuberuntime_manager.go:815] "CreatePodSandbox for pod 
failed" err="rpc error: code = Unknown desc = failed to setup network for sandbox \"f453c354061501bb5b5ea8fc9befc7a84813d1fd38b05d5b55bb5
1a28c38244f\": plugin type=\"weave-net\" name=\"weave\" failed (add): unable to allocate IP address: Post \"http://127.0.0.1:6784/ip/f453
c354061501bb5b5ea8fc9befc7a84813d1fd38b05d5b55bb51a28c38244f\": dial tcp 127.0.0.1:6784: connect: connection refused" pod="kube-system/co
redns-6d4b75cb6d-9sn4z"
Aug 08 01:19:34 cluster2-controlplane kubelet[2128]: E0808 01:19:34.892474    2128 pod_workers.go:951] "Error syncing pod, skipping" err=
"failed to \"CreatePodSandbox\" for \"coredns-6d4b75cb6d-9sn4z_kube-system(af4dc646-365e-4845-92b6-c78895d2e841)\" with CreatePodSandboxE
rror: \"Failed to create sandbox for pod \\\"coredns-6d4b75cb6d-9sn4z_kube-system(af4dc646-365e-4845-92b6-c78895d2e841)\\\": rpc error: c
ode = Unknown desc = failed to setup network for sandbox \\\"f453c354061501bb5b5ea8fc9befc7a84813d1fd38b05d5b55bb51a28c38244f\\\": plugin
 type=\\\"weave-net\\\" name=\\\"weave\\\" failed (add): unable to allocate IP address: Post \\\"http://127.0.0.1:6784/ip/f453c354061501b

cluster2-controlplane ~ ➜  systemctl restart kubelet

cluster2-controlplane ~ ➜  systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Tue 2023-08-08 02:55:01 UTC; 1s ago
     Docs: https://kubernetes.io/docs/home/
 Main PID: 11775 (kubelet)
    Tasks: 30 (limit: 251379)
   CGroup: /system.slice/kubelet.service
           └─11775 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.co
nf --config=/var/lib/kubelet/config.yaml --container-runtime=remote --container-runtime-endpoint=unix:///var/run/containerd/containerd.so
ck --pod-infra-container-image=k8s.gcr.io/pause:3.7

Aug 08 02:55:03 cluster2-controlplane kubelet[11775]: I0808 02:55:03.086185   11775 manager.go:610] "Failed to read data from checkpoint"
 checkpoint="kubelet_internal_checkpoint" err="checkpoint is not found"
Aug 08 02:55:03 cluster2-controlplane kubelet[11775]: I0808 02:55:03.088188   11775 plugin_manager.go:114] "Starting Kubelet Plugin Manag
er"
Aug 08 02:55:03 cluster2-controlplane kubelet[11775]: I0808 02:55:03.112879   11775 apiserver.go:52] "Watching apiserver"
Aug 08 02:55:03 cluster2-controlplane kubelet[11775]: I0808 02:55:03.282616   11775 topology_manager.go:200] "Topology Admit Handler"
Aug 08 02:55:03 cluster2-controlplane kubelet[11775]: I0808 02:55:03.282895   11775 topology_manager.go:200] "Topology Admit Handler"
Aug 08 02:55:03 cluster2-controlplane kubelet[11775]: I0808 02:55:03.282971   11775 topology_manager.go:200] "Topology Admit Handler"
Aug 08 02:55:03 cluster2-controlplane kubelet[11775]: I0808 02:55:03.283229   11775 topology_manager.go:200] "Topology Admit Handler"
Aug 08 02:55:03 cluster2-controlplane kubelet[11775]: I0808 02:55:03.284996   11775 topology_manager.go:200] "Topology Admit Handler"
Aug 08 02:55:03 cluster2-controlplane kubelet[11775]: I0808 02:55:03.285378   11775 topology_manager.go:200] "Topology Admit Handler"
Aug 08 02:55:03 cluster2-controlplane kubelet[11775]: I0808 02:55:03.285762   11775 topology_manager.go:200] "Topology Admit Handler"

cluster2-controlplane ~ ➜  


student-node ~ ✖ kubectl get pods -A
NAMESPACE     NAME                                            READY   STATUS    RESTARTS      AGE
kube-system   coredns-6d4b75cb6d-9sn4z                        1/1     Running   0             96m
kube-system   coredns-6d4b75cb6d-tpt5p                        1/1     Running   0             96m
kube-system   kube-apiserver-cluster2-controlplane            1/1     Running   0             96m
kube-system   kube-controller-manager-cluster2-controlplane   1/1     Running   1 (89m ago)   96m
kube-system   kube-proxy-g4p62                                1/1     Running   0             95m
kube-system   kube-proxy-khv29                                1/1     Running   0             96m
kube-system   kube-scheduler-cluster2-controlplane            1/1     Running   1 (89m ago)   96m
kube-system   weave-net-fcpwg                                 2/2     Running   0             95m
kube-system   weave-net-l8g8l                                 2/2     Running   1 (96m ago)   96m

student-node ~ ➜  kubectl delete pods kube-controller-manager-cluster2-controlplane kube-scheduler-cluster2-controlplane -n kube-system
pod "kube-controller-manager-cluster2-controlplane" deleted
pod "kube-scheduler-cluster2-controlplane" deleted

student-node ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                            READY   STATUS    RESTARTS      AGE
kube-system   coredns-6d4b75cb6d-9sn4z                        1/1     Running   0             96m
kube-system   coredns-6d4b75cb6d-tpt5p                        1/1     Running   0             96m
kube-system   kube-apiserver-cluster2-controlplane            1/1     Running   0             96m
kube-system   kube-controller-manager-cluster2-controlplane   0/1     Pending   0             3s
kube-system   kube-proxy-g4p62                                1/1     Running   0             96m
kube-system   kube-proxy-khv29                                1/1     Running   0             96m
kube-system   kube-scheduler-cluster2-controlplane            0/1     Pending   0             3s
kube-system   weave-net-fcpwg                                 2/2     Running   0             96m
kube-system   weave-net-l8g8l                                 2/2     Running   1 (96m ago)   96m

student-node ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                            READY   STATUS    RESTARTS      AGE
kube-system   coredns-6d4b75cb6d-9sn4z                        1/1     Running   0             96m
kube-system   coredns-6d4b75cb6d-tpt5p                        1/1     Running   0             96m
kube-system   kube-apiserver-cluster2-controlplane            1/1     Running   0             96m
kube-system   kube-controller-manager-cluster2-controlplane   1/1     Running   1 (89m ago)   9s
kube-system   kube-proxy-g4p62                                1/1     Running   0             96m
kube-system   kube-proxy-khv29                                1/1     Running   0             96m
kube-system   kube-scheduler-cluster2-controlplane            1/1     Running   1 (89m ago)   9s
kube-system   weave-net-fcpwg                                 2/2     Running   0             96m
kube-system   weave-net-l8g8l                                 2/2     Running   1 (96m ago)   96m

student-node ~ ➜  date
Tue Aug  8 02:56:10 UTC 2023

student-node ~ ➜  

cluster2-controlplane ~ ➜  systemctl | grep api
var-lib-kubelet-pods-07922376\x2dae07\x2d466d\x2da3f2\x2dd9ca801e7372-volumes-kubernetes.io\x7eprojected-kube\x2dapi\x2daccess\x2ddtg69.mount loaded active     mounted   /var/lib/kubelet/pods/07922376-ae07-466d-a3f2-d9ca801e7372/volumes/kubernetes.io~projected/kube-api-access-dtg69            
var-lib-kubelet-pods-3164da41\x2d8a55\x2d4167\x2da6e6\x2d37d50f0bb7ef-volumes-kubernetes.io\x7eprojected-kube\x2dapi\x2daccess\x2dt8qqj.mount loaded active     mounted   /var/lib/kubelet/pods/3164da41-8a55-4167-a6e6-37d50f0bb7ef/volumes/kubernetes.io~projected/kube-api-access-t8qqj            
var-lib-kubelet-pods-978c38b9\x2d530a\x2d427d\x2d83f3\x2d0fec826fa848-volumes-kubernetes.io\x7eprojected-kube\x2dapi\x2daccess\x2dsw6kd.mount loaded active     mounted   /var/lib/kubelet/pods/978c38b9-530a-427d-83f3-0fec826fa848/volumes/kubernetes.io~projected/kube-api-access-sw6kd            
var-lib-kubelet-pods-af4dc646\x2d365e\x2d4845\x2d92b6\x2dc78895d2e841-volumes-kubernetes.io\x7eprojected-kube\x2dapi\x2daccess\x2dtmbhv.mount loaded active     mounted   /var/lib/kubelet/pods/af4dc646-365e-4845-92b6-c78895d2e841/volumes/kubernetes.io~projected/kube-api-access-tmbhv            

cluster2-controlplane ~ ➜  ps -ef | grep api
root        1780    1385  7 01:19 ?        00:05:27 kube-apiserver --advertise-address=192.4.53.22 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.pem --etcd-certfile=/etc/kubernetes/pki/etcd/etcd.pem --etcd-keyfile=/etc/kubernetes/pki/etcd/etcd-key.pem --etcd-servers=https://192.4.53.12:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root        3855    3750  0 01:19 ?        00:00:05 /home/weave/weaver --port=6783 --datapath=datapath --name=aa:78:96:30:4f:d9 --http-addr=127.0.0.1:6784 --metrics-addr=0.0.0.0:6782 --docker-api= --no-dns --db-prefix=/weavedb/weave-net --ipalloc-range=10.50.0.0/16 --nickname=cluster2-controlplane --ipalloc-init consensus=0 --conn-limit=200 --expect-npc --no-masq-local
root       12269   11017  0 02:56 pts/1    00:00:00 grep api

cluster2-controlplane ~ ➜  systemctl status kube-apiserver
Unit kube-apiserver.service could not be found.

cluster2-controlplane ~ ✖ 


Move the backup to the etcd-server node

scp /opt/cluster2.db etcd-server:~/


ssh etcd-server

ls -ld /var/lib/etcd-data/

    Note that owner and group are both etcd

Do the restore

ETCDCTL_API=3 etcdctl snapshot restore \
    --data-dir /var/lib/etcd-data-new \
    cluster2.db

Set ownership on the restored directory

chown -R etcd:etcd /var/lib/etcd-data-new

Reconfigure and restart etcd

We will need the location of the service unit file which we also determined in Q12

vi /etc/systemd/system/etcd.service

Edit the --data-dir argument to the newly restored directory, and save.


student-node /opt ➜  ssh etcd-server
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.
Last login: Tue Aug  8 02:36:31 2023 from 192.4.53.17

etcd-server ~ ➜  ls -ld /var/lib/etcd-data/
drwx------ 1 etcd etcd 4096 Aug  8 01:26 /var/lib/etcd-data/

etcd-server ~ ➜  

etcd-server ~ ➜  ETCDCTL_API=3 etcdctl snapshot restore \
>     --data-dir /var/lib/etcd-data-new \
>     cluster2.db
{"level":"info","ts":1691463683.071083,"caller":"snapshot/v3_snapshot.go:296","msg":"restoring snapshot","path":"cluster2.db","wal-dir":"/var/lib/etcd-data-new/member/wal","data-dir":"/var/lib/etcd-data-new","snap-dir":"/var/lib/etcd-data-new/member/snap"}
{"level":"info","ts":1691463683.0985966,"caller":"mvcc/kvstore.go:388","msg":"restored last compact revision","meta-bucket-name":"meta","meta-bucket-name-key":"finishedCompactRev","restored-compact-revision":6734}
{"level":"info","ts":1691463683.1098518,"caller":"membership/cluster.go:392","msg":"added member","cluster-id":"cdf818194e3a8c32","local-member-id":"0","added-peer-id":"8e9e05c52164694d","added-peer-peer-urls":["http://localhost:2380"]}
{"level":"info","ts":1691463683.1270738,"caller":"snapshot/v3_snapshot.go:309","msg":"restored snapshot","path":"cluster2.db","wal-dir":"/var/lib/etcd-data-new/member/wal","data-dir":"/var/lib/etcd-data-new","snap-dir":"/var/lib/etcd-data-new/member/snap"}

etcd-server ~ ➜  ls -lhasp /var/lib/etcd-data-new
total 16K
4.0K drwx------ 3 root root 4.0K Aug  8 03:01 ./
8.0K drwxr-xr-x 1 root root 4.0K Aug  8 03:01 ../
4.0K drwx------ 4 root root 4.0K Aug  8 03:01 member/

etcd-server ~ ➜  chown -R etcd:etcd /var/lib/etcd-data-new

etcd-server ~ ➜  vi /etc/systemd/system/etcd.service

etcd-server ~ ➜  

etcd-server ~ ➜  vi /etc/systemd/system/etcd.service

etcd-server ~ ➜  

etcd-server ~ ➜  

etcd-server ~ ➜  cat /etc/systemd/system/etcd.service
[Unit]
Description=etcd key-value store
Documentation=https://github.com/etcd-io/etcd
After=network.target

[Service]
User=etcd
Type=notify
ExecStart=/usr/local/bin/etcd \
  --name etcd-server \
  --data-dir=/var/lib/etcd-data-new \
  --cert-file=/etc/etcd/pki/etcd.pem \
  --key-file=/etc/etcd/pki/etcd-key.pem \
  --peer-cert-file=/etc/etcd/pki/etcd.pem \
  --peer-key-file=/etc/etcd/pki/etcd-key.pem \
  --trusted-ca-file=/etc/etcd/pki/ca.pem \
  --peer-trusted-ca-file=/etc/etcd/pki/ca.pem \
  --peer-client-cert-auth \
  --client-cert-auth \
  --initial-advertise-peer-urls https://192.4.53.12:2380 \
  --listen-peer-urls https://192.4.53.12:2380 \
  --advertise-client-urls https://192.4.53.12:2379 \
  --listen-client-urls https://192.4.53.12:2379,https://127.0.0.1:2379 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster etcd-server=https://192.4.53.12:2380 \
  --initial-cluster-state new
Restart=on-failure
RestartSec=5
LimitNOFILE=40000

[Install]
WantedBy=multi-user.target

etcd-server ~ ➜  
etcd-server ~ ➜  

etcd-server ~ ➜  systemctl daemon-reload

etcd-server ~ ➜  systemctl restart etcd.service

etcd-server ~ ➜  


kubectl config use-context cluster2
kubectl get all -n critical



- Efetuar restart dos seguintes serviços, após ajustar o ETCD External:
1. kube-controller-manager
2. scheduler

kubectl delete pods kube-controller-manager scheduler -n kube-system

- Depois é necessário acessar o controlplane do cluster2 via SSH:
ssh cluster2-controlplane

- Reiniciar o serviço do Kubelet
systemctl restart kubelet
systemctl status kubelet


etcd-server ~ ➜  systemctl status daemon-reload
Unit daemon-reload.service could not be found.

etcd-server ~ ✖ systemctl status etcd.service
● etcd.service - etcd key-value store
   Loaded: loaded (/etc/systemd/system/etcd.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2023-08-08 03:03:22 UTC; 5min ago
     Docs: https://github.com/etcd-io/etcd
 Main PID: 2921 (etcd)
    Tasks: 45 (limit: 251379)
   CGroup: /system.slice/etcd.service
           └─2921 /usr/local/bin/etcd --name etcd-server --data-dir=/var/lib/etcd-data-new --cert-file=/etc/etcd/pki/etcd.pem --key-file=
/etc/etcd/pki/etcd-key.pem --peer-cert-file=/etc/etcd/pki/etcd.pem --peer-key-file=/etc/etcd/pki/etcd-key.pem --trusted-ca-file=/etc/etcd
/pki/ca.pem --peer-trusted-ca-file=/etc/etcd/pki/ca.pem --peer-client-cert-auth --client-cert-auth --initial-advertise-peer-urls https://
192.4.53.12:2380 --listen-peer-urls https://192.4.53.12:2380 --advertise-client-urls https://192.4.53.12:2379 --listen-client-urls https:
//192.4.53.12:2379,https://127.0.0.1:2379 --initial-cluster-token etcd-cluster-1 --initial-cluster etcd-server=https://192.4.53.12:2380 -
-initial-cluster-state new

Aug 08 03:03:22 etcd-server etcd[2921]: setting up the initial cluster version to 3.4
Aug 08 03:03:22 etcd-server etcd[2921]: ready to serve client requests
Aug 08 03:03:22 etcd-server etcd[2921]: published {Name:etcd-server ClientURLs:[https://192.4.53.12:2379]} to cluster cdf818194e3a8c32
Aug 08 03:03:22 etcd-server etcd[2921]: ready to serve client requests
Aug 08 03:03:22 etcd-server etcd[2921]: set the initial cluster version to 3.4
Aug 08 03:03:22 etcd-server etcd[2921]: enabled capabilities for version 3.4
Aug 08 03:03:22 etcd-server etcd[2921]: serving client requests on 127.0.0.1:2379
Aug 08 03:03:22 etcd-server etcd[2921]: serving client requests on 192.4.53.12:2379
Aug 08 03:09:04 etcd-server etcd[2921]: store.index: compact 7374
Aug 08 03:09:04 etcd-server etcd[2921]: finished scheduled compaction at 7374 (took 1.491249ms)

etcd-server ~ ➜  

student-node ~ ➜  ssh cluster2-controlplane
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.
Last login: Tue Aug  8 02:50:54 2023 from 192.4.53.10

cluster2-controlplane ~ ➜  systemctl restart kubelet

cluster2-controlplane ~ ➜  systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Tue 2023-08-08 03:09:48 UTC; 255ms ago
     Docs: https://kubernetes.io/docs/home/
 Main PID: 13341 (kubelet)
    Tasks: 15 (limit: 251379)
   CGroup: /system.slice/kubelet.service
           └─13341 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.co
nf --config=/var/lib/kubelet/config.yaml --container-runtime=remote --container-runtime-endpoint=unix:///var/run/containerd/containerd.so
ck --pod-infra-container-image=k8s.gcr.io/pause:3.7

cluster2-controlplane ~ ➜  systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Tue 2023-08-08 03:09:48 UTC; 5s ago
     Docs: https://kubernetes.io/docs/home/
 Main PID: 13341 (kubelet)
    Tasks: 31 (limit: 251379)
   CGroup: /system.slice/kubelet.service
           └─13341 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.co
nf --config=/var/lib/kubelet/config.yaml --container-runtime=remote --container-runtime-endpoint=unix:///var/run/containerd/containerd.so
ck --pod-infra-container-image=k8s.gcr.io/pause:3.7

Aug 08 03:09:50 cluster2-controlplane kubelet[13341]: I0808 03:09:50.182522   13341 reconciler.go:270] "operationExecutor.VerifyControlle
rAttachedVolume started for volume \"kube-api-access-sw6kd\" (UniqueName: \"kubernetes.io/projected/978c38b9-530a-427d-83f3-0fec826fa848-
kube-api-access-sw6kd\") pod \"kube-proxy-khv29\" (UID: \"978c38b9-530a-427d-83f3-0fec826fa848\") " pod="kube-system/kube-proxy-khv29"
Aug 08 03:09:50 cluster2-controlplane kubelet[13341]: I0808 03:09:50.182571   13341 reconciler.go:270] "operationExecutor.VerifyControlle
rAttachedVolume started for volume \"kube-api-access-dtg69\" (UniqueName: \"kubernetes.io/projected/07922376-ae07-466d-a3f2-d9ca801e7372-
kube-api-access-dtg69\") pod \"weave-net-l8g8l\" (UID: \"07922376-ae07-466d-a3f2-d9ca801e7372\") " pod="kube-system/weave-net-l8g8l"
Aug 08 03:09:50 cluster2-controlplane kubelet[13341]: I0808 03:09:50.182638   13341 reconciler.go:270] "operationExecutor.VerifyControlle
rAttachedVolume started for volume \"config-volume\" (UniqueName: \"kubernetes.io/configmap/3164da41-8a55-4167-a6e6-37d50f0bb7ef-config-v
olume\") pod \"coredns-6d4b75cb6d-tpt5p\" (UID: \"3164da41-8a55-4167-a6e6-37d50f0bb7ef\") " pod="kube-system/coredns-6d4b75cb6d-tpt5p"
Aug 08 03:09:50 cluster2-controlplane kubelet[13341]: I0808 03:09:50.182714   13341 reconciler.go:270] "operationExecutor.VerifyControlle
rAttachedVolume started for volume \"kube-api-access-t8qqj\" (UniqueName: \"kubernetes.io/projected/3164da41-8a55-4167-a6e6-37d50f0bb7ef-
kube-api-access-t8qqj\") pod \"coredns-6d4b75cb6d-tpt5p\" (UID: \"3164da41-8a55-4167-a6e6-37d50f0bb7ef\") " pod="kube-system/coredns-6d4b
75cb6d-tpt5p"
Aug 08 03:09:50 cluster2-controlplane kubelet[13341]: I0808 03:09:50.182768   13341 reconciler.go:270] "operationExecutor.VerifyControlle
rAttachedVolume started for volume \"kube-proxy\" (UniqueName: \"kubernetes.io/configmap/978c38b9-530a-427d-83f3-0fec826fa848-kube-proxy\
") pod \"kube-proxy-khv29\" (UID: \"978c38b9-530a-427d-83f3-0fec826fa848\") " pod="kube-system/kube-proxy-khv29"
Aug 08 03:09:50 cluster2-controlplane kubelet[13341]: I0808 03:09:50.182868   13341 reconciler.go:270] "operationExecutor.VerifyControlle
rAttachedVolume started for volume \"xtables-lock\" (UniqueName: \"kubernetes.io/host-path/07922376-ae07-466d-a3f2-d9ca801e7372-xtables-l
ock\") pod \"weave-net-l8g8l\" (UID: \"07922376-ae07-466d-a3f2-d9ca801e7372\") " pod="kube-system/weave-net-l8g8l"
Aug 08 03:09:50 cluster2-controlplane kubelet[13341]: I0808 03:09:50.182911   13341 reconciler.go:270] "operationExecutor.VerifyControlle
rAttachedVolume started for volume \"config-volume\" (UniqueName: \"kubernetes.io/configmap/af4dc646-365e-4845-92b6-c78895d2e841-config-v
olume\") pod \"coredns-6d4b75cb6d-9sn4z\" (UID: \"af4dc646-365e-4845-92b6-c78895d2e841\") " pod="kube-system/coredns-6d4b75cb6d-9sn4z"
Aug 08 03:09:50 cluster2-controlplane kubelet[13341]: I0808 03:09:50.182937   13341 reconciler.go:157] "Reconciler: start to sync state"
Aug 08 03:09:51 cluster2-controlplane kubelet[13341]: I0808 03:09:51.883373   13341 prober_manager.go:255] "Failed to trigger a manual ru
n" probe="Readiness"
Aug 08 03:09:51 cluster2-controlplane kubelet[13341]: I0808 03:09:51.883404   13341 prober_manager.go:255] "Failed to trigger a manual ru
n" probe="Readiness"

cluster2-controlplane ~ ➜  


- Pods do controller e do scheduler só ficam em terminating:


student-node ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                            READY   STATUS        RESTARTS       AGE
critical      critical-deployment-240616-5bf45c9459-m9dsl     1/1     Running       0              46m
critical      critical-deployment-240616-5bf45c9459-t29p5     1/1     Running       0              46m
kube-system   coredns-6d4b75cb6d-9sn4z                        1/1     Running       0              111m
kube-system   coredns-6d4b75cb6d-tpt5p                        1/1     Running       0              111m
kube-system   kube-apiserver-cluster2-controlplane            1/1     Running       0              111m
kube-system   kube-controller-manager-cluster2-controlplane   1/1     Terminating   1 (104m ago)   111m
kube-system   kube-proxy-g4p62                                1/1     Running       0              110m
kube-system   kube-proxy-khv29                                1/1     Running       0              111m
kube-system   kube-scheduler-cluster2-controlplane            1/1     Terminating   1 (104m ago)   111m
kube-system   weave-net-fcpwg                                 2/2     Running       0              110m
kube-system   weave-net-l8g8l                                 2/2     Running       1 (110m ago)   111m

student-node ~ ➜  


- Deletados alguns pods com o --force

student-node /opt ➜  kubectl get pods -n kube-system
NAME                                            READY   STATUS    RESTARTS       AGE
coredns-6d4b75cb6d-9sn4z                        1/1     Running   0              116m
coredns-6d4b75cb6d-tpt5p                        1/1     Running   0              116m
kube-controller-manager-cluster2-controlplane   1/1     Running   1 (109m ago)   23s
kube-proxy-g4p62                                1/1     Running   0              116m
kube-proxy-khv29                                1/1     Running   0              116m
kube-scheduler-cluster2-controlplane            1/1     Running   1 (109m ago)   7s
weave-net-fcpwg                                 2/2     Running   0              116m
weave-net-l8g8l                                 2/2     Running   1 (116m ago)   116m

student-node /opt ➜  date
Tue Aug  8 03:16:10 UTC 2023
student-node /opt ➜  

student-node /opt ➜  kubectl get pods -n kube-system
NAME                                            READY   STATUS    RESTARTS       AGE
coredns-6d4b75cb6d-9sn4z                        1/1     Running   0              117m
coredns-6d4b75cb6d-tpt5p                        1/1     Running   0              117m
kube-apiserver-cluster2-controlplane            1/1     Running   0              13s
kube-controller-manager-cluster2-controlplane   1/1     Running   1 (110m ago)   49s
kube-proxy-g4p62                                1/1     Running   0              116m
kube-proxy-khv29                                1/1     Running   0              117m
kube-scheduler-cluster2-controlplane            1/1     Running   1 (110m ago)   33s
weave-net-fcpwg                                 2/2     Running   0              116m
weave-net-l8g8l                                 2/2     Running   1 (117m ago)   117m

student-node /opt ➜  date
Tue Aug  8 03:16:35 UTC 2023

student-node /opt ➜  

student-node /opt ➜  