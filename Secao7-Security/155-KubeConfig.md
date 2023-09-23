



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









sudo kubeadm init

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.92.129:6443 --token hb026g.19rh1gi8lpn855ry \
        --discovery-token-ca-cert-hash sha256:000324cfe5e20d04bae4f5cb644fd965f2a9c12b91d18da9e3d8a0e71fd436df







- Aula 148 tem detalhes sobre 
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/148-View-Certificate-Details.md
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/148-x-Kubeadm-instalacao-e-tshoot.md



# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

sudo kubeadm init

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config


You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

helm repo add cilium https://helm.cilium.io/
helm install cilium cilium/cilium --version 1.14.2 --namespace kube-system
kubectl get pod cilium-operator-788c4f69bc-jv5tk -n kube-system -o yaml

- Ajustando número de réplicas do Cilium:

helm upgrade --install cilium cilium/cilium -n kube-system -f /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/148-x-cilium-values.yaml

cilium status
cilium connectivity test
kubectl get pods -n cilium-test
kubectl describe pod pod-to-b-multi-node-clusterip-7cb4bf5495-h4mp8 -n cilium-test

- Removendo

kubectl taint nodes debian10x64 node-role.kubernetes.io/control-plane-

cilium status





root@debian10x64:/home/fernando# helm repo add cilium https://helm.cilium.io/
"cilium" already exists with the same configuration, skipping
root@debian10x64:/home/fernando# helm install cilium cilium/cilium --version 1.14.2 --namespace kube-system
Error: INSTALLATION FAILED: chart "cilium" matching 1.14.2 not found in cilium index. (try 'helm repo update'): no chart version found for cilium-1.14.2
root@debian10x64:/home/fernando#






helm install cilium cilium/cilium --version 1.14.1 --namespace kube-system

root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# helm install cilium cilium/cilium --version 1.14.1 --namespace kube-system
Error: INSTALLATION FAILED: Kubernetes cluster unreachable: Get "https://192.168.92.129:6443/version": x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "kubernetes")
root@debian10x64:/home/fernando#


root@debian10x64:/home/fernando# kubectl get pods
Unable to connect to the server: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "kubernetes")
root@debian10x64:/home/fernando# kubectl get pods -A
Unable to connect to the server: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "kubernetes")
root@debian10x64:/home/fernando#









# ########################################################################################################################################## 
# ########################################################################################################################################## 
# ########################################################################################################################################## 
## PENDENTE

- TSHOOT do Kubernetes via Kubeadm, erro no certificado.
- Instalar Cilium no Kubeadm via Helm.
    Tutorial:
    /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/148-x-Kubeadm-instalacao-e-tshoot.md
- Subir cluster via Kubeadm.
- Criar certificado de client, baseado na aula 152.
- Tentar comunicar com a api via curl, usando o certificado de client.






- TSHOOT

~~~~bash
root@debian10x64:/home/fernando# kubectl get pods
Unable to connect to the server: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "kubernetes")
root@debian10x64:/home/fernando# kubectl get pods -A
Unable to connect to the server: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "kubernetes")
root@debian10x64:/home/fernando#
~~~~


- Resolvido:

~~~~bash

root@debian10x64:/home/fernando# export KUBECONFIG=/etc/kubernetes/admin.conf
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl get pods
No resources found in default namespace.
root@debian10x64:/home/fernando# kubectl get pods -A
NAMESPACE     NAME                                  READY   STATUS              RESTARTS   AGE
kube-system   coredns-5dd5756b68-4c6sw              0/1     ContainerCreating   0          21m
kube-system   coredns-5dd5756b68-8jr6c              0/1     ContainerCreating   0          21m
kube-system   etcd-debian10x64                      1/1     Running             3          21m
kube-system   kube-apiserver-debian10x64            1/1     Running             2          21m
kube-system   kube-controller-manager-debian10x64   1/1     Running             2          21m
kube-system   kube-proxy-fcbjq                      1/1     Running             0          21m
kube-system   kube-scheduler-debian10x64            1/1     Running             2          21m
root@debian10x64:/home/fernando# date
Fri 22 Sep 2023 08:55:04 PM -03
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# history | tail
  343  kubectl get pods -A
  344  CAT $HOME/.kube/config
  345  cat $HOME/.kube/config
  346  unset KUBECONFIG
  347  cat /etc/kubernetes/admin.conf
  348  export KUBECONFIG=/etc/kubernetes/admin.conf
  349  kubectl get pods
  350  kubectl get pods -A
  351  date
  352  history | tail
