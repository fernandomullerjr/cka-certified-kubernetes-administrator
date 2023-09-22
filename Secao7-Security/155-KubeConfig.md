



# ############################################################################
# ############################################################################
# ############################################################################
# push

git status
git add .
git commit -m "155. KubeConfig."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ############################################################################
# ############################################################################
# ############################################################################
# 155. KubeConfig

# KubeConfig 

In this section, we will take a look at kubeconfig in kubernetes


#### Client uses the certificate file and key to query the kubernetes Rest API for a list of pods using curl.
- You can specify the same using kubectl

  ![kc1](../../images/kc1.PNG)
  
- We can move these information to a configuration file called kubeconfig. And the specify this file as the kubeconfig option in the command.
  ```
  $ kubectl get pods --kubeconfig config
  ```
  
## Kubeconfig File
- The kubeconfig file has 3 sections
  - Clusters
  - Contexts
  - USers
  
  ![kc4](../../images/kc4.PNG)
  
  ![kc5](../../images/kc5.PNG)
  
- To view the current file being used
  ```
  $ kubectl config view
  ```
- You can specify the kubeconfig file with kubectl config view with "--kubeconfig" flag
  ```
  $ kubectl config veiw --kubeconfig=my-custom-config
  ```
  
  ![kc6](../../images/kc6.PNG)
  
- How do you update your current context? Or change the current context
  ```
  $ kubectl config view --kubeconfig=my-custom-config
  ```
  
  ![kc7](../../images/kc7.PNG)
  
- kubectl config help
  ```
  $ kubectl config -h
  ```
  
  ![kc8](../../images/kc8.PNG)
  
## What about namespaces?

  ![kc9](../../images/kc9.PNG)
 
## Certificates in kubeconfig

  ![kc10](../../images/kc10.PNG)
 
  ![kc12](../../images/kc12.PNG)
  
  ![kc11](../../images/kc11.PNG)
 
#### K8s Reference Docs
- https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/
- https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#config





# ############################################################################
# ############################################################################
# ############################################################################
# 155. KubeConfig


- Iniciando playground
https://killercoda.com/playgrounds/scenario/kubernetes
<https://killercoda.com/playgrounds/scenario/kubernetes>

~~~~bash
controlplane $ kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   17d   v1.28.1
node01         Ready    <none>          17d   v1.28.1
controlplane $ kubectl cluster-info
Kubernetes control plane is running at https://172.30.1.2:6443
CoreDNS is running at https://172.30.1.2:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
controlplane $ 
~~~~



- Comando:

~~~~bash
curl  https://172.30.1.2:6443/api/v1/pods \
    --key admin.key \
    --cert admin.crt \
    --cacert ca.crt
~~~~



- Erro

~~~~bash
controlplane $ curl  https://172.30.1.2:6443/api/v1/pods \
>     --key admin.key \
>     --cert admin.crt \
>     --cacert ca.crt
curl: (58) could not load PEM client certificate, OpenSSL error error:02001002:system library:fopen:No such file or directory, (no key found, wrong pass phrase, or wrong file format?)
controlplane $ 
~~~~



- Processo no node:

~~~~bash
controlplane $ ps -ef | grep crt
root       27818   27754  2 16:55 ?        00:00:11 etcd --advertise-client-urls=https://172.30.1.2:2379 --cert-file=/etc/kubernetes/pki/etcd/server.crt --client-cert-auth=true --data-dir=/var/lib/etcd --experimental-initial-corrupt-check=true --experimental-watch-progress-notify-interval=5s --initial-advertise-peer-urls=https://172.30.1.2:2380 --initial-cluster=controlplane=https://172.30.1.2:2380 --key-file=/etc/kubernetes/pki/etcd/server.key --listen-client-urls=https://127.0.0.1:2379,https://172.30.1.2:2379 --listen-metrics-urls=http://127.0.0.1:2381 --listen-peer-urls=https://172.30.1.2:2380 --name=controlplane --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt --peer-client-cert-auth=true --peer-key-file=/etc/kubernetes/pki/etcd/peer.key --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt --snapshot-count=10000 --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
root       33662   27473  0 16:59 ?        00:00:02 kube-controller-manager --allocate-node-cidrs=true --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf --bind-address=127.0.0.1 --client-ca-file=/etc/kubernetes/pki/ca.crt --cluster-cidr=192.168.0.0/16 --cluster-name=kubernetes --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt --cluster-signing-key-file=/etc/kubernetes/pki/ca.key --controllers=*,bootstrapsigner,tokencleaner --kubeconfig=/etc/kubernetes/controller-manager.conf --leader-elect=true --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-cacrt --root-ca-file=/etc/kubernetes/pki/ca.crt --service-account-private-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --use-service-account-credentials=true
root       33673   27630  3 16:59 ?        00:00:10 kube-apiserver --advertise-address=172.30.1.2 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root       37126   35750  0 17:03 pts/0    00:00:00 grep --color=auto crt
controlplane $ 
~~~~







