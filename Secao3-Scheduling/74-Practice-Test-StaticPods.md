



############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 74. Practice Test - Static Pods"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status







# ##############################################################################################################################################################
# 74. Practice Test - Static Pods

# How many static pods exist in this cluster in all namespaces?


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

controlplane ~ ➜  kubectl get pods -A | wc
     11      66     946

controlplane ~ ➜  ls
sample.yaml

controlplane ~ ➜  ls /etc/kubernetes/
admin.conf               kubelet.conf             pki/                     
controller-manager.conf  manifests/               scheduler.conf           

controlplane ~ ➜  ls /etc/kubernetes/manifests/
etcd.yaml  kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml

controlplane ~ ➜  ls -lhasp /etc/kubernetes/manifests/
total 28K
4.0K drwxr-xr-x 1 root root 4.0K Dec 13 01:39 ./
8.0K drwxr-xr-x 1 root root 4.0K Dec 13 01:39 ../
4.0K -rw------- 1 root root 2.3K Dec 13 01:39 etcd.yaml
4.0K -rw------- 1 root root 3.8K Dec 13 01:39 kube-apiserver.yaml
4.0K -rw------- 1 root root 3.3K Dec 13 01:39 kube-controller-manager.yaml
4.0K -rw------- 1 root root 1.5K Dec 13 01:39 kube-scheduler.yaml

controlplane ~ ➜  




- RESPOSTA:
4








# Which of the below components is NOT deployed as a static pod?

- RESPOSTA:
coredns





# Which of the below components is NOT deployed as a static POD?

- RESPOSTA:
kube-proxy





# On which nodes are the static pods created currently?

-RESPOSTA:
controlplane
observação:
é controlplane, porque no nome dos Pods tem "-controlplane" ao final do nome do Pod.




# What is the path of the directory holding the static pod definition files?

"/etc/kubernetes/manifests"





# How many pod definition files are present in the manifests folder?


- RESPOSTA:
4




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

















# Edit the image on the static pod to use busybox:1.28.4



controlplane ~ ✖ vi /etc/kubernetes/manifests/static-busybox.yaml 

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
default       static-busybox-controlplane            1/1     Running   0          3m34s


- Necessário deletar o Pod antigo:
kubectl delete pod static-busybox-controlplane

- Desta maneira, Pod foi recriado:


controlplane ~ ✖ kubectl delete pod static-busybox-controlplane
pod "static-busybox-controlplane" deleted

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
default       static-busybox-controlplane            0/1     Pending   0          3s



- Detalhando:
Events:
  Type    Reason   Age   From     Message
  ----    ------   ----  ----     -------
  Normal  Pulling  72s   kubelet  Pulling image "busybox:1.28.4"
  Normal  Pulled   70s   kubelet  Successfully pulled image "busybox:1.28.4" in 1.107757411s
  Normal  Created  70s   kubelet  Created container busybox
  Normal  Started  70s   kubelet  Started container busybox












# We just created a new static pod named static-greenbox. Find it and delete it.

This question is a bit tricky. But if you use the knowledge you gained in the previous questions in this lab, you should be able to find the answer to it.

    Static pod deleted







controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
default       static-busybox-controlplane            1/1     Running   0          68s
default       static-greenbox-node01                 1/1     Running   0          17s
kube-system   coredns-6d4b75cb6d-qsdgx               1/1     Running   0          37m
kube-system   coredns-6d4b75cb6d-wtdgg               1/1     Running   0          37m
kube-system   etcd-controlplane                      1/1     Running   0          37m
kube-system   kube-apiserver-controlplane            1/1     Running   0          37m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          37m
kube-system   kube-flannel-ds-5l8qh                  1/1     Running   0          37m
kube-system   kube-flannel-ds-jdwzc                  1/1     Running   0          37m
kube-system   kube-proxy-dgcmf                       1/1     Running   0          37m
kube-system   kube-proxy-wsfmh                       1/1     Running   0          37m
kube-system   kube-scheduler-controlplane            1/1     Running   0          37m