root@debian10x64:/home/fernando#

~~~~







root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# helm install cilium cilium/cilium --version 1.14.1 --namespace kube-system
NAME: cilium
LAST DEPLOYED: Fri Sep 22 20:57:59 2023
NAMESPACE: kube-system
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
You have successfully installed Cilium with Hubble.

Your release version is 1.14.1.

For any further help, visit https://docs.cilium.io/en/v1.14/gettinghelp
root@debian10x64:/home/fernando#




















root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl get pods -A
NAMESPACE     NAME                                  READY   STATUS              RESTARTS   AGE
kube-system   cilium-krwv4                          0/1     Init:0/6            0          53s
kube-system   cilium-operator-788c4f69bc-6n8pg      1/1     Running             0          53s
kube-system   cilium-operator-788c4f69bc-sgk6z      0/1     Pending             0          53s
kube-system   coredns-5dd5756b68-4c6sw              0/1     ContainerCreating   0          25m
kube-system   coredns-5dd5756b68-8jr6c              0/1     ContainerCreating   0          25m
kube-system   etcd-debian10x64                      1/1     Running             3          25m
kube-system   kube-apiserver-debian10x64            1/1     Running             2          25m
kube-system   kube-controller-manager-debian10x64   1/1     Running             2          25m
kube-system   kube-proxy-fcbjq                      1/1     Running             0          25m
kube-system   kube-scheduler-debian10x64            1/1     Running             2          25m
root@debian10x64:/home/fernando# kubectl get pods -A
NAMESPACE     NAME                                  READY   STATUS              RESTARTS   AGE
kube-system   cilium-krwv4                          0/1     Init:0/6            0          62s
kube-system   cilium-operator-788c4f69bc-6n8pg      1/1     Running             0          62s
kube-system   cilium-operator-788c4f69bc-sgk6z      0/1     Pending             0          62s
kube-system   coredns-5dd5756b68-4c6sw              0/1     ContainerCreating   0          26m
kube-system   coredns-5dd5756b68-8jr6c              0/1     ContainerCreating   0          26m
kube-system   etcd-debian10x64                      1/1     Running             3          26m
kube-system   kube-apiserver-debian10x64            1/1     Running             2          26m
kube-system   kube-controller-manager-debian10x64   1/1     Running             2          26m
kube-system   kube-proxy-fcbjq                      1/1     Running             0          26m
kube-system   kube-scheduler-debian10x64            1/1     Running             2          26m
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# cilium status
    /¯¯\
 /¯¯\__/¯¯\    Cilium:             1 errors, 1 warnings
 \__/¯¯\__/    Operator:           1 errors, 1 warnings
 /¯¯\__/¯¯\    Envoy DaemonSet:    disabled (using embedded mode)
 \__/¯¯\__/    Hubble Relay:       disabled
    \__/       ClusterMesh:        disabled

DaemonSet              cilium             Desired: 1, Unavailable: 1/1
Deployment             cilium-operator    Desired: 2, Ready: 1/2, Available: 1/2, Unavailable: 1/2
Containers:            cilium             Pending: 1
                       cilium-operator    Running: 1, Pending: 1
Cluster Pods:          0/2 managed by Cilium
Helm chart version:    1.14.1
Image versions         cilium             quay.io/cilium/cilium:v1.14.1@sha256:edc1d05ea1365c4a8f6ac6982247d5c145181704894bb698619c3827b6963a72: 1
                       cilium-operator    quay.io/cilium/operator-generic:v1.14.1@sha256:e061de0a930534c7e3f8feda8330976367971238ccafff42659f104effd4b5f7: 2