- Comando ajustado:

~~~~bash
curl  https://172.30.1.2:6443/api/v1/pods \
    --key admin.key \
    --cert admin.crt \
    --cacert ca.crt
~~~~




~~~~bash
controlplane $ kubectl get pods --kubeconfig config
error: stat config: no such file or directory
controlplane $ ls
filesystem
controlplane $ touch config.yaml
controlplane $ kubectl get pods --kubeconfig config.yaml
E0920 17:06:19.292231   38603 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0920 17:06:19.292687   38603 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0920 17:06:19.293971   38603 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0920 17:06:19.295329   38603 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0920 17:06:19.296799   38603 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
The connection to the server localhost:8080 was refused - did you specify the right host or port?
controlplane $ 
~~~~





## PENDENTE
- Subir cluster via Kubeadm.
- Criar certificado de client, baseado na aula 152.
- Tentar comunicar com a api via curl, usando o certificado de client.






- Subir cluster via Kubeadm.

- ERROS:

~~~~bash

root@debian10x64:/home/fernando# sudo kubeadm init

[init] Using Kubernetes version: v1.28.2
[preflight] Running pre-flight checks
        [WARNING Swap]: swap is enabled; production deployments should disable swap unless testing the NodeSwap feature gate of the kubelet
        [WARNING SystemVerification]: missing optional cgroups: hugetlb
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
W0922 20:13:34.641048    3600 checks.go:835] detected that the sandbox image "registry.k8s.io/pause:3.6" of the container runtime is inconsistent with that used by kubeadm. It is recommended that using "registry.k8s.io/pause:3.9" as the CRI sandbox image.
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [debian10x64 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.92.129]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [debian10x64 localhost] and IPs [192.168.92.129 127.0.0.1 ::1]
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [debian10x64 localhost] and IPs [192.168.92.129 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[kubelet-check] Initial timeout of 40s passed.
[kubelet-check] It seems like the kubelet isn't running or healthy.
[kubelet-check] The HTTP call equal to 'curl -sSL http://localhost:10248/healthz' failed with error: Get "http://localhost:10248/healthz": dial tcp [::1]:10248: connect: connection refused.
[kubelet-check] It seems like the kubelet isn't running or healthy.
[kubelet-check] The HTTP call equal to 'curl -sSL http://localhost:10248/healthz' failed with error: Get "http://localhost:10248/healthz": dial tcp [::1]:10248: connect: connection refused.
[kubelet-check] It seems like the kubelet isn't running or healthy.
[kubelet-check] The HTTP call equal to 'curl -sSL http://localhost:10248/healthz' failed with error: Get "http://localhost:10248/healthz": dial tcp [::1]:10248: connect: connection refused.
[kubelet-check] It seems like the kubelet isn't running or healthy.
[kubelet-check] The HTTP call equal to 'curl -sSL http://localhost:10248/healthz' failed with error: Get "http://localhost:10248/healthz": dial tcp [::1]:10248: connect: connection refused.
[kubelet-check] It seems like the kubelet isn't running or healthy.
[kubelet-check] The HTTP call equal to 'curl -sSL http://localhost:10248/healthz' failed with error: Get "http://localhost:10248/healthz": dial tcp [::1]:10248: connect: connection refused.

Unfortunately, an error has occurred:
        timed out waiting for the condition

This error is likely caused by:
        - The kubelet is not running
        - The kubelet is unhealthy due to a misconfiguration of the node in some way (required cgroups disabled)

If you are on a systemd-powered system, you can try to troubleshoot the error with the following commands:
        - 'systemctl status kubelet'
        - 'journalctl -xeu kubelet'

Additionally, a control plane component may have crashed or exited when started by the container runtime.
To troubleshoot, list all containers using your preferred container runtimes CLI.
Here is one example how you may list all running Kubernetes containers by using crictl:
        - 'crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock ps -a | grep kube | grep -v pause'
        Once you have found the failing container, you can inspect its logs with:
        - 'crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock logs CONTAINERID'
error execution phase wait-control-plane: couldn't initialize a Kubernetes cluster
To see the stack trace of this error execute with --v=5 or higher
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: activating (auto-restart) (Result: exit-code) since Fri 2023-09-22 20:15:53 -03; 3s ago
     Docs: https://kubernetes.io/docs/home/
  Process: 4091 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, status=1/FAILURE)
 Main PID: 4091 (code=exited, status=1/FAILURE)
