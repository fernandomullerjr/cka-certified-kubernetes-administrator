#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "247. Practice Test - Deploy a Kubernetes Cluster using Kubeadm."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
## 247. Practice Test - Deploy a Kubernetes Cluster using Kubeadm


Install the kubeadm and kubelet packages on the controlplane and node01 nodes.

Use the exact version of 1.29.0-1.1 for both.

kubeadm installed on controlplane?

kubelet installed on controlplane?

Kubeadm installed on worker node01?

Kubelet installed on worker node01 ?



- Instalando com base no material da DOC:
<https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/>


controlplane ~ ➜  nc 127.0.0.1 6443 -v
nc: connect to 127.0.0.1 port 6443 (tcp) failed: Connection refused

controlplane ~ ✖ 




sudo swapoff -a


controlplane ~ ✖ sudo swapoff -a
swapoff: /proc/swaps: parse error at line 1 -- ignored

controlplane ~ ➜  




cat /etc/fstab

controlplane ~ ➜  cat /etc/fstab
# UNCONFIGURED FSTAB FOR BASE SYSTEM

controlplane ~ ➜  



Verify the MAC address and product_uuid are unique for every node

    You can get the MAC address of the network interfaces using the command ip link or ifconfig -a
    The product_uuid can be checked by using the command sudo cat /sys/class/dmi/id/product_uuid

It is very likely that hardware devices will have unique addresses, although some virtual machines may have identical values. Kubernetes uses these values to uniquely identify the nodes in the cluster. If these values are not unique to each node, the installation process may fail.
Check network adapters
If you have more than one network adapter, and your Kubernetes components are not reachable on the default route, we recommend you add IP route(s) so Kubernetes cluster addresses go via the appropriate adapter.


~~~~BASH
controlplane ~ ➜  ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: flannel.1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKNOWN mode DEFAULT group default 
    link/ether 12:04:ee:b4:0a:86 brd ff:ff:ff:ff:ff:ff
3: cni0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether ba:d6:8e:d9:52:1a brd ff:ff:ff:ff:ff:ff
14725: eth0@if14726: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:c0:02:58:06 brd ff:ff:ff:ff:ff:ff link-netnsid 0
14729: eth1@if14730: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:ac:19:00:1c brd ff:ff:ff:ff:ff:ff link-netnsid 1

controlplane ~ ➜  

controlplane ~ ➜  ssh node01

root@node01 ~ ➜  

root@node01 ~ ➜  ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: flannel.1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKNOWN mode DEFAULT group default 
    link/ether 7e:94:36:c4:6a:ab brd ff:ff:ff:ff:ff:ff
15685: eth0@if15686: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:c0:02:58:08 brd ff:ff:ff:ff:ff:ff link-netnsid 0
15687: eth1@if15688: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:ac:19:00:14 brd ff:ff:ff:ff:ff:ff link-netnsid 1

root@node01 ~ ➜  
~~~~


OK, Endereços MAC únicos para os adaptadores de rede!




The product_uuid can be checked by using the command sudo cat /sys/class/dmi/id/product_uuid

~~~~BASH

controlplane ~ ➜  sudo cat /sys/class/dmi/id/product_uuid
ccf22a91-925e-0514-bae9-520601baf4ff

controlplane ~ ➜  

root@node01 ~ ➜  sudo cat /sys/class/dmi/id/product_uuid
e8faf770-da5e-cf83-9c62-bafdacc199f5

root@node01 ~ ➜  

~~~~



Installing a container runtime

<https://v1-29.docs.kubernetes.io/docs/setup/production-environment/container-runtimes/>


Já tem o Containerd

~~~~bash
controlplane ~ ➜  ls /etc/containerd/config.toml 
/etc/containerd/config.toml

controlplane ~ ➜  cat /etc/containerd/config.toml 
#   Copyright 2018-2022 Docker Inc.

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at

#       http://www.apache.org/licenses/LICENSE-2.0

#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


#root = "/var/lib/containerd"
#state = "/run/containerd"
#subreaper = true
#oom_score = 0

#[grpc]
#  address = "/run/containerd/containerd.sock"
#  uid = 0
#  gid = 0

#[debug]
#  address = "/run/containerd/debug.sock"
#  uid = 0
#  gid = 0
#  level = "info"

controlplane ~ ➜  

~~~~





sudo systemctl status containerd

~~~~bash