Errors:                cilium-operator    cilium-operator                     1 pods of Deployment cilium-operator are not ready
                       cilium             cilium                              1 pods of DaemonSet cilium are not ready
Warnings:              cilium             cilium-krwv4                        pod is pending
                       cilium-operator    cilium-operator-788c4f69bc-sgk6z    pod is pending
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl get pods -A
NAMESPACE     NAME                                  READY   STATUS              RESTARTS   AGE
kube-system   cilium-krwv4                          1/1     Running             0          106s
kube-system   cilium-operator-788c4f69bc-6n8pg      1/1     Running             0          106s
kube-system   cilium-operator-788c4f69bc-sgk6z      0/1     Pending             0          106s
kube-system   coredns-5dd5756b68-4c6sw              0/1     ContainerCreating   0          26m
kube-system   coredns-5dd5756b68-8jr6c              0/1     ContainerCreating   0          26m
kube-system   etcd-debian10x64                      1/1     Running             3          26m
kube-system   kube-apiserver-debian10x64            1/1     Running             2          26m
kube-system   kube-controller-manager-debian10x64   1/1     Running             2          26m
kube-system   kube-proxy-fcbjq                      1/1     Running             0          26m
kube-system   kube-scheduler-debian10x64            1/1     Running             2          26m
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl get pods -A
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE
kube-system   cilium-krwv4                          1/1     Running   0          2m
kube-system   cilium-operator-788c4f69bc-6n8pg      1/1     Running   0          2m
kube-system   cilium-operator-788c4f69bc-sgk6z      0/1     Pending   0          2m
kube-system   coredns-5dd5756b68-4c6sw              1/1     Running   0          26m
kube-system   coredns-5dd5756b68-8jr6c              1/1     Running   0          26m
kube-system   etcd-debian10x64                      1/1     Running   3          27m
kube-system   kube-apiserver-debian10x64            1/1     Running   2          27m
kube-system   kube-controller-manager-debian10x64   1/1     Running   2          27m
kube-system   kube-proxy-fcbjq                      1/1     Running   0          26m
kube-system   kube-scheduler-debian10x64            1/1     Running   2          27m
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Fri 22 Sep 2023 09:00:10 PM -03
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl get pods -A
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE
kube-system   cilium-krwv4                          1/1     Running   0          2m14s
kube-system   cilium-operator-788c4f69bc-6n8pg      1/1     Running   0          2m14s
kube-system   cilium-operator-788c4f69bc-sgk6z      0/1     Pending   0          2m14s
kube-system   coredns-5dd5756b68-4c6sw              1/1     Running   0          27m
kube-system   coredns-5dd5756b68-8jr6c              1/1     Running   0          27m
kube-system   etcd-debian10x64                      1/1     Running   3          27m
kube-system   kube-apiserver-debian10x64            1/1     Running   2          27m
kube-system   kube-controller-manager-debian10x64   1/1     Running   2          27m
kube-system   kube-proxy-fcbjq                      1/1     Running   0          27m
kube-system   kube-scheduler-debian10x64            1/1     Running   2          27m
root@debian10x64:/home/fernando# cilium status
    /¯¯\
 /¯¯\__/¯¯\    Cilium:             OK
 \__/¯¯\__/    Operator:           1 errors, 1 warnings
 /¯¯\__/¯¯\    Envoy DaemonSet:    disabled (using embedded mode)
 \__/¯¯\__/    Hubble Relay:       disabled
    \__/       ClusterMesh:        disabled

DaemonSet              cilium             Desired: 1, Ready: 1/1, Available: 1/1
Deployment             cilium-operator    Desired: 2, Ready: 1/2, Available: 1/2, Unavailable: 1/2
Containers:            cilium             Running: 1
                       cilium-operator    Running: 1, Pending: 1
