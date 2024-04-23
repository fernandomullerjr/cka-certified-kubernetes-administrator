#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "245. Deploy with Kubeadm - Provision VMs with Vagrant."
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
##   245. Deploy with Kubeadm - Provision VMs with Vagrant

# Provision VMs with Vagrant tool

  - Take me to [Lecture](https://kodekloud.com/topic/deploy-with-kubeadm-provision-vms-with-vagrant/)

If you want to build your own cluster, check these out. They are more up to date than the video currently :smile:

* [Kubeadm Clusters](../../kubeadm-clusters/)
* [Managed Clusters](../../managed-clusters/)


# Demo - Deployment with Kubeadm tool

- Take me to [Lecture](https://kodekloud.com/topic/demo-deployment-with-kubeadm/)

# Apple Silicon

If you have an Apple M1 or M2 (Apple Silicon) machine, then please follow the separate instructions [here](../../apple-silicon/README.md).

For all other operating systems/hardware including Intel Apple, please remain on this page...

# VirtualBox/Vagrant

In this lab, you will build your own 3-node Kubernetes cluster using `kubeadm` with `VirtualBox` and `Vagrant`

## Important Note

This lab cannot currently be performed on Apple M1/M2. We are waiting for VirtualBox to release a version that is fully compatible with Apple Silicon.

## Changes to Lecture

Since the video was recorded, Kubernetes and Ubuntu have progressed somewhat.

We are now using the latest stable release of Ubuntu - 22.04

Docker is no longer supported as a container driver. Instead we will install the `containerd` driver and associated tooling.

# Lab Instructions

1. Install required software

    <details>

    * VirtualBox: https://www.virtualbox.org/
    * Vagrant: https://developer.hashicorp.com/vagrant/downloads

    </details>

1. Clone this repository

    <details>

    ```
    git clone https://github.com/kodekloudhub/certified-kubernetes-administrator-course.git
    cd certified-kubernetes-administrator-course
    ```

    </details>

1. Bring up the virtual machines

    <details>

    ```
    vagrant up
    ```

    This will start 3 virtual machines named

    * `kubemaster` - where we will install the control plane
    * `kubenode01`
    * `kubenode02`

    </details>

1. Check you can SSH to each VM

    <details>

    Note: To exit from VM's ssh session, enter `exit`

    ```
    vagrant ssh kubemaster
    ```

    ```
    vagrant ssh kubenode01
    ```

    ```
    vagrant ssh kubenode02
    ```

    </details>

1. Initialize the nodes.

    The following steps must be performed on each of the three nodes, so `ssh` to `kubemaster` and run the steps, then to `kubenode01`, then to `kubenode02`

      1. Configure kernel parameters

            ```
            {
            cat <<EOF | sudo tee /etc/modules-load.d/11-k8s.conf
            br_netfilter
            EOF

            sudo modprobe br_netfilter

            cat <<EOF | sudo tee /etc/sysctl.d/11-k8s.conf
            net.bridge.bridge-nf-call-ip6tables = 1
            net.bridge.bridge-nf-call-iptables = 1
            net.ipv4.ip_forward = 1
            EOF

            sudo sysctl --system
            }
            ```

    1. Install `containerd` container driver and associated tooling

        <details>

        ```bash
        {
            sudo apt update
            sudo apt install -y apt-transport-https ca-certificates curl
            sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
            echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
            sudo apt-get install -y containerd
            #sudo mkdir -p /opt/cni/bin
            #wget -q --https-only \
            #  https://github.com/containernetworking/plugins/releases/download/v0.8.#6/cni-plugins-linux-amd64-v0.8.6.tgz \
            #  https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.25.0/#crictl-v1.25.0-linux-amd64.tar.gz
            #sudo tar -xzf cni-plugins-linux-amd64-v0.8.6.tgz -C /opt/cni/bin
            #sudo tar -xzf crictl-v1.25.0-linux-amd64.tar.gz -C /usr/local/bin
        }
        ```

    1. Install Kubernetes software

        <details>
        This will install the latest version

        ```bash
        {
        sudo  curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

        echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.

        sudo apt update

        sudo apt-get install -y kubelet kubeadm kubectl
        sudo apt-mark hold kubelet kubeadm kubectl

        # Configure crictl so it doesn't print ugly warning messages
        sudo crictl config \
            --set runtime-endpoint=unix:///run/containerd/containerd.sock \
            --set image-endpoint=unix:///run/containerd/containerd.sock
        }
        ```

        </details>

  1. Initialize controlplane node

     <details>

      1. Get the IP address of the `eth0` adapter of the controlplane

         ```
         ip addr show dev enp0s8
         ```

         Take the value printed for `inet` in the output. This should be:

         > 192.168.56.11

      1. Create a config file for `kubeadm` to get settings from 

          ```yaml
          kind: ClusterConfiguration
          apiVersion: kubeadm.k8s.io/v1beta3
          kubernetesVersion: v1.25.4          # <- At time of writing. Change as appropriate
          controlPlaneEndpoint: 192.168.56.11:6443
          networking:
            serviceSubnet: "10.96.0.0/16"
            podSubnet: "10.244.0.0/16"
            dnsDomain: "cluster.local"
          controllerManager:
            extraArgs:
              "node-cidr-mask-size": "24"
          apiServer:
            extraArgs:
              authorization-mode: "Node,RBAC"
            certSANs:
              - "192.168.56.11"
              - "kubemaster"
              - "kubernetes"
              
          ---
          kind: KubeletConfiguration
          apiVersion: kubelet.config.k8s.io/v1beta1
          cgroupDriver: systemd
          serverTLSBootstrap: true
          ```

      1. Run `kubeadm init` using the IP address determined above for `--apiserver-advertise-address`

         ```
         sudo kubeadm init \
            --apiserver-cert-extra-sans=kubemaster01 \
            --apiserver-advertise-address 192.168.56.11 \
            --pod-network-cidr=10.244.0.0/16
         ```

         Note the `kubeadm join` command output at the end of this run. You will require it for the step `Initialize the worker nodes` below

      1. Set up the default kubeconfig file

         ```
         {
         mkdir ~/.kube
         sudo cp /etc/kubernetes/admin.conf ~/.kube/config
         sudo chown vagrant:vagrant ~/.kube/config
         }
         ```

     </details>

1. Initialize the worker nodes

    <details>

    The following steps must be performed on both worker nodes, so `ssh` to `kubenode01` and run the steps, then to `kubenode02`

    * Paste the `kubeadm join` command from above step to the command prompt and enter it.

    </details>






# ###################################################################################################################### 
# ###################################################################################################################### 
##   245. Deploy with Kubeadm - Provision VMs with Vagrant

- Instalar VirtualBox



## PENDENTE
- Instalar
<https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/kubeadm-clusters/virtualbox/docs/01-prerequisites.md>

- Pasta que tem o  Vagrantfile:
https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/kubeadm-clusters/virtualbox/Vagrantfile




cd /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao11-Install-Kubernetes-the-kubeadm-way/kubeadm-clusters

~~~~bash

fernando@debian10x64:~$ cd /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao11-Install-Kubernetes-the-kubeadm-way/kubeadm-clusters
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/Secao11-Install-Kubernetes-the-kubeadm-way/kubeadm-clusters$
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/Secao11-Install-Kubernetes-the-kubeadm-way/kubeadm-clusters$
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/Secao11-Install-Kubernetes-the-kubeadm-way/kubeadm-clusters$ ls
apple-silicon  aws  aws-ha  generic  README.md  virtualbox
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/Secao11-Install-Kubernetes-the-kubeadm-way/kubeadm-clusters$ ls -lhasp
total 32K
4.0K drwxr-xr-x 7 fernando fernando 4.0K Apr 23 08:43 ./
4.0K drwxr-xr-x 3 fernando fernando 4.0K Apr 23 08:43 ../
4.0K drwxr-xr-x 4 fernando fernando 4.0K Apr 23 08:43 apple-silicon/
4.0K drwxr-xr-x 4 fernando fernando 4.0K Apr 23 08:43 aws/
4.0K drwxr-xr-x 4 fernando fernando 4.0K Apr 23 08:43 aws-ha/
4.0K drwxr-xr-x 2 fernando fernando 4.0K Apr 23 08:43 generic/
4.0K -rw-r--r-- 1 fernando fernando  731 Apr 23 08:43 README.md
4.0K drwxr-xr-x 6 fernando fernando 4.0K Apr 23 08:43 virtualbox/
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/Secao11-Install-Kubernetes-the-kubeadm-way/kubeadm-clusters$ ls -lhasp virtualbox/
total 40K
4.0K drwxr-xr-x 6 fernando fernando 4.0K Apr 23 08:43 ./
4.0K drwxr-xr-x 7 fernando fernando 4.0K Apr 23 08:43 ../
4.0K drwxr-xr-x 2 fernando fernando 4.0K Apr 23 08:43 docs/
4.0K -rw-r--r-- 1 fernando fernando   12 Apr 23 08:43 .gitignore
4.0K drwxr-xr-x 2 fernando fernando 4.0K Apr 23 08:43 mac/
4.0K -rw-r--r-- 1 fernando fernando  127 Apr 23 08:43 README.md
4.0K drwxr-xr-x 2 fernando fernando 4.0K Apr 23 08:43 tools/
4.0K drwxr-xr-x 3 fernando fernando 4.0K Apr 23 08:43 ubuntu/
8.0K -rw-r--r-- 1 fernando fernando 6.9K Apr 23 08:43 Vagrantfile
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/Secao11-Install-Kubernetes-the-kubeadm-way/kubeadm-clusters$ date
Tue 23 Apr 2024 08:44:07 AM -03
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/Secao11-Install-Kubernetes-the-kubeadm-way/kubeadm-clusters$

~~~~




## VirtualBox

<https://www.virtualbox.org/wiki/Linux_Downloads>

Debian-based Linux distributions

Add the following line to your /etc/apt/sources.list. For Debian 11 and older, replace '<mydist>' with 'bullseye', 'buster', or 'stretch'. For Ubuntu 22.04 and older, 'replace '<mydist>' with 'jammy', 'eoan', 'bionic', 'xenial',

deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian <mydist> contrib


fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ lsb_release -cs
buster
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$


- Comando ajustado:
vi /etc/apt/sources.list

deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian buster contrib




 The Oracle public key for verifying the signatures can be downloaded here. You can add these keys with

sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor oracle_vbox_2016.asc

or combine downloading and registering:

wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor

The key fingerprint for oracle_vbox_2016.asc is

B9F8 D658 297A F3EF C18D  5CDF A2F6 83C5 2980 AECF
Oracle Corporation (VirtualBox archive signing key) <info@virtualbox.org>

~~~~bash
fernando@debian10x64:/tmp$ wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
--2024-04-23 08:50:52--  https://www.virtualbox.org/download/oracle_vbox_2016.asc
[sudo] password for fernando: Resolving www.virtualbox.org (www.virtualbox.org)... 184.85.41.242, 2600:1419:3e00:187::37b7, 2600:1419:3e00:183::37b7
Connecting to www.virtualbox.org (www.virtualbox.org)|184.85.41.242|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3157 (3.1K) [application/pgp-signature]
Saving to: ‘STDOUT’

-                                                                  100%[==============================================================================================================================================================>]   3.08K  --.-KB/s    in 0s

2024-04-23 08:50:52 (21.3 MB/s) - written to stdout [3157/3157]


Sorry, try again.
[sudo] password for fernando:
You have new mail in /var/mail/fernando
fernando@debian10x64:/tmp$
fernando@debian10x64:/tmp$ wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
--2024-04-23 08:53:35--  https://www.virtualbox.org/download/oracle_vbox_2016.asc
Resolving www.virtualbox.org (www.virtualbox.org)... 184.85.41.242, 2600:1419:3e00:183::37b7, 2600:1419:3e00:187::37b7
Connecting to www.virtualbox.org (www.virtualbox.org)|184.85.41.242|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3157 (3.1K) [application/pgp-signature]
Saving to: ‘oracle_vbox_2016.asc’

oracle_vbox_2016.asc                                               100%[==============================================================================================================================================================>]   3.08K  --.-KB/s    in 0s

2024-04-23 08:53:35 (11.7 MB/s) - ‘oracle_vbox_2016.asc’ saved [3157/3157]

fernando@debian10x64:/tmp$ sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor oracle_vbox_2016.asc
You have new mail in /var/mail/fernando

~~~~


 To install VirtualBox, do

sudo apt-get update
sudo apt-get install virtualbox-6.1




## Vagrant

<https://developer.hashicorp.com/vagrant/install?product_intent=vagrant>

Linux
Package manager

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant


~~~~bash

root@debian10x64:/tmp# vagrant status

A Vagrant environment or target machine is required to run this
command. Run `vagrant init` to create a new Vagrant environment. Or,
get an ID of a target machine from `vagrant global-status` to run
this command on. A final option is to change to a directory with a
Vagrantfile and to try again.
root@debian10x64:/tmp#
root@debian10x64:/tmp#
root@debian10x64:/tmp# date
Tue 23 Apr 2024 08:57:59 AM -03
root@debian10x64:/tmp#

~~~~


- Efetuada instalação do Virtualbox e Vagrant.


## PENDENTE

- Efetuar proximos passos.




# ###################################################################################################################### 
# ###################################################################################################################### 
##   RESUMO

.- Instalar VirtualBox

- Instalar o Vagrant.

- Pasta que tem o  Vagrantfile:
https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/kubeadm-clusters/virtualbox/Vagrantfile