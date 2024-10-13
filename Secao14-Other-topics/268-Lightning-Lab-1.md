#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "268 - Lightning Lab - 1."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
##  Lightning Lab - 1



### 1 / 7
Weight: 15

Upgrade the current version of kubernetes from 1.29.0 to 1.30.0 exactly using the kubeadm utility. Make sure that the upgrade is carried out one node at a time starting with the controlplane node. To minimize downtime, the deployment gold-nginx should be rescheduled on an alternate node before upgrading each node.

Upgrade controlplane node first and drain node node01 before upgrading it. Pods for gold-nginx should run on the controlplane node subsequently.

Cluster Upgraded?

pods 'gold-nginx' running on controlplane?



controlplane ~ ➜  kubectl get node
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   69m   v1.29.0
node01         Ready    <none>          68m   v1.29.0

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE     IP             NODE           NOMINATED NODE   READINESS GATES
admin2406     deploy1-67b55d4f9f-9m484               1/1     Running   0             2m22s   10.244.192.2   node01         <none>           <none>
admin2406     deploy2-5d4697f587-g2gld               1/1     Running   0             2m22s   10.244.192.3   node01         <none>           <none>
admin2406     deploy3-59985b7bb9-7zfns               1/1     Running   0             2m21s   10.244.192.4   node01         <none>           <none>
admin2406     deploy4-c669bb985-dgddj                1/1     Running   0             2m21s   10.244.192.5   node01         <none>           <none>
admin2406     deploy5-7d5f6f769b-hwsl9               1/1     Running   0             2m21s   10.244.192.6   node01         <none>           <none>
alpha         alpha-mysql-5b944d484-m8t84            0/1     Pending   0             2m23s   <none>         <none>         <none>           <none>
default       gold-nginx-5d9489d9cc-kgq7g            1/1     Running   0             2m28s   10.244.192.1   node01         <none>           <none>
kube-system   coredns-69f9c977-5k82g                 1/1     Running   0             69m     10.244.0.2     controlplane   <none>           <none>
kube-system   coredns-69f9c977-k9f4g                 1/1     Running   0             69m     10.244.0.3     controlplane   <none>           <none>
kube-system   etcd-controlplane                      1/1     Running   0             69m     192.0.254.6    controlplane   <none>           <none>
kube-system   kube-apiserver-controlplane            1/1     Running   0             69m     192.0.254.6    controlplane   <none>           <none>
kube-system   kube-controller-manager-controlplane   1/1     Running   0             69m     192.0.254.6    controlplane   <none>           <none>
kube-system   kube-proxy-7l5ff                       1/1     Running   0             69m     192.0.254.9    node01         <none>           <none>
kube-system   kube-proxy-gz22h                       1/1     Running   0             69m     192.0.254.6    controlplane   <none>           <none>
kube-system   kube-scheduler-controlplane            1/1     Running   0             69m     192.0.254.6    controlplane   <none>           <none>
kube-system   weave-net-5cxkb                        2/2     Running   1 (69m ago)   69m     192.0.254.6    controlplane   <none>           <none>
kube-system   weave-net-mzb97                        2/2     Running   0             69m     192.0.254.9    node01         <none>           <none>

controlplane ~ ➜  

https://v1-30.docs.kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/

sudo apt update
sudo apt-cache madison kubeadm


controlplane ~ ✖ sudo apt update
Get:2 http://security.ubuntu.com/ubuntu jammy-security InRelease [129 kB]                                                                  
Get:3 http://archive.ubuntu.com/ubuntu jammy InRelease [270 kB]                                                                                            
Get:4 https://download.docker.com/linux/ubuntu jammy InRelease [48.8 kB]                                                                                   
Get:5 http://archive.ubuntu.com/ubuntu jammy-updates InRelease [128 kB]                                                                                    
Get:6 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages [48.4 kB]
Get:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.29/deb  InRelease [1,189 B]
Get:7 http://archive.ubuntu.com/ubuntu jammy-backports InRelease [127 kB]
Get:8 http://security.ubuntu.com/ubuntu jammy-security/main amd64 Packages [2,325 kB]
Get:9 http://archive.ubuntu.com/ubuntu jammy/universe amd64 Packages [17.5 MB]
Get:10 http://security.ubuntu.com/ubuntu jammy-security/restricted amd64 Packages [3,122 kB]
Get:11 http://security.ubuntu.com/ubuntu jammy-security/multiverse amd64 Packages [44.7 kB]
Get:12 http://security.ubuntu.com/ubuntu jammy-security/universe amd64 Packages [1,160 kB]   
Get:13 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.29/deb  Packages [14.0 kB]
Get:14 http://archive.ubuntu.com/ubuntu jammy/restricted amd64 Packages [164 kB]              
Get:15 http://archive.ubuntu.com/ubuntu jammy/multiverse amd64 Packages [266 kB]
Get:16 http://archive.ubuntu.com/ubuntu jammy/main amd64 Packages [1,792 kB]
Get:17 http://archive.ubuntu.com/ubuntu jammy-updates/restricted amd64 Packages [3,200 kB]
Get:18 http://archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 Packages [51.8 kB]
Get:19 http://archive.ubuntu.com/ubuntu jammy-updates/universe amd64 Packages [1,449 kB]
Get:20 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [2,602 kB]
Get:21 http://archive.ubuntu.com/ubuntu jammy-backports/universe amd64 Packages [33.7 kB]
Get:22 http://archive.ubuntu.com/ubuntu jammy-backports/main amd64 Packages [81.4 kB]
Fetched 34.5 MB in 3s (12.9 MB/s)                            
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
31 packages can be upgraded. Run 'apt list --upgradable' to see them.

controlplane ~ ➜  sudo apt-cache madison kubeadm
   kubeadm | 1.29.9-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.8-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.7-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.6-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.5-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.4-2.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.3-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.2-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.1-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.0-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages

controlplane ~ ➜  


controlplane ~ ➜  sudo apt update
Hit:2 http://archive.ubuntu.com/ubuntu jammy InRelease                                                                                      
Hit:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.29/deb  InRelease                                     
Hit:3 https://download.docker.com/linux/ubuntu jammy InRelease      
Hit:4 http://archive.ubuntu.com/ubuntu jammy-updates InRelease      
Hit:5 http://security.ubuntu.com/ubuntu jammy-security InRelease
Hit:6 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
31 packages can be upgraded. Run 'apt list --upgradable' to see them.

controlplane ~ ➜  sudo apt-cache madison kubeadm
   kubeadm | 1.29.9-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.8-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.7-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.6-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.5-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.4-2.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.3-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.2-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.1-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages
   kubeadm | 1.29.0-1.1 | https://pkgs.k8s.io/core:/stable:/v1.29/deb  Packages

controlplane ~ ➜  lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.4 LTS
Release:        22.04
Codename:       jammy

controlplane ~ ➜  

https://v1-30.docs.kubernetes.io/blog/2023/08/15/pkgs-k8s-io-introduction/

How to migrate to the Kubernetes community-owned repositories?
Debian, Ubuntu, and operating systems using apt/apt-get

    Replace the apt repository definition so that apt points to the new repository instead of the Google-hosted repository. Make sure to replace the Kubernetes minor version in the command below with the minor version that you're currently using:

    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    Download the public signing key for the Kubernetes package repositories. The same signing key is used for all repositories, so you can disregard the version in the URL:

    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

    Update: In releases older than Debian 12 and Ubuntu 22.04, the folder /etc/apt/keyrings does not exist by default, and it should be created before the curl command.

    Update the apt package index:

    sudo apt-get update

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo apt-get update



controlplane ~ ➜  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list^C

controlplane ~ ✖ echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
File '/etc/apt/keyrings/kubernetes-apt-keyring.gpg' exists. Overwrite? (y/N) y