Cluster Pods:          2/2 managed by Cilium
Helm chart version:    1.14.1
Image versions         cilium             quay.io/cilium/cilium:v1.14.1@sha256:edc1d05ea1365c4a8f6ac6982247d5c145181704894bb698619c3827b6963a72: 1
                       cilium-operator    quay.io/cilium/operator-generic:v1.14.1@sha256:e061de0a930534c7e3f8feda8330976367971238ccafff42659f104effd4b5f7: 2
Errors:                cilium-operator    cilium-operator                     1 pods of Deployment cilium-operator are not ready
Warnings:              cilium-operator    cilium-operator-788c4f69bc-sgk6z    pod is pending
root@debian10x64:/home/fernando# kubectl get pods -A
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE
kube-system   cilium-krwv4                          1/1     Running   0          2m39s
kube-system   cilium-operator-788c4f69bc-6n8pg      1/1     Running   0          2m39s
kube-system   cilium-operator-788c4f69bc-sgk6z      0/1     Pending   0          2m39s
kube-system   coredns-5dd5756b68-4c6sw              1/1     Running   0          27m
kube-system   coredns-5dd5756b68-8jr6c              1/1     Running   0          27m
kube-system   etcd-debian10x64                      1/1     Running   3          27m
kube-system   kube-apiserver-debian10x64            1/1     Running   2          27m
kube-system   kube-controller-manager-debian10x64   1/1     Running   2          27m
kube-system   kube-proxy-fcbjq                      1/1     Running   0          27m
kube-system   kube-scheduler-debian10x64            1/1     Running   2          27m
root@debian10x64:/home/fernando# kubectl^C









root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl describe pod cilium-operator-788c4f69bc-sgk6z -n kube-system

QoS Class:                   BestEffort
Node-Selectors:              kubernetes.io/os=linux
Tolerations:                 op=Exists
Events:
  Type     Reason            Age    From               Message
  ----     ------            ----   ----               -------
  Warning  FailedScheduling  3m33s  default-scheduler  0/1 nodes are available: 1 node(s) didn't match pod anti-affinity rules. preemption: 0/1 nodes are available: 1 No preemption victims found for incoming pod..
root@debian10x64:/home/fernando#









root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl describe pod cilium-operator-788c4f69bc-sgk6z -n kube-system^C
root@debian10x64:/home/fernando# kubectl get nodes
NAME          STATUS   ROLES           AGE   VERSION
debian10x64   Ready    control-plane   29m   v1.28.1
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl taint nodes debian10x64 node-role.kubernetes.io/control-plane-
node/debian10x64 untainted
root@debian10x64:/home/fernando# kubectl get pods -A | grep opera
kube-system   cilium-operator-788c4f69bc-6n8pg      1/1     Running   0          4m23s
kube-system   cilium-operator-788c4f69bc-sgk6z      0/1     Pending   0          4m23s
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Fri 22 Sep 2023 09:03:06 PM -03
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl get pods -A | grep opera
kube-system   cilium-operator-788c4f69bc-6n8pg      1/1     Running   0          5m4s
kube-system   cilium-operator-788c4f69bc-sgk6z      0/1     Pending   0          5m4s
root@debian10x64:/home/fernando# kubectl delete pod cilium-operator-788c4f69bc-sgk6z -n kube-system
pod "cilium-operator-788c4f69bc-sgk6z" deleted
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl get pods -A | grep opera
kube-system   cilium-operator-788c4f69bc-6n8pg      1/1     Running   0          5m24s
kube-system   cilium-operator-788c4f69bc-p45wb      0/1     Pending   0          3s
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl get pods -A | grep opera
kube-system   cilium-operator-788c4f69bc-6n8pg      1/1     Running   0          5m28s
kube-system   cilium-operator-788c4f69bc-p45wb      0/1     Pending   0          7s
root@debian10x64:/home/fernando#
s
root@debian10x64:/home/fernando# helm ls -A
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
cilium  kube-system     1               2023-09-22 20:57:59.97023391 -0300 -03  deployed        cilium-1.14.1   1.14.1
root@debian10x64:/home/fernando#