controlplane ~ ➜  sudo systemctl status containerd
● containerd.service - containerd container runtime
     Loaded: loaded (/lib/systemd/system/containerd.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2024-05-09 20:41:32 EDT; 1h 5min ago
       Docs: https://containerd.io
   Main PID: 1063 (containerd)
      Tasks: 43
     Memory: 157.2M
     CGroup: /system.slice/containerd.service
             └─1063 /usr/bin/containerd

May 09 21:34:41 controlplane containerd[1063]: time="2024-05-09T21:34:41.847764471-04:00" level=info msg="TearDown network for sandbox \"da66dcf765dc2f266ed8d6268ec01600d9c32ff66e0
2d79efbfbdd222cfa38a8\" successfully"
May 09 21:34:41 controlplane containerd[1063]: time="2024-05-09T21:34:41.847791747-04:00" level=info msg="StopPodSandbox for \"da66dcf765dc2f266ed8d6268ec01600d9c32ff66e02d79efbfbd
d222cfa38a8\" returns successfully"
May 09 21:34:41 controlplane containerd[1063]: time="2024-05-09T21:34:41.916306406-04:00" level=info msg="RemovePodSandbox for \"da66dcf765dc2f266ed8d6268ec01600d9c32ff66e02d79efbf
bdd222cfa38a8\""
May 09 21:34:41 controlplane containerd[1063]: time="2024-05-09T21:34:41.916353027-04:00" level=info msg="Forcibly stopping sandbox \"da66dcf765dc2f266ed8d6268ec01600d9c32ff66e02d7
9efbfbdd222cfa38a8\""
May 09 21:34:41 controlplane containerd[1063]: time="2024-05-09T21:34:41.916380627-04:00" level=info msg="Container to stop \"4ab6420dd3a8f43cfa13677bd83ecaf069a384a99f4d54c79d0437
d76f410bf6\" must be in running or unknown state, current state \"CONTAINER_EXITED\""
May 09 21:34:41 controlplane containerd[1063]: time="2024-05-09T21:34:41.917084099-04:00" level=info msg="TearDown network for sandbox \"da66dcf765dc2f266ed8d6268ec01600d9c32ff66e0
2d79efbfbdd222cfa38a8\" successfully"
May 09 21:34:41 controlplane containerd[1063]: time="2024-05-09T21:34:41.921860125-04:00" level=info msg="RemovePodSandbox \"da66dcf765dc2f266ed8d6268ec01600d9c32ff66e02d79efbfbdd2
22cfa38a8\" returns successfully"
May 09 21:34:46 controlplane containerd[1063]: time="2024-05-09T21:34:46.040239842-04:00" level=error msg="failed to reload cni configuration after receiving fs change event(\"/etc
/cni/net.d/.kubernetes-cni-keep\": REMOVE)" error="cni config load failed: no network config found in /etc/cni/net.d: cni plugin not initialized: failed to load cni config"
May 09 21:34:46 controlplane containerd[1063]: time="2024-05-09T21:34:46.040352269-04:00" level=error msg="failed to reload cni configuration after receiving fs change event(\"/etc
/cni/net.d/10-flannel.conflist\": REMOVE)" error="cni config load failed: no network config found in /etc/cni/net.d: cni plugin not initialized: failed to load cni config"
May 09 21:34:46 controlplane containerd[1063]: time="2024-05-09T21:34:46.040375404-04:00" level=error msg="failed to reload cni configuration after receiving fs change event(\"/etc
/cni/net.d\": REMOVE)" error="cni config load failed: no network config found in /etc/cni/net.d: cni plugin not initialized: failed to load cni config"

controlplane ~ ➜  
~~~~




Como já tem o Containerd

retomando doc de kubeadm:
<https://v1-29.docs.kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/>


- Validando se é Debian-based:

~~~~bash
controlplane ~ ➜  uname -a
Linux controlplane 5.4.0-1106-gcp #115~18.04.1-Ubuntu SMP Mon May 22 20:46:39 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux

controlplane ~ ➜  
~~~~



These instructions are for Kubernetes v1.29.

    Update the apt package index and install packages needed to use the Kubernetes apt repository:

    sudo apt-get update
    # apt-transport-https may be a dummy package; if so, you can skip that package
    sudo apt-get install -y apt-transport-https ca-certificates curl gpg

    Download the public signing key for the Kubernetes package repositories. The same signing key is used for all repositories so you can disregard the version in the URL:

    # If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
    # sudo mkdir -p -m 755 /etc/apt/keyrings
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

Note: In releases older than Debian 12 and Ubuntu 22.04, directory /etc/apt/keyrings does not exist by default, and it should be created before the curl command.

    Add the appropriate Kubernetes apt repository. Please note that this repository have packages only for Kubernetes 1.29; for other Kubernetes minor versions, you need to change the Kubernetes minor version in the URL to match your desired minor version (you should also check that you are reading the documentation for the version of Kubernetes that you plan to install).

    # This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

    Update the apt package index, install kubelet, kubeadm and kubectl, and pin their version:

    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl

    (Optional) Enable the kubelet service before running kubeadm:

    sudo systemctl enable --now kubelet

The kubelet is now restarting every few seconds, as it waits in a crashloop for kubeadm to tell it what to do.
Configuring a cgroup driver



    # This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list














## PENDENTE
- Ver sobre ajuste da versão exata para instalar kubeadm, questão pede "1.29.0-1.1 for both", mas o comando instala "1.29.4-2.1"





## Dia 10/05/2024

- Ver sobre ajuste da versão exata para instalar kubeadm, questão pede "1.29.0-1.1 for both", mas o comando instala "1.29.4-2.1"

- Exemplo:
<https://rx-m.com/lesson/cka-perform-a-version-upgrade-on-a-kubernetes-cluster-using-kubeadm/>

Install the newer kubeadm version e.g. v1.26.0:
sudo apt install kubeadm=1.26.0-00


- Exemplo2
Specify the version as shown below. Here I am using 1.29.0-1.1

sudo apt-get install -y kubelet=1.29.0-1.1 kubectl=1.29.0-1.1 kubeadm=1.29.0-1.1


## Installing kubeadm, kubelet and kubectl

<https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl>

~~~~bash
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet
~~~~



- Determinando versão especifica

Use the exact version of 1.29.0-1.1 for both.

~~~~bash
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet=1.29.0-1.1 kubectl=1.29.0-1.1 kubeadm=1.29.0-1.1

sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet
~~~~



Install the kubeadm and kubelet packages on the controlplane and node01 nodes.

Use the exact version of 1.29.0-1.1 for both.

kubeadm installed on controlplane?

kubelet installed on controlplane?

Kubeadm installed on worker node01?

Kubelet installed on worker node01 ?



controlplane ~ ➜  sudo apt-get install -y kubelet=1.29.0-1.1 kubectl=1.29.0-1.1 kubeadm=1.29.0-1.1
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Version '1.29.0-1.1' for 'kubelet' was not found
E: Version '1.29.0-1.1' for 'kubectl' was not found
E: Version '1.29.0-1.1' for 'kubeadm' was not found

controlplane ~ ✖ 


controlplane ~ ✖ apt-cache madison kubeadm | tac
   kubeadm | 1.30.0-1.1 | https://pkgs.k8s.io/core:/stable:/v1.30/deb  Packages

controlplane ~ ➜  




- Ajustando para 1.29:
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list



- Ajustada para 1.29


~~~~bash
sudo apt-get update -y
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet=1.29.0-1.1 kubectl=1.29.0-1.1 kubeadm=1.29.0-1.1

sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet
~~~~





- Instalado:
só não está up
tem falha

~~~~bash
root@node01 ~ ➜  sudo apt-mark hold kubelet kubeadm kubectl
kubelet set on hold.
kubeadm set on hold.
kubectl set on hold.

root@node01 ~ ➜  sudo systemctl enable --now kubelet

root@node01 ~ ➜  systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /usr/lib/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: activating (auto-restart) (Result: exit-code) since Fri 2024-05-10 20:40:10 EDT; 9s ago
       Docs: https://kubernetes.io/docs/
    Process: 18150 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, status=1/FAILURE)
   Main PID: 18150 (code=exited, status=1/FAILURE)

