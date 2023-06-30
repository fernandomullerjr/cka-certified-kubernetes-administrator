
## Drenar node
kubectl drain controlplane

## Marcar o node como schedulable novamente
kubectl uncordon controlplane




## Upgrade Kubeadm

apt update
apt-cache madison kubeadm

apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.27.0-00 && \
apt-mark hold kubeadm

kubeadm version

kubeadm upgrade plan

sudo kubeadm upgrade apply v1.27.0




## Upgrade the kubelet and kubectl:

apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.27.0-00 kubectl=1.27.0-00 && \
apt-mark hold kubelet kubectl

sudo systemctl daemon-reload
sudo systemctl restart kubelet





## Worker node - Upgrade


apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.27.0-00 && \
apt-mark hold kubeadm

sudo kubeadm upgrade node

apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.27.0-00 kubectl=1.27.0-00 && \
apt-mark hold kubelet kubectl