controlplane ~ ➜  sudo apt-get update
Get:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  InRelease [1,186 B]                           
Hit:2 https://download.docker.com/linux/ubuntu jammy InRelease                                                                                             
Hit:3 http://archive.ubuntu.com/ubuntu jammy InRelease                                                                         
Get:4 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  Packages [9,318 B]
Hit:5 http://archive.ubuntu.com/ubuntu jammy-updates InRelease                  
Hit:6 http://security.ubuntu.com/ubuntu jammy-security InRelease
Hit:7 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Fetched 10.5 kB in 1s (16.4 kB/s)
Reading package lists... Done

controlplane ~ ➜  


- Agora traz 1.30

controlplane ~ ➜  sudo apt-cache madison kubeadm
   kubeadm | 1.30.5-1.1 | https://pkgs.k8s.io/core:/stable:/v1.30/deb  Packages
   kubeadm | 1.30.4-1.1 | https://pkgs.k8s.io/core:/stable:/v1.30/deb  Packages
   kubeadm | 1.30.3-1.1 | https://pkgs.k8s.io/core:/stable:/v1.30/deb  Packages
   kubeadm | 1.30.2-1.1 | https://pkgs.k8s.io/core:/stable:/v1.30/deb  Packages
   kubeadm | 1.30.1-1.1 | https://pkgs.k8s.io/core:/stable:/v1.30/deb  Packages
   kubeadm | 1.30.0-1.1 | https://pkgs.k8s.io/core:/stable:/v1.30/deb  Packages

controlplane ~ ➜  



Call "kubeadm upgrade"

For the first control plane node

    Upgrade kubeadm:
        Ubuntu, Debian or HypriotOS
        CentOS, RHEL or Fedora

    # replace x in 1.30.x-* with the latest patch version
    sudo apt-mark unhold kubeadm && \
    sudo apt-get update && sudo apt-get install -y kubeadm='1.30.x-*' && \
    sudo apt-mark hold kubeadm

    Verify that the download works and has the expected version:

    kubeadm version

    Verify the upgrade plan:

    sudo kubeadm upgrade plan

Choose a version to upgrade to, and run the appropriate command. For example:

# replace x with the patch version you picked for this upgrade
sudo kubeadm upgrade apply v1.30.x

Once the command finishes you should see:

[upgrade/successful] SUCCESS! Your cluster was upgraded to "v1.30.x". Enjoy!

[upgrade/kubelet] Now that your control plane is upgraded, please proceed with upgrading your kubelets if you haven't already done so.



- Ajustados
kubeadm version
sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.30.0-1.1' && \
sudo apt-mark hold kubeadm

kubeadm version
sudo kubeadm upgrade plan
sudo kubeadm upgrade apply v1.30.0



controlplane ~ ➜  kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"29", GitVersion:"v1.29.0", GitCommit:"3f7a50f38688eb332e2a1b013678c6435d539ae6", GitTreeState:"clean", BuildDate:"2023-12-13T08:50:10Z", GoVersion:"go1.21.5", Compiler:"gc", Platform:"linux/amd64"}

controlplane ~ ➜  

controlplane ~ ➜  kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"29", GitVersion:"v1.29.0", GitCommit:"3f7a50f38688eb332e2a1b013678c6435d539ae6", GitTreeState:"clean", BuildDate:"2023-12-13T08:50:10Z", GoVersion:"go1.21.5", Compiler:"gc", Platform:"linux/amd64"}

controlplane ~ ➜  sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.30.0-1.1' && \
sudo apt-mark hold kubeadm
kubeadm was already not on hold.
Hit:2 https://download.docker.com/linux/ubuntu jammy InRelease                                                                                            
Hit:3 http://archive.ubuntu.com/ubuntu jammy InRelease                                                                                                    
Hit:4 http://security.ubuntu.com/ubuntu jammy-security InRelease                       
Hit:5 http://archive.ubuntu.com/ubuntu jammy-updates InRelease                         
Hit:6 http://archive.ubuntu.com/ubuntu jammy-backports InRelease                 
Hit:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  cri-tools
The following packages will be upgraded:
  cri-tools kubeadm
2 upgraded, 0 newly installed, 0 to remove and 31 not upgraded.
Need to get 31.7 MB of archives.
After this operation, 5,055 kB of additional disk space will be used.
Get:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  cri-tools 1.30.1-1.1 [21.3 MB]
Get:2 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  kubeadm 1.30.0-1.1 [10.4 MB]
Fetched 31.7 MB in 1s (56.0 MB/s) 
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 20584 files and directories currently installed.)
Preparing to unpack .../cri-tools_1.30.1-1.1_amd64.deb ...
Unpacking cri-tools (1.30.1-1.1) over (1.29.0-1.1) ...
Preparing to unpack .../kubeadm_1.30.0-1.1_amd64.deb ...
Unpacking kubeadm (1.30.0-1.1) over (1.29.0-1.1) ...
Setting up cri-tools (1.30.1-1.1) ...
Setting up kubeadm (1.30.0-1.1) ...
kubeadm set on hold.

controlplane ~ ➜  kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"30", GitVersion:"v1.30.0", GitCommit:"7c48c2bd72b9bf5c44d21d7338cc7bea77d0ad2a", GitTreeState:"clean", BuildDate:"2024-04-17T17:34:08Z", GoVersion:"go1.22.2", Compiler:"gc", Platform:"linux/amd64"}

controlplane ~ ➜  sudo kubeadm upgrade plan
[upgrade/config] Making sure the configuration is correct:
[preflight] Running pre-flight checks.
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[upgrade] Running cluster health checks
[upgrade] Fetching available versions to upgrade to
[upgrade/versions] Cluster version: 1.29.0
[upgrade/versions] kubeadm version: v1.30.0
I1011 01:08:24.506173   15451 version.go:256] remote version is much newer: v1.31.1; falling back to: stable-1.30
[upgrade/versions] Target version: v1.30.5
[upgrade/versions] Latest version in the v1.29 series: v1.29.9

Components that must be upgraded manually after you have upgraded the control plane with 'kubeadm upgrade apply':
COMPONENT   NODE           CURRENT   TARGET
kubelet     controlplane   v1.29.0   v1.29.9
kubelet     node01         v1.29.0   v1.29.9

Upgrade to the latest version in the v1.29 series:

COMPONENT                 NODE           CURRENT    TARGET
kube-apiserver            controlplane   v1.29.0    v1.29.9
kube-controller-manager   controlplane   v1.29.0    v1.29.9
kube-scheduler            controlplane   v1.29.0    v1.29.9
kube-proxy                               1.29.0     v1.29.9
CoreDNS                                  v1.10.1    v1.11.1
etcd                      controlplane   3.5.10-0   3.5.12-0

You can now apply the upgrade by executing the following command:

        kubeadm upgrade apply v1.29.9

_____________________________________________________________________

Components that must be upgraded manually after you have upgraded the control plane with 'kubeadm upgrade apply':
COMPONENT   NODE           CURRENT   TARGET
kubelet     controlplane   v1.29.0   v1.30.5
kubelet     node01         v1.29.0   v1.30.5

Upgrade to the latest stable version:

COMPONENT                 NODE           CURRENT    TARGET
kube-apiserver            controlplane   v1.29.0    v1.30.5
kube-controller-manager   controlplane   v1.29.0    v1.30.5
kube-scheduler            controlplane   v1.29.0    v1.30.5
kube-proxy                               1.29.0     v1.30.5
CoreDNS                                  v1.10.1    v1.11.1
etcd                      controlplane   3.5.10-0   3.5.12-0

You can now apply the upgrade by executing the following command:

        kubeadm upgrade apply v1.30.5

Note: Before you can perform this upgrade, you have to update kubeadm to v1.30.5.

_____________________________________________________________________


The table below shows the current state of component configs as understood by this version of kubeadm.
Configs that have a "yes" mark in the "MANUAL UPGRADE REQUIRED" column require manual config upgrade or
resetting to kubeadm defaults before a successful upgrade can be performed. The version to manually
upgrade to is denoted in the "PREFERRED VERSION" column.