root@node01 ~ ✖ 

~~~~















What is the version of kubelet installed?


~~~~bash
root@node01 ~ ✖ kubelet
I0510 20:42:16.547667   19114 server.go:487] "Kubelet version" kubeletVersion="v1.29.0"

~~~~








How many nodes are part of kubernetes cluster currently?

Are you able to run kubectl get nodes?


~~~~bash
root@node01 ~ ➜  kubectl get nodes
E0510 20:42:45.217402   19327 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0510 20:42:45.217903   19327 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0510 20:42:45.219352   19327 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0510 20:42:45.219722   19327 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0510 20:42:45.221242   19327 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
The connection to the server localhost:8080 was refused - did you specify the right host or port?

root@node01 ~ ✖ 


root@node01 ~ ✖ exit
logout
Connection to node01 closed.

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ kubectl get nodes
E0510 20:43:00.697129   24776 memcache.go:265] couldn't get current server API group list: the server could not find the requested resource
E0510 20:43:00.698340   24776 memcache.go:265] couldn't get current server API group list: the server could not find the requested resource
E0510 20:43:00.699331   24776 memcache.go:265] couldn't get current server API group list: the server could not find the requested resource
E0510 20:43:00.701046   24776 memcache.go:265] couldn't get current server API group list: the server could not find the requested resource
E0510 20:43:00.702175   24776 memcache.go:265] couldn't get current server API group list: the server could not find the requested resource
Error from server (NotFound): the server could not find the requested resource

controlplane ~ ✖ 

~~~~













Lets now bootstrap a kubernetes cluster using kubeadm.

The latest version of Kubernetes will be installed.


Initialize Control Plane Node (Master Node). Use the following options:

    apiserver-advertise-address - Use the IP address allocated to eth0 on the controlplane node

    apiserver-cert-extra-sans - Set it to controlplane

    pod-network-cidr - Set to 10.244.0.0/16


Once done, set up the default kubeconfig file and wait for node to be part of the cluster.

Controlplane node initialized

~~~~bash
controlplane ~ ✖ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: flannel.1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKNOWN group default 
    link/ether 0a:1f:51:de:ca:14 brd ff:ff:ff:ff:ff:ff
    inet 10.244.0.0/32 scope global flannel.1
       valid_lft forever preferred_lft forever
3: cni0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 8a:6d:43:4c:0a:2a brd ff:ff:ff:ff:ff:ff
    inet 10.244.0.1/24 brd 10.244.0.255 scope global cni0
       valid_lft forever preferred_lft forever
13679: eth0@if13680: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default 
    link/ether 02:42:c0:00:44:0c brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.0.68.12/24 brd 192.0.68.255 scope global eth0
       valid_lft forever preferred_lft forever
13681: eth1@if13682: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:19:00:2c brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet 172.25.0.44/24 brd 172.25.0.255 scope global eth1
       valid_lft forever preferred_lft forever

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  ip route show
default via 172.25.0.1 dev eth1 
10.244.0.0/24 dev cni0 proto kernel scope link src 10.244.0.1 linkdown 
10.244.1.0/24 via 10.244.1.0 dev flannel.1 onlink 
172.25.0.0/24 dev eth1 proto kernel scope link src 172.25.0.44 
192.0.68.0/24 dev eth0 proto kernel scope link src 192.0.68.12 

controlplane ~ ➜  
~~~~


<https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/>
<https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/#steps-for-the-first-control-plane-node>

## Steps for the first control plane node

Initialize the control plane:

sudo kubeadm init --control-plane-endpoint "LOAD_BALANCER_DNS:LOAD_BALANCER_PORT" --upload-certs

Flags:
      --apiserver-advertise-address string   The IP address the API Server will advertise it's listening on. If not set the default network interface will be used.
      --apiserver-cert-extra-sans strings    Optional extra Subject Alternative Names (SANs) to use for the API Server serving certificate. Can be both IP addresses and DNS names.
      --pod-network-cidr string              Specify range of IP addresses for the pod network. If set, the control plane will automatically allocate CIDRs for every node.


- Editado
sudo kubeadm init --apiserver-advertise-address 192.0.68.12/24 --apiserver-cert-extra-sans controlplane  --pod-network-cidr 10.244.0.0/16

- ERRO:

~~~~bash
controlplane ~ ➜  sudo kubeadm init --apiserver-advertise-address 192.0.68.12/24 --apiserver-cert-extra-sans controlplane  --pod-network-cidr 10.244.0.0/16
couldn't use "192.0.68.12/24" as "apiserver-advertise-address", must be ipv4 or ipv6 address
To see the stack trace of this error execute with --v=5 or higher

controlplane ~ ✖ 
~~~~

- Ajustando:
sudo kubeadm init --apiserver-advertise-address 192.0.68.12 --apiserver-cert-extra-sans controlplane  --pod-network-cidr 10.244.0.0/16

- OK:

~~~~BASH

