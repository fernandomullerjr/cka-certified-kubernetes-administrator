



167-Service-Accounts.md




# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# push

git status
git add .
git commit -m "167-Service-Accounts."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# 167-Service-Accounts



~~~~bash
fernando@debian10x64:~$ kubectl get sa
NAME      SECRETS   AGE
default   0         31d
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get sa -A
NAMESPACE         NAME                                 SECRETS   AGE
backstage         default                              0         22h
default           default                              0         31d
kube-node-lease   default                              0         31d
kube-public       default                              0         31d
kube-system       attachdetach-controller              0         31d
kube-system       bootstrap-signer                     0         31d
kube-system       certificate-controller               0         31d
kube-system       cilium                               0         31d
kube-system       cilium-operator                      0         31d
kube-system       clusterrole-aggregation-controller   0         31d
kube-system       coredns                              0         31d
kube-system       cronjob-controller                   0         31d
kube-system       daemon-set-controller                0         31d
kube-system       default                              0         31d
kube-system       deployment-controller                0         31d
kube-system       disruption-controller                0         31d
kube-system       endpoint-controller                  0         31d
kube-system       endpointslice-controller             0         31d
kube-system       endpointslicemirroring-controller    0         31d
kube-system       ephemeral-volume-controller          0         31d
kube-system       expand-controller                    0         31d
kube-system       generic-garbage-collector            0         31d
kube-system       horizontal-pod-autoscaler            0         31d
kube-system       job-controller                       0         31d
kube-system       kube-proxy                           0         31d
kube-system       namespace-controller                 0         31d
kube-system       node-controller                      0         31d
kube-system       persistent-volume-binder             0         31d
kube-system       pod-garbage-collector                0         31d
kube-system       pv-protection-controller             0         31d
kube-system       pvc-protection-controller            0         31d
kube-system       replicaset-controller                0         31d
kube-system       replication-controller               0         31d
kube-system       resourcequota-controller             0         31d
kube-system       root-ca-cert-publisher               0         31d
kube-system       service-account-controller           0         31d
kube-system       service-controller                   0         31d
kube-system       statefulset-controller               0         31d
kube-system       token-cleaner                        0         31d
kube-system       ttl-after-finished-controller        0         31d
kube-system       ttl-controller                       0         31d
fernando@debian10x64:~$

~~~~







kubectl describe serviceaccount cilium-operator -n kube-system



fernando@debian10x64:~$ kubectl describe serviceaccount cilium-operator -n kube-system
Name:                cilium-operator
Namespace:           kube-system
Labels:              app.kubernetes.io/managed-by=Helm
Annotations:         meta.helm.sh/release-name: cilium
                     meta.helm.sh/release-namespace: kube-system
Image pull secrets:  <none>
Mountable secrets:   <none>
Tokens:              <none>
Events:              <none>
fernando@debian10x64:~$











kubectl create serviceaccount teste-aula

~~~~bash

fernando@debian10x64:~$ kubectl create serviceaccount teste-aula
serviceaccount/teste-aula created
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl describe serviceaccount teste-aula
Name:                teste-aula
Namespace:           default
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   <none>
Tokens:              <none>
Events:              <none>
fernando@debian10x64:~$

~~~~




