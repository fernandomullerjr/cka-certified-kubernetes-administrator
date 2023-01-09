
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
Quando o owner é do kind "Node", podemos confirmar que é um Static Pod.

Por exemplo, usando este comando:
    kubectl get pod kube-apiserver-minikube -n kube-system -o yaml | head

É possível verificar na parte que fala sobre "ownerReferences":

~~~~yaml
apiVersion: v1
kind: Pod
#omitido o restante
#omitido o restante
  ownerReferences:
  - apiVersion: v1
    controller: true
    kind: Node
    name: minikube
    uid: a6c2733b-8e14-49c0-bcb6-9134f3fd8455
~~~~

- Exemplo de caso onde não é um Static Pod, temos um kind ReplicaSet como owner:
comando:
    kubectl get pod coredns-78fcd69978-zbfqb -n kube-system -o yaml

É possível verificar na parte que fala sobre "ownerReferences":

~~~~yaml
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: coredns-78fcd69978
    uid: a672af72-fd9a-4f45-9ccc-ab59767785aa
~~~~






# Which of the below components is NOT deployed as a static pod?

- RESPOSTA:
coredns

- Detalhando
neste caso a opção escolhida foi baseada no nome do Pod, pois não tinha o nome do node ao final do nome do Pod.








# Which of the below components is NOT deployed as a static POD?

- RESPOSTA:
kube-proxy

- Detalhando
neste caso a opção escolhida foi baseada no nome do Pod, pois não tinha o nome do node ao final do nome do Pod.






# On which nodes are the static pods created currently?

-RESPOSTA:
controlplane
observação:
é controlplane, porque no nome dos Pods tem "-controlplane" ao final do nome do Pod.






# What is the path of the directory holding the static pod definition files?

"/etc/kubernetes/manifests"


- Detalhando

É possível verificar o caminho onde são guardados os manifestos dos Static Pods no Kubelet, através de arquivo config.yaml na pasta "/var/lib/kubelet/".

- Verificando no Minikube:

~~~~bash

fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get nodes -A
NAME       STATUS   ROLES                  AGE    VERSION
minikube   Ready    control-plane,master   7d7h   v1.22.2
fernando@debian10x64:~$ docker ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED        STATUS         PORTS                                                                                                                                  NAMES
68ac6cef7ccb   gcr.io/k8s-minikube/kicbase:v0.0.27   "/usr/local/bin/entr…"   2 months ago   Up 3 minutes   127.0.0.1:49157->22/tcp, 127.0.0.1:49156->2376/tcp, 127.0.0.1:49155->5000/tcp, 127.0.0.1:49154->8443/tcp, 127.0.0.1:49153->32443/tcp   minikube
fernando@debian10x64:~$ docker container exec -ti minikube sh

docker@minikube:~$ sudo ls /var/lib/kubelet/
config.yaml  cpu_manager_state  device-plugins  kubeadm-flags.env  memory_manager_state  pki  plugins  plugins_registry  pod-resources  pods
docker@minikube:~$
~~~~

- Verificando o campo "staticPodPath":

docker@minikube:~$ sudo cat /var/lib/kubelet/config.yaml
~~~~yaml
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    cacheTTL: 0s
    enabled: true
  x509:
    clientCAFile: /var/lib/minikube/certs/ca.crt
authorization:
  mode: Webhook
  webhook:
    cacheAuthorizedTTL: 0s
    cacheUnauthorizedTTL: 0s
cgroupDriver: cgroupfs
clusterDNS:
- 10.96.0.10
clusterDomain: cluster.local
cpuManagerReconcilePeriod: 0s
evictionHard:
  imagefs.available: 0%
  nodefs.available: 0%
  nodefs.inodesFree: 0%
evictionPressureTransitionPeriod: 0s
failSwapOn: false
fileCheckFrequency: 0s
healthzBindAddress: 127.0.0.1
healthzPort: 10248
httpCheckFrequency: 0s
imageGCHighThresholdPercent: 100
imageMinimumGCAge: 0s
kind: KubeletConfiguration
logging: {}
memorySwap: {}
nodeStatusReportFrequency: 0s
nodeStatusUpdateFrequency: 0s
rotateCertificates: true
runtimeRequestTimeout: 0s
shutdownGracePeriod: 0s
shutdownGracePeriodCriticalPods: 0s
staticPodPath: /etc/kubernetes/manifests
streamingConnectionIdleTimeout: 0s
syncFrequency: 0s
volumeStatsAggPeriod: 0s
~~~~










# How many pod definition files are present in the manifests folder?