controlplane ~ ✖ sudo kubeadm init --apiserver-advertise-address 192.0.68.12 --apiserver-cert-extra-sans controlplane  --pod-network-cidr 10.244.0.0/16
I0510 20:55:15.227236   27267 version.go:256] remote version is much newer: v1.30.0; falling back to: stable-1.29
[init] Using Kubernetes version: v1.29.4
[preflight] Running pre-flight checks
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
W0510 20:55:32.899868   27267 checks.go:835] detected that the sandbox image "k8s.gcr.io/pause:3.6" of the container runtime is inconsistent with that used by kubeadm. It is recommended that using "registry.k8s.io/pause:3.9" as the CRI sandbox image.
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [controlplane kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.0.68.12]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [controlplane localhost] and IPs [192.0.68.12 127.0.0.1 ::1]
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [controlplane localhost] and IPs [192.0.68.12 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "super-admin.conf" kubeconfig file
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
[apiclient] All control plane components are healthy after 11.502714 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node controlplane as control-plane by adding the labels: [node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
[mark-control-plane] Marking the node controlplane as control-plane by adding the taints [node-role.kubernetes.io/control-plane:NoSchedule]
[bootstrap-token] Using token: tojk0g.3235g2sdu877zao1
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

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

kubeadm join 192.0.68.12:6443 --token tojk0g.3235g2sdu877zao1 \
        --discovery-token-ca-cert-hash sha256:0389e5959ca2430f10a1e1ce3b93d775b4b1e098262a8a9cc53ccc250d50b2cf 

controlplane ~ ➜  



controlplane ~ ➜    mkdir -p $HOME/.kube

controlplane ~ ➜    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

controlplane ~ ➜    sudo chown $(id -u):$(id -g) $HOME/.kube/config

controlplane ~ ➜  export KUBECONFIG=/etc/kubernetes/admin.conf

controlplane ~ ➜  kubectl get nodes
NAME           STATUS     ROLES           AGE   VERSION
controlplane   NotReady   control-plane   73s   v1.29.0

controlplane ~ ➜  
~~~~














Generate a kubeadm join token

Or copy the one that was generated by kubeadm init command



kubeadm join 192.0.68.12:6443 --token tojk0g.3235g2sdu877zao1 \
        --discovery-token-ca-cert-hash sha256:0389e5959ca2430f10a1e1ce3b93d775b4b1e098262a8a9cc53ccc250d50b2cf 











Join node01 to the cluster using the join token

Node01 joined the cluster?


~~~~bash

kubeadm join 192.0.68.12:6443 --token tojk0g.3235g2sdu877zao1 \
        --discovery-token-ca-cert-hash sha256:0389e5959ca2430f10a1e1ce3b93d775b4b1e098262a8a9cc53ccc250d50b2cf 


root@node01 ~ ➜  kubeadm join 192.0.68.12:6443 --token tojk0g.3235g2sdu877zao1 \
>         --discovery-token-ca-cert-hash sha256:0389e5959ca2430f10a1e1ce3b93d775b4b1e098262a8a9cc53ccc250d50b2cf 
[preflight] Running pre-flight checks
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Starting the kubelet
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the control-plane to see this node join the cluster.


root@node01 ~ ➜  kubectl get nodes
E0510 20:58:15.331528   22762 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0510 20:58:15.331848   22762 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0510 20:58:15.333269   22762 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0510 20:58:15.333520   22762 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0510 20:58:15.334994   22762 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
The connection to the server localhost:8080 was refused - did you specify the right host or port?

root@node01 ~ ✖ 


root@node01 ~ ✖ exit
logout
Connection to node01 closed.

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ kubectl get nodes
NAME           STATUS     ROLES           AGE    VERSION
controlplane   NotReady   control-plane   3m3s   v1.29.0
node01         NotReady   <none>          45s    v1.29.0

controlplane ~ ➜  date
Fri 10 May 2024 08:58:59 PM EDT

controlplane ~ ➜  
~~~~

















To install a network plugin, we will go with Flannel as the default choice. For inter-host communication, we will utilize the eth0 interface.


Please ensure that the Flannel manifest includes the appropriate options for this configuration.

Refer to the official documentation for the procedure.

Network Plugin deployed?

Is Flannel using "eth0" interface for inter-host communication ?


<https://kubernetes.io/docs/concepts/cluster-administration/addons/#networking-and-network-policy>

<https://github.com/flannel-io/flannel#deploying-flannel-manually>



For Kubernetes v1.17+
Deploying Flannel with kubectl

kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

If you use custom podCIDR (not 10.244.0.0/16) you first need to download the above manifest and modify the network to match your one.

~~~~bash


controlplane ~ ✖ kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
namespace/kube-flannel created
serviceaccount/flannel created
clusterrole.rbac.authorization.k8s.io/flannel created
clusterrolebinding.rbac.authorization.k8s.io/flannel created
configmap/kube-flannel-cfg created
daemonset.apps/kube-flannel-ds created

controlplane ~ ➜  
~~~~