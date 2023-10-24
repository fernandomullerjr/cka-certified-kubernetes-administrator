



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







# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# RESUMO

Na versão K8s anterior à 1.24, sempre que criávamos uma conta de serviço, um token secreto que não expirava (segredos e tokens montáveis) era criado por padrão. 
Porém, a partir da versão 1.24, ele foi desfeito e nenhum token secreto é criado por padrão quando criamos uma conta de serviço. No entanto, podemos criá-lo quando necessário.
