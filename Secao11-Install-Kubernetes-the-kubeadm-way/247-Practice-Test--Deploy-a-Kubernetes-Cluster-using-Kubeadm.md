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