API GROUP                 CURRENT VERSION   PREFERRED VERSION   MANUAL UPGRADE REQUIRED
kubeproxy.config.k8s.io   v1alpha1          v1alpha1            no
kubelet.config.k8s.io     v1beta1           v1beta1             no
_____________________________________________________________________


controlplane ~ ➜  

controlplane ~ ➜  sudo kubeadm upgrade apply v1.30.0
[upgrade/config] Making sure the configuration is correct:
[preflight] Running pre-flight checks.
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[upgrade] Running cluster health checks
[upgrade/version] You have chosen to change the cluster version to "v1.30.0"
[upgrade/versions] Cluster version: v1.29.0
[upgrade/versions] kubeadm version: v1.30.0
[upgrade] Are you sure you want to proceed? [y/N]: y
[upgrade/prepull] Pulling images required for setting up a Kubernetes cluster
[upgrade/prepull] This might take a minute or two, depending on the speed of your internet connection
[upgrade/prepull] You can also perform this action in beforehand using 'kubeadm config images pull'
W1011 01:09:11.151606   15598 checks.go:844] detected that the sandbox image "registry.k8s.io/pause:3.8" of the container runtime is inconsistent with that used by kubeadm.It is recommended to use "registry.k8s.io/pause:3.9" as the CRI sandbox image.
[upgrade/apply] Upgrading your Static Pod-hosted control plane to version "v1.30.0" (timeout: 5m0s)...
[upgrade/etcd] Upgrading to TLS for etcd
[upgrade/staticpods] Preparing for "etcd" upgrade
[upgrade/staticpods] Renewing etcd-server certificate
[upgrade/staticpods] Renewing etcd-peer certificate
[upgrade/staticpods] Renewing etcd-healthcheck-client certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/etcd.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2024-10-11-01-09-21/etcd.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This can take up to 5m0s
[apiclient] Found 1 Pods for label selector component=etcd
[upgrade/staticpods] Component "etcd" upgraded successfully!
[upgrade/etcd] Waiting for etcd to become available
[upgrade/staticpods] Writing new Static Pod manifests to "/etc/kubernetes/tmp/kubeadm-upgraded-manifests4010477458"
[upgrade/staticpods] Preparing for "kube-apiserver" upgrade
[upgrade/staticpods] Renewing apiserver certificate
[upgrade/staticpods] Renewing apiserver-kubelet-client certificate
[upgrade/staticpods] Renewing front-proxy-client certificate
[upgrade/staticpods] Renewing apiserver-etcd-client certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-apiserver.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2024-10-11-01-09-21/kube-apiserver.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This can take up to 5m0s
[apiclient] Found 1 Pods for label selector component=kube-apiserver
[upgrade/staticpods] Component "kube-apiserver" upgraded successfully!
[upgrade/staticpods] Preparing for "kube-controller-manager" upgrade
[upgrade/staticpods] Renewing controller-manager.conf certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-controller-manager.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2024-10-11-01-09-21/kube-controller-manager.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This can take up to 5m0s
[apiclient] Found 1 Pods for label selector component=kube-controller-manager
[upgrade/staticpods] Component "kube-controller-manager" upgraded successfully!
[upgrade/staticpods] Preparing for "kube-scheduler" upgrade
[upgrade/staticpods] Renewing scheduler.conf certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-scheduler.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2024-10-11-01-09-21/kube-scheduler.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This can take up to 5m0s
[apiclient] Found 1 Pods for label selector component=kube-scheduler
[upgrade/staticpods] Component "kube-scheduler" upgraded successfully!
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[upgrade] Backing up kubelet config file to /etc/kubernetes/tmp/kubeadm-kubelet-config2855891187/config.yaml
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

[upgrade/successful] SUCCESS! Your cluster was upgraded to "v1.30.0". Enjoy!

[upgrade/kubelet] Now that your control plane is upgraded, please proceed with upgrading your kubelets if you haven't already done so.

controlplane ~ ➜  


controlplane ~ ✖ kubectl get node
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   93m   v1.29.0
node01         Ready    <none>          93m   v1.29.0

controlplane ~ ➜  kubectl get node -o wide
NAME           STATUS   ROLES           AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane   93m   v1.29.0   192.0.254.6   <none>        Ubuntu 22.04.4 LTS   5.4.0-1106-gcp   containerd://1.6.26
node01         Ready    <none>          93m   v1.29.0   192.0.254.9   <none>        Ubuntu 22.04.4 LTS   5.4.0-1106-gcp   containerd://1.6.26

controlplane ~ ➜  


controlplane ~ ✖ sudo kubeadm upgrade node
[upgrade] Reading configuration from the cluster...
[upgrade] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
W1011 01:15:12.637991   18747 checks.go:844] detected that the sandbox image "registry.k8s.io/pause:3.8" of the container runtime is inconsistent with that used by kubeadm.It is recommended to use "registry.k8s.io/pause:3.9" as the CRI sandbox image.
[upgrade] Upgrading your Static Pod-hosted control plane instance to version "v1.30.0"...
[upgrade/etcd] Upgrading to TLS for etcd
[upgrade/staticpods] Preparing for "etcd" upgrade
[upgrade/staticpods] Current and new manifests of etcd are equal, skipping upgrade
[upgrade/etcd] Waiting for etcd to become available
[upgrade/staticpods] Writing new Static Pod manifests to "/etc/kubernetes/tmp/kubeadm-upgraded-manifests2575449291"
[upgrade/staticpods] Preparing for "kube-apiserver" upgrade
[upgrade/staticpods] Current and new manifests of kube-apiserver are equal, skipping upgrade
[upgrade/staticpods] Preparing for "kube-controller-manager" upgrade
[upgrade/staticpods] Current and new manifests of kube-controller-manager are equal, skipping upgrade
[upgrade/staticpods] Preparing for "kube-scheduler" upgrade
[upgrade/staticpods] Current and new manifests of kube-scheduler are equal, skipping upgrade
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy
[upgrade] The control plane instance for this node was successfully updated!
[upgrade] Backing up kubelet config file to /etc/kubernetes/tmp/kubeadm-kubelet-config4136536296/config.yaml
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[upgrade] The configuration for this node was successfully updated!
[upgrade] Now you should go ahead and upgrade the kubelet package using your package manager.

controlplane ~ ➜  


Drain the node

Prepare the node for maintenance by marking it unschedulable and evicting the workloads:

# replace <node-to-drain> with the name of your node you are draining
kubectl drain <node-to-drain> --ignore-daemonsets

Upgrade kubelet and kubectl

    Upgrade the kubelet and kubectl:
        Ubuntu, Debian or HypriotOS
        CentOS, RHEL or Fedora

    # replace x in 1.30.x-* with the latest patch version
    sudo apt-mark unhold kubelet kubectl && \
    sudo apt-get update && sudo apt-get install -y kubelet='1.30.x-*' kubectl='1.30.x-*' && \
    sudo apt-mark hold kubelet kubectl

    Restart the kubelet:

    sudo systemctl daemon-reload
    sudo systemctl restart kubelet

Uncordon the node

Bring the node back online by marking it schedulable:

# replace <node-to-uncordon> with the name of your node
kubectl uncordon <node-to-uncordon>


- Ajustados:

~~~~bash
kubectl drain controlplane --ignore-daemonsets
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.30.0-1.1' kubectl='1.30.0-1.1' && \
sudo apt-mark hold kubelet kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet
kubectl uncordon controlplane
~~~~


controlplane ~ ➜  kubectl drain controlplane --ignore-daemonsets
node/controlplane cordoned
Warning: ignoring DaemonSet-managed Pods: kube-system/kube-proxy-wlrmp, kube-system/weave-net-5cxkb
node/controlplane drained

