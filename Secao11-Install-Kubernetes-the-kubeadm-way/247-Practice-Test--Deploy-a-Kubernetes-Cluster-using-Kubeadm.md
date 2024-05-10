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