- RESPOSTA:
4

- Detalhando:
Tem 4 Pods do tipo "Static Pod" no controlplane

devido o nome "-controlplane" ao final dos 4 Pods:

~~~~bash
controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
kube-system   coredns-6d4b75cb6d-qsdgx               1/1     Running   0          16m
kube-system   coredns-6d4b75cb6d-wtdgg               1/1     Running   0          16m
kube-system   etcd-controlplane                      1/1     Running   0          17m
kube-system   kube-apiserver-controlplane            1/1     Running   0          17m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          17m
kube-system   kube-flannel-ds-5l8qh                  1/1     Running   0          16m
kube-system   kube-flannel-ds-jdwzc                  1/1     Running   0          16m
kube-system   kube-proxy-dgcmf                       1/1     Running   0          16m
kube-system   kube-proxy-wsfmh                       1/1     Running   0          16m
kube-system   kube-scheduler-controlplane            1/1     Running   0          17m
~~~~










# What is the docker image used to deploy the kube-api server as a static pod?



controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-apiserver.yaml 
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 10.1.125.3:6443
  creationTimestamp: null
  labels:
    component: kube-apiserver
    tier: control-plane
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
    - --advertise-address=10.1.125.3
    - --allow-privileged=true
    - --authorization-mode=Node,RBAC
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --enable-admission-plugins=NodeRestriction
    - --enable-bootstrap-token-auth=true
    - --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
    - --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
    - --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key
    - --etcd-servers=https://127.0.0.1:2379
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
    - --secure-port=6443
    - --service-account-issuer=https://kubernetes.default.svc.cluster.local
    - --service-account-key-file=/etc/kubernetes/pki/sa.pub
    - --service-account-signing-key-file=/etc/kubernetes/pki/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --tls-cert-file=/etc/kubernetes/pki/apiserver.crt
    - --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
    image: k8s.gcr.io/kube-apiserver:v1.24.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 10.1.125.3
        path: /livez
        port: 6443
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-apiserver
    readinessProbe:
      failureThreshold: 3
      httpGet:
        host: 10.1.125.3
        path: /readyz
        port: 6443
        scheme: HTTPS
      periodSeconds: 1
      timeoutSeconds: 15
    resources:
      requests:
        cpu: 250m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 10.1.125.3
        path: /livez
        port: 6443
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /etc/ssl/certs
      name: ca-certs
      readOnly: true
    - mountPath: /etc/ca-certificates
      name: etc-ca-certificates
      readOnly: true
    - mountPath: /etc/kubernetes/pki
      name: k8s-certs
      readOnly: true
    - mountPath: /usr/local/share/ca-certificates
      name: usr-local-share-ca-certificates
      readOnly: true
    - mountPath: /usr/share/ca-certificates
      name: usr-share-ca-certificates
      readOnly: true
  hostNetwork: true
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/ssl/certs
      type: DirectoryOrCreate
    name: ca-certs
  - hostPath:
      path: /etc/ca-certificates
      type: DirectoryOrCreate
    name: etc-ca-certificates
  - hostPath:
      path: /etc/kubernetes/pki
      type: DirectoryOrCreate
    name: k8s-certs
  - hostPath:
      path: /usr/local/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-local-share-ca-certificates
  - hostPath:
      path: /usr/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-share-ca-certificates
status: {}

controlplane ~ ➜  


- RESPOSTA:
image: k8s.gcr.io/kube-apiserver:v1.24.0





















# Create a static pod named static-busybox that uses the busybox image and the command sleep 1000

    Name: static-busybox

    Image: busybox


- Script que faz a criação:
partindo do pressuposto que você esteja conectado ao node desejado
~~~~bash
cat <<EOF >/etc/kubernetes/manifests/static-busybox.yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-busybox
spec:
  containers:
    - name: busybox
      image: busybox
      args:
      - sleep
      - "1000"
EOF
~~~~



- Resultado, criou o Pod:

~~~~bash
controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
default       static-busybox-controlplane            1/1     Running   0          4s
kube-system   coredns-6d4b75cb6d-qsdgx               1/1     Running   0          31m
kube-system   coredns-6d4b75cb6d-wtdgg               1/1     Running   0          31m
kube-system   etcd-controlplane                      1/1     Running   0          31m
kube-system   kube-apiserver-controlplane            1/1     Running   0          32m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          32m
kube-system   kube-flannel-ds-5l8qh                  1/1     Running   0          31m
kube-system   kube-flannel-ds-jdwzc                  1/1     Running   0          31m
kube-system   kube-proxy-dgcmf                       1/1     Running   0          31m
kube-system   kube-proxy-wsfmh                       1/1     Running   0          31m
kube-system   kube-scheduler-controlplane            1/1     Running   0          31m