kubectl get secret $(kubectl get serviceaccount teste-aula -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 -d

NADA OCORREU



https://medium.com/@th3b3ginn3r/understanding-service-accounts-in-kubernetes-e9d2abe19df8

<https://medium.com/@th3b3ginn3r/understanding-service-accounts-in-kubernetes-e9d2abe19df8>

In the K8s version before 1.24, every time we would create a service account, a non-expiring secret token (Mountable secrets & Tokens) was created by default. However, from version 1.24 onwards, it was disbanded and no secret token is created by default when we create a service account. However, we can create it when need be. Now let us take a look at the service account token in a bit more depth.











https://dev.to/perber/how-to-create-a-secret-for-a-service-account-in-kubernetes-124-and-above-5c92
<https://dev.to/perber/how-to-create-a-secret-for-a-service-account-in-kubernetes-124-and-above-5c92>

 How to Create a Secret for a Service Account in Kubernetes 1.24 and above
#kubernetes
#devops
#linux

Starting from Kubernetes version 1.24, the secrets for a service account are no longer created automatically. This can be a problem for developers who need to access the Kubernetes API server with the service account, for example, when working with pipelines. We had the issue when connection to vault. In this post, I will show you how to manually create a secret for a service account in Kubernetes.
Using kubectl create token to Create a Token

To generate a token to access the Kubernetes API server, you can use the kubectl create token command. This command will return a JWT token. Here's an example:

~~~~BASH
# creating service account
kubectl create sa pipeline
kubectl create token pipeline
kubectl create token pipeline --duration=999999h
~~~~





fernando@debian10x64:~$ kubectl create token teste
Error: must specify one of -f and -k

error: unknown command "token teste"
See 'kubectl create -h' for help and examples
fernando@debian10x64:~$










comando curl para efetuar consulta na api do kubernetes com opção insecure?
ChatGPT

Para fazer uma consulta à API do Kubernetes usando o curl e ignorar a verificação do certificado SSL (o que é inseguro e deve ser evitado em ambientes de produção), você pode usar a opção --insecure ou -k. Além disso, você precisa especificar o token de autenticação do ServiceAccount ou credenciais de autenticação apropriadas, juntamente com a URL da API do Kubernetes.

Aqui está um exemplo de um comando curl para fazer uma solicitação à API do Kubernetes com a opção --insecure:

bash

curl --insecure --header "Authorization: Bearer YOUR_TOKEN" "https://YOUR_KUBERNETES_API_SERVER/api/v1/namespaces/default/pods"

Neste comando:

    --insecure: Ignora a verificação do certificado SSL (inseguro, use apenas para testes).
    --header "Authorization: Bearer YOUR_TOKEN": Substitua YOUR_TOKEN pelo token de autenticação do ServiceAccount ou outro método de autenticação que você esteja usando.
    "https://YOUR_KUBERNETES_API_SERVER/api/v1/namespaces/default/pods": Substitua YOUR_KUBERNETES_API_SERVER pelo endereço do seu servidor de API do Kubernetes. Este exemplo consulta todos os pods no namespace padrão (default). Você pode ajustar a URL conforme necessário para acessar outras partes da API do Kubernetes.

Tenha cuidado ao usar a opção --insecure, pois ela expõe suas comunicações a possíveis ataques Man-in-the-Middle (MITM). Em ambientes de produção, é altamente recomendável usar certificados SSL válidos e configurar a autenticação adequada em vez de desativar a verificação SSL.





curl -k --header "Authorization: Bearer YOUR_TOKEN" https://192.168.92.129:6443/version





- A secret é montada dentro do Pod no diretório "/var/run/secrets/kubernetes.io/serviceaccount":

kubectl exec -it cilium-krwv4 -n kube-system -- ls -lhasp /var/run/secrets/kubernetes.io/

~~~~bash

fernando@debian10x64:~$ kubectl exec -it cilium-krwv4 -n kube-system -- ls -lhasp /var/run/secrets/kubernetes.io/serviceaccount
Defaulted container "cilium-agent" out of: cilium-agent, config (init), mount-cgroup (init), apply-sysctl-overwrites (init), mount-bpf-fs (init), clean-cilium-state (init), install-cni-binaries (init)
total 4.0K
   0 drwxrwxrwt 3 root root  140 Oct 24 01:32 ./
4.0K drwxr-xr-x 3 root root 4.0K Oct 18 00:09 ../
   0 drwxr-xr-x 2 root root  100 Oct 24 01:32 ..2023_10_24_01_32_44.4110393460/
   0 lrwxrwxrwx 1 root root   32 Oct 24 01:32 ..data -> ..2023_10_24_01_32_44.4110393460
   0 lrwxrwxrwx 1 root root   13 Oct 18 00:09 ca.crt -> ..data/ca.crt
   0 lrwxrwxrwx 1 root root   16 Oct 18 00:09 namespace -> ..data/namespace
   0 lrwxrwxrwx 1 root root   12 Oct 18 00:09 token -> ..data/token
fernando@debian10x64:~$

~~~~




kubectl exec -it cilium-krwv4 -n kube-system -- ls -lhasp /var/run/secrets/kubernetes.io/

kubectl exec -it cilium-krwv4 -n kube-system -- cat /var/run/secrets/kubernetes.io/serviceaccount/token


~~~~baSH

fernando@debian10x64:~$ kubectl exec -it cilium-krwv4 -n kube-system -- cat /var/run/secrets/kubernetes.io/serviceaccount/token     Defaulted container "cilium-agent" out of: cilium-agent, config (init), mount-cgroup (init), apply-sysctl-overwrites (init), mount-bpf-fs (init), clean-cilium-state (init), install-cni-binaries (init)
eyJhbGciOiJSUzI1NiIsImtpZCI6Ikp3SXpmZHBVMTV4ZTVNdjcyVXhOYWJoWFdXUEpud1NFSDB2Wlk0dGR3d3cifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiXSwiZXhwIjoxNzI5NjQ3MTY0LCJpYXQiOjE2OTgxMTExNjQsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsInBvZCI6eyJuYW1lIjoiY2lsaXVtLWtyd3Y0IiwidWlkIjoiNzEyMjMxYjMtYWZkOS00OGExLTlmNGEtZWZmOWI1Zjg3YTg0In0sInNlcnZpY2VhY2NvdW50Ijp7Im5hbWUiOiJjaWxpdW0iLCJ1aWQiOiI1ZmIyMzBmYS0yM2ZmLTQ4MzItYjAwZS0zMzViMDAwNjUxNzMifSwid2FybmFmdGVyIjoxNjk4MTE0NzcxfSwibmJmIjoxNjk4MTExMTY0LCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06Y2lsaXVtIn0.RWOzeJEtkmdZmvrMFqUgHwgde4pslDwhN5BoCJotpX1Y_XBV-NH2GTFK96Oh5ldWYK-RBVTdaCvLmnykm7S0yWBWQdo1a08PfrcrwiHHsA-1k1bjCbmryqHTPLY16ax3_zdGj-Gywey2JNNIQrH8QKRoUYT6rhXjeC1CV16LysTXtPlX538rkwoOyZJCMEwrbbq27xB78LHL_311d4QfjB6HiOiekX01zlszH57hhWMN8uSqg2yQ2ajSVG_twsBPnspIYJ-oNII_zTVgNA3kbZbCO3zzT2mzWs4agp1g4cYl5ad4ZloGH9ikVWj-xGYZBFDpLUpzGMerTvrBdvapmgfernando@debian10x64:~$
fernando@debian10x64:~$

~~~~



## PENDENTE

- Ver porque não é possível criar Token no Kubernetes 1.28


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# RESUMO

Na versão K8s anterior à 1.24, sempre que criávamos uma conta de serviço, um token secreto que não expirava (segredos e tokens montáveis) era criado por padrão. 
Porém, a partir da versão 1.24, ele foi desfeito e nenhum token secreto é criado por padrão quando criamos uma conta de serviço. No entanto, podemos criá-lo quando necessário.













# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
#  Dia 27/10/2023

- Erro no kubeadm

~~~~bash

root@debian10x64:/home/fernando# kubectl get pods
The connection to the server 192.168.92.129:6443 was refused - did you specify the right host or port?
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Fri 27 Oct 2023 11:48:21 PM -03
root@debian10x64:/home/fernando#

The connection to the server 192.168.92.129:6443 was refused - did you specify the right host or port?
root@debian10x64:/home/fernando# kubectl get nodes
The connection to the server 192.168.92.129:6443 was refused - did you specify the right host or port?
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl cluster-info

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
The connection to the server 192.168.92.129:6443 was refused - did you specify the right host or port?
root@debian10x64:/home/fernando#

~~~~







Please perform below steps on the master node. It works like charm.

1. sudo -i

2. swapoff -a

3. exit

4. strace -eopenat kubectl version



Efetuado teste, segue com erro.












- Kubelet com erros

journalctl -xeu kubelet

~~~~bash
Oct 28 00:00:54 debian10x64 kubelet[4687]: I1028 00:00:54.359429    4687 reconciler_common.go:258] "operationExecutor.VerifyControllerAttachedVolume started for volume \"usr-local-share
Oct 28 00:00:54 debian10x64 kubelet[4687]: E1028 00:00:54.460095    4687 controller.go:146] "Failed to ensure lease exists, will retry" err="Get \"https://192.168.92.129:6443/apis/coord
Oct 28 00:00:54 debian10x64 kubelet[4687]: I1028 00:00:54.555250    4687 scope.go:117] "RemoveContainer" containerID="92f71d8760fdc154a9065c7a18cd1d059bed8e734ffa36498934f1935ce84617"
Oct 28 00:00:54 debian10x64 kubelet[4687]: I1028 00:00:54.679765    4687 kubelet_node_status.go:70] "Attempting to register node" node="debian10x64"
Oct 28 00:00:54 debian10x64 kubelet[4687]: E1028 00:00:54.681311    4687 kubelet_node_status.go:92] "Unable to register node with API server" err="Post \"https://192.168.92.129:6443/api
Oct 28 00:00:54 debian10x64 kubelet[4687]: E1028 00:00:54.862592    4687 controller.go:146] "Failed to ensure lease exists, will retry" err="Get \"https://192.168.92.129:6443/apis/coord
Oct 28 00:00:55 debian10x64 kubelet[4687]: W1028 00:00:55.384636    4687 reflector.go:535] vendor/k8s.io/client-go/informers/factory.go:150: failed to list *v1.Service: Get "https://192
Oct 28 00:00:55 debian10x64 kubelet[4687]: E1028 00:00:55.384876    4687 reflector.go:147] vendor/k8s.io/client-go/informers/factory.go:150: Failed to watch *v1.Service: failed to list
Oct 28 00:00:55 debian10x64 kubelet[4687]: W1028 00:00:55.566704    4687 reflector.go:535] vendor/k8s.io/client-go/informers/factory.go:150: failed to list *v1.RuntimeClass: Get "https:
Oct 28 00:00:55 debian10x64 kubelet[4687]: E1028 00:00:55.566908    4687 reflector.go:147] vendor/k8s.io/client-go/informers/factory.go:150: Failed to watch *v1.RuntimeClass: failed to
Oct 28 00:00:55 debian10x64 kubelet[4687]: I1028 00:00:55.578719    4687 scope.go:117] "RemoveContainer" containerID="eb0c4e855dfc3974a3abf3e478c62a62a4b19c32727cac25aa02b23fae7498e2"
Oct 28 00:00:55 debian10x64 kubelet[4687]: E1028 00:00:55.668555    4687 controller.go:146] "Failed to ensure lease exists, will retry" err="Get \"https://192.168.92.129:6443/apis/coord
Oct 28 00:00:55 debian10x64 kubelet[4687]: W1028 00:00:55.817311    4687 reflector.go:535] vendor/k8s.io/client-go/informers/factory.go:150: failed to list *v1.CSIDriver: Get "https://1
Oct 28 00:00:55 debian10x64 kubelet[4687]: E1028 00:00:55.817748    4687 reflector.go:147] vendor/k8s.io/client-go/informers/factory.go:150: Failed to watch *v1.CSIDriver: failed to lis
Oct 28 00:00:55 debian10x64 kubelet[4687]: W1028 00:00:55.844529    4687 reflector.go:535] vendor/k8s.io/client-go/informers/factory.go:150: failed to list *v1.Node: Get "https://192.16
Oct 28 00:00:55 debian10x64 kubelet[4687]: E1028 00:00:55.844750    4687 reflector.go:147] vendor/k8s.io/client-go/informers/factory.go:150: Failed to watch *v1.Node: failed to list *v1
Oct 28 00:00:56 debian10x64 kubelet[4687]: I1028 00:00:56.291050    4687 kubelet_node_status.go:70] "Attempting to register node" node="debian10x64"
Oct 28 00:00:56 debian10x64 kubelet[4687]: I1028 00:00:56.620084    4687 scope.go:117] "RemoveContainer" containerID="92f71d8760fdc154a9065c7a18cd1d059bed8e734ffa36498934f1935ce84617"
Oct 28 00:00:56 debian10x64 kubelet[4687]: I1028 00:00:56.628767    4687 scope.go:117] "RemoveContainer" containerID="17759088870d9a7a2edb28b06164170620441044d96b0c01ccce84e25abe7bf3"
Oct 28 00:00:56 debian10x64 kubelet[4687]: E1028 00:00:56.629724    4687 pod_workers.go:1300] "Error syncing pod, skipping" err="failed to \"StartContainer\" for \"etcd\" with CrashLoop
Oct 28 00:00:57 debian10x64 kubelet[4687]: I1028 00:00:57.643270    4687 scope.go:117] "RemoveContainer" containerID="17759088870d9a7a2edb28b06164170620441044d96b0c01ccce84e25abe7bf3"
Oct 28 00:00:57 debian10x64 kubelet[4687]: E1028 00:00:57.644116    4687 pod_workers.go:1300] "Error syncing pod, skipping" err="failed to \"StartContainer\" for \"etcd\" with CrashLoop
Oct 28 00:01:02 debian10x64 kubelet[4687]: I1028 00:01:02.754339    4687 scope.go:117] "RemoveContainer" containerID="17759088870d9a7a2edb28b06164170620441044d96b0c01ccce84e25abe7bf3"
Oct 28 00:01:02 debian10x64 kubelet[4687]: E1028 00:01:02.755000    4687 pod_workers.go:1300] "Error syncing pod, skipping" err="failed to \"StartContainer\" for \"etcd\" with CrashLoop
Oct 28 00:01:02 debian10x64 kubelet[4687]: E1028 00:01:02.777163    4687 eviction_manager.go:258] "Eviction manager: failed to get summary stats" err="failed to get node info: node \"de
Oct 28 00:01:04 debian10x64 kubelet[4687]: I1028 00:01:04.571885    4687 scope.go:117] "RemoveContainer" containerID="17759088870d9a7a2edb28b06164170620441044d96b0c01ccce84e25abe7bf3"
Oct 28 00:01:04 debian10x64 kubelet[4687]: E1028 00:01:04.572449    4687 pod_workers.go:1300] "Error syncing pod, skipping" err="failed to \"StartContainer\" for \"etcd\" with CrashLoop
Oct 28 00:01:06 debian10x64 kubelet[4687]: E1028 00:01:06.295354    4687 kubelet_node_status.go:92] "Unable to register node with API server" err="Post \"https://192.168.92.129:6443/api
Oct 28 00:01:07 debian10x64 kubelet[4687]: E1028 00:01:07.271411    4687 controller.go:146] "Failed to ensure lease exists, will retry" err="Get \"https://192.168.92.129:6443/apis/coord
Oct 28 00:01:08 debian10x64 kubelet[4687]: W1028 00:01:08.256171    4687 reflector.go:535] vendor/k8s.io/client-go/informers/factory.go:150: failed to list *v1.CSIDriver: Get "https://1
Oct 28 00:01:08 debian10x64 kubelet[4687]: I1028 00:01:08.256403    4687 trace.go:236] Trace[509717370]: "Reflector ListAndWatch" name:vendor/k8s.io/client-go/informers/factory.go:150 (
Oct 28 00:01:08 debian10x64 kubelet[4687]: Trace[509717370]: ---"Objects listed" error:Get "https://192.168.92.129:6443/apis/storage.k8s.io/v1/csidrivers?limit=500&resourceVersion=0": n
Oct 28 00:01:08 debian10x64 kubelet[4687]: Trace[509717370]: [10.005025427s] [10.005025427s] END
Oct 28 00:01:08 debian10x64 kubelet[4687]: E1028 00:01:08.256476    4687 reflector.go:147] vendor/k8s.io/client-go/informers/factory.go:150: Failed to watch *v1.CSIDriver: failed to lis
Oct 28 00:01:08 debian10x64 kubelet[4687]: W1028 00:01:08.366471    4687 reflector.go:535] vendor/k8s.io/client-go/informers/factory.go:150: failed to list *v1.RuntimeClass: Get "https:
Oct 28 00:01:08 debian10x64 kubelet[4687]: I1028 00:01:08.366719    4687 trace.go:236] Trace[935093795]: "Reflector ListAndWatch" name:vendor/k8s.io/client-go/informers/factory.go:150 (
Oct 28 00:01:08 debian10x64 kubelet[4687]: Trace[935093795]: ---"Objects listed" error:Get "https://192.168.92.129:6443/apis/node.k8s.io/v1/runtimeclasses?limit=500&resourceVersion=0":
Oct 28 00:01:08 debian10x64 kubelet[4687]: Trace[935093795]: [10.003346987s] [10.003346987s] END
Oct 28 00:01:08 debian10x64 kubelet[4687]: E1028 00:01:08.366805    4687 reflector.go:147] vendor/k8s.io/client-go/informers/factory.go:150: Failed to watch *v1.RuntimeClass: failed to
Oct 28 00:01:08 debian10x64 kubelet[4687]: W1028 00:01:08.369746    4687 reflector.go:535] vendor/k8s.io/client-go/informers/factory.go:150: failed to list *v1.Service: Get "https://192
Oct 28 00:01:08 debian10x64 kubelet[4687]: I1028 00:01:08.369919    4687 trace.go:236] Trace[2141674617]: "Reflector ListAndWatch" name:vendor/k8s.io/client-go/informers/factory.go:150
Oct 28 00:01:08 debian10x64 kubelet[4687]: Trace[2141674617]: ---"Objects listed" error:Get "https://192.168.92.129:6443/api/v1/services?limit=500&resourceVersion=0": net/http: TLS hand
Oct 28 00:01:08 debian10x64 kubelet[4687]: Trace[2141674617]: [10.002634326s] [10.002634326s] END
Oct 28 00:01:08 debian10x64 kubelet[4687]: E1028 00:01:08.369992    4687 reflector.go:147] vendor/k8s.io/client-go/informers/factory.go:150: Failed to watch *v1.Service: failed to list
Oct 28 00:01:08 debian10x64 kubelet[4687]: W1028 00:01:08.969697    4687 reflector.go:535] vendor/k8s.io/client-go/informers/factory.go:150: failed to list *v1.Node: Get "https://192.16
Oct 28 00:01:08 debian10x64 kubelet[4687]: I1028 00:01:08.969941    4687 trace.go:236] Trace[1916504381]: "Reflector ListAndWatch" name:vendor/k8s.io/client-go/informers/factory.go:150
Oct 28 00:01:08 debian10x64 kubelet[4687]: Trace[1916504381]: ---"Objects listed" error:Get "https://192.168.92.129:6443/api/v1/nodes?fieldSelector=metadata.name%3Ddebian10x64&limit=500
Oct 28 00:01:08 debian10x64 kubelet[4687]: Trace[1916504381]: [10.002649898s] [10.002649898s] END
Oct 28 00:01:08 debian10x64 kubelet[4687]: E1028 00:01:08.970025    4687 reflector.go:147] vendor/k8s.io/client-go/informers/factory.go:150: Failed to watch *v1.Node: failed to list *v1
Oct 28 00:01:09 debian10x64 kubelet[4687]: I1028 00:01:09.504843    4687 kubelet_node_status.go:70] "Attempting to register node" node="debian10x64"
lines 1004-1053/1053 (END)

