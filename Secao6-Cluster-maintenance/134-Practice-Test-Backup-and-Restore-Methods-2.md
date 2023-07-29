

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



## PENDENTE
- Ver sobre questão "How is ETCD configured for cluster2?", porque é EXTERNAL ETCD.