controlplane ~ ➜  
~~~~



- DETALHANDO:

kubectl run static-busybox --image=busybox --dry-run=client -o yaml --command -- sleep 1000

OBSERVAÇÃO:
Não colocar nada ao final do comando dry-run, após os 2 traços do --command, pois ali ele entende como "options" para aquele comando.

jogando para um arquivo:
kubectl run static-busybox --image=busybox --dry-run=client -o yaml --command -- sleep 1000 > static-busybox.yaml

~~~~bash
fernando@debian10x64:~$ cat static-busybox.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: static-busybox
  name: static-busybox
spec:
  containers:
  - command:
    - sleep
    - "1000"
    image: busybox
    name: static-busybox
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
fernando@debian10x64:~$
~~~~



- Conectar no Node desejado e aplicar o manifesto.

~~~~bash
cat <<EOF >/etc/kubernetes/manifests/static-busybox.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: static-busybox
  name: static-busybox
spec:
  containers:
  - command:
    - sleep
    - "1000"
    image: busybox
    name: static-busybox
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
EOF
~~~~



- ANTES:

~~~~bash
fernando@debian10x64:~$ kubectl get pods -A
NAMESPACE     NAME                               READY   STATUS    RESTARTS       AGE
kube-system   coredns-78fcd69978-zbfqb           1/1     Running   5 (71m ago)    46d
kube-system   etcd-minikube                      1/1     Running   5 (71m ago)    46d
kube-system   kube-apiserver-minikube            1/1     Running   5 (71m ago)    46d
kube-system   kube-controller-manager-minikube   1/1     Running   6 (71m ago)    46d
kube-system   kube-proxy-2r8hf                   1/1     Running   5 (71m ago)    46d
kube-system   kube-scheduler-minikube            1/1     Running   5 (71m ago)    46d
kube-system   storage-provisioner                1/1     Running   10 (70m ago)   46d
fernando@debian10x64:~$

docker@minikube:~$ ls /etc/kubernetes/manifests
etcd.yaml  kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml
docker@minikube:~$
~~~~


- DEPOIS:

~~~~bash
root@minikube:/home/docker# ls /etc/kubernetes/manifests
etcd.yaml  kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml  static-busybox.yaml
root@minikube:/home/docker#

fernando@debian10x64:~$ kubectl get pods -A
NAMESPACE     NAME                               READY   STATUS    RESTARTS       AGE
default       static-busybox-minikube            1/1     Running   0              13s
kube-system   coredns-78fcd69978-zbfqb           1/1     Running   5 (75m ago)    46d
kube-system   etcd-minikube                      1/1     Running   5 (75m ago)    46d
kube-system   kube-apiserver-minikube            1/1     Running   5 (75m ago)    46d
kube-system   kube-controller-manager-minikube   1/1     Running   6 (75m ago)    46d
kube-system   kube-proxy-2r8hf                   1/1     Running   5 (75m ago)    46d
kube-system   kube-scheduler-minikube            1/1     Running   5 (75m ago)    46d
kube-system   storage-provisioner                1/1     Running   10 (74m ago)   46d
fernando@debian10x64:~$
~~~~


foi criado o "Static Pod" no node "minikube".






# PENDENTE
- Video continua em 08:32




# DIA 08/01/2023

- Testando Pod estático / Static Pod.


- ANTES:

~~~~bash

fernando@debian10x64:~$ kubectl get pods -A
NAMESPACE       NAME                                                              READY   STATUS    RESTARTS        AGE
kube-system     coredns-78fcd69978-5xcpp                                          1/1     Running   4 (44h ago)     7d7h
kube-system     etcd-minikube                                                     1/1     Running   17 (44h ago)    7d7h
kube-system     kube-apiserver-minikube                                           1/1     Running   16 (44h ago)    7d7h
kube-system     kube-controller-manager-minikube                                  1/1     Running   17 (44h ago)    7d7h
kube-system     kube-proxy-5pc9k                                                  1/1     Running   4 (44h ago)     7d7h
kube-system     kube-scheduler-minikube                                           1/1     Running   13 (44h ago)    7d7h
kube-system     storage-provisioner                                               1/1     Running   9 (8m39s ago)   7d7h
nginx-ingress   meu-ingress-controller-ingress-nginx-controller-85685788f82hp89   1/1     Running   1 (44h ago)     45h
nginx-ingress   meu-ingress-controller-ingress-nginx-controller-85685788f8xpg5v   1/1     Running   1 (44h ago)     44h
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get pods -A | grep static
fernando@debian10x64:~$

