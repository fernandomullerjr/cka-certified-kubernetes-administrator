



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

https://kubernetes.io/docs/concepts/security/service-accounts/
<https://kubernetes.io/docs/concepts/security/service-accounts/>

https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
<https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/>

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



fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ crictl logs
WARN[0000] runtime connect using default endpoints: [unix:///var/run/dockershim.sock unix:///run/containerd/containerd.sock unix:///run/crio/crio.sock unix:///var/run/cri-dockerd.sock]. As the default settings are now deprecated, you should set the endpoint instead.
FATA[0000] ID cannot be empty
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$
~~~~







/etc/docker/daemon.json


cat /etc/docker/daemon.json



root@debian10x64:/home/fernando# cat /etc/docker/daemon.json
{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}
root@debian10x64:/home/fernando#








sudo cat /etc/containerd/config.toml



reinstalei o docker, mas não é criado o /var/run/dockershim.sock
ChatGPT

Se o arquivo /var/run/dockershim.sock não está sendo criado após reinstalar o Docker, pode haver um problema com a instalação ou com a configuração do Docker. Aqui estão algumas etapas adicionais que você pode tentar para resolver o problema:

    Verifique o Status do Docker:
    Primeiro, verifique se o Docker está em execução usando o comando:

    bash

sudo systemctl status docker

Certifique-se de que o Docker está ativo (running) e sem erros. Se estiver inativo, você pode tentar iniciar o Docker novamente com:

bash

sudo systemctl start docker

Verifique Configurações do Docker:
Certifique-se de que não há problemas nas configurações do Docker. Verifique os arquivos de configuração do Docker para garantir que não haja configurações inválidas ou ausentes.

Reconfigure o Docker:
Às vezes, reconfigurar o Docker pode ajudar a resolver problemas de configuração. Use o seguinte comando para reconfigurar o Docker:

bash

sudo dpkg-reconfigure docker-ce

Este comando permitirá que você reconfigure as opções do Docker. Siga as instruções na tela para ajustar as configurações conforme necessário.

Verifique o Docker Socket:
O arquivo de soquete /var/run/dockershim.sock é essencial para a comunicação entre o Docker e outros componentes, como o Containerd. Certifique-se de que o Docker está configurado corretamente para criar esse soquete. Verifique o arquivo de configuração do Docker, geralmente localizado em /etc/docker/daemon.json, e confirme se a configuração socket está correta.

Exemplo de configuração do Docker no daemon.json:

json

    {
      "socket": "/var/run/docker.sock"
    }

    Se essa configuração estiver ausente ou incorreta, ajuste-a de acordo.

    Reinstale o Containerd (opcional):
    Se o problema persistir após tentar as etapas acima, considere reinstalar o Containerd. Remova o Containerd usando sudo apt remove containerd.io e, em seguida, reinstale-o usando sudo apt install containerd.io. Em seguida, reinicie tanto o Docker quanto o Containerd.

    Verifique Logs do Docker:
    Verifique os logs do Docker para obter informações detalhadas sobre qualquer erro ou problema que esteja ocorrendo. Os logs do Docker geralmente estão localizados em /var/log/docker.log ou podem ser visualizados usando o comando journalctl.

Se após seguir estas etapas o problema persistir, pode ser útil verificar fóruns de suporte específicos do Docker ou do seu sistema operacional para soluções mais específicas. Em alguns casos, problemas como esse podem ser específicos da versão do Docker ou do sistema operacional, e outros usuários podem ter encontrado e resolvido problemas semelhantes.
User
como ajustar o containerd, para utilizar o "/var/run/docker.sock" ao invés do "/var/run/dockershim.sock"?
ChatGPT

Para configurar o Containerd para utilizar o arquivo de soquete /var/run/docker.sock em vez de /var/run/dockershim.sock, você precisará modificar o arquivo de configuração do Containerd.

    Localize o arquivo de configuração do Containerd:
    O arquivo de configuração do Containerd geralmente está localizado em /etc/containerd/config.toml. Você pode usar um editor de texto como o nano ou o vim para editar o arquivo:

    bash

sudo nano /etc/containerd/config.toml

Se o arquivo não existir, você pode criar um novo.

Atualize o arquivo de configuração:
Adicione ou atualize a seção plugins."io.containerd.grpc.v1.cri".containerd no arquivo de configuração para especificar o caminho do arquivo de soquete do Docker. O arquivo de configuração do Containerd deve se parecer com algo assim:

toml

[plugins."io.containerd.grpc.v1.cri".containerd]
  [plugins."io.containerd.grpc.v1.cri".containerd.default_runtime]
    runtime_type = "io.containerd.runtime.v1.linux"
    runtime_engine = "/usr/bin/runc"
    runtime_root = ""
    privileged_without_host_devices = false
    runtime_args = []
    runtime_env = []
  [plugins."io.containerd.grpc.v1.cri".containerd.untrusted_workload_runtime]
    runtime_type = "io.containerd.runtime.v1.linux"
    runtime_engine = ""
    runtime_root = ""
    privileged_without_host_devices = false
    runtime_args = []
    runtime_env = []
  [plugins."io.containerd.grpc.v1.cri".containerd.config]
    sandbox_image = "k8s.gcr.io/pause:3.1"
    stop_timeout = "0s"
    systemd_cgroup = false
    enable_selinux = false
    enable_apparmor = false
  [plugins."io.containerd.grpc.v1.cri".containerd.default_runtime.runtime_options]
    runtime = "runc"
    runtime_root = ""
    privileged_without_host_devices = false
    selinux_label = ""

No exemplo acima, runtime_engine é o caminho para o executável de execução (geralmente runc) e runtime_root é o diretório do sistema de arquivos da execução.

Reinicie o Containerd:
Após editar o arquivo de configuração, salve as alterações e saia do editor de texto. Em seguida, reinicie o serviço do Containerd para aplicar as configurações:

bash

    sudo systemctl restart containerd

Após essas etapas, o Containerd deverá estar configurado para utilizar o arquivo de soquete /var/run/docker.sock. Certifique-se de que o Docker também esteja em execução e utilizando o mesmo arquivo de soquete para evitar conflitos.

Lembre-se de que é importante ter cuidado ao editar arquivos de configuração do sistema. Faça backup dos arquivos antes de fazer alterações significativas para evitar problemas no sistema.















## CILIUM E TSHOOT




https://docs.cilium.io/en/stable/installation/k8s-install-kubeadm/
<https://docs.cilium.io/en/stable/installation/k8s-install-kubeadm/>



helm install cilium cilium/cilium --namespace kube-system



root@debian10x64:/home/fernando# helm install cilium cilium/cilium --namespace kube-system
NAME: cilium
LAST DEPLOYED: Sat Oct 28 15:27:37 2023
NAMESPACE: kube-system
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
You have successfully installed Cilium with Hubble.

Your release version is 1.14.1.

For any further help, visit https://docs.cilium.io/en/v1.14/gettinghelp
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#








root@debian10x64:/home/fernando# helm ls -A
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
cilium  kube-system     1               2023-10-28 15:27:37.254219442 -0300 -03 deployed        cilium-1.14.1   1.14.1
root@debian10x64:/home/fernando#






- Pods do cilium e do coredns em pending:

root@debian10x64:/home/fernando# kubectl get pods -A
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE
kube-system   cilium-operator-788c4f69bc-g7mw4      1/1     Running   0          74s
kube-system   cilium-operator-788c4f69bc-nktj2      0/1     Pending   0          74s
kube-system   cilium-q8xc5                          0/1     Running   0          74s
kube-system   coredns-5dd5756b68-btrs6              0/1     Pending   0          5m7s
kube-system   coredns-5dd5756b68-gpwnt              0/1     Pending   0          5m7s
kube-system   etcd-debian10x64                      1/1     Running   60         5m12s
kube-system   kube-apiserver-debian10x64            1/1     Running   0          5m9s
kube-system   kube-controller-manager-debian10x64   1/1     Running   0          5m9s
kube-system   kube-proxy-272d4                      1/1     Running   0          5m7s
kube-system   kube-scheduler-debian10x64            1/1     Running   0          5m9s
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Sat 28 Oct 2023 03:28:59 PM -03
root@debian10x64:/home/fernando#













helm upgrade --install cilium cilium/cilium -n kube-system -f /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/148-x-cilium-values.yaml


root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# helm upgrade --install cilium cilium/cilium -n kube-system -f /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/148-x-cilium-values.yaml
Release "cilium" has been upgraded. Happy Helming!
NAME: cilium
LAST DEPLOYED: Sat Oct 28 15:30:02 2023
NAMESPACE: kube-system
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
You have successfully installed Cilium with Hubble.

Your release version is 1.14.1.

For any further help, visit https://docs.cilium.io/en/v1.14/gettinghelp
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Sat 28 Oct 2023 03:30:07 PM -03
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#








- Pods do coredns em pending ainda


root@debian10x64:/home/fernando# kubectl get pods -A
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE
kube-system   cilium-operator-788c4f69bc-g7mw4      1/1     Running   0          2m39s
kube-system   cilium-q8xc5                          1/1     Running   0          2m39s
kube-system   coredns-5dd5756b68-btrs6              0/1     Pending   0          6m32s
kube-system   coredns-5dd5756b68-gpwnt              0/1     Pending   0          6m32s
kube-system   etcd-debian10x64                      1/1     Running   60         6m37s
kube-system   kube-apiserver-debian10x64            1/1     Running   0          6m34s
kube-system   kube-controller-manager-debian10x64   1/1     Running   0          6m34s
kube-system   kube-proxy-272d4                      1/1     Running   0          6m32s
kube-system   kube-scheduler-debian10x64            1/1     Running   0          6m34s
root@debian10x64:/home/fernando#










root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl describe pod coredns-5dd5756b68-btrs6 -n kube-system
Name:                 coredns-5dd5756b68-btrs6
Namespace:            kube-system

Events:
  Type     Reason            Age    From               Message
  ----     ------            ----   ----               -------
  Warning  FailedScheduling  7m17s  default-scheduler  0/1 nodes are available: 1 node(s) had untolerated taint {node.kubernetes.io/not-ready: }. preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling..
  Warning  FailedScheduling  111s   default-scheduler  0/1 nodes are available: 1 node(s) had untolerated taint {node.kubernetes.io/disk-pressure: }. preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling..
root@debian10x64:/home/fernando#



root@debian10x64:/home/fernando# kubectl get nodes
NAME          STATUS   ROLES           AGE     VERSION
debian10x64   Ready    control-plane   7m58s   v1.28.1
root@debian10x64:/home/fernando#








root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl describe node debian10x64
Name:               debian10x64
Roles:              control-plane
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=debian10x64
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/control-plane=
                    node.kubernetes.io/exclude-from-external-load-balancers=
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Sat, 28 Oct 2023 15:23:37 -0300
Taints:             node-role.kubernetes.io/control-plane:NoSchedule
                    node.kubernetes.io/disk-pressure:NoSchedule
Unschedulable:      false














- Efetuado resize do disco da VM de 60gb para 75gb
- Efetuado resize da sda3 de 20gb para 35gb
- Reboot da VM


root@debian10x64:/home/fernando# lsblk
NAME                       MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
fd0                          2:0    1     4K  0 disk
loop0                        7:0    0 272.7M  1 loop /snap/kontena-lens/249
loop1                        7:1    0 105.8M  1 loop /snap/core/16091
loop2                        7:2    0  55.7M  1 loop /snap/core18/2790
loop3                        7:3    0  55.7M  1 loop /snap/core18/2785
loop4                        7:4    0 272.7M  1 loop /snap/kontena-lens/248
loop5                        7:5    0 116.7M  1 loop /snap/robo3t-snap/9
loop6                        7:6    0 105.8M  1 loop /snap/core/16202
sda                          8:0    0    75G  0 disk
├─sda1                       8:1    0   487M  0 part /boot
├─sda2                       8:2    0     1K  0 part
├─sda3                       8:3    0    35G  0 part
│ └─debian10x64--vg-root   254:0    0  73.6G  0 lvm  /
└─sda5                       8:5    0  39.5G  0 part
  ├─debian10x64--vg-root   254:0    0  73.6G  0 lvm  /
  └─debian10x64--vg-swap_1 254:1    0   976M  0 lvm
sr0                         11:0    1   336M  0 rom
root@debian10x64:/home/fernando#


root@debian10x64:/home/fernando# df -h
Filesystem                        Size  Used Avail Use% Mounted on
udev                              4.8G     0  4.8G   0% /dev
tmpfs                             982M   15M  968M   2% /run
/dev/mapper/debian10x64--vg-root   73G   54G   16G  78% /






- Todos os pods em "running" agora:


root@debian10x64:/home/fernando# kubectl get pods -A
NAMESPACE     NAME                                  READY   STATUS    RESTARTS        AGE
kube-system   cilium-operator-788c4f69bc-g7mw4      1/1     Running   2 (108s ago)    140m
kube-system   cilium-q8xc5                          1/1     Running   2 (108s ago)    140m
kube-system   coredns-5dd5756b68-btrs6              1/1     Running   3 (108s ago)    144m
kube-system   coredns-5dd5756b68-gpwnt              1/1     Running   3 (67s ago)     144m
kube-system   etcd-debian10x64                      1/1     Running   62 (108s ago)   144m
kube-system   kube-apiserver-debian10x64            1/1     Running   2 (108s ago)    144m
kube-system   kube-controller-manager-debian10x64   1/1     Running   2 (108s ago)    144m
kube-system   kube-proxy-272d4                      1/1     Running   2 (108s ago)    144m
kube-system   kube-scheduler-debian10x64            1/1     Running   2 (108s ago)    144m
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Sat 28 Oct 2023 05:48:02 PM -03
root@debian10x64:/home/fernando#














## Dia 31/10/2023

Um Service Account no Kubernetes é uma entidade que representa a identidade de um conjunto de processos em execução em um cluster que desejam interagir com o API server Kubernetes. A seguir, você encontrará um exemplo de manifesto YAML para criar um Service Account no Kubernetes:

~~~~yaml

apiVersion: v1
kind: ServiceAccount
metadata:
  name: nome-do-service-account
  namespace: namespace-desejado
~~~~

Neste exemplo:

    apiVersion: Especifica a versão da API do Kubernetes que estamos usando.
    kind: Define o tipo do objeto, que neste caso é ServiceAccount.
    metadata: Contém informações sobre o objeto, como o nome e o namespace do Service Account.
        name: Especifica o nome do Service Account.
        namespace: Especifica o namespace onde o Service Account será criado. Se você não especificar um namespace, ele será criado no namespace padrão.

Você pode salvar este manifesto em um arquivo YAML (por exemplo, serviceaccount.yaml) e, em seguida, aplicá-lo ao seu cluster Kubernetes usando o comando kubectl apply:

bash

kubectl apply -f serviceaccount.yaml

Isso criará o Service Account no namespace especificado. Lembre-se de substituir nome-do-service-account pelo nome desejado para o Service Account e namespace-desejado pelo namespace onde você deseja criar o Service Account.









https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/

## Use the default service account to access the API server

When Pods contact the API server, Pods authenticate as a particular ServiceAccount (for example, default). There is always at least one ServiceAccount in each namespace.

Every Kubernetes namespace contains at least one ServiceAccount: the default ServiceAccount for that namespace, named default. If you do not specify a ServiceAccount when you create a Pod, Kubernetes automatically assigns the ServiceAccount named default in that namespace.

You can fetch the details for a Pod you have created. For example:

kubectl get pods/<podname> -o yaml

In the output, you see a field spec.serviceAccountName. Kubernetes automatically sets that value if you don't specify it when you create a Pod.

An application running inside a Pod can access the Kubernetes API using automatically mounted service account credentials. See accessing the Cluster to learn more.

When a Pod authenticates as a ServiceAccount, its level of access depends on the authorization plugin and policy in use.


## Opt out of API credential automounting

If you don't want the kubelet to automatically mount a ServiceAccount's API credentials, you can opt out of the default behavior. You can opt out of automounting API credentials on /var/run/secrets/kubernetes.io/serviceaccount/token for a service account by setting automountServiceAccountToken: false on the ServiceAccount:

For example:

~~~~YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  name: build-robot
automountServiceAccountToken: false
...
~~~~

You can also opt out of automounting API credentials for a particular Pod:

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  serviceAccountName: build-robot
  automountServiceAccountToken: false
  ...
~~~~

If both the ServiceAccount and the Pod's .spec specify a value for automountServiceAccountToken, the Pod spec takes precedence.
Use more than one








- Verificando existencia da "  serviceAccountName: default" no Pod:

kubectl get pods/backstage-7b5dc95679-c7mzs -n backstage -o yaml

~~~~YAML

root@debian10x64:/home/fernando# kubectl get pods/backstage-7b5dc95679-c7mzs -n backstage -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-10-29T17:59:53Z"
  generateName: backstage-7b5dc95679-
  labels:
    app: backstage
    pod-template-hash: 7b5dc95679
  name: backstage-7b5dc95679-c7mzs
  namespace: backstage
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: backstage-7b5dc95679
    uid: 4c7d4012-5f3c-4050-85f4-12715163313a
  resourceVersion: "33157"
  uid: cc243080-b1fa-4a5c-bd3b-8c0876b58db4
spec:
  containers:
  - envFrom:
    - secretRef:
        name: postgres-secrets
    - secretRef:
        name: backstage-secrets
    image: fernandomj90/backstage-local:v3
    imagePullPolicy: IfNotPresent
    name: backstage
    ports:
    - containerPort: 7007
      name: http
      protocol: TCP
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-rcsbp
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: debian10x64
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: kube-api-access-rcsbp
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2023-10-29T17:59:53Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-10-29T17:59:55Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-10-29T17:59:55Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-10-29T17:59:53Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://551c86dc967b75aa7dd865854b84f6a61ef598b5d61e561f0747404b5c983e98
    image: docker.io/fernandomj90/backstage-local:v3
    imageID: docker.io/fernandomj90/backstage-local@sha256:42cbe9f633d998b8ec6ee0bf0e909dd6f2c1b00db53c9e5be29b08488ecf71c1
    lastState: {}
    name: backstage
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-10-29T17:59:55Z"
  hostIP: 192.168.92.129
  phase: Running
  podIP: 10.0.0.205
  podIPs:
  - ip: 10.0.0.205
  qosClass: BestEffort
  startTime: "2023-10-29T17:59:53Z"
root@debian10x64:/home/fernando#

~~~~







- Consta:

  serviceAccountName: default




- Verificando a listagem de SA(ServiceAccounts):

~~~~bash

root@debian10x64:/home/fernando# kubectl get sa
NAME      SECRETS   AGE
default   0         24h
root@debian10x64:/home/fernando# kubectl get sa -A
NAMESPACE         NAME                                 SECRETS   AGE
backstage         default                              0         21h
default           default                              0         24h
kube-node-lease   default                              0         24h
kube-public       default                              0         24h
kube-system       attachdetach-controller              0         24h
kube-system       bootstrap-signer                     0         24h
kube-system       certificate-controller               0         24h
kube-system       cilium                               0         23h
kube-system       cilium-operator                      0         23h
kube-system       clusterrole-aggregation-controller   0         24h
kube-system       coredns                              0         24h
kube-system       cronjob-controller                   0         24h
kube-system       daemon-set-controller                0         24h
kube-system       default                              0         24h
kube-system       deployment-controller                0         24h
kube-system       disruption-controller                0         24h
kube-system       endpoint-controller                  0         24h
kube-system       endpointslice-controller             0         24h
kube-system       endpointslicemirroring-controller    0         24h
kube-system       ephemeral-volume-controller          0         24h
kube-system       expand-controller                    0         24h
kube-system       generic-garbage-collector            0         24h
kube-system       horizontal-pod-autoscaler            0         24h
kube-system       job-controller                       0         24h
kube-system       kube-proxy                           0         24h
kube-system       namespace-controller                 0         24h
kube-system       node-controller                      0         24h
kube-system       persistent-volume-binder             0         24h
kube-system       pod-garbage-collector                0         24h
kube-system       pv-protection-controller             0         24h
kube-system       pvc-protection-controller            0         24h
kube-system       replicaset-controller                0         24h
kube-system       replication-controller               0         24h
kube-system       resourcequota-controller             0         24h
kube-system       root-ca-cert-publisher               0         24h
kube-system       service-account-controller           0         24h
kube-system       service-controller                   0         24h
kube-system       statefulset-controller               0         24h
kube-system       token-cleaner                        0         24h
kube-system       ttl-after-finished-controller        0         24h
kube-system       ttl-controller                       0         24h
root@debian10x64:/home/fernando#

~~~~










## PENDENTE
- Resumir,
- Pods, caminho montado, diferen~ças entre 1.22 e 1.24.



## RESUMO

- Every Kubernetes namespace contains at least one ServiceAccount: the default ServiceAccount for that namespace, named default. If you do not specify a ServiceAccount when you create a Pod, Kubernetes automatically assigns the ServiceAccount named default in that namespace.

- If both the ServiceAccount and the Pod's .spec specify a value for automountServiceAccountToken, the Pod spec takes precedence.




- Verificando ponto de montagem da SA no Pod:

~~~~yaml
root@debian10x64:/home/fernando# kubectl describe pod cilium-operator-788c4f69bc-g7mw4 -n kube-system
Name:                 cilium-operator-788c4f69bc-g7mw4
Namespace:  
    Mounts:
      /tmp/cilium/config-map from cilium-config-path (ro)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-fl5mc (ro)
Conditions:
  Type              Status
  Initialized       True
~~~~





kubectl exec -it cilium-operator-788c4f69bc-g7mw4 -n kube-system -- ls /var/run/secrets/kubernetes.io/serviceaccount







kubectl exec -it cilium-operator-788c4f69bc-g7mw4 -n kube-system -- ls /var/run/secrets/kubernetes.io/serviceaccount
