
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 83. Monitor Cluster Components"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
#  83. Monitor Cluster Components


# Monitor Cluster Components
  - Take me to [Video Tutuorials](https://kodekloud.com/topic/monitor-cluster-components/)
  
In this section, we will take a look at monitoring kubernetes cluster

#### How do you monitor resource consumption in kubernetes? or more importantly, what would you like to monitor?
  ![mon](../../images/mon.PNG)
 
## Heapster vs Metrics Server
- Heapster is now deprecated and a slimmed down version was formed known as the **`metrics server`**.

  ![hpms](../../images/hpms.PNG)
  
## Metrics Server

  ![ms1](../../images/ms1.PNG)

#### How are the metrics generated for the PODs on these nodes?

  ![ca](../../images/ca.PNG)
  
## Metrics Server - Getting Started

  ![msg](../../images/msg.PNG)
  
- Clone the metric server from github repo
  ```
  $ git clone https://github.com/kubernetes-incubator/metrics-server.git
  ```
- Deploy the metric server
  ```
  $ kubectl create -f metric-server/deploy/1.8+/
  ```
  
- View the cluster performance
  ```
  $ kubectl top node
  ```
- View performance metrics of pod
  ```
  $ kubectl top pod
  ```
  
  ![view](../../images/view.PNG)
  
  







# ##############################################################################################################################################################
#  83. Monitor Cluster Components

- Heapster vs Metrics Server
    Heapster is now deprecated and a slimmed down version was formed known as the metrics server.


## Metrics Server

How are the metrics generated for the PODs on these nodes?


### Metrics Server - Getting Started

- Para ativar o metrics-server no Minikube:

minikube addons enable metrics-server


### OUTROS 

- Fazendo o Deploy do Metrics Server manualmente num cluster Kubernetes:
é necessário fazer o apply de manifestos que vão criar os recursos necessários para o Metrics Server trabalhar.
após aplicado, é necessário deixar o Metrics Server trabalhar algum tempo, coletando dados e métricas.

- Clone the metric server from github repo

$ git clone https://github.com/kubernetes-incubator/metrics-server.git

- Deploy the metric server

$ kubectl create -f metric-server/deploy/1.8+/

View the cluster performance

$ kubectl top node

View performance metrics of pod

$ kubectl top pod



- Para validar que o Metrics Server está OK e funcionando, usar o comando top:
kubectl top node










# ##############################################################################################################################################################
# Minikube - Testes

- Verificando os addons do Minikube:

~~~~bash
fernando@debian10x64:~$ minikube addons list
|-----------------------------|----------|--------------|-----------------------|
|         ADDON NAME          | PROFILE  |    STATUS    |      MAINTAINER       |
|-----------------------------|----------|--------------|-----------------------|
| ambassador                  | minikube | disabled     | unknown (third-party) |
| auto-pause                  | minikube | disabled     | google                |
| csi-hostpath-driver         | minikube | disabled     | kubernetes            |
| dashboard                   | minikube | disabled     | kubernetes            |
| default-storageclass        | minikube | enabled ✅   | kubernetes            |
| efk                         | minikube | disabled     | unknown (third-party) |
| freshpod                    | minikube | disabled     | google                |
| gcp-auth                    | minikube | disabled     | google                |
| gvisor                      | minikube | disabled     | google                |
| helm-tiller                 | minikube | disabled     | unknown (third-party) |
| ingress                     | minikube | disabled     | unknown (third-party) |
| ingress-dns                 | minikube | disabled     | unknown (third-party) |
| istio                       | minikube | disabled     | unknown (third-party) |
| istio-provisioner           | minikube | disabled     | unknown (third-party) |
| kubevirt                    | minikube | disabled     | unknown (third-party) |
| logviewer                   | minikube | disabled     | google                |
| metallb                     | minikube | disabled     | unknown (third-party) |
| metrics-server              | minikube | disabled     | kubernetes            |
| nvidia-driver-installer     | minikube | disabled     | google                |
| nvidia-gpu-device-plugin    | minikube | disabled     | unknown (third-party) |
| olm                         | minikube | disabled     | unknown (third-party) |
| pod-security-policy         | minikube | disabled     | unknown (third-party) |
| portainer                   | minikube | disabled     | portainer.io          |
| registry                    | minikube | disabled     | google                |
| registry-aliases            | minikube | disabled     | unknown (third-party) |
| registry-creds              | minikube | disabled     | unknown (third-party) |
| storage-provisioner         | minikube | enabled ✅   | kubernetes            |
| storage-provisioner-gluster | minikube | disabled     | unknown (third-party) |
| volumesnapshots             | minikube | disabled     | kubernetes            |
|-----------------------------|----------|--------------|-----------------------|
fernando@debian10x64:~$
~~~~






- MATERIAL EXTRA

<http://www.mtitek.com/tutorials/kubernetes/kubernetes_metrics.php>

~~~~bash
 Verify that 'metrics-server' addon is enabled
Verify that 'metrics-server' addon is enabled:

1

$ minikube addons list | grep metrics-server

1

| metrics-server              | minikube | disabled     |


Enable metrics-server addon (if disabled):

1

$ minikube addons enable metrics-server

1

🌟  The 'metrics-server' addon is enabled


Verify that 'metrics-server' pod is running:

1

$ kubectl get pods --namespace kube-system | grep metrics-server

1

metrics-server-7bc6d75975-qwgxt    1/1     Running   0          17s

Use Kubernetes Dashboard to visualize metrics
Please see this page for details on how to configure Minikube dashboard: MiniKube dashboard

    Visualize Nodes metrics

~~~~






- Para ativar o metrics-server no Minikube:

minikube addons enable metrics-server
minikube addons list | grep metrics-server
kubectl get pods --namespace kube-system | grep metrics-server
kubectl get --raw /apis/metrics.k8s.io/
kubectl get --raw /apis/metrics.k8s.io/v1beta1

~~~~bash
fernando@debian10x64:~$ minikube addons enable metrics-server
  - Using image k8s.gcr.io/metrics-server/metrics-server:v0.4.2
* The 'metrics-server' addon is enabled
fernando@debian10x64:~$


fernando@debian10x64:~$ minikube addons list | grep metrics-server
| metrics-server              | minikube | enabled ✅   | kubernetes            |
fernando@debian10x64:~$

fernando@debian10x64:~$ kubectl get pods --namespace kube-system | grep metrics-server
metrics-server-77c99ccb96-pnnwl    1/1     Running   0                78s
fernando@debian10x64:~$

fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ kubectl get --raw /apis/metrics.k8s.io/
{"kind":"APIGroup","apiVersion":"v1","name":"metrics.k8s.io","versions":[{"groupVersion":"metrics.k8s.io/v1beta1","version":"v1beta1"}],"preferredVersion":{"groupVersion":"metrics.k8s.io/v1beta1","version":"v1beta1"}}
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$

fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ kubectl get --raw /apis/metrics.k8s.io/v1beta1
{"kind":"APIResourceList","apiVersion":"v1","groupVersion":"metrics.k8s.io/v1beta1","resources":[{"name":"nodes","singularName":"","namespaced":false,"kind":"NodeMetrics","verbs":["get","list"]},{"name":"pods","singularName":"","namespaced":true,"kind":"PodMetrics","verbs":["get","list"]}]}
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$

~~~~