root@debian10x64:/home/fernando# systemctl enable kubelet
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: activating (auto-restart) (Result: exit-code) since Fri 2023-09-22 20:16:24 -03; 278ms ago
     Docs: https://kubernetes.io/docs/home/
  Process: 4153 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, status=1/FAILURE)
 Main PID: 4153 (code=exited, status=1/FAILURE)
root@debian10x64:/home/fernando# systemctl start kubelet
root@debian10x64:/home/fernando# systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: activating (auto-restart) (Result: exit-code) since Fri 2023-09-22 20:16:34 -03; 1s ago
     Docs: https://kubernetes.io/docs/home/
  Process: 4171 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, status=1/FAILURE)
 Main PID: 4171 (code=exited, status=1/FAILURE)




If you are on a systemd-powered system, you can try to troubleshoot the error with the following commands:
        - 'systemctl status kubelet'
        - 'journalctl -xeu kubelet'



-- The job identifier is 9113.
Sep 22 20:17:46 debian10x64 kubelet[4268]: Flag --container-runtime-endpoint has been deprecated, This parameter should be set via the config file specified by the Kubelet's --config fla
Sep 22 20:17:46 debian10x64 kubelet[4268]: Flag --pod-infra-container-image has been deprecated, will be removed in a future release. Image garbage collector will get sandbox image infor
Sep 22 20:17:46 debian10x64 kubelet[4268]: I0922 20:17:46.270924    4268 server.go:203] "--pod-infra-container-image will not be pruned by the image garbage collector in kubelet and shou
Sep 22 20:17:46 debian10x64 kubelet[4268]: I0922 20:17:46.277745    4268 server.go:467] "Kubelet version" kubeletVersion="v1.28.1"
Sep 22 20:17:46 debian10x64 kubelet[4268]: I0922 20:17:46.277814    4268 server.go:469] "Golang settings" GOGC="" GOMAXPROCS="" GOTRACEBACK=""
Sep 22 20:17:46 debian10x64 kubelet[4268]: I0922 20:17:46.278156    4268 server.go:895] "Client rotation is on, will bootstrap in background"
Sep 22 20:17:46 debian10x64 kubelet[4268]: I0922 20:17:46.280370    4268 certificate_store.go:130] Loading cert/key pair from "/var/lib/kubelet/pki/kubelet-client-current.pem".
Sep 22 20:17:46 debian10x64 kubelet[4268]: I0922 20:17:46.281736    4268 dynamic_cafile_content.go:157] "Starting controller" name="client-ca-bundle::/etc/kubernetes/pki/ca.crt"
Sep 22 20:17:46 debian10x64 kubelet[4268]: I0922 20:17:46.304573    4268 server.go:725] "--cgroups-per-qos enabled, but --cgroup-root was not specified.  defaulting to /"
Sep 22 20:17:46 debian10x64 kubelet[4268]: E0922 20:17:46.305124    4268 run.go:74] "command failed" err="failed to run Kubelet: running with swap on is not supported, please disable swa
Sep 22 20:17:46 debian10x64 systemd[1]: kubelet.service: Main process exited, code=exited, status=1/FAILURE
-- Subject: Unit process exited
-- Defined-By: systemd
-- Support: https://www.debian.org/support
--
-- An ExecStart= process belonging to unit kubelet.service has exited.
--
-- The process' exit code is 'exited' and its exit status is 1.
Sep 22 20:17:46 debian10x64 systemd[1]: kubelet.service: Failed with result 'exit-code'.
-- Subject: Unit failed
-- Defined-By: systemd
-- Support: https://www.debian.org/support
--
-- The unit kubelet.service has entered the 'failed' state with result 'exit-code'.
lines 3004-3049/3049 (END)