QoS Class:                   BestEffort
Node-Selectors:              kubernetes.io/os=linux
Tolerations:                 op=Exists
Events:
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  57s   default-scheduler  0/1 nodes are available: 1 node(s) didn't match pod anti-affinity rules. preemption: 0/1 nodes are available: 1 No preemption victims found for incoming pod..
root@debian10x64:/home/fernando#











# ########################################################################################################################################## 
# ########################################################################################################################################## 
# ########################################################################################################################################## 
## PENDENTE

- TSHOOT do Pod cilium-operator.
- Instalar Cilium no Kubeadm via Helm.
    Tutorial:
    /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/148-x-Kubeadm-instalacao-e-tshoot.md
- Subir cluster via Kubeadm.
- Criar certificado de client, baseado na aula 152.
- Tentar comunicar com a api via curl, usando o certificado de client.









# ########################################################################################################################################## 
# ########################################################################################################################################## 
# ########################################################################################################################################## 
## dia 23/09/2023


- TSHOOT do Pod cilium-operator.
- Instalar Cilium no Kubeadm via Helm.
    Tutorial:
    /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/148-x-Kubeadm-instalacao-e-tshoot.md


~~~~bash

root@debian10x64:/home/fernando# kubectl get pods -A
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE
kube-system   cilium-krwv4                          1/1     Running   0          18m
kube-system   cilium-operator-788c4f69bc-6n8pg      1/1     Running   0          18m
kube-system   cilium-operator-788c4f69bc-p45wb      0/1     Pending   0          12m
kube-system   coredns-5dd5756b68-4c6sw              1/1     Running   0          43m
kube-system   coredns-5dd5756b68-8jr6c              1/1     Running   0          43m
kube-system   etcd-debian10x64                      1/1     Running   3          43m
kube-system   kube-apiserver-debian10x64            1/1     Running   2          43m
kube-system   kube-controller-manager-debian10x64   1/1     Running   2          43m
kube-system   kube-proxy-fcbjq                      1/1     Running   0          43m
kube-system   kube-scheduler-debian10x64            1/1     Running   2          43m
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl get nodes
NAME          STATUS   ROLES           AGE   VERSION
debian10x64   Ready    control-plane   43m   v1.28.1
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# helm ls -A
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
cilium  kube-system     1               2023-09-22 20:57:59.97023391 -0300 -03  deployed        cilium-1.14.1   1.14.1
root@debian10x64:/home/fernando#

~~~~







~~~~bash
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl describe pod cilium-operator-788c4f69bc-p45wb -n kube-system

root@debian10x64:/home/fernando# kubectl describe pod cilium-operator-788c4f69bc-p45wb -n kube-system
Name:                 cilium-operator-788c4f69bc-p45wb
Namespace:            kube-system
Priority:             2000000000
Priority Class Name:  system-cluster-critical
Node:                 <none>
Labels:               app.kubernetes.io/name=cilium-operator
                      app.kubernetes.io/part-of=cilium
                      io.cilium/app=operator
                      name=cilium-operator
                      pod-template-hash=788c4f69bc
Annotations:          <none>
Status:               Pending
IP:
IPs:                  <none>
Controlled By:        ReplicaSet/cilium-operator-788c4f69bc
Containers:
  cilium-operator:
    Image:      quay.io/cilium/operator-generic:v1.14.1@sha256:e061de0a930534c7e3f8feda8330976367971238ccafff42659f104effd4b5f7
    Port:       <none>
    Host Port:  <none>
    Command:
      cilium-operator-generic
    Args:
      --config-dir=/tmp/cilium/config-map
      --debug=$(CILIUM_DEBUG)
    Liveness:   http-get http://127.0.0.1:9234/healthz delay=60s timeout=3s period=10s #success=1 #failure=3
    Readiness:  http-get http://127.0.0.1:9234/healthz delay=0s timeout=3s period=5s #success=1 #failure=5
    Environment:
      K8S_NODE_NAME:          (v1:spec.nodeName)
      CILIUM_K8S_NAMESPACE:  kube-system (v1:metadata.namespace)
      CILIUM_DEBUG:          <set to the key 'debug' of config map 'cilium-config'>  Optional: true
    Mounts:
      /tmp/cilium/config-map from cilium-config-path (ro)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-shsfj (ro)
