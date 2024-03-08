
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "215. Practice Test - Explore CNI"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  215. Practice Test - Explore CNI

Inspect the kubelet service and identify the container runtime endpoint value is set for Kubernetes.


controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
kube-flannel   kube-flannel-ds-f5s5z                  1/1     Running   0          5m35s
kube-system    coredns-69f9c977-kt8cb                 1/1     Running   0          5m35s
kube-system    coredns-69f9c977-nh4zn                 1/1     Running   0          5m35s
kube-system    etcd-controlplane                      1/1     Running   0          5m47s
kube-system    kube-apiserver-controlplane            1/1     Running   0          5m47s
kube-system    kube-controller-manager-controlplane   1/1     Running   0          5m47s
kube-system    kube-proxy-rhb84                       1/1     Running   0          5m35s
kube-system    kube-scheduler-controlplane            1/1     Running   0          5m47s

controlplane ~ ➜  ps -ef | grep kubelet
root        3730    3210  0 23:21 ?        00:00:17 kube-apiserver --advertise-address=192.1.68.3 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root        4281       1  0 23:21 ?        00:00:07 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock --pod-infra-container-image=registry.k8s.io/pause:3.9
root        8913    8297  0 23:27 pts/0    00:00:00 grep --color=auto kubelet

controlplane ~ ➜  

controlplane ~ ✖ cat /etc/kubernetes/kubelet.conf
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJRW1oQkRtNHY2OGd3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBek1EZ3lNekUyTWpWYUZ3MHpOREF6TURZeU16SXhNalZhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUN1WGlwVW5rbkFBMDg2R2hVWHZZSThFRHVSSzhBLzZwUCtFN0xlVVlxbmliU2ZqK2wxSG1nQ1pLZFoKYmpOMEQ0a2ppMTNUVlNKem95dmNySXlBQklQVGFsUmo5UUlsakJ1dUJ4d2czd2tVZGRiaE1mUXVnWEN4QUJlUApvUHJQend2S05UVGRXdG1weEJYT0VTWlNGbmNTQ0tHSEhmT1JlVnA4ZHlLTUdFRXkvTks0UEF5YzkwVXNWZlViCjNaMXVjd1p3WmpxRVhKZEdSNzBFQ09qQkRnVkk5M1FQelpUYWFpQmJrVnZwempBaHhZSTB3RUN1QnVEN1g4dXAKN2NEM1BPRTYvakxlcG0zY0hTSTMwVmw0d05ZeDFkWERkU1Mzdmc5RWpYb0xDcnFPZGlvVTExYTFVTXJHV0picwpOK0hLY2Q4c2NTYW9CUGZtVklsMTVQRHV6cktIQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJRTVY5US9iWXo4NWNOdGY1ektMLzVEOVlxZmF6QVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQjVzQ3dyVEtvdQpJSmtINGQ5b1hvMFZNeXZyeHJSTUtKU0VMQ1pTc2ZUTVViRlJtMTB5V3VGMzlMUlpsYzZkczdCSVN1MEhPTFhHCkZDV0ZkKzYrcDUwbkt6Mk4xWlp2MWFFN0FXdWljYjVaZzMxMUwyekVYNktnWlhMdjRBeERJZ2hhMzNFRTd5VlQKaUhaOFJuYjJHdHk5Q2c2c1NrZVhWNG5LRGI3Q3oyVGtwVHYvWEc0eUQreU92bFF2VnlXbTNLZ1VKUi9jeDhsRApPWW4xSWhSVkpyN2w1MlZVTjRZYTN4Z2NJTEhJUnhwQVNsYmFkalArZGIwSGcxTXpsQUM5bHJQdHdEdVdXMk5DClR1MGJEenljUUpyZ1BnSzM2UWl3cUNVK0dpRVFPRVRHZDBWRnI0amZyNWdDTmlSdGtjTlI2U01SZHo4dVV5SjUKWGNkVWVjQ09lR1QzCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: system:node:controlplane
  name: system:node:controlplane@kubernetes
current-context: system:node:controlplane@kubernetes
kind: Config
preferences: {}
users:
- name: system:node:controlplane
  user:
    client-certificate: /var/lib/kubelet/pki/kubelet-client-current.pem
    client-key: /var/lib/kubelet/pki/kubelet-client-current.pem

controlplane ~ ➜  


controlplane ~ ➜  cat /var/lib/kubelet/config.yaml
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    cacheTTL: 0s
    enabled: true
  x509:
    clientCAFile: /etc/kubernetes/pki/ca.crt
authorization:
  mode: Webhook
  webhook:
    cacheAuthorizedTTL: 0s
    cacheUnauthorizedTTL: 0s
cgroupDriver: systemd
clusterDNS:
- 10.96.0.10
clusterDomain: cluster.local
containerRuntimeEndpoint: ""
cpuManagerReconcilePeriod: 0s
evictionPressureTransitionPeriod: 0s
fileCheckFrequency: 0s
healthzBindAddress: 127.0.0.1
healthzPort: 10248
httpCheckFrequency: 0s
imageMaximumGCAge: 0s
imageMinimumGCAge: 0s
kind: KubeletConfiguration
logging:
  flushFrequency: 0
  options:
    json:
      infoBufferSize: "0"
  verbosity: 0
memorySwap: {}
nodeStatusReportFrequency: 0s
nodeStatusUpdateFrequency: 0s
resolvConf: /run/systemd/resolve/resolv.conf
rotateCertificates: true
runtimeRequestTimeout: 0s
shutdownGracePeriod: 0s
shutdownGracePeriodCriticalPods: 0s
staticPodPath: /etc/kubernetes/manifests
streamingConnectionIdleTimeout: 0s
syncFrequency: 0s
volumeStatsAggPeriod: 0s

controlplane ~ ➜  

controlplane ~ ➜  ps -ef | grep kubelet | grep runtime
root        4281       1  0 23:21 ?        00:00:08 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock --pod-infra-container-image=registry.k8s.io/pause:3.9

controlplane ~ ➜  

--container-runtime-endpoint=unix:///var/run/containerd/containerd.sock










What is the path configured with all binaries of CNI supported plugins?


controlplane ~ ➜  ls /etc/cni/net.d/
10-flannel.conflist

controlplane ~ ➜  
controlplane ~ ➜  ls /opt/cni/bin/
bandwidth  bridge  dhcp  dummy  firewall  flannel  host-device  host-local  ipvlan  loopback  macvlan  portmap  ptp  sbr  static  tap  tuning  vlan  vrf

controlplane ~ ➜  





Identify which of the below plugins is not available in the list of available CNI plugins on this host?

cisco




What is the CNI plugin configured to be used on this kubernetes cluster?

What is the CNI plugin configured to be used on this kubernetes cluster?

controlplane ~ ➜  ls /etc/cni/net.d/
10-flannel.conflist

flannel




What binary executable file will be run by kubelet after a container and its associated namespace are created?

flannel


