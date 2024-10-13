


### Questão 1


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
# repo
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



- Passar Pod gold-nginx para o node "controlplane"
~~~~bash
kubectl edit deploy gold-nginx
nodeName: controlplane
~~~~









### Questão 2


- Comando ajustado, trazendo TODAS AS COLUNAS:

~~~~bash
kubectl get deployment -o custom-columns='DEPLOYMENT:.metadata.name,CONTAINER_IMAGE:.spec.template.spec.containers[*].image,READY_REPLICAS:status.readyReplicas,NAMESPACE:.metadata.namespace' -n admin2406
~~~~

- Enviando para o diretório /opt/admin2406_data:

~~~~bash
kubectl get deployment -o custom-columns='DEPLOYMENT:.metadata.name,CONTAINER_IMAGE:.spec.template.spec.containers[*].image,READY_REPLICAS:status.readyReplicas,NAMESPACE:.metadata.namespace' -n admin2406 > /opt/admin2406_data
~~~~








### Questão 3

- Editando a porta
DE:
4380
PARA:
6443


controlplane ~/CKA ✖ cat admin.kubeconfig  | grep control
    server: https://controlplane:6443

controlplane ~/CKA ➜  







### Questão 4
kubectl create deployment nginx-deploy --image=nginx:1.16 --replicas=1
kubectl edit deployment nginx-deploy