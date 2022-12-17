
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


- Conectar no Node desejado e aplicar o manifesto.

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



- ANTES:
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



- DEPOIS:

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


foi criado o "Static Pod" no node "minikube".






# PENDENTE
- Video continua em 08:32