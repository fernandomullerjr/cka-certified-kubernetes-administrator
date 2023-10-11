

# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# push

git status
git add .
git commit -m "162. Practice Test - RBAC."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# 162. Practice Test - RBAC

Inspect the environment and identify the authorization modes configured on the cluster.

Check the kube-apiserver settings.

controlplane /etc/kubernetes ➜  ls manifests/
etcd.yaml  kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml

controlplane /etc/kubernetes ➜  cd manifests/

controlplane /etc/kubernetes/manifests ➜  cat kube-apiserver.yaml 
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 192.35.222.3:6443
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
    - --advertise-address=192.35.222.3
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
    image: registry.k8s.io/kube-apiserver:v1.27.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 192.35.222.3
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
        host: 192.35.222.3
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
        host: 192.35.222.3
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

controlplane /etc/kubernetes/manifests ➜  


- RESPOSTA

    - --authorization-mode=Node,RBAC








How many roles exist in the default namespace?

controlplane /etc/kubernetes/manifests ➜  kubectl get roles
No resources found in default namespace.

controlplane /etc/kubernetes/manifests ➜  









How many roles exist in all namespaces together?
controlplane /etc/kubernetes/manifests ➜  kubectl get roles -A | wc
     13      40    1082

controlplane /etc/kubernetes/manifests ➜  kubectl get roles -A 
NAMESPACE     NAME                                             CREATED AT
blue          developer                                        2023-10-11T18:02:59Z
kube-public   kubeadm:bootstrap-signer-clusterinfo             2023-10-11T18:01:07Z
kube-public   system:controller:bootstrap-signer               2023-10-11T18:01:05Z
kube-system   extension-apiserver-authentication-reader        2023-10-11T18:01:05Z
kube-system   kube-proxy                                       2023-10-11T18:01:09Z
kube-system   kubeadm:kubelet-config                           2023-10-11T18:01:06Z
kube-system   kubeadm:nodes-kubeadm-config                     2023-10-11T18:01:06Z
kube-system   system::leader-locking-kube-controller-manager   2023-10-11T18:01:05Z
kube-system   system::leader-locking-kube-scheduler            2023-10-11T18:01:05Z
kube-system   system:controller:bootstrap-signer               2023-10-11T18:01:05Z
kube-system   system:controller:cloud-provider                 2023-10-11T18:01:05Z
kube-system   system:controller:token-cleaner                  2023-10-11T18:01:05Z

controlplane /etc/kubernetes/manifests ➜  

- RESPOSTA
12