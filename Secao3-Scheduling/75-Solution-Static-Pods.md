
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 75. Solution - Static Pods"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ##############################################################################################################################################################
#  75. Solution - Static Pods

# How many static pods exist in this cluster in all namespaces?

# Detalhando

## 1ª maneira
Para verificar se um Pod é Static Pod ou não, é possível verificar quando o Pod tem o nome do Node ao final do nome dele, normalmente.
Por exemplo:

~~~~bash
fernando@debian10x64:~$ kubectl get pods -A
NAMESPACE     NAME                               READY   STATUS    RESTARTS         AGE
kube-system   coredns-78fcd69978-zbfqb           1/1     Running   5 (3m44s ago)    46d
kube-system   etcd-minikube                      1/1     Running   5 (3m44s ago)    46d
kube-system   kube-apiserver-minikube            1/1     Running   5 (3m44s ago)    46d
kube-system   kube-controller-manager-minikube   1/1     Running   6 (3m44s ago)    46d
kube-system   kube-proxy-2r8hf                   1/1     Running   5 (3m44s ago)    46d
kube-system   kube-scheduler-minikube            1/1     Running   5 (3m44s ago)    46d
kube-system   storage-provisioner                1/1     Running   10 (2m54s ago)   46d
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get nodes
NAME       STATUS   ROLES                  AGE   VERSION
minikube   Ready    control-plane,master   46d   v1.22.2
fernando@debian10x64:~$
~~~~

Neste caso o node "-minikube".

## 2ª maneira
Para verificar se um Pod é Static Pod ou não, é possível verificar o owner do Pod também, é uma segunda maneira.
Por exemplo:
