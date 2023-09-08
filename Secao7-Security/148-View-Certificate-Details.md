
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "148. View Certificate Details."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 148. View Certificate Details

# View Certificate Details
  - Take me to [Video Tutorial](https://kodekloud.com/topic/view-certificate-details/)
  
In this section, we will take a look how to view certificates in a kubernetes cluster.

## View Certs 
 ![hrd](../../images/hrd.PNG)

 ![hrd1](../../images/hrd1.PNG)
 
 - To view the details of the certificate
   ```
   $ openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout
   ```
   
   ![hrd2](../../images/hrd2.PNG)
   
#### Follow the same procedure to identify information about of all the other certificates

   ![hrd3](../../images/hrd3.PNG)
   
## Inspect Server Logs - Hardware setup
- Inspect server logs using journalctl
  ```
  $ journalctl -u etcd.service -l
  ```
  
  ![hrd4](../../images/hrd4.PNG)
  
## Inspect Server Logs - kubeadm setup
- View logs using kubectl
  ```
  $ kubectl logs etcd-master
  ```
  ![hrd5](../../images/hrd5.PNG)
  
- View logs using docker ps and docker logs
  ```
  $ docker ps -a
  $ docker logs <container-id>
  ```
  ![hrd6](../../images/hrd6.PNG)
  
#### K8s Reference Docs
- https://kubernetes.io/docs/setup/best-practices/certificates/#certificate-paths
  
  

  

   
   





------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 148. View Certificate Details

- To view the details of the certificate

~~~~bash
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout
~~~~


- Follow the same procedure to identify information about of all the other certificates

   



## Inspect Server Logs - Hardware setup

- Inspect server logs using journalctl
~~~~bash
journalctl -u etcd.service -l
~~~~
  


  
## Inspect Server Logs - kubeadm setup

- View logs using kubectl

~~~~bash
kubectl logs etcd-master
~~~~



  
- View logs using docker ps and docker logs

~~~~bash
docker ps -a
docker logs <container-id>
~~~~



  
#### K8s Reference Docs
- https://kubernetes.io/docs/setup/best-practices/certificates/#certificate-paths
  
  







- Tentei consultar o kube-apiserver do Minikube, porém o Pod não tá com o Container operacional

~~~~bash

fernando@debian10x64:~$ kubectl get pods -n kube-system
NAME                               READY   STATUS    RESTARTS       AGE
coredns-78fcd69978-5xcpp           1/1     Running   45 (24m ago)   244d
etcd-minikube                      1/1     Running   58 (24m ago)   244d
kube-apiserver-minikube            0/1     Running   9 (24m ago)    138d
kube-controller-manager-minikube   1/1     Running   65 (24m ago)   244d
kube-proxy-5pc9k                   1/1     Running   45 (24m ago)   244d
kube-scheduler-minikube            1/1     Running   54 (24m ago)   244d
metrics-server-77c99ccb96-pnnwl    1/1     Running   39 (28d ago)   210d
my-scheduler-6c595b886d-87dms      1/1     Running   25 (24m ago)   215d
storage-provisioner                1/1     Running   96 (22m ago)   244d
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl describe pod kube-apiserver-minikube -n kube-system | tail
Events:
  Type     Reason          Age                     From     Message
  ----     ------          ----                    ----     -------
  Warning  Unhealthy       28d (x3556 over 29d)    kubelet  Readiness probe failed: HTTP probe failed with statuscode: 500
  Normal   SandboxChanged  23m                     kubelet  Pod sandbox changed, it will be killed and re-created.
  Normal   Pulled          23m                     kubelet  Container image "k8s.gcr.io/kube-apiserver:v1.22.2" already present on machine
  Normal   Created         23m                     kubelet  Created container kube-apiserver
  Normal   Started         23m                     kubelet  Started container kube-apiserver
  Warning  Unhealthy       23m                     kubelet  Startup probe failed: HTTP probe failed with statuscode: 403
  Warning  Unhealthy       3m28s (x1219 over 23m)  kubelet  Readiness probe failed: HTTP probe failed with statuscode: 500
fernando@debian10x64:~$

~~~~




- Logs do Pod do kube-apiserver:

~~~~bash

E0903 03:07:13.853462       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:14.857342       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:15.861114       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:16.865845       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:17.870541       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:18.876564       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:19.881186       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:20.886275       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:21.892463       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:22.906017       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:22.991535       1 status.go:71] apiserver received an error that is not an metav1.Status: 3: illegal base64 data at input byte 3
E0903 03:07:22.992482       1 reflector.go:138] k8s.io/client-go/informers/factory.go:134: Failed to watch *v1.Secret: failed to list *v1.Secret: illegal base64 data at input byte 3
E0903 03:07:23.911527       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:24.915953       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:25.920763       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:26.931890       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:27.940936       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:28.947989       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:29.954516       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:30.959193       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:31.967650       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:32.977136       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:33.981761       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:34.988165       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:35.992397       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:36.997642       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:38.001749       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:38.509094       1 status.go:71] apiserver received an error that is not an metav1.Status: 3: illegal base64 data at input byte 3
E0903 03:07:39.013951       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:40.026583       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:41.040839       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:42.054132       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:42.208735       1 status.go:71] apiserver received an error that is not an metav1.Status: 3: illegal base64 data at input byte 3
E0903 03:07:43.058921       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
E0903 03:07:44.062127       1 cacher.go:420] cacher (*core.Secret): unexpected ListAndWatch error: failed to list *core.Secret: illegal base64 data at input byte 3; reinitializing...
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ date
Sun 03 Sep 2023 12:07:48 AM -03
fernando@debian10x64:~$

fernando@debian10x64:~$ kubectl get secret -A
Error from server: illegal base64 data at input byte 3
fernando@debian10x64:~$
fernando@debian10x64:~$ date
Sun 03 Sep 2023 01:43:25 AM -03
fernando@debian10x64:~$

~~~~






## PENDENTE
- Resolver problema no Pod do kube-apiserver no Minikube, para poder efetuar procedimento da aula 148 e verificar detalhes do certificado.
        Erro   no Pod do kube-apiserver parece ter relação com Secret.
- Ver sobre Minikube + API-Server. Relação da Secret com api
- Ver Dashboard do Kubernetes via "minikube dashboard"
- Usar planilha excel da aula149, para modulo7.













------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# Dia 03/09/2023



- Kubeadm subindo agora:

~~~~bash

root@debian10x64:/home/fernando# sudo kubeadm init
[init] Using Kubernetes version: v1.28.1
[preflight] Running pre-flight checks
        [WARNING SystemVerification]: missing optional cgroups: hugetlb
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
W0903 13:53:58.561171   20502 checks.go:835] detected that the sandbox image "registry.k8s.io/pause:3.6" of the container runtime is inconsistent with that used by kubeadm. It is recommended that using "registry.k8s.io/pause:3.9" as the CRI sandbox image.
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [debian10x64 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.92.129]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [debian10x64 localhost] and IPs [192.168.92.129 127.0.0.1 ::1]
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [debian10x64 localhost] and IPs [192.168.92.129 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 12.004876 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node debian10x64 as control-plane by adding the labels: [node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
[mark-control-plane] Marking the node debian10x64 as control-plane by adding the taints [node-role.kubernetes.io/control-plane:NoSchedule]
[bootstrap-token] Using token: 43qh9d.rii269nnocdyyj7d
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.92.129:6443 --token 43qh9d.rii269nnocdyyj7d \
        --discovery-token-ca-cert-hash sha256:846acc96ef4ca22d9e03634aac252343987378443ff572becb4178d8c9a50cda
root@debian10x64:/home/fernando#

~~~~





- Erro no Pod do Cilium

~~~~bash
Events:
  Type     Reason            Age    From               Message
  ----     ------            ----   ----               -------
  Warning  FailedScheduling  2m14s  default-scheduler  0/1 nodes are available: 1 node(s) didn't match pod anti-affinity rules. preemption: 0/1 nodes are available: 1 No preemption victims found for incoming pod..
root@debian10x64:/home/fernando#




root@debian10x64:/home/fernando# cilium status --wait
    /¯¯\
 /¯¯\__/¯¯\    Cilium:             OK
 \__/¯¯\__/    Operator:           1 errors, 1 warnings
 /¯¯\__/¯¯\    Envoy DaemonSet:    disabled (using embedded mode)
 \__/¯¯\__/    Hubble Relay:       disabled
    \__/       ClusterMesh:        disabled

Deployment             cilium-operator    Desired: 2, Ready: 1/2, Available: 1/2, Unavailable: 1/2
DaemonSet              cilium             Desired: 1, Ready: 1/1, Available: 1/1
Containers:            cilium             Running: 1
                       cilium-operator    Pending: 1, Running: 1
Cluster Pods:          2/5 managed by Cilium
Helm chart version:    1.14.1
Image versions         cilium             quay.io/cilium/cilium:v1.14.1@sha256:edc1d05ea1365c4a8f6ac6982247d5c145181704894bb698619c3827b6963a72: 1
                       cilium-operator    quay.io/cilium/operator-generic:v1.14.1@sha256:e061de0a930534c7e3f8feda8330976367971238ccafff42659f104effd4b5f7: 2
Errors:                cilium-operator    cilium-operator                     1 pods of Deployment cilium-operator are not ready
Warnings:              cilium-operator    cilium-operator-788c4f69bc-jv5tk    pod is pending

Error: Unable to determine status:  timeout while waiting for status to become successful: context deadline exceeded
root@debian10x64:/home/fernando# date
Sun 03 Sep 2023 02:09:57 PM -03
root@debian10x64:/home/fernando#

~~~~












- Status do Pod api-server e processo na maquina Debian

~~~~bash

root@debian10x64:/home/fernando# ps -ef | grep api
root       21263   21028  9 13:55 ?        00:04:55 kube-apiserver --advertise-address=192.168.92.129 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root       39927   24425  0 14:48 pts/4    00:00:00 grep api
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Sun 03 Sep 2023 02:48:42 PM -03
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#

root@debian10x64:/home/fernando# kubectl get pods -n kube-system
NAME                                  READY   STATUS    RESTARTS   AGE
cilium-operator-788c4f69bc-kxc29      1/1     Running   0          45m
cilium-p29l7                          1/1     Running   0          45m
coredns-5dd5756b68-2d2b4              1/1     Running   0          53m
coredns-5dd5756b68-cxks8              1/1     Running   0          53m
etcd-debian10x64                      1/1     Running   0          53m
kube-apiserver-debian10x64            1/1     Running   0          53m
kube-controller-manager-debian10x64   1/1     Running   0          53m
kube-proxy-vvdqq                      1/1     Running   0          53m
kube-scheduler-debian10x64            1/1     Running   0          53m
root@debian10x64:/home/fernando#

~~~~











root@debian10x64:/etc/kubernetes# cat /etc/kubernetes/manifests/
etcd.yaml                     kube-apiserver.yaml           kube-controller-manager.yaml  kube-scheduler.yaml
root@debian10x64:/etc/kubernetes# cat /etc/kubernetes/manifests/kube-apiserver.yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 192.168.92.129:6443
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
    - --advertise-address=192.168.92.129
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
    image: registry.k8s.io/kube-apiserver:v1.28.1
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 192.168.92.129
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
        host: 192.168.92.129
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
        host: 192.168.92.129
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
    - mountPath: /etc/pki
      name: etc-pki
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
  priority: 2000001000
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
      path: /etc/pki
      type: DirectoryOrCreate
    name: etc-pki
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
root@debian10x64:/etc/kubernetes# date
Sun 03 Sep 2023 02:51:22 PM -03
root@debian10x64:/etc/kubernetes#








- Verificando detalhes do certificado:

openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout

~~~~bash

root@debian10x64:/etc/kubernetes# openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 7437391954516342934 (0x6736ec93e04b7896)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = kubernetes
        Validity
            Not Before: Sep  3 16:50:00 2023 GMT
            Not After : Sep  2 16:55:00 2024 GMT
        Subject: CN = kube-apiserver
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:f2:f6:b4:be:d9:e5:91:a7:83:0a:8d:bb:8c:28:
                    26:ac:e3:2d:0d:c3:0d:a3:3c:b7:85:b1:f2:e1:36:
                    29:c5:99:53:17:f1:86:00:be:a4:eb:6f:12:c3:df:
                    25:b8:02:a2:41:0e:8e:78:81:b7:91:a4:12:d0:45:
                    c6:e3:8c:db:e0:01:e0:29:56:66:a0:59:a6:e5:85:
                    80:a2:89:a4:f3:c8:11:a2:5c:88:13:1a:ce:7f:4a:
                    69:83:01:18:dc:8e:1e:6a:57:00:79:29:a4:12:0a:
                    50:95:b4:e3:3a:82:c3:28:4b:32:0b:3f:75:1b:4b:
                    47:d2:de:c6:4f:e8:ea:ad:a3:17:1e:2d:f0:48:be:
                    4f:bb:a8:95:63:30:59:25:67:9e:be:b6:cc:59:64:
                    e2:0e:b6:3f:91:88:43:58:48:9d:61:f3:94:b9:25:
                    92:84:00:f7:ec:b9:cf:19:5e:11:b1:bc:23:82:4c:
                    04:d5:a4:e2:10:16:8c:c1:f4:c5:62:77:61:a8:1d:
                    dc:2e:f1:a7:66:2f:fc:89:29:4d:02:96:19:08:00:
                    86:ce:8a:68:40:4c:de:74:eb:07:5d:b0:8a:8a:7f:
                    26:74:b2:67:4f:13:11:89:0b:02:9d:4d:44:a8:51:
                    d1:04:85:6e:23:a3:12:91:49:77:bc:ae:b1:3b:a1:
                    73:01
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage:
                TLS Web Server Authentication
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 Authority Key Identifier:
                keyid:C3:70:BA:31:CB:EE:45:6F:D2:8D:42:5D:80:7B:31:72:7C:19:9B:37

            X509v3 Subject Alternative Name:
                DNS:debian10x64, DNS:kubernetes, DNS:kubernetes.default, DNS:kubernetes.default.svc, DNS:kubernetes.default.svc.cluster.local, IP Address:10.96.0.1, IP Address:192.168.92.129
    Signature Algorithm: sha256WithRSAEncryption
         9d:1a:da:3c:e3:f1:2e:b7:7e:0e:2c:f3:0a:5e:f0:bb:13:7f:
         04:65:c6:6f:0f:6e:95:8e:11:61:4c:bd:83:cd:c5:d5:f7:cd:
         68:47:f9:ea:35:37:1a:0a:4c:62:0b:84:35:2c:e2:6d:e4:e4:
         bb:1f:24:c2:b0:82:36:01:75:00:eb:6c:d6:4a:d7:63:92:7c:
         a6:e1:87:7d:04:69:c2:46:48:74:51:2b:f6:62:f3:a8:29:68:
         8a:77:a4:e0:b3:47:b0:97:bb:2d:e9:e2:3c:29:f3:17:d4:d5:
         17:25:19:96:6a:64:47:88:07:e4:73:f1:62:82:db:b0:0e:f7:
         de:fc:dd:10:81:e7:e4:92:98:b4:2c:df:ec:6e:f8:ad:be:a3:
         c2:9a:e7:24:3f:28:08:3c:fb:56:2e:38:bf:df:ac:cb:dc:e1:
         dd:3a:f7:1b:04:b7:f9:ad:fe:bb:2b:8a:d2:6f:d1:8e:92:70:
         5d:d1:bf:42:bd:ce:71:f7:94:a2:cd:7e:09:b4:e0:b7:bb:03:
         45:12:5e:4e:0e:f7:d2:7d:68:5a:07:83:5c:67:d8:02:ca:ca:
         33:c0:a9:ea:40:42:e8:c0:d8:05:19:6d:51:5f:ef:45:22:3b:
         b8:b3:1d:04:32:f5:d3:9a:51:2f:91:e1:10:12:27:5a:e6:35:
         42:13:2d:81
root@debian10x64:/etc/kubernetes#

~~~~






- Principais detalhes:

Subject: CN = kube-apiserver


            X509v3 Subject Alternative Name:
                DNS:debian10x64, DNS:kubernetes, DNS:kubernetes.default, DNS:kubernetes.default.svc, DNS:kubernetes.default.svc.cluster.local, IP Address:10.96.0.1, IP Address:192.168.92.129



        Issuer: CN = kubernetes














## Inspect Server Logs - Hardware setup

- Inspect server logs using journalctl
~~~~bash
journalctl -u etcd.service -l
~~~~


~~~~bash
root@debian10x64:/etc/kubernetes# journalctl -u etcd.service -l
-- Logs begin at Sun 2023-09-03 13:16:51 -03, end at Sun 2023-09-03 14:54:46 -03. --
-- No entries --
root@debian10x64:/etc/kubernetes# date
Sun 03 Sep 2023 02:54:49 PM -03
root@debian10x64:/etc/kubernetes#
~~~~







## Inspect Server Logs - kubeadm setup

- View logs using kubectl

~~~~bash
kubectl logs etcd-master
~~~~







kubectl logs etcd-debian10x64 -n kube-system

- Logs

~~~~json

{"level":"info","ts":"2023-09-03T16:55:11.417149Z","caller":"embed/etcd.go:855","msg":"serving metrics","address":"http://127.0.0.1:2381"}
{"level":"info","ts":"2023-09-03T16:55:11.495127Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"85e911e1606da1d3 is starting a new election at term 1"}
{"level":"info","ts":"2023-09-03T16:55:11.495264Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"85e911e1606da1d3 became pre-candidate at term 1"}
{"level":"info","ts":"2023-09-03T16:55:11.495312Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"85e911e1606da1d3 received MsgPreVoteResp from 85e911e1606da1d3 at term 1"}
{"level":"info","ts":"2023-09-03T16:55:11.495353Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"85e911e1606da1d3 became candidate at term 2"}
{"level":"info","ts":"2023-09-03T16:55:11.495533Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"85e911e1606da1d3 received MsgVoteResp from 85e911e1606da1d3 at term 2"}
{"level":"info","ts":"2023-09-03T16:55:11.495709Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"85e911e1606da1d3 became leader at term 2"}
{"level":"info","ts":"2023-09-03T16:55:11.495778Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"raft.node: 85e911e1606da1d3 elected leader 85e911e1606da1d3 at term 2"}
{"level":"info","ts":"2023-09-03T16:55:11.496595Z","caller":"etcdserver/server.go:2062","msg":"published local member to cluster through raft","local-member-id":"85e911e1606da1d3","local-member-attributes":"{Name:debian10x64 ClientURLs:[https://192.168.92.129:2379]}","request-path":"/0/members/85e911e1606da1d3/attributes","cluster-id":"91af2e05e7463c54","publish-timeout":"7s"}
{"level":"info","ts":"2023-09-03T16:55:11.497048Z","caller":"etcdserver/server.go:2571","msg":"setting up initial cluster version using v2 API","cluster-version":"3.5"}
{"level":"info","ts":"2023-09-03T16:55:11.497383Z","caller":"embed/serve.go:103","msg":"ready to serve client requests"}
{"level":"info","ts":"2023-09-03T16:55:11.497565Z","caller":"embed/serve.go:103","msg":"ready to serve client requests"}
{"level":"info","ts":"2023-09-03T16:55:11.498144Z","caller":"etcdmain/main.go:44","msg":"notifying init daemon"}
{"level":"info","ts":"2023-09-03T16:55:11.498213Z","caller":"etcdmain/main.go:50","msg":"successfully notified init daemon"}
{"level":"info","ts":"2023-09-03T16:55:11.498489Z","caller":"membership/cluster.go:584","msg":"set initial cluster version","cluster-id":"91af2e05e7463c54","local-member-id":"85e911e1606da1d3","cluster-version":"3.5"}
{"level":"info","ts":"2023-09-03T16:55:11.498778Z","caller":"api/capability.go:75","msg":"enabled capabilities for version","cluster-version":"3.5"}
{"level":"info","ts":"2023-09-03T16:55:11.498857Z","caller":"etcdserver/server.go:2595","msg":"cluster version is updated","cluster-version":"3.5"}
{"level":"info","ts":"2023-09-03T16:55:11.499092Z","caller":"embed/serve.go:250","msg":"serving client traffic securely","traffic":"grpc+http","address":"127.0.0.1:2379"}
{"level":"info","ts":"2023-09-03T16:55:11.4992Z","caller":"embed/serve.go:250","msg":"serving client traffic securely","traffic":"grpc+http","address":"192.168.92.129:2379"}
{"level":"info","ts":"2023-09-03T17:50:12.011524Z","caller":"mvcc/hash.go:137","msg":"storing new hash","hash":4083046016,"revision":6582,"compact-revision":5686}
{"level":"info","ts":"2023-09-03T17:55:12.002586Z","caller":"mvcc/index.go:214","msg":"compact tree index","revision":7692}
{"level":"info","ts":"2023-09-03T17:55:12.021959Z","caller":"mvcc/kvstore_compaction.go:66","msg":"finished scheduled compaction","compact-revision":7692,"took":"18.768243ms","hash":2193106557}
{"level":"info","ts":"2023-09-03T17:55:12.022083Z","caller":"mvcc/hash.go:137","msg":"storing new hash","hash":2193106557,"revision":7692,"compact-revision":6582}
root@debian10x64:/etc/kubernetes#

~~~~