controlplane ~ ➜  sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.30.0-1.1' kubectl='1.30.0-1.1' && \
sudo apt-mark hold kubelet kubectl
kubelet was already not on hold.
kubectl was already not on hold.
Hit:2 https://download.docker.com/linux/ubuntu jammy InRelease                                                                                             
Hit:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  InRelease                                                    
Hit:3 http://security.ubuntu.com/ubuntu jammy-security InRelease                                                                                           
Hit:4 http://archive.ubuntu.com/ubuntu jammy InRelease
Hit:5 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:6 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages will be upgraded:
  kubectl kubelet
2 upgraded, 0 newly installed, 0 to remove and 30 not upgraded.
Need to get 28.9 MB of archives.
After this operation, 9,959 kB disk space will be freed.
Get:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  kubectl 1.30.0-1.1 [10.8 MB]
Get:2 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  kubelet 1.30.0-1.1 [18.1 MB]
Fetched 28.9 MB in 0s (67.5 MB/s) 
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 20584 files and directories currently installed.)
Preparing to unpack .../kubectl_1.30.0-1.1_amd64.deb ...
Unpacking kubectl (1.30.0-1.1) over (1.29.0-1.1) ...
Preparing to unpack .../kubelet_1.30.0-1.1_amd64.deb ...
Unpacking kubelet (1.30.0-1.1) over (1.29.0-1.1) ...
Setting up kubectl (1.30.0-1.1) ...
Setting up kubelet (1.30.0-1.1) ...
kubelet set on hold.
kubectl set on hold.

controlplane ~ ➜  sudo systemctl daemon-reload

controlplane ~ ➜  sudo systemctl restart kubelet

controlplane ~ ➜  kubectl uncordon controlplane
Unable to connect to the server: net/http: TLS handshake timeout

controlplane ~ ✖ 

controlplane ~ ✖ sudo systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /usr/lib/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: active (running) since Fri 2024-10-11 01:18:03 UTC; 32s ago
       Docs: https://kubernetes.io/docs/
   Main PID: 20023 (kubelet)
      Tasks: 32 (limit: 251379)
     Memory: 46.2M
     CGroup: /system.slice/kubelet.service
             └─20023 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var>

Oct 11 01:18:20 controlplane kubelet[20023]: I1011 01:18:20.046733   20023 kubelet.go:1913] "Deleted mirror pod because it is outdated" pod="kube-system/et>
Oct 11 01:18:20 controlplane kubelet[20023]: I1011 01:18:20.047958   20023 kubelet.go:1913] "Deleted mirror pod because it is outdated" pod="kube-system/ku>
Oct 11 01:18:21 controlplane kubelet[20023]: I1011 01:18:21.049707   20023 pod_startup_latency_tracker.go:104] "Observed pod startup duration" pod="kube-sy>
Oct 11 01:18:21 controlplane kubelet[20023]: I1011 01:18:21.056145   20023 pod_startup_latency_tracker.go:104] "Observed pod startup duration" pod="kube-sy>
Oct 11 01:18:21 controlplane kubelet[20023]: I1011 01:18:21.469047   20023 kubelet.go:1908] "Trying to delete pod" pod="kube-system/kube-controller-manager>
Oct 11 01:18:21 controlplane kubelet[20023]: I1011 01:18:21.477078   20023 kubelet.go:1913] "Deleted mirror pod because it is outdated" pod="kube-system/ku>
Oct 11 01:18:21 controlplane kubelet[20023]: I1011 01:18:21.478968   20023 status_manager.go:877] "Failed to update status for pod" pod="kube-system/kube-c>
Oct 11 01:18:23 controlplane kubelet[20023]: I1011 01:18:23.547491   20023 pod_startup_latency_tracker.go:104] "Observed pod startup duration" pod="kube-sy>
Oct 11 01:18:27 controlplane kubelet[20023]: I1011 01:18:27.383133   20023 kubelet.go:1908] "Trying to delete pod" pod="kube-system/kube-apiserver-controlp>
Oct 11 01:18:27 controlplane kubelet[20023]: I1011 01:18:27.391502   20023 kubelet.go:1913] "Deleted mirror pod because it is outdated" pod="kube-system/ku>

controlplane ~ ➜  

- Agora o controlplane tá atualizado:


controlplane ~ ➜  kubectl get node
NAME           STATUS                     ROLES           AGE    VERSION
controlplane   Ready,SchedulingDisabled   control-plane   100m   v1.30.0
node01         Ready                      <none>          99m    v1.29.0

controlplane ~ ➜  date
Fri Oct 11 01:18:57 AM UTC 2024

controlplane ~ ➜  




controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE     NAME                                   READY   STATUS    RESTARTS       AGE     IP             NODE           NOMINATED NODE   READINESS GATES
admin2406     deploy1-67b55d4f9f-9m484               1/1     Running   0              33m     10.244.192.2   node01         <none>           <none>
admin2406     deploy2-5d4697f587-g2gld               1/1     Running   0              33m     10.244.192.3   node01         <none>           <none>
admin2406     deploy3-59985b7bb9-7zfns               1/1     Running   0              33m     10.244.192.4   node01         <none>           <none>
admin2406     deploy4-c669bb985-dgddj                1/1     Running   0              33m     10.244.192.5   node01         <none>           <none>
admin2406     deploy5-7d5f6f769b-hwsl9               1/1     Running   0              33m     10.244.192.6   node01         <none>           <none>
alpha         alpha-mysql-5b944d484-m8t84            0/1     Pending   0              33m     <none>         <none>         <none>           <none>
default       gold-nginx-5d9489d9cc-kgq7g            1/1     Running   0              33m     10.244.192.1   node01         <none>           <none>
kube-system   coredns-7db6d8ff4d-6wpg5               1/1     Running   0              7m29s   10.244.192.8   node01         <none>           <none>
kube-system   coredns-7db6d8ff4d-b9rw9               1/1     Running   0              7m29s   10.244.192.7   node01         <none>           <none>
kube-system   etcd-controlplane                      1/1     Running   1 (85s ago)    70s     192.0.254.6    controlplane   <none>           <none>
kube-system   kube-controller-manager-controlplane   1/1     Running   0              69s     192.0.254.6    controlplane   <none>           <none>
kube-system   kube-proxy-795k4                       1/1     Running   0              7m27s   192.0.254.9    node01         <none>           <none>
kube-system   kube-proxy-wlrmp                       1/1     Running   0              7m29s   192.0.254.6    controlplane   <none>           <none>
kube-system   kube-scheduler-controlplane            1/1     Running   0              70s     192.0.254.6    controlplane   <none>           <none>
kube-system   weave-net-5cxkb                        2/2     Running   1 (100m ago)   100m    192.0.254.6    controlplane   <none>           <none>
kube-system   weave-net-mzb97                        2/2     Running   0              99m     192.0.254.9    node01         <none>           <none>

controlplane ~ ➜  




- Passar o Pod gold-nginx para o node controlplane, antes do upgrade do node01
https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/
https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/
kubectl get nodes --show-labels

controlplane ~ ➜  kubectl get deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
gold-nginx   1/1     1            1           34m

controlplane ~ ➜  kubectl get nodes --show-labels
NAME           STATUS                     ROLES           AGE    VERSION   LABELS
controlplane   Ready,SchedulingDisabled   control-plane   104m   v1.30.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=controlplane,kubernetes.io/os=linux,node-role.kubernetes.io/control-plane=,node.kubernetes.io/exclude-from-external-load-balancers=
node01         Ready                      <none>          103m   v1.29.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=node01,kubernetes.io/os=linux

controlplane ~ ➜  


Create a pod that gets scheduled to your chosen node

This pod configuration file describes a pod that has a node selector, disktype: ssd. This means that the pod will get scheduled on a node that has a disktype=ssd label.
pods/pod-nginx.yaml [Copy pods/pod-nginx.yaml to clipboard]

apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  nodeSelector:
    kubernetes.io/hostname: controlplane


kubectl edit deploy gold-nginx

spec:
  nodeName: controlplane




controlplane ~ ➜  kubectl edit deploy gold-nginx
error: deployments.apps "gold-nginx" is invalid
error: deployments.apps "gold-nginx" is invalid
deployment.apps/gold-nginx edited

controlplane ~ ➜  date
Fri Oct 11 01:27:00 AM UTC 2024

controlplane ~ ➜  





controlplane ~ ➜  kubectl get pods -o wide
NAME                          READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
gold-nginx-65d94b4477-5m9ls   1/1     Running   0          18s   10.244.0.2   controlplane   <none>           <none>

controlplane ~ ➜  



https://v1-30.docs.kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/

Upgrading worker nodes
Upgrade kubeadm

Upgrade kubeadm:

    Ubuntu, Debian or HypriotOS
    CentOS, RHEL or Fedora

# replace x in 1.30.x-* with the latest patch version
sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.30.x-*' && \
sudo apt-mark hold kubeadm

Call "kubeadm upgrade"

For worker nodes this upgrades the local kubelet configuration:

sudo kubeadm upgrade node

Drain the node

Prepare the node for maintenance by marking it unschedulable and evicting the workloads:

# execute this command on a control plane node
# replace <node-to-drain> with the name of your node you are draining
kubectl drain <node-to-drain> --ignore-daemonsets

Upgrade kubelet and kubectl

    Upgrade the kubelet and kubectl:
        Ubuntu, Debian or HypriotOS
        CentOS, RHEL or Fedora

    # replace x in 1.30.x-* with the latest patch version
    sudo apt-mark unhold kubelet kubectl && \
    sudo apt-get update && sudo apt-get install -y kubelet='1.30.x-*' kubectl='1.30.x-*' && \
    sudo apt-mark hold kubelet kubectl

    Restart the kubelet:

    sudo systemctl daemon-reload
    sudo systemctl restart kubelet

Uncordon the node

Bring the node back online by marking it schedulable:

# execute this command on a control plane node
# replace <node-to-uncordon> with the name of your node
kubectl uncordon <node-to-uncordon>




~~~~bash
ssh node01

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo apt-get update

sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.30.0-1.1' && \
sudo apt-mark hold kubeadm

sudo kubeadm upgrade node

kubectl drain node01 --ignore-daemonsets

sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.30.0-1.1' kubectl='1.30.0-1.1' && \
sudo apt-mark hold kubelet kubectl

sudo systemctl daemon-reload
sudo systemctl restart kubelet

kubectl uncordon node01
~~~~



controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  ssh node01

node01 ~ ➜  sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.30.0-1.1' && \
sudo apt-mark hold kubeadm
Canceled hold on kubeadm.
Get:2 https://download.docker.com/linux/ubuntu jammy InRelease [48.8 kB]     
Get:3 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages [48.4 kB]                                               
Get:4 http://security.ubuntu.com/ubuntu jammy-security InRelease [129 kB]                                                                                  
Get:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.29/deb  InRelease [1189 B]
Get:5 http://archive.ubuntu.com/ubuntu jammy InRelease [270 kB]                           
Get:6 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.29/deb  Packages [14.0 kB]
Get:7 http://security.ubuntu.com/ubuntu jammy-security/multiverse amd64 Packages [44.7 kB]           
Get:8 http://archive.ubuntu.com/ubuntu jammy-updates InRelease [128 kB]
Get:9 http://security.ubuntu.com/ubuntu jammy-security/restricted amd64 Packages [3122 kB]
Get:10 http://archive.ubuntu.com/ubuntu jammy-backports InRelease [127 kB]
Get:11 http://archive.ubuntu.com/ubuntu jammy/multiverse amd64 Packages [266 kB]
Get:12 http://archive.ubuntu.com/ubuntu jammy/restricted amd64 Packages [164 kB]
Get:13 http://archive.ubuntu.com/ubuntu jammy/main amd64 Packages [1792 kB]               
Get:14 http://security.ubuntu.com/ubuntu jammy-security/universe amd64 Packages [1160 kB]   
Get:15 http://security.ubuntu.com/ubuntu jammy-security/main amd64 Packages [2325 kB]       
Get:16 http://archive.ubuntu.com/ubuntu jammy/universe amd64 Packages [17.5 MB]             
Get:17 http://archive.ubuntu.com/ubuntu jammy-updates/restricted amd64 Packages [3200 kB]     
Get:18 http://archive.ubuntu.com/ubuntu jammy-updates/universe amd64 Packages [1449 kB]
Get:19 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [2602 kB]
Get:20 http://archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 Packages [51.8 kB]
Get:21 http://archive.ubuntu.com/ubuntu jammy-backports/universe amd64 Packages [33.7 kB]
Get:22 http://archive.ubuntu.com/ubuntu jammy-backports/main amd64 Packages [81.4 kB]
Fetched 34.5 MB in 4s (9088 kB/s)                            
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Package kubeadm is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source

E: Version '1.30.0-1.1' for 'kubeadm' was not found

node01 ~ ✖ echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /

node01 ~ ➜  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
Overwrite? (y/N) y

node01 ~ ➜  sudo apt-get update
Hit:2 https://download.docker.com/linux/ubuntu jammy InRelease                                                                               
Get:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  InRelease [1186 B]                                  
Hit:3 http://archive.ubuntu.com/ubuntu jammy InRelease                                                        
Get:4 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  Packages [9318 B]
Hit:5 http://security.ubuntu.com/ubuntu jammy-security InRelease              
Hit:6 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:7 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Fetched 10.5 kB in 1s (16.0 kB/s)
Reading package lists... Done

node01 ~ ➜  sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.30.0-1.1' && \
sudo apt-mark hold kubeadm
kubeadm was already not on hold.
Hit:2 https://download.docker.com/linux/ubuntu jammy InRelease                                                                   
Hit:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  InRelease                          
Hit:3 http://security.ubuntu.com/ubuntu jammy-security InRelease    
Hit:4 http://archive.ubuntu.com/ubuntu jammy InRelease
Hit:5 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:6 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  cri-tools
The following packages will be upgraded:
  cri-tools kubeadm
2 upgraded, 0 newly installed, 0 to remove and 41 not upgraded.
Need to get 31.7 MB of archives.
After this operation, 5055 kB of additional disk space will be used.
Get:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  cri-tools 1.30.1-1.1 [21.3 MB]
Get:2 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  kubeadm 1.30.0-1.1 [10.4 MB]
Fetched 31.7 MB in 0s (66.7 MB/s) 
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 16698 files and directories currently installed.)
Preparing to unpack .../cri-tools_1.30.1-1.1_amd64.deb ...
Unpacking cri-tools (1.30.1-1.1) over (1.29.0-1.1) ...
Preparing to unpack .../kubeadm_1.30.0-1.1_amd64.deb ...
Unpacking kubeadm (1.30.0-1.1) over (1.29.0-1.1) ...
Setting up cri-tools (1.30.1-1.1) ...
Setting up kubeadm (1.30.0-1.1) ...
kubeadm set on hold.

node01 ~ ➜  sudo kubeadm upgrade node
[upgrade] Reading configuration from the cluster...
[upgrade] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks
[preflight] Skipping prepull. Not a control plane node.
[upgrade] Skipping phase. Not a control plane node.
[upgrade] Backing up kubelet config file to /etc/kubernetes/tmp/kubeadm-kubelet-config1939999691/config.yaml
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[upgrade] The configuration for this node was successfully updated!
[upgrade] Now you should go ahead and upgrade the kubelet package using your package manager.

node01 ~ ➜  kubectl drain node01 --ignore-daemonsets
E1011 01:32:31.770792   16415 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E1011 01:32:31.771592   16415 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E1011 01:32:31.773297   16415 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E1011 01:32:31.773764   16415 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
The connection to the server localhost:8080 was refused - did you specify the right host or port?