~~~~















root@debian10x64:/home/fernando# ufw
bash: ufw: command not found
root@debian10x64:/home/fernando# ss -nltp | grep 6443
LISTEN    5         1024                     *:6443                   *:*        users:(("kube-apiserver",pid=5549,fd=3))
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl get pods
The connection to the server 192.168.92.129:6443 was refused - did you specify the right host or port?
root@debian10x64:/home/fernando# echo $KUBECONFIG
/etc/kubernetes/admin.conf
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#

root@debian10x64:/home/fernando# ss -nltp | grep 6443
LISTEN    5         1024                     *:6443                   *:*        users:(("kube-apiserver",pid=5549,fd=3))
root@debian10x64:/home/fernando#








kubeadm init --apiserver-advertise-address=192.168.0.110 --pod-network-cidr=10.123.0.0/16

~~~~bash
root@debian10x64:/home/fernando# kubeadm init --apiserver-advertise-address=192.168.0.110 --pod-network-cidr=10.123.0.0/16
[init] Using Kubernetes version: v1.28.3
[preflight] Running pre-flight checks
        [WARNING SystemVerification]: missing optional cgroups: hugetlb
error execution phase preflight: [preflight] Some fatal errors occurred:
        [ERROR Port-10259]: Port 10259 is in use
        [ERROR Port-10257]: Port 10257 is in use
        [ERROR FileAvailable--etc-kubernetes-manifests-kube-apiserver.yaml]: /etc/kubernetes/manifests/kube-apiserver.yaml already exists
        [ERROR FileAvailable--etc-kubernetes-manifests-kube-controller-manager.yaml]: /etc/kubernetes/manifests/kube-controller-manager.yaml already exists
        [ERROR FileAvailable--etc-kubernetes-manifests-kube-scheduler.yaml]: /etc/kubernetes/manifests/kube-scheduler.yaml already exists
        [ERROR FileAvailable--etc-kubernetes-manifests-etcd.yaml]: /etc/kubernetes/manifests/etcd.yaml already exists
        [ERROR Port-10250]: Port 10250 is in use
        [ERROR DirAvailable--var-lib-etcd]: /var/lib/etcd is not empty
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`
To see the stack trace of this error execute with --v=5 or higher
root@debian10x64:/home/fernando#
~~~~




kubeadm init --apiserver-advertise-address=192.168.0.110 --pod-network-cidr=10.123.0.0/16




- crictl apresenta erro

~~~~bash
root@debian10x64:/home/fernando# crictl ps
WARN[0000] runtime connect using default endpoints: [unix:///var/run/dockershim.sock unix:///run/containerd/containerd.sock unix:///run/crio/crio.sock unix:///var/run/cri-dockerd.sock]. As the default settings are now deprecated, you should set the endpoint instead.
WARN[0000] image connect using default endpoints: [unix:///var/run/dockershim.sock unix:///run/containerd/containerd.sock unix:///run/crio/crio.sock unix:///var/run/cri-dockerd.sock]. As the default settings are now deprecated, you should set the endpoint instead.
E1028 00:07:08.414823    5887 remote_runtime.go:390] "ListContainers with filter from runtime service failed" err="rpc error: code = Unavailable desc = connection error: desc = \"transport: Error while dialing dial unix /var/run/dockershim.sock: connect: no such file or directory\"" filter="&ContainerFilter{Id:,State:&ContainerStateValue{State:CONTAINER_RUNNING,},PodSandboxId:,LabelSelector:map[string]string{},}"
FATA[0000] listing containers: rpc error: code = Unavailable desc = connection error: desc = "transport: Error while dialing dial unix /var/run/dockershim.sock: connect: no such file or directory"
root@debian10x64:/home/fernando#
~~~~



FATA[0000] listing containers: rpc error: code = Unavailable desc = connection error: desc = "transport: Error while dialing dial unix /var/run/dockershim.sock: connect: no such file or directory"




## TSHOOT
- Kube-apiserver ta escutando na porta 6443
- crictl apresenta erro






mv /etc/containerd/config.toml /root/config.toml.bak
systemctl restart containerd



~~~~bash

root@debian10x64:/home/fernando# mv /etc/containerd/config.toml /root/config.toml.bak
root@debian10x64:/home/fernando# systemctl restart containerd
root@debian10x64:/home/fernando# systemctl status containerd
● containerd.service - containerd container runtime
   Loaded: loaded (/lib/systemd/system/containerd.service; disabled; vendor preset: enabled)
   Active: active (running) since Sat 2023-10-28 14:25:49 -03; 4s ago
     Docs: https://containerd.io
  Process: 3550 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
 Main PID: 3551 (containerd)
    Tasks: 95
   Memory: 638.4M
   CGroup: /system.slice/containerd.service
           ├─1701 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id a1d96cfae1e9301806464c814fb55c0b590c05aaa252d7381aa8f2adf539a8c5 -address /run/containerd/containerd.sock
           ├─1702 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id 1fe7e388479c073517a5f0ddf424f86b1c6e503f99f5f6132327ba2312d5222a -address /run/containerd/containerd.sock
           ├─1703 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id 01607f0ea8b7cca3794ea4a89c08978e9f68d3c6c6940545d9d18b80616b7936 -address /run/containerd/containerd.sock
           ├─1704 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id b1bd26817ed7daa957797213687373fc2e5e36722d4c38b785ea5fda98e268c5 -address /run/containerd/containerd.sock
           └─3551 /usr/bin/containerd

Oct 28 14:25:49 debian10x64 containerd[3551]: time="2023-10-28T14:25:49.046652923-03:00" level=info msg="Start event monitor"
Oct 28 14:25:49 debian10x64 containerd[3551]: time="2023-10-28T14:25:49.046766576-03:00" level=info msg="Start snapshots syncer"
Oct 28 14:25:49 debian10x64 containerd[3551]: time="2023-10-28T14:25:49.046962799-03:00" level=info msg="Start cni network conf syncer for default"
Oct 28 14:25:49 debian10x64 containerd[3551]: time="2023-10-28T14:25:49.046987454-03:00" level=info msg="Start streaming server"
Oct 28 14:25:49 debian10x64 containerd[3551]: time="2023-10-28T14:25:49.047249388-03:00" level=info msg="containerd successfully booted in 0.145453s"
Oct 28 14:25:49 debian10x64 systemd[1]: Started containerd container runtime.
Oct 28 14:25:52 debian10x64 containerd[3551]: time="2023-10-28T14:25:52.286993387-03:00" level=info msg="CreateContainer within sandbox \"01607f0ea8b7cca3794ea4a89c08978e9f68d3c6c694054
Oct 28 14:25:52 debian10x64 containerd[3551]: time="2023-10-28T14:25:52.359957065-03:00" level=info msg="CreateContainer within sandbox \"01607f0ea8b7cca3794ea4a89c08978e9f68d3c6c694054
Oct 28 14:25:52 debian10x64 containerd[3551]: time="2023-10-28T14:25:52.361338507-03:00" level=info msg="StartContainer for \"e0a834df77676cb0958e8f971700d368f2a319f642f727386d548ec0203
Oct 28 14:25:52 debian10x64 containerd[3551]: time="2023-10-28T14:25:52.587277749-03:00" level=info msg="StartContainer for \"e0a834df77676cb0958e8f971700d368f2a319f642f727386d548ec0203
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# systemctl status containerd
● containerd.service - containerd container runtime
   Loaded: loaded (/lib/systemd/system/containerd.service; disabled; vendor preset: enabled)
   Active: active (running) since Sat 2023-10-28 14:25:49 -03; 7s ago
     Docs: https://containerd.io
  Process: 3550 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
 Main PID: 3551 (containerd)
    Tasks: 97
   Memory: 639.0M
   CGroup: /system.slice/containerd.service
           ├─1701 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id a1d96cfae1e9301806464c814fb55c0b590c05aaa252d7381aa8f2adf539a8c5 -address /run/containerd/containerd.sock
           ├─1702 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id 1fe7e388479c073517a5f0ddf424f86b1c6e503f99f5f6132327ba2312d5222a -address /run/containerd/containerd.sock
           ├─1703 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id 01607f0ea8b7cca3794ea4a89c08978e9f68d3c6c6940545d9d18b80616b7936 -address /run/containerd/containerd.sock
           ├─1704 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id b1bd26817ed7daa957797213687373fc2e5e36722d4c38b785ea5fda98e268c5 -address /run/containerd/containerd.sock
           └─3551 /usr/bin/containerd

Oct 28 14:25:49 debian10x64 containerd[3551]: time="2023-10-28T14:25:49.046652923-03:00" level=info msg="Start event monitor"
Oct 28 14:25:49 debian10x64 containerd[3551]: time="2023-10-28T14:25:49.046766576-03:00" level=info msg="Start snapshots syncer"
Oct 28 14:25:49 debian10x64 containerd[3551]: time="2023-10-28T14:25:49.046962799-03:00" level=info msg="Start cni network conf syncer for default"
Oct 28 14:25:49 debian10x64 containerd[3551]: time="2023-10-28T14:25:49.046987454-03:00" level=info msg="Start streaming server"
Oct 28 14:25:49 debian10x64 containerd[3551]: time="2023-10-28T14:25:49.047249388-03:00" level=info msg="containerd successfully booted in 0.145453s"
Oct 28 14:25:49 debian10x64 systemd[1]: Started containerd container runtime.
Oct 28 14:25:52 debian10x64 containerd[3551]: time="2023-10-28T14:25:52.286993387-03:00" level=info msg="CreateContainer within sandbox \"01607f0ea8b7cca3794ea4a89c08978e9f68d3c6c694054
Oct 28 14:25:52 debian10x64 containerd[3551]: time="2023-10-28T14:25:52.359957065-03:00" level=info msg="CreateContainer within sandbox \"01607f0ea8b7cca3794ea4a89c08978e9f68d3c6c694054
Oct 28 14:25:52 debian10x64 containerd[3551]: time="2023-10-28T14:25:52.361338507-03:00" level=info msg="StartContainer for \"e0a834df77676cb0958e8f971700d368f2a319f642f727386d548ec0203
Oct 28 14:25:52 debian10x64 containerd[3551]: time="2023-10-28T14:25:52.587277749-03:00" level=info msg="StartContainer for \"e0a834df77676cb0958e8f971700d368f2a319f642f727386d548ec0203
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
~~~~










jcometti commented May 5, 2023

I resolved my issue with the commands below:
Configure containerd

mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = true/SystemdCgroup = false/g' /etc/containerd/config.toml


Restart containerd

systemctl restart containerd




- Segue com erro


root@debian10x64:/home/fernando# systemctl restart containerd
root@debian10x64:/home/fernando# systemctl status containerd
● containerd.service - containerd container runtime
   Loaded: loaded (/lib/systemd/system/containerd.service; disabled; vendor preset: enabled)
   Active: active (running) since Sat 2023-10-28 14:30:56 -03; 5s ago
     Docs: https://containerd.io
  Process: 4383 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
 Main PID: 4384 (containerd)
    Tasks: 99
   Memory: 638.9M
   CGroup: /system.slice/containerd.service
           ├─1701 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id a1d96cfae1e9301806464c814fb55c0b590c05aaa252d7381aa8f2adf539a8c5 -address /run/containerd/containerd.sock
           ├─1702 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id 1fe7e388479c073517a5f0ddf424f86b1c6e503f99f5f6132327ba2312d5222a -address /run/containerd/containerd.sock
           ├─1703 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id 01607f0ea8b7cca3794ea4a89c08978e9f68d3c6c6940545d9d18b80616b7936 -address /run/containerd/containerd.sock
           ├─1704 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id b1bd26817ed7daa957797213687373fc2e5e36722d4c38b785ea5fda98e268c5 -address /run/containerd/containerd.sock
           └─4384 /usr/bin/containerd

Oct 28 14:30:56 debian10x64 containerd[4384]: time="2023-10-28T14:30:56.752106135-03:00" level=info msg="Start subscribing containerd event"
Oct 28 14:30:56 debian10x64 containerd[4384]: time="2023-10-28T14:30:56.752218569-03:00" level=info msg="Start recovering state"
Oct 28 14:30:56 debian10x64 containerd[4384]: time="2023-10-28T14:30:56.755740224-03:00" level=info msg=serving... address=/run/containerd/containerd.sock.ttrpc
Oct 28 14:30:56 debian10x64 containerd[4384]: time="2023-10-28T14:30:56.755959269-03:00" level=info msg=serving... address=/run/containerd/containerd.sock
Oct 28 14:30:56 debian10x64 containerd[4384]: time="2023-10-28T14:30:56.861841310-03:00" level=info msg="Start event monitor"
Oct 28 14:30:56 debian10x64 containerd[4384]: time="2023-10-28T14:30:56.861949463-03:00" level=info msg="Start snapshots syncer"
Oct 28 14:30:56 debian10x64 containerd[4384]: time="2023-10-28T14:30:56.861975235-03:00" level=info msg="Start cni network conf syncer for default"
Oct 28 14:30:56 debian10x64 containerd[4384]: time="2023-10-28T14:30:56.861985687-03:00" level=info msg="Start streaming server"
Oct 28 14:30:56 debian10x64 containerd[4384]: time="2023-10-28T14:30:56.862139286-03:00" level=info msg="containerd successfully booted in 0.165190s"
Oct 28 14:30:56 debian10x64 systemd[1]: Started containerd container runtime.
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# crictl ps
WARN[0000] runtime connect using default endpoints: [unix:///var/run/dockershim.sock unix:///run/containerd/containerd.sock unix:///run/crio/crio.sock unix:///var/run/cri-dockerd.sock]. As the default settings are now deprecated, you should set the endpoint instead.
WARN[0000] image connect using default endpoints: [unix:///var/run/dockershim.sock unix:///run/containerd/containerd.sock unix:///run/crio/crio.sock unix:///var/run/cri-dockerd.sock]. As the default settings are now deprecated, you should set the endpoint instead.
E1028 14:31:06.865981    4414 remote_runtime.go:390] "ListContainers with filter from runtime service failed" err="rpc error: code = Unavailable desc = connection error: desc = \"transport: Error while dialing dial unix /var/run/dockershim.sock: connect: no such file or directory\"" filter="&ContainerFilter{Id:,State:&ContainerStateValue{State:CONTAINER_RUNNING,},PodSandboxId:,LabelSelector:map[string]string{},}"
FATA[0000] listing containers: rpc error: code = Unavailable desc = connection error: desc = "transport: Error while dialing dial unix /var/run/dockershim.sock: connect: no such file or directory"
root@debian10x64:/home/fernando#







- Reinstalado

- Segue com erro

~~~~bash

root@debian10x64:/home/fernando# containerd --version
containerd containerd.io 1.6.24 61f9fd88f79f081d64d6fa3bb1a0dc71ec870523
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# crictl ps
WARN[0000] runtime connect using default endpoints: [unix:///var/run/dockershim.sock unix:///run/containerd/containerd.sock unix:///run/crio/crio.sock unix:///var/run/cri-dockerd.sock]. As the default settings are now deprecated, you should set the endpoint instead.
WARN[0000] image connect using default endpoints: [unix:///var/run/dockershim.sock unix:///run/containerd/containerd.sock unix:///run/crio/crio.sock unix:///var/run/cri-dockerd.sock]. As the default settings are now deprecated, you should set the endpoint instead.
E1028 14:50:35.923914   36862 remote_runtime.go:390] "ListContainers with filter from runtime service failed" err="rpc error: code = Unavailable desc = connection error: desc = \"transport: Error while dialing dial unix /var/run/dockershim.sock: connect: no such file or directory\"" filter="&ContainerFilter{Id:,State:&ContainerStateValue{State:CONTAINER_RUNNING,},PodSandboxId:,LabelSelector:map[string]string{},}"
FATA[0000] listing containers: rpc error: code = Unavailable desc = connection error: desc = "transport: Error while dialing dial unix /var/run/dockershim.sock: connect: no such file or directory"
root@debian10x64:/home/fernando# date
Sat 28 Oct 2023 02:50:41 PM -03
root@debian10x64:/home/fernando#