~~~~







 4268 run.go:74] "command failed" err="failed to run Kubelet: running with swap on is not supported, please disable swa






root@debian10x64:/home/fernando# free -h
              total        used        free      shared  buff/cache   available
Mem:          9.6Gi       986Mi       6.3Gi       9.0Mi       2.3Gi       8.3Gi
Swap:         975Mi          0B       975Mi
root@debian10x64:/home/fernando#

root@debian10x64:/home/fernando# blkid
/dev/sr0: UUID="2021-06-19-16-14-34-00" LABEL="Debian 10.10.0 amd64 n" TYPE="iso9660" PTUUID="0d28081a" PTTYPE="dos"
/dev/sda1: UUID="4bdfda28-f25a-48ef-9fa2-1fc10c59efc8" TYPE="ext2" PARTUUID="61c0bc9e-01"
/dev/sda3: UUID="caZWCB-3LMa-laIM-1dC4-MJbM-XiT3-9epM7g" TYPE="LVM2_member" PARTUUID="61c0bc9e-03"
/dev/sda5: UUID="LOU9xG-GLZl-2x29-jp1L-9TaU-tych-6GzOQy" TYPE="LVM2_member" PARTUUID="61c0bc9e-05"
/dev/mapper/debian10x64--vg-root: UUID="e75eefef-1d8f-4860-9d6d-6ecb6c3ed630" TYPE="ext4"
/dev/mapper/debian10x64--vg-swap_1: UUID="9dd96a23-e030-45e0-9b9c-6d82d54422a9" TYPE="swap"
/dev/loop1: TYPE="squashfs"
/dev/loop2: TYPE="squashfs"
/dev/loop3: TYPE="squashfs"
/dev/loop4: TYPE="squashfs"
/dev/loop5: TYPE="squashfs"
/dev/loop6: TYPE="squashfs"
/dev/loop7: TYPE="squashfs"
root@debian10x64:/home/fernando#

root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# lsblk
NAME                       MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
fd0                          2:0    1     4K  0 disk
loop1                        7:1    0 116.7M  1 loop /snap/robo3t-snap/9
loop2                        7:2    0  55.7M  1 loop /snap/core18/2790
loop3                        7:3    0  55.7M  1 loop /snap/core18/2785
loop4                        7:4    0 105.8M  1 loop /snap/core/16091
loop5                        7:5    0 105.8M  1 loop /snap/core/15925
loop6                        7:6    0 272.8M  1 loop /snap/kontena-lens/245
loop7                        7:7    0 272.8M  1 loop /snap/kontena-lens/246
sda                          8:0    0    60G  0 disk
├─sda1                       8:1    0   487M  0 part /boot
├─sda2                       8:2    0     1K  0 part
├─sda3                       8:3    0    20G  0 part
│ └─debian10x64--vg-root   254:0    0  58.6G  0 lvm  /
└─sda5                       8:5    0  39.5G  0 part
  ├─debian10x64--vg-root   254:0    0  58.6G  0 lvm  /
  └─debian10x64--vg-swap_1 254:1    0   976M  0 lvm  [SWAP]
sr0                         11:0    1   336M  0 rom
root@debian10x64:/home/fernando#