controlplane ~ ➜  kubectl delete pod static-greenbox-node01
pod "static-greenbox-node01" deleted

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
default       static-busybox-controlplane            1/1     Running   0          94s
default       static-greenbox-node01                 0/1     Pending   0          3s
kube-system   coredns-6d4b75cb6d-qsdgx               1/1     Running   0          38m
kube-system   coredns-6d4b75cb6d-wtdgg               1/1     Running   0          38m
kube-system   etcd-controlplane                      1/1     Running   0          38m
kube-system   kube-apiserver-controlplane            1/1     Running   0          38m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          38m
kube-system   kube-flannel-ds-5l8qh                  1/1     Running   0          38m
kube-system   kube-flannel-ds-jdwzc                  1/1     Running   0          37m
kube-system   kube-proxy-dgcmf                       1/1     Running   0          38m
kube-system   kube-proxy-wsfmh                       1/1     Running   0          37m
kube-system   kube-scheduler-controlplane            1/1     Running   0          38m

controlplane ~ ➜  




ormal  Started  7m31s  kubelet  Started container static-greenbox

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   46m   v1.24.0
node01         Ready    <none>          45m   v1.24.0

controlplane ~ ➜  ssh node01

root@node01 ~ ➜  



root@node01 /etc/kubernetes ➜  crictl ps
CONTAINER           IMAGE               CREATED             STATE               NAME                ATTEMPT             POD ID              POD
919ee2fcc7b51       334e4a014c81b       10 minutes ago      Running             static-greenbox     0                   05dfaa6b56008       static-greenbox-node01
6a26ebb4ef511       f03a23d55e578       47 minutes ago      Running             kube-flannel        0                   41927b68b32af       kube-flannel-ds-jdwzc
5a94f315aa9a1       77b49675beae1       47 minutes ago      Running             kube-proxy          0                   da411fa8fa32c       kube-proxy-wsfmh

root@node01 /etc/kubernetes ➜  


root@node01 /etc/kubernetes ✖ kubectl get pods -A
The connection to the server localhost:8080 was refused - did you specify the right host or port?

root@node01 /etc/kubernetes ✖ ls /etc/kubernetes/manifests

root@node01 /etc/kubernetes ➜  docker ps
-bash: docker: command not found

root@node01 /etc/kubernetes ✖ crictl rm 919ee2fcc7b51
ERRO[0000] container "919ee2fcc7b51" is running, please stop it first 
FATA[0000] unable to remove container(s)                

root@node01 /etc/kubernetes ✖ crictl stop 919ee2fcc7b51
919ee2fcc7b51

root@node01 /etc/kubernetes ➜  crictl rm 919ee2fcc7b51
919ee2fcc7b51

root@node01 /etc/kubernetes ➜  crictl ps
CONTAINER           IMAGE               CREATED             STATE               NAME                ATTEMPT             POD ID              POD
6a26ebb4ef511       f03a23d55e578       49 minutes ago      Running             kube-flannel        0                   41927b68b32af       kube-flannel-ds-jdwzc
5a94f315aa9a1       77b49675beae1       49 minutes ago      Running             kube-proxy          0                   da411fa8fa32c       kube-proxy-wsfmh

root@node01 /etc/kubernetes ➜  

controlplane ~ ➜  kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
static-busybox-controlplane   1/1     Running   0          13m
static-greenbox-node01        0/1     Error     0          12m

controlplane ~ ➜  kubectl delete pod static-greenbox-node01
pod "static-greenbox-node01" deleted

controlplane ~ ➜  kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
static-busybox-controlplane   1/1     Running   0          13m

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
default       static-busybox-controlplane            1/1     Running   0          13m
kube-system   coredns-6d4b75cb6d-qsdgx               1/1     Running   0          50m
kube-system   coredns-6d4b75cb6d-wtdgg               1/1     Running   0          50m
kube-system   etcd-controlplane                      1/1     Running   0          50m
kube-system   kube-apiserver-controlplane            1/1     Running   0          50m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          50m
kube-system   kube-flannel-ds-5l8qh                  1/1     Running   0          50m
kube-system   kube-flannel-ds-jdwzc                  1/1     Running   0          50m
kube-system   kube-proxy-dgcmf                       1/1     Running   0          50m
kube-system   kube-proxy-wsfmh                       1/1     Running   0          50m
kube-system   kube-scheduler-controlplane            1/1     Running   0          50m

controlplane ~ ➜  



- RESPOSTA
para resolver esta questão, foi necessário entrar no node01, deletar o Container usando o crictl.
Voltar ao node controlplane, deletar o Pod "static-greenbox-node01".
usando comandos obtidos no site:
https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/