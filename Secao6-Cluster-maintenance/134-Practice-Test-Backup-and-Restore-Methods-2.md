

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