root@debian10x64:/home/fernando# df -h
Filesystem                        Size  Used Avail Use% Mounted on
udev                              4.8G     0  4.8G   0% /dev
tmpfs                             983M  9.4M  973M   1% /run
/dev/mapper/debian10x64--vg-root   58G   47G  8.5G  85% /
tmpfs                             4.8G     0  4.8G   0% /dev/shm
tmpfs                             5.0M     0  5.0M   0% /run/lock
tmpfs                             4.8G     0  4.8G   0% /sys/fs/cgroup
/dev/loop3                         56M   56M     0 100% /snap/core18/2785
/dev/loop1                        117M  117M     0 100% /snap/robo3t-snap/9
/dev/loop2                         56M   56M     0 100% /snap/core18/2790
/dev/loop4                        106M  106M     0 100% /snap/core/16091
/dev/loop5                        106M  106M     0 100% /snap/core/15925
/dev/loop6                        273M  273M     0 100% /snap/kontena-lens/245
/dev/sda1                         472M   59M  389M  14% /boot
tmpfs                             983M   28K  983M   1% /run/user/117
tmpfs                             983M     0  983M   0% /run/user/1000
/dev/loop7                        273M  273M     0 100% /snap/kontena-lens/246
root@debian10x64:/home/fernando#







Run the below command to deactivate the swap area after you have identified the swap partition or file.

swapoff /dev/mapper/centos-swap 

Or disable all swaps from /proc/swaps.

swapoff -a 


To check if the swap area has been disabled, run the free command.

free -h

To permanently disable Linux swap space, open the /etc/fstab file, search for a swap line and add a # (hashtag) sign in front of the line to comment on the entire line, as shown in the screenshot below.

vi /etc/fstab

Afterwards, reboot the system in order to apply the new swap setting or issuing mount -a command in some cases might do the trick.

mount -a






- Comandos

swapoff /dev/mapper/debian10x64--vg-swap_1

swapoff -a 

vi /etc/fstab





- DEPOIS


root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# free -h
              total        used        free      shared  buff/cache   available