node01 ~ ✖ exit
logout
Connection to node01 closed.

controlplane ~ ✖ kubectl drain node01 --ignore-daemonsets
node/node01 cordoned
Warning: ignoring DaemonSet-managed Pods: kube-system/kube-proxy-795k4, kube-system/weave-net-mzb97
evicting pod kube-system/coredns-7db6d8ff4d-b9rw9
evicting pod admin2406/deploy3-59985b7bb9-7zfns
evicting pod admin2406/deploy5-7d5f6f769b-hwsl9
evicting pod admin2406/deploy4-c669bb985-dgddj
evicting pod kube-system/coredns-7db6d8ff4d-6wpg5
evicting pod admin2406/deploy2-5d4697f587-g2gld
evicting pod admin2406/deploy1-67b55d4f9f-9m484
pod/deploy3-59985b7bb9-7zfns evicted
pod/deploy1-67b55d4f9f-9m484 evicted
pod/deploy2-5d4697f587-g2gld evicted
pod/deploy4-c669bb985-dgddj evicted
pod/deploy5-7d5f6f769b-hwsl9 evicted
pod/coredns-7db6d8ff4d-b9rw9 evicted
pod/coredns-7db6d8ff4d-6wpg5 evicted
node/node01 drained

controlplane ~ ➜  ssh node01
Last login: Fri Oct 11 01:30:57 2024 from 192.0.254.6

node01 ~ ➜  sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.30.0-1.1' kubectl='1.30.0-1.1' && \
sudo apt-mark hold kubelet kubectl
Canceled hold on kubelet.
Canceled hold on kubectl.
Hit:2 https://download.docker.com/linux/ubuntu jammy InRelease                                                                                             
Hit:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  InRelease                                                    
Hit:3 http://security.ubuntu.com/ubuntu jammy-security InRelease                                  
Hit:4 http://archive.ubuntu.com/ubuntu jammy InRelease
Hit:5 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:6 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages will be upgraded:
  kubectl kubelet
2 upgraded, 0 newly installed, 0 to remove and 40 not upgraded.
Need to get 28.9 MB of archives.
After this operation, 9959 kB disk space will be freed.
Get:1 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  kubectl 1.30.0-1.1 [10.8 MB]
Get:2 https://prod-cdn.packages.k8s.io/repositories/isv:/kubernetes:/core:/stable:/v1.30/deb  kubelet 1.30.0-1.1 [18.1 MB]
Fetched 28.9 MB in 0s (66.4 MB/s) 
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 16698 files and directories currently installed.)
Preparing to unpack .../kubectl_1.30.0-1.1_amd64.deb ...
Unpacking kubectl (1.30.0-1.1) over (1.29.0-1.1) ...
Preparing to unpack .../kubelet_1.30.0-1.1_amd64.deb ...
Unpacking kubelet (1.30.0-1.1) over (1.29.0-1.1) ...
Setting up kubectl (1.30.0-1.1) ...
Setting up kubelet (1.30.0-1.1) ...
kubelet set on hold.
kubectl set on hold.

node01 ~ ➜  sudo systemctl daemon-reload
sudo systemctl restart kubelet

node01 ~ ➜  exit
logout
Connection to node01 closed.

controlplane ~ ➜  kubectl uncordon node01
node/node01 uncordoned

controlplane ~ ➜  kubectl get node
NAME           STATUS                     ROLES           AGE    VERSION
controlplane   Ready,SchedulingDisabled   control-plane   114m   v1.30.0
node01         Ready                      <none>          113m   v1.30.0

controlplane ~ ➜  date
Fri Oct 11 01:33:13 AM UTC 2024

controlplane ~ ➜  



controlplane ~ ➜  kubectl get pods -o wide
NAME                          READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
gold-nginx-65d94b4477-5m9ls   1/1     Running   0          6m43s   10.244.0.2   controlplane   <none>           <none>

controlplane ~ ➜  











### 2 / 7
Weight: 15

Print the names of all deployments in the admin2406 namespace in the following format:

DEPLOYMENT   CONTAINER_IMAGE   READY_REPLICAS   NAMESPACE

<deployment name>   <container image used>   <ready replica count>   <Namespace>
. The data should be sorted by the increasing order of the deployment name.

Example:

DEPLOYMENT   CONTAINER_IMAGE   READY_REPLICAS   NAMESPACE
deploy0   nginx:alpine   1   admin2406
Write the result to the file /opt/admin2406_data.

Task completed?








# ###################################################################################################################### 
# ###################################################################################################################### 
## PENDENTE

- Documentar procedimento do upgrade de controlplane, usados 2 docs:
https://v1-30.docs.kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/#upgrade-kubelet-and-kubectl
https://v1-30.docs.kubernetes.io/blog/2023/08/15/pkgs-k8s-io-introduction/
Usar versão
'1.30.0-1.1'

No Ubuntu/Deian, usar menção ao 1.30:
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo apt-get update

- Passar Pod gold-nginx para o node "controlplane"
spec:
  nodeName: controlplane

- Upgrade node
https://v1-30.docs.kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/










# ###################################################################################################################### 
# ###################################################################################################################### 
## Dia 13/10/2024


### 1 / 7
Weight: 15

Upgrade the current version of kubernetes from 1.29.0 to 1.30.0 exactly using the kubeadm utility. Make sure that the upgrade is carried out one node at a time starting with the controlplane node. To minimize downtime, the deployment gold-nginx should be rescheduled on an alternate node before upgrading each node.

Upgrade controlplane node first and drain node node01 before upgrading it. Pods for gold-nginx should run on the controlplane node subsequently.

Cluster Upgraded?

pods 'gold-nginx' running on controlplane?



- Atualizando controlplane:

~~~~bash
# repo
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo apt-get update
sudo apt-cache madison kubeadm

# kubeadm
kubeadm version
sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.30.0-1.1' && \
sudo apt-mark hold kubeadm
kubeadm version
sudo kubeadm upgrade plan
sudo kubeadm upgrade apply v1.30.0
kubeadm version

# kubelet and kubectl
kubectl drain controlplane --ignore-daemonsets
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.30.0-1.1' kubectl='1.30.0-1.1' && \
sudo apt-mark hold kubelet kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet
kubectl uncordon controlplane
~~~~



- Agora no node01:

~~~~bash
ssh node01

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo apt-get update

sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.30.0-1.1' && \
sudo apt-mark hold kubeadm

sudo kubeadm upgrade node

exit
kubectl drain node01 --ignore-daemonsets

ssh node01
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.30.0-1.1' kubectl='1.30.0-1.1' && \
sudo apt-mark hold kubelet kubectl

sudo systemctl daemon-reload
sudo systemctl restart kubelet

exit
kubectl uncordon node01
~~~~




controlplane ~ ➜  kubectl get node
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   83m   v1.30.0
node01         Ready    <none>          82m   v1.30.0

controlplane ~ ➜  date
Sun Oct 13 03:37:24 PM UTC 2024

controlplane ~ ➜  




- Passar Pod gold-nginx para o node "controlplane"
spec:
  nodeName: controlplane



controlplane ~ ➜  kubectl get deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
gold-nginx   1/1     1            1           44m

controlplane ~ ➜  

~~~~bash
kubectl edit deploy gold-nginx
nodeName: controlplane
~~~~


controlplane ~ ➜  kubectl get deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
gold-nginx   1/1     1            1           44m

controlplane ~ ➜  kubectl edit deploy gold-nginx
deployment.apps/gold-nginx edited

controlplane ~ ➜  

controlplane ~ ➜  kubectl get deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
gold-nginx   1/1     1            1           45m

controlplane ~ ➜  kubectl get pods -o wide
NAME                          READY   STATUS    RESTARTS   AGE   IP            NODE           NOMINATED NODE   READINESS GATES
gold-nginx-65d94b4477-w6cxc   1/1     Running   0          12s   10.244.0.10   controlplane   <none>           <none>