Conditions:
  Type           Status
  PodScheduled   False
Volumes:
  cilium-config-path:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      cilium-config
    Optional:  false
  kube-api-access-shsfj:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              kubernetes.io/os=linux
Tolerations:                 op=Exists
Events:
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  4m27s (x4 over 19m)  default-scheduler  0/1 nodes are available: 1 node(s) didn't match pod anti-affinity rules. preemption: 0/1 nodes are available: 1 No preemption victims found for incoming pod..
root@debian10x64:/home/fernando#

~~~~







- Manifesto do Pod, verificando affinity

~~~~yaml

root@debian10x64:/home/fernando# kubectl get pod cilium-operator-788c4f69bc-p45wb -n kube-system -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-09-23T00:03:26Z"
  generateName: cilium-operator-788c4f69bc-
  labels:
    app.kubernetes.io/name: cilium-operator
    app.kubernetes.io/part-of: cilium
    io.cilium/app: operator
    name: cilium-operator
    pod-template-hash: 788c4f69bc
  name: cilium-operator-788c4f69bc-p45wb
  namespace: kube-system
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: cilium-operator-788c4f69bc
    uid: db43150e-8c16-4847-abcc-b603a674784a
  resourceVersion: "3106"
  uid: 03d1f00e-3e71-4aac-9ca2-9e01975a560f
spec:
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            io.cilium/app: operator
        topologyKey: kubernetes.io/hostname
  automountServiceAccountToken: true
  containers:
  - args:
    - --config-dir=/tmp/cilium/config-map
    - --debug=$(CILIUM_DEBUG)
    command:
    - cilium-operator-generic
    env:
    - name: K8S_NODE_NAME
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: spec.nodeName
    - name: CILIUM_K8S_NAMESPACE
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.namespace
    - name: CILIUM_DEBUG
      valueFrom:
        configMapKeyRef:
          key: debug
          name: cilium-config
          optional: true
    image: quay.io/cilium/operator-generic:v1.14.1@sha256:e061de0a930534c7e3f8feda8330976367971238ccafff42659f104effd4b5f7
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 3
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 9234
        scheme: HTTP
      initialDelaySeconds: 60
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 3
    name: cilium-operator
    readinessProbe:
      failureThreshold: 5
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 9234
        scheme: HTTP
      periodSeconds: 5
      successThreshold: 1
      timeoutSeconds: 3
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: FallbackToLogsOnError
    volumeMounts:
    - mountPath: /tmp/cilium/config-map
      name: cilium-config-path
      readOnly: true
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-shsfj
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  hostNetwork: true
  nodeSelector:
    kubernetes.io/os: linux
  preemptionPolicy: PreemptLowerPriority
  priority: 2000000000
  priorityClassName: system-cluster-critical
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: cilium-operator
  serviceAccountName: cilium-operator
  terminationGracePeriodSeconds: 30
  tolerations:
  - operator: Exists
  volumes:
  - configMap:
      defaultMode: 420
      name: cilium-config
    name: cilium-config-path
  - name: kube-api-access-shsfj
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
    lastTransitionTime: "2023-09-23T00:03:26Z"
    message: '0/1 nodes are available: 1 node(s) didn''t match pod anti-affinity rules.
      preemption: 0/1 nodes are available: 1 No preemption victims found for incoming
      pod..'
    reason: Unschedulable
    status: "False"
    type: PodScheduled
  phase: Pending
  qosClass: BestEffort
root@debian10x64:/home/fernando#

~~~~





- Atualmente

spec:
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            io.cilium/app: operator
        topologyKey: kubernetes.io/hostname