Mem:          9.6Gi       1.4Gi       5.8Gi        10Mi       2.4Gi       7.9Gi
Swap:            0B          0B          0B
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# df -h
Filesystem                        Size  Used Avail Use% Mounted on
udev                              4.8G     0  4.8G   0% /dev
tmpfs                             983M   10M  973M   2% /run
/dev/mapper/debian10x64--vg-root   58G   47G  8.4G  85% /
tmpfs                             4.8G     0  4.8G   0% /dev/shm
tmpfs                             5.0M     0  5.0M   0% /run/lock
tmpfs                             4.8G     0  4.8G   0% /sys/fs/cgroup
/dev/loop3                         56M   56M     0 100% /snap/core18/2785
/dev/loop1                        117M  117M     0 100% /snap/robo3t-snap/9
/dev/loop2                         56M   56M     0 100% /snap/core18/2790
/dev/loop4                        106M  106M     0 100% /snap/core/16091
/dev/loop5                        106M  106M     0 100% /snap/core/15925
/dev/loop6                        273M  273M     0 100% /snap/kontena-lens/245
/dev/sda1                         472M   59M  389M  14% /boot
tmpfs                             983M   28K  983M   1% /run/user/117
tmpfs                             983M     0  983M   0% /run/user/1000
/dev/loop7                        273M  273M     0 100% /snap/kontena-lens/246
shm                                64M     0   64M   0% /run/containerd/io.containerd.grpc.v1.cri/sandboxes/3325d8e52f8d3f87e5a603754096a26c3742b942a13f31bad0965749b1f29b2e/shm
shm                                64M     0   64M   0% /run/containerd/io.containerd.grpc.v1.cri/sandboxes/6567d17b2f2b673e8885213821d14921311717cf003cbf136689ee61749ea7f2/shm
shm                                64M     0   64M   0% /run/containerd/io.containerd.grpc.v1.cri/sandboxes/e355088bff3cba32a50dfb0f43101de77f70d3760b1d1d2004dc1d30b6024101/shm
shm                                64M     0   64M   0% /run/containerd/io.containerd.grpc.v1.cri/sandboxes/5903c5da31d6ed0d321c419dab409a7ce48d00cb75138c1a5223a5d25afe79e9/shm
overlay                            58G   47G  8.4G  85% /run/containerd/io.containerd.runtime.v2.task/k8s.io/e355088bff3cba32a50dfb0f43101de77f70d3760b1d1d2004dc1d30b6024101/rootfs
overlay                            58G   47G  8.4G  85% /run/containerd/io.containerd.runtime.v2.task/k8s.io/5903c5da31d6ed0d321c419dab409a7ce48d00cb75138c1a5223a5d25afe79e9/rootfs
overlay                            58G   47G  8.4G  85% /run/containerd/io.containerd.runtime.v2.task/k8s.io/3325d8e52f8d3f87e5a603754096a26c3742b942a13f31bad0965749b1f29b2e/rootfs
overlay                            58G   47G  8.4G  85% /run/containerd/io.containerd.runtime.v2.task/k8s.io/6567d17b2f2b673e8885213821d14921311717cf003cbf136689ee61749ea7f2/rootfs
overlay                            58G   47G  8.4G  85% /run/containerd/io.containerd.runtime.v2.task/k8s.io/ea9f4d71a643d47150135b9c6fea40aedbab5a5e478b034bdb259f0f2f035b29/rootfs
overlay                            58G   47G  8.4G  85% /run/containerd/io.containerd.runtime.v2.task/k8s.io/3c0e71ce9592216272b7e33dac0102444345c853a86699e5eb3fda5901fabe04/rootfs
overlay                            58G   47G  8.4G  85% /run/containerd/io.containerd.runtime.v2.task/k8s.io/aa4bca876e96a5de9255ce669e54382a952e50271b6fb306a2c85e76e7369948/rootfs
overlay                            58G   47G  8.4G  85% /run/containerd/io.containerd.runtime.v2.task/k8s.io/9bfea364b0bbeb71210d26ee582caeef5325d3230885ed61423423867ad845b4/rootfs
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# blkid
/dev/sr0: UUID="2021-06-19-16-14-34-00" LABEL="Debian 10.10.0 amd64 n" TYPE="iso9660" PTUUID="0d28081a" PTTYPE="dos"
/dev/sda1: UUID="4bdfda28-f25a-48ef-9fa2-1fc10c59efc8" TYPE="ext2" PARTUUID="61c0bc9e-01"
/dev/sda3: UUID="caZWCB-3LMa-laIM-1dC4-MJbM-XiT3-9epM7g" TYPE="LVM2_member" PARTUUID="61c0bc9e-03"
/dev/sda5: UUID="LOU9xG-GLZl-2x29-jp1L-9TaU-tych-6GzOQy" TYPE="LVM2_member" PARTUUID="61c0bc9e-05"
/dev/mapper/debian10x64--vg-root: UUID="e75eefef-1d8f-4860-9d6d-6ecb6c3ed630" TYPE="ext4"
/dev/mapper/debian10x64--vg-swap_1: UUID="9dd96a23-e030-45e0-9b9c-6d82d54422a9" TYPE="swap"
/dev/loop1: TYPE="squashfs"
/dev/loop2: TYPE="squashfs"
/dev/loop3: TYPE="squashfs"
/dev/loop4: TYPE="squashfs"
/dev/loop5: TYPE="squashfs"
/dev/loop6: TYPE="squashfs"
/dev/loop7: TYPE="squashfs"
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# lsblk
NAME                       MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
fd0                          2:0    1     4K  0 disk
loop1                        7:1    0 116.7M  1 loop /snap/robo3t-snap/9
loop2                        7:2    0  55.7M  1 loop /snap/core18/2790
loop3                        7:3    0  55.7M  1 loop /snap/core18/2785
loop4                        7:4    0 105.8M  1 loop /snap/core/16091
loop5                        7:5    0 105.8M  1 loop /snap/core/15925
loop6                        7:6    0 272.8M  1 loop /snap/kontena-lens/245
loop7                        7:7    0 272.8M  1 loop /snap/kontena-lens/246
sda                          8:0    0    60G  0 disk
├─sda1                       8:1    0   487M  0 part /boot
├─sda2                       8:2    0     1K  0 part
├─sda3                       8:3    0    20G  0 part
│ └─debian10x64--vg-root   254:0    0  58.6G  0 lvm  /
└─sda5                       8:5    0  39.5G  0 part
  ├─debian10x64--vg-root   254:0    0  58.6G  0 lvm  /
  └─debian10x64--vg-swap_1 254:1    0   976M  0 lvm
sr0                         11:0    1   336M  0 rom
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Fri 22 Sep 2023 08:23:18 PM -03
root@debian10x64:/home/fernando#










- Após reboot

~~~~bash

