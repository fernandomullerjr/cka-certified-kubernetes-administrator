



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