controlplane ~ ➜  date
Sun Oct 13 03:39:33 PM UTC 2024

controlplane ~ ➜  








### 2 / 7
Weight: 15

Print the names of all deployments in the admin2406 namespace in the following format:

DEPLOYMENT   CONTAINER_IMAGE   READY_REPLICAS   NAMESPACE

<deployment name>   <container image used>   <ready replica count>   <Namespace>
. The data should be sorted by the increasing order of the deployment name.

Example:

DEPLOYMENT   CONTAINER_IMAGE   READY_REPLICAS   NAMESPACE
deploy0   nginx:alpine   1   admin2406
Write the result to the file /opt/admin2406_data.

Task completed?


controlplane ~ ➜  kubectl get deployments -n admin2406 
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
deploy1   1/1     1            1           47m
deploy2   1/1     1            1           47m
deploy3   1/1     1            1           47m
deploy4   1/1     1            1           47m
deploy5   1/1     1            1           47m

controlplane ~ ➜  date
Sun Oct 13 03:40:46 PM UTC 2024

controlplane ~ ➜  


https://kubernetes.io/docs/reference/kubectl/jsonpath/

<https://kubernetes.io/docs/reference/kubectl/jsonpath/>

Examples using kubectl and JSONPath expressions:

~~~~bash
kubectl get pods -o json
kubectl get pods -o=jsonpath='{@}'
kubectl get pods -o=jsonpath='{.items[0]}'
kubectl get pods -o=jsonpath='{.items[0].metadata.name}'
kubectl get pods -o=jsonpath="{.items[*]['metadata.name', 'status.capacity']}"
kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.startTime}{"\n"}{end}'
kubectl get pods -o=jsonpath='{.items[0].metadata.labels.kubernetes\.io/hostname}'
~~~~

https://kubernetes.io/docs/reference/kubectl/quick-reference/

~~~~bash
# Check which nodes are ready with custom-columns
kubectl get node -o custom-columns='NODE_NAME:.metadata.name,STATUS:.status.conditions[?(@.type=="Ready")].status'
~~~~



- Verificando estrutura do JSON dos Deployments:

kubectl get deployment -o json
kubectl get deployment -o json -n admin2406 

kubectl get deployment -o json -n admin2406 