root@debian10x64:/home/fernando# free -h
              total        used        free      shared  buff/cache   available
Mem:          9.6Gi       1.0Gi       7.5Gi       9.0Mi       1.1Gi       8.3Gi
Swap:            0B          0B          0B
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# df -h
Filesystem                        Size  Used Avail Use% Mounted on
udev                              4.8G     0  4.8G   0% /dev
tmpfs                             983M  9.4M  973M   1% /run
/dev/mapper/debian10x64--vg-root   58G   45G  9.9G  83% /
tmpfs                             4.8G     0  4.8G   0% /dev/shm
tmpfs                             5.0M     0  5.0M   0% /run/lock
tmpfs                             4.8G     0  4.8G   0% /sys/fs/cgroup
/dev/loop2                        117M  117M     0 100% /snap/robo3t-snap/9
/dev/loop0                         56M   56M     0 100% /snap/core18/2785
/dev/loop3                        106M  106M     0 100% /snap/core/15925
/dev/loop4                         56M   56M     0 100% /snap/core18/2790
/dev/loop1                        273M  273M     0 100% /snap/kontena-lens/246
/dev/loop5                        106M  106M     0 100% /snap/core/16091
/dev/loop6                        273M  273M     0 100% /snap/kontena-lens/245
/dev/sda1                         472M   59M  389M  14% /boot
tmpfs                             983M   28K  983M   1% /run/user/117
tmpfs                             983M     0  983M   0% /run/user/1000
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# blkid
/dev/sr0: UUID="2021-06-19-16-14-34-00" LABEL="Debian 10.10.0 amd64 n" TYPE="iso9660" PTUUID="0d28081a" PTTYPE="dos"
/dev/sda1: UUID="4bdfda28-f25a-48ef-9fa2-1fc10c59efc8" TYPE="ext2" PARTUUID="61c0bc9e-01"
/dev/sda3: UUID="caZWCB-3LMa-laIM-1dC4-MJbM-XiT3-9epM7g" TYPE="LVM2_member" PARTUUID="61c0bc9e-03"
/dev/sda5: UUID="LOU9xG-GLZl-2x29-jp1L-9TaU-tych-6GzOQy" TYPE="LVM2_member" PARTUUID="61c0bc9e-05"
/dev/mapper/debian10x64--vg-root: UUID="e75eefef-1d8f-4860-9d6d-6ecb6c3ed630" TYPE="ext4"
/dev/mapper/debian10x64--vg-swap_1: UUID="9dd96a23-e030-45e0-9b9c-6d82d54422a9" TYPE="swap"
/dev/loop0: TYPE="squashfs"
/dev/loop1: TYPE="squashfs"
/dev/loop2: TYPE="squashfs"
/dev/loop3: TYPE="squashfs"
/dev/loop4: TYPE="squashfs"
/dev/loop5: TYPE="squashfs"
/dev/loop6: TYPE="squashfs"
root@debian10x64:/home/fernando# lsblk
NAME                       MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
fd0                          2:0    1     4K  0 disk
loop0                        7:0    0  55.7M  1 loop /snap/core18/2785
loop1                        7:1    0 272.8M  1 loop /snap/kontena-lens/246
loop2                        7:2    0 116.7M  1 loop /snap/robo3t-snap/9
loop3                        7:3    0 105.8M  1 loop /snap/core/15925
loop4                        7:4    0  55.7M  1 loop /snap/core18/2790
loop5                        7:5    0 105.8M  1 loop /snap/core/16091
loop6                        7:6    0 272.8M  1 loop /snap/kontena-lens/245
sda                          8:0    0    60G  0 disk
├─sda1                       8:1    0   487M  0 part /boot
├─sda2                       8:2    0     1K  0 part
├─sda3                       8:3    0    20G  0 part
│ └─debian10x64--vg-root   254:0    0  58.6G  0 lvm  /
└─sda5                       8:5    0  39.5G  0 part
  ├─debian10x64--vg-root   254:0    0  58.6G  0 lvm  /
  └─debian10x64--vg-swap_1 254:1    0   976M  0 lvm
sr0                         11:0    1   336M  0 rom
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Fri 22 Sep 2023 08:29:19 PM -03
root@debian10x64:/home/fernando#

~~~~