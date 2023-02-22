# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 15 - Kube api Server. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 15 - Kube API Server

Kubernetes Architecture
kubectl get nodes
NAME STATUS ROLES AGE VERSION
master Ready master 20m v1.11.3
node01 Ready <none> 20m v1.11.3



Kubernetes Architecture
curl –X POST /api/v1/namespaces/default/pods ...[other]
Pod created!
1. Authenticate User
2. Validate Request
3. Retrieve data
4. Update ETCD
5. Scheduler
6. Kubelet



Kube api Server
1. Authenticate User
2. Validate Request
3. Retrieve data
4. Update ETCD
5. Scheduler
6.
Kubelet





# Installing kube-api server

~~~~bash
wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-apiserver

ExecStart=/usr/local/bin/kube-apiserver \\
--advertise-address=${INTERNAL_IP} \\
--allow-privileged=true \\
--apiserver-count=3 \\
--authorization-mode=Node,RBAC \\
--bind-address=0.0.0.0 \\
--client-ca-file=/var/lib/kubernetes/ca.pem \\
--enable-admissionplugins=
Initializers,NamespaceLifecycle,NodeRestriction,LimitRanger,ServiceAccount,DefaultStorageClass,Reso
urceQuota \\
--enable-swagger-ui=true \\
--etcd-cafile=/var/lib/kubernetes/ca.pem \\
--etcd-certfile=/var/lib/kubernetes/kubernetes.pem \\
--etcd-keyfile=/var/lib/kubernetes/kubernetes-key.pem \\
--etcd-servers=https://127.0.0.1:2379 \\
--event-ttl=1h \\
--experimental-encryption-provider-config=/var/lib/kubernetes/encryption-config.yaml \\
--kubelet-certificate-authority=/var/lib/kubernetes/ca.pem \\
--kubelet-client-certificate=/var/lib/kubernetes/kubernetes.pem \\
--kubelet-cl
~~~~




# View api-server - kubeadm

kubectl get pods -n kube-system

NAMESPACE NAME READY STATUS RESTARTS AGE
kube-system coredns-78fcdf6894-hwrq9 1/1 Running 0 16m
kube-system coredns-78fcdf6894-rzhjr 1/1 Running 0 16m
kube-system etcd-master 1/1 Running 0 15m
kube-system kube-apiserver-master 1/1 Running 0 15m
kube-system kube-controller-manager-master 1/1 Running 0 15m
kube-system kube-proxy-lzt6f 1/1 Running 0 16m
kube-system kube-proxy-zm5qd 1/1 Running 0 16m
kube-system kube-scheduler-master 1/1 Running 0 15m
kube-system weave-net-29z42 2/2 Running 1 16m
kube-system weave-net-snmdl 2/2 Running 1 16m -


# View api-server options - kubeadm

cat /etc/kubernetes/manifests/kube-apiserver.yaml

spec:
containers:
- command:
- kube-apiserver
- --authorization-mode=Node,RBAC
- --advertise-address=172.17.0.32
- --allow-privileged=true
- --client-ca-file=/etc/kubernetes/pki/ca.crt
- --disable-admission-plugins=PersistentVolumeLabel
- --enable-admission-plugins=NodeRestriction
- --enable-bootstrap-token-auth=true
- --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
- --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
- --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key
- --etcd-servers=https://127.0.0.1:2379
- --insecure-port=0
- --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt
- --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key
- --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
- --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt
- --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key
- --requestheader-allowed-names=front-proxy-client
- --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
- --requestheader-extra-headers-prefix=X-Remote-Extra-
- --requestheader-group-headers=X-Remote-Group
- --requestheader-username-headers=X-Remote-User




# PENDENTE
- Passar a limpo a aula 15.