~~~~json
controlplane ~ ➜  kubectl get deployment -o json -n admin2406 
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "apps/v1",
            "kind": "Deployment",
            "metadata": {
                "annotations": {
                    "deployment.kubernetes.io/revision": "1"
                },
                "creationTimestamp": "2024-10-13T15:49:04Z",
                "generation": 1,
                "labels": {
                    "app": "deploy1"
                },
                "name": "deploy1",
                "namespace": "admin2406",
                "resourceVersion": "6975",
                "uid": "7d109c51-3b51-4c1a-bebd-d4166ad1150f"
            },
            "spec": {
                "progressDeadlineSeconds": 600,
                "replicas": 1,
                "revisionHistoryLimit": 10,
                "selector": {
                    "matchLabels": {
                        "app": "deploy1"
                    }
                },
                "strategy": {
                    "rollingUpdate": {
                        "maxSurge": "25%",
                        "maxUnavailable": "25%"
                    },
                    "type": "RollingUpdate"
                },
                "template": {
                    "metadata": {
                        "creationTimestamp": null,
                        "labels": {
                            "app": "deploy1"
                        }
                    },
                    "spec": {
                        "containers": [
                            {
                                "image": "nginx",
                                "imagePullPolicy": "Always",
                                "name": "nginx",
                                "resources": {},
                                "terminationMessagePath": "/dev/termination-log",
                                "terminationMessagePolicy": "File"
                            }
                        ],
                        "dnsPolicy": "ClusterFirst",
                        "restartPolicy": "Always",
                        "schedulerName": "default-scheduler",
                        "securityContext": {},
                        "terminationGracePeriodSeconds": 30
                    }
                }
            },
            "status": {
                "availableReplicas": 1,
                "conditions": [
                    {
                        "lastTransitionTime": "2024-10-13T15:49:04Z",
                        "lastUpdateTime": "2024-10-13T15:49:07Z",
                        "message": "ReplicaSet \"deploy1-67b55d4f9f\" has successfully progressed.",
                        "reason": "NewReplicaSetAvailable",
                        "status": "True",
                        "type": "Progressing"
                    },
                    {
                        "lastTransitionTime": "2024-10-13T16:05:03Z",
                        "lastUpdateTime": "2024-10-13T16:05:03Z",
                        "message": "Deployment has minimum availability.",
                        "reason": "MinimumReplicasAvailable",
                        "status": "True",
                        "type": "Available"
                    }
                ],
                "observedGeneration": 1,
                "readyReplicas": 1,
                "replicas": 1,
                "updatedReplicas": 1
            }
        },
        {
            "apiVersion": "apps/v1",
            "kind": "Deployment",
            "metadata": {
                "annotations": {
                    "deployment.kubernetes.io/revision": "1"
                },
                "creationTimestamp": "2024-10-13T15:49:04Z",
                "generation": 1,
                "labels": {
                    "app": "deploy2"
                },
                "name": "deploy2",
                "namespace": "admin2406",
                "resourceVersion": "6902",
                "uid": "33303845-a563-4a5a-86bf-e6487ba9a332"
            },
            "spec": {
                "progressDeadlineSeconds": 600,
                "replicas": 1,
                "revisionHistoryLimit": 10,
                "selector": {
                    "matchLabels": {
                        "app": "deploy2"
                    }
                },
                "strategy": {
                    "rollingUpdate": {
                        "maxSurge": "25%",
                        "maxUnavailable": "25%"
                    },
                    "type": "RollingUpdate"
                },
                "template": {
                    "metadata": {
                        "creationTimestamp": null,
                        "labels": {
                            "app": "deploy2"
                        }
                    },
                    "spec": {
                        "containers": [
                            {
                                "image": "nginx:alpine",
                                "imagePullPolicy": "IfNotPresent",
                                "name": "nginx",
                                "resources": {},
                                "terminationMessagePath": "/dev/termination-log",
                                "terminationMessagePolicy": "File"
                            }
                        ],
                        "dnsPolicy": "ClusterFirst",
                        "restartPolicy": "Always",
                        "schedulerName": "default-scheduler",
                        "securityContext": {},
                        "terminationGracePeriodSeconds": 30
                    }
                }
            },
            "status": {
                "availableReplicas": 1,
                "conditions": [
                    {
                        "lastTransitionTime": "2024-10-13T15:49:04Z",
                        "lastUpdateTime": "2024-10-13T15:49:07Z",
                        "message": "ReplicaSet \"deploy2-5d4697f587\" has successfully progressed.",
                        "reason": "NewReplicaSetAvailable",
                        "status": "True",
                        "type": "Progressing"
                    },
                    {
                        "lastTransitionTime": "2024-10-13T16:04:52Z",
                        "lastUpdateTime": "2024-10-13T16:04:52Z",
                        "message": "Deployment has minimum availability.",
                        "reason": "MinimumReplicasAvailable",
                        "status": "True",
                        "type": "Available"
                    }
                ],
                "observedGeneration": 1,
                "readyReplicas": 1,
                "replicas": 1,
                "updatedReplicas": 1
            }
        },
        {
            "apiVersion": "apps/v1",
            "kind": "Deployment",
            "metadata": {
                "annotations": {
                    "deployment.kubernetes.io/revision": "1"
                },
                "creationTimestamp": "2024-10-13T15:49:04Z",
                "generation": 1,
                "labels": {
                    "app": "deploy3"
                },
                "name": "deploy3",
                "namespace": "admin2406",
                "resourceVersion": "6972",
                "uid": "713fdbfe-d8be-49a6-9b0d-e8bd6d804ef6"
            },
            "spec": {
                "progressDeadlineSeconds": 600,
                "replicas": 1,
                "revisionHistoryLimit": 10,
                "selector": {
                    "matchLabels": {
                        "app": "deploy3"
                    }
                },
                "strategy": {
                    "rollingUpdate": {
                        "maxSurge": "25%",
                        "maxUnavailable": "25%"
                    },
                    "type": "RollingUpdate"
                },
                "template": {
                    "metadata": {
                        "creationTimestamp": null,
                        "labels": {
                            "app": "deploy3"
                        }
                    },
                    "spec": {
                        "containers": [
                            {
                                "image": "nginx:1.16",
                                "imagePullPolicy": "IfNotPresent",
                                "name": "nginx",
                                "resources": {},
                                "terminationMessagePath": "/dev/termination-log",
                                "terminationMessagePolicy": "File"
                            }
                        ],
                        "dnsPolicy": "ClusterFirst",
                        "restartPolicy": "Always",
                        "schedulerName": "default-scheduler",
                        "securityContext": {},
                        "terminationGracePeriodSeconds": 30
                    }
                }
            },
            "status": {
                "availableReplicas": 1,
                "conditions": [
                    {
                        "lastTransitionTime": "2024-10-13T15:49:04Z",
                        "lastUpdateTime": "2024-10-13T15:49:10Z",
                        "message": "ReplicaSet \"deploy3-59985b7bb9\" has successfully progressed.",
                        "reason": "NewReplicaSetAvailable",
                        "status": "True",
                        "type": "Progressing"
                    },
                    {
                        "lastTransitionTime": "2024-10-13T16:05:03Z",
                        "lastUpdateTime": "2024-10-13T16:05:03Z",
                        "message": "Deployment has minimum availability.",
                        "reason": "MinimumReplicasAvailable",
                        "status": "True",
                        "type": "Available"
                    }
                ],
                "observedGeneration": 1,
                "readyReplicas": 1,
                "replicas": 1,
                "updatedReplicas": 1
            }
        },
        {
            "apiVersion": "apps/v1",
            "kind": "Deployment",
            "metadata": {
                "annotations": {
                    "deployment.kubernetes.io/revision": "1"
                },
                "creationTimestamp": "2024-10-13T15:49:05Z",
                "generation": 1,
                "labels": {
                    "app": "deploy4"
                },
                "name": "deploy4",
                "namespace": "admin2406",
                "resourceVersion": "6946",
                "uid": "0acc1fa5-2ebb-445c-b327-2f340478305f"
            },
            "spec": {
                "progressDeadlineSeconds": 600,
                "replicas": 1,
                "revisionHistoryLimit": 10,
                "selector": {
                    "matchLabels": {
                        "app": "deploy4"
                    }
                },
                "strategy": {
                    "rollingUpdate": {
                        "maxSurge": "25%",
                        "maxUnavailable": "25%"
                    },
                    "type": "RollingUpdate"
                },
                "template": {
                    "metadata": {
                        "creationTimestamp": null,
                        "labels": {
                            "app": "deploy4"
                        }
                    },
                    "spec": {
                        "containers": [
                            {
                                "image": "nginx:1.17",
                                "imagePullPolicy": "IfNotPresent",
                                "name": "nginx",
                                "resources": {},
                                "terminationMessagePath": "/dev/termination-log",
                                "terminationMessagePolicy": "File"
                            }
                        ],
                        "dnsPolicy": "ClusterFirst",
                        "restartPolicy": "Always",
                        "schedulerName": "default-scheduler",
                        "securityContext": {},
                        "terminationGracePeriodSeconds": 30
                    }
                }
            },
            "status": {
                "availableReplicas": 1,
                "conditions": [
                    {
                        "lastTransitionTime": "2024-10-13T15:49:05Z",
                        "lastUpdateTime": "2024-10-13T15:49:13Z",
                        "message": "ReplicaSet \"deploy4-c669bb985\" has successfully progressed.",
                        "reason": "NewReplicaSetAvailable",
                        "status": "True",
                        "type": "Progressing"
                    },
                    {
                        "lastTransitionTime": "2024-10-13T16:04:56Z",
                        "lastUpdateTime": "2024-10-13T16:04:56Z",
                        "message": "Deployment has minimum availability.",
                        "reason": "MinimumReplicasAvailable",
                        "status": "True",
                        "type": "Available"
                    }
                ],
                "observedGeneration": 1,
                "readyReplicas": 1,
                "replicas": 1,
                "updatedReplicas": 1
            }
        },
        {
            "apiVersion": "apps/v1",
            "kind": "Deployment",
            "metadata": {
                "annotations": {
                    "deployment.kubernetes.io/revision": "1"
                },
                "creationTimestamp": "2024-10-13T15:49:05Z",
                "generation": 1,
                "labels": {
                    "app": "deploy5"
                },
                "name": "deploy5",
                "namespace": "admin2406",
                "resourceVersion": "6957",
                "uid": "9d81853b-42fa-47e9-ba1b-c62f53327c31"
            },
            "spec": {
                "progressDeadlineSeconds": 600,
                "replicas": 1,
                "revisionHistoryLimit": 10,
                "selector": {
                    "matchLabels": {
                        "app": "deploy5"
                    }
                },
                "strategy": {
                    "rollingUpdate": {
                        "maxSurge": "25%",
                        "maxUnavailable": "25%"
                    },
                    "type": "RollingUpdate"
                },
                "template": {
                    "metadata": {
                        "creationTimestamp": null,
                        "labels": {
                            "app": "deploy5"
                        }
                    },
                    "spec": {
                        "containers": [
                            {
                                "image": "nginx:latest",
                                "imagePullPolicy": "Always",
                                "name": "nginx",
                                "resources": {},
                                "terminationMessagePath": "/dev/termination-log",
                                "terminationMessagePolicy": "File"
                            }
                        ],
                        "dnsPolicy": "ClusterFirst",
                        "restartPolicy": "Always",
                        "schedulerName": "default-scheduler",
                        "securityContext": {},
                        "terminationGracePeriodSeconds": 30
                    }
                }
            },
            "status": {
                "availableReplicas": 1,
                "conditions": [
                    {
                        "lastTransitionTime": "2024-10-13T15:49:05Z",
                        "lastUpdateTime": "2024-10-13T15:49:13Z",
                        "message": "ReplicaSet \"deploy5-7d5f6f769b\" has successfully progressed.",
                        "reason": "NewReplicaSetAvailable",
                        "status": "True",
                        "type": "Progressing"
                    },
                    {
                        "lastTransitionTime": "2024-10-13T16:05:00Z",
                        "lastUpdateTime": "2024-10-13T16:05:00Z",
                        "message": "Deployment has minimum availability.",
                        "reason": "MinimumReplicasAvailable",
                        "status": "True",
                        "type": "Available"
                    }
                ],
                "observedGeneration": 1,
                "readyReplicas": 1,
                "replicas": 1,
                "updatedReplicas": 1
            }
        }
    ],
    "kind": "List",
    "metadata": {
        "resourceVersion": ""
    }
}

controlplane ~ ➜  

~~~~


- Ajustando:


kubectl get deployment -o=jsonpath="{.items[*]['metadata.name', 'status.capacity']}" -n admin2406

controlplane ~ ➜  kubectl get deployment -o=jsonpath="{.items[*]['metadata.name', 'status.capacity']}" -n admin2406
deploy1 deploy2 deploy3 deploy4 deploy5
controlplane ~ ➜  


controlplane ~ ➜  kubectl get deployment -o custom-columns='DEPLOYMENT:.metadata.name' -n admin2406
DEPLOYMENT
deploy1
deploy2
deploy3
deploy4
deploy5

controlplane ~ ➜  



~~~~bash
kubectl get deployment -o custom-columns='DEPLOYMENT:.metadata.name' -n admin2406
~~~~