root@minikube:/#
root@minikube:/# ls /etc/kubernetes/manifests/
etcd.yaml  kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml
root@minikube:/#
root@minikube:/#
root@minikube:/# ls -lhasp /etc/kubernetes/manifests/
total 28K
4.0K drwxr-xr-x 1 root root 4.0K Jan  8 23:13 ./
8.0K drwxr-xr-x 1 root root 4.0K Jan  8 23:13 ../
4.0K -rw------- 1 root root 2.3K Jan  8 23:13 etcd.yaml
4.0K -rw------- 1 root root 4.0K Jan  8 23:13 kube-apiserver.yaml
4.0K -rw------- 1 root root 3.4K Jan  8 23:13 kube-controller-manager.yaml
4.0K -rw------- 1 root root 1.5K Jan  8 23:13 kube-scheduler.yaml
root@minikube:/#
root@minikube:/#
root@minikube:/#

~~~~




- criando o Static-Pod:

~~~~bash
root@minikube:/#
root@minikube:/# cat <<EOF >/etc/kubernetes/manifests/static-busybox.yaml
> apiVersion: v1
  name: static-busybox
spec:
  containers:
  - command:
    - sleep
> kind: Pod
> metadata:
>   creationTimestamp: null
>   labels:
>     run: static-busybox
>   name: static-busybox
> spec:
>   containers:
>   - command:
>     - sleep
>     - "1000"
>     image: busybox
>     name: static-busybox
>     resources: {}
>   dnsPolicy: ClusterFirst
>   restartPolicy: Always
> status: {}
> EOF
root@minikube:/#
~~~~





- DEPOIS:

~~~~bash
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get pods -A | grep static
default         static-busybox-minikube                                           1/1     Running   0               10s
fernando@debian10x64:~$

~~~~





- Removendo o Static-Pod:

~~~~bash
root@minikube:/# rm -f /etc/kubernetes/manifests/static-busybox.yaml
root@minikube:/#

fernando@debian10x64:~$ kubectl get pods -A | grep static
default         static-busybox-minikube                                           1/1     Running   0               10s
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get pods -A | grep static
default         static-busybox-minikube                                           1/1     Running   0              2m15s
fernando@debian10x64:~$ kubectl delete pod static-busybox-minikube
pod "static-busybox-minikube" deleted

fernando@debian10x64:~$
fernando@debian10x64:~$
~~~~








# PENDENTE
- Video continua em 08:32












# We just created a new static pod named static-greenbox. Find it and delete it.

This question is a bit tricky. But if you use the knowledge you gained in the previous questions in this lab, you should be able to find the answer to it.


- Averiguar o arquivo de configuração do Kubelet, pois não há manifesto na pasta "/etc/kubernetes/manifests" do node01:

~~~~bash
controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   46m   v1.24.0
node01         Ready    <none>          45m   v1.24.0

controlplane ~ ➜  ssh node01

root@node01 ~ ➜  


root@node01 /etc/kubernetes ✖ ls /etc/kubernetes/manifests
~~~~



- Pegando no Minikube um exemplo, só para pegar a idéia, pois o ambiente do LAB não tá montado agora.
- Idéia é que no LAB de Static-Pod, ao invés de ter sido deletado o Pod "static-greenbox-node01" via crictl dentro do Node, que fosse removido o manifesto no path onde o Kubelet guarda os manifestos.
- No meu Minikube o path tá o padrão, mas no video da solução da questão tá um path maluco, por isto tava vazio o "/etc/kubernetes/manifests", Kubelet do LAB carregava os manifestos de outro path.

~~~~bash
root@minikube:/# cat /var/lib/kubelet/config.yaml | grep -i path
staticPodPath: /etc/kubernetes/manifests
root@minikube:/#
~~~~


- Outro detalhe é que no LAB eu deletei o Pod dentro do Node usando o crictl e depois usei o comando "delete pod" do kubectl, para deletar o Pod, porém não era necessário, pois o Pod é deletado sozinho um tempo depois.
- No video é mostrado o uso do get pods usando o parametro "--watch", que fica acompanhando e o terminate do Pod ocorre na sequencia, sem precisar deletar o Pod manualmente.



# RESUMO
- Editando o manifesto do Static-Pod dentro do Node ou deletando ele, o Pod será afetado automaticamente.