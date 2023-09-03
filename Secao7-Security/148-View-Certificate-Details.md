
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



