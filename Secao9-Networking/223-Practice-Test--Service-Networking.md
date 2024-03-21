
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m " 223. Practice Test - Service Networking."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##   223. Practice Test - Service Networking


What network range are the nodes in the cluster part of?


controlplane ~ ➜  kubectl get nodes 
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   95m   v1.29.0
node01         Ready    <none>          94m   v1.29.0

controlplane ~ ➜  kubectl get nodes  -o wide
NAME           STATUS   ROLES           AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane   95m   v1.29.0   192.2.79.12   <none>        Ubuntu 22.04.3 LTS   5.4.0-1106-gcp   containerd://1.6.26
node01         Ready    <none>          94m   v1.29.0   192.2.79.3    <none>        Ubuntu 22.04.3 LTS   5.4.0-1106-gcp   containerd://1.6.26

controlplane ~ ➜  ps -ef | grep alloc
root        3740    3232  0 Mar20 ?        00:01:22 kube-controller-manager --allocate-node-cidrs=true --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf --bind-address=127.0.0.1 --client-ca-file=/etc/kubernetes/pki/ca.crt --cluster-cidr=10.244.0.0/16 --cluster-name=kubernetes --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt --cluster-signing-key-file=/etc/kubernetes/pki/ca.key --controllers=*,bootstrapsigner,tokencleaner --kubeconfig=/etc/kubernetes/controller-manager.conf --leader-elect=true --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --root-ca-file=/etc/kubernetes/pki/ca.crt --service-account-private-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --use-service-account-credentials=true
root        5758    5642  0 Mar20 ?        00:00:03 /home/weave/weaver --port=6783 --datapath=datapath --name=0e:18:29:0c:3d:dc --http-addr=127.0.0.1:6784 --metrics-addr=0.0.0.0:6782 --docker-api= --no-dns --db-prefix=/weavedb/weave-net --ipalloc-range=10.244.0.0/16 --nickname=controlplane --ipalloc-init consensus=0 --conn-limit=200 --expect-npc --no-masq-local
root       13353   13083  0 01:20 pts/0    00:00:00 grep --color=auto alloc

controlplane ~ ➜  








What is the range of IP addresses configured for PODs on this cluster?

--ipalloc-range=10.244.0.0/16 







What is the IP Range configured for the services within the cluster?



controlplane ~ ➜  kubectl get svc -A
NAMESPACE     NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
default       kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  96m
kube-system   kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   96m

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE
kube-system   coredns-69f9c977-kmmmb                 1/1     Running   0             96m
kube-system   coredns-69f9c977-x6fb4                 1/1     Running   0             96m
kube-system   etcd-controlplane                      1/1     Running   0             97m
kube-system   kube-apiserver-controlplane            1/1     Running   0             97m
kube-system   kube-controller-manager-controlplane   1/1     Running   0             97m
kube-system   kube-proxy-dm8df                       1/1     Running   0             96m
kube-system   kube-proxy-fl992                       1/1     Running   0             96m
kube-system   kube-scheduler-controlplane            1/1     Running   0             97m
kube-system   weave-net-kvfg2                        2/2     Running   1 (96m ago)   96m
kube-system   weave-net-nngzd                        2/2     Running   0             96m

controlplane ~ ➜  kubectl describe pod coredns-69f9c977-kmmmb -n kube-system
Name:                 coredns-69f9c977-kmmmb
Namespace:            kube-system
Priority:             2000000000
Priority Class Name:  system-cluster-critical
Service Account:      coredns
Node:                 controlplane/192.2.79.12
Start Time:           Wed, 20 Mar 2024 23:44:59 +0000
Labels:               k8s-app=kube-dns
                      pod-template-hash=69f9c977
Annotations:          <none>
Status:               Running
IP:                   10.244.0.3
IPs:
  IP:           10.244.0.3
Controlled By:  ReplicaSet/coredns-69f9c977
Containers:
  coredns:
    Container ID:  containerd://cc6d99f9c13fcbbd28f976c69ced1cc2d67c2b5f4c128f256f1e5afdce6a364c
    Image:         registry.k8s.io/coredns/coredns:v1.10.1
    Image ID:      registry.k8s.io/coredns/coredns@sha256:a0ead06651cf580044aeb0a0feba63591858fb2e43ade8c9dea45a6a89ae7e5e
    Ports:         53/UDP, 53/TCP, 9153/TCP
    Host Ports:    0/UDP, 0/TCP, 0/TCP
    Args:
      -conf
      /etc/coredns/Corefile
    State:          Running
      Started:      Wed, 20 Mar 2024 23:45:11 +0000
    Ready:          True
    Restart Count:  0
    Limits:
      memory:  170Mi
    Requests:
      cpu:        100m
      memory:     70Mi
    Liveness:     http-get http://:8080/health delay=60s timeout=5s period=10s #success=1 #failure=5
    Readiness:    http-get http://:8181/ready delay=0s timeout=1s period=10s #success=1 #failure=3
    Environment:  <none>
    Mounts:
      /etc/coredns from config-volume (ro)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-q7hwf (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  config-volume:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      coredns
    Optional:  false
  kube-api-access-q7hwf:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              kubernetes.io/os=linux
Tolerations:                 CriticalAddonsOnly op=Exists
                             node-role.kubernetes.io/control-plane:NoSchedule
                             node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pod coredns-69f9c977-kmmmb -n kube-system
NAME                     READY   STATUS    RESTARTS   AGE
coredns-69f9c977-kmmmb   1/1     Running   0          97m

controlplane ~ ➜  kubectl get pod coredns-69f9c977-kmmmb -n kube-system -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2024-03-20T23:44:55Z"
  generateName: coredns-69f9c977-
  labels:
    k8s-app: kube-dns
    pod-template-hash: 69f9c977
  name: coredns-69f9c977-kmmmb
  namespace: kube-system
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: coredns-69f9c977
    uid: 802dc6ea-338b-4f79-95d7-2afc62f75626
  resourceVersion: "495"
  uid: aa3a64c8-c0ef-4123-9af2-bad3a1c86e77
spec:
  affinity:
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - podAffinityTerm:
          labelSelector:
            matchExpressions:
            - key: k8s-app
              operator: In
              values:
              - kube-dns
          topologyKey: kubernetes.io/hostname
        weight: 100
  containers:
  - args:
    - -conf
    - /etc/coredns/Corefile
    image: registry.k8s.io/coredns/coredns:v1.10.1
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 5
      httpGet:
        path: /health
        port: 8080
        scheme: HTTP
      initialDelaySeconds: 60
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 5
    name: coredns
    ports:
    - containerPort: 53
      name: dns
      protocol: UDP
    - containerPort: 53
      name: dns-tcp
      protocol: TCP
    - containerPort: 9153
      name: metrics
      protocol: TCP
    readinessProbe:
      failureThreshold: 3
      httpGet:
        path: /ready
        port: 8181
        scheme: HTTP
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 1
    resources:
      limits:
        memory: 170Mi
      requests:
        cpu: 100m
        memory: 70Mi
    securityContext:
      allowPrivilegeEscalation: false
      capabilities:
        add:
        - NET_BIND_SERVICE
        drop:
        - ALL
      readOnlyRootFilesystem: true
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /etc/coredns
      name: config-volume
      readOnly: true
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-q7hwf
      readOnly: true
  dnsPolicy: Default
  enableServiceLinks: true
  nodeName: controlplane
  nodeSelector:
    kubernetes.io/os: linux
  preemptionPolicy: PreemptLowerPriority
  priority: 2000000000
  priorityClassName: system-cluster-critical
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: coredns
  serviceAccountName: coredns
  terminationGracePeriodSeconds: 30
  tolerations:
  - key: CriticalAddonsOnly
    operator: Exists
  - effect: NoSchedule
    key: node-role.kubernetes.io/control-plane
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - configMap:
      defaultMode: 420
      items:
      - key: Corefile
        path: Corefile
      name: coredns
    name: config-volume
  - name: kube-api-access-q7hwf
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
    lastTransitionTime: "2024-03-20T23:45:11Z"
    status: "True"
    type: PodReadyToStartContainers
  - lastProbeTime: null
    lastTransitionTime: "2024-03-20T23:44:59Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2024-03-20T23:45:19Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2024-03-20T23:45:19Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2024-03-20T23:44:59Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://cc6d99f9c13fcbbd28f976c69ced1cc2d67c2b5f4c128f256f1e5afdce6a364c
    image: registry.k8s.io/coredns/coredns:v1.10.1
    imageID: registry.k8s.io/coredns/coredns@sha256:a0ead06651cf580044aeb0a0feba63591858fb2e43ade8c9dea45a6a89ae7e5e
    lastState: {}
    name: coredns
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2024-03-20T23:45:11Z"
  hostIP: 192.2.79.12
  hostIPs:
  - ip: 192.2.79.12
  phase: Running
  podIP: 10.244.0.3
  podIPs:
  - ip: 10.244.0.3
  qosClass: Burstable
  startTime: "2024-03-20T23:44:59Z"

controlplane ~ ➜  
















How many kube-proxy pods are deployed in this cluster?


controlplane ~ ✖ kubectl get pods -A | grep proxy
kube-system   kube-proxy-dm8df                       1/1     Running   0             99m
kube-system   kube-proxy-fl992                       1/1     Running   0             98m

controlplane ~ ➜  ssh node01

node01 ~ ✖ crictl ps
CONTAINER           IMAGE               CREATED             STATE               NAME                ATTEMPT             POD ID              POD
152cdf2b148d9       7f92d556d4ffe       2 hours ago         Running             weave-npc           0                   d5076ab81ab34       weave-net-nngzd
928ee6b06f41d       df29c0a4002c0       2 hours ago         Running             weave               0                   d5076ab81ab34       weave-net-nngzd
20b21a6b4a231       98262743b26f9       2 hours ago         Running             kube-proxy          0                   1f533bf405b10       kube-proxy-fl992

node01 ~ ➜  















What type of proxy is the kube-proxy configured to use?


node01 ~ ➜  iptables --list
# Warning: iptables-legacy tables present, use iptables-legacy to see them
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         
KUBE-PROXY-FIREWALL  all  --  anywhere             anywhere             ctstate NEW /* kubernetes load balancer firewall */
KUBE-NODEPORTS  all  --  anywhere             anywhere             /* kubernetes health check service ports */
KUBE-EXTERNAL-SERVICES  all  --  anywhere             anywhere             ctstate NEW /* kubernetes externally-visible service portals */
KUBE-FIREWALL  all  --  anywhere             anywhere            
DROP       tcp  --  anywhere             localhost            tcp dpt:6784 ADDRTYPE match src-type !LOCAL ! ctstate RELATED,ESTABLISHED /* Block non-local access to Weave Net control port */
WEAVE-NPC-EGRESS  all  --  anywhere             anywhere            

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         
WEAVE-NPC-EGRESS  all  --  anywhere             anywhere             /* NOTE: this must go before '-j KUBE-FORWARD' */
WEAVE-NPC  all  --  anywhere             anywhere             /* NOTE: this must go before '-j KUBE-FORWARD' */
NFLOG      all  --  anywhere             anywhere             state NEW nflog-group 86
DROP       all  --  anywhere             anywhere            
ACCEPT     all  --  anywhere             anywhere            
ACCEPT     all  --  anywhere             anywhere             ctstate RELATED,ESTABLISHED
KUBE-PROXY-FIREWALL  all  --  anywhere             anywhere             ctstate NEW /* kubernetes load balancer firewall */
KUBE-FORWARD  all  --  anywhere             anywhere             /* kubernetes forwarding rules */
KUBE-SERVICES  all  --  anywhere             anywhere             ctstate NEW /* kubernetes service portals */
KUBE-EXTERNAL-SERVICES  all  --  anywhere             anywhere             ctstate NEW /* kubernetes externally-visible service portals */

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
KUBE-PROXY-FIREWALL  all  --  anywhere             anywhere             ctstate NEW /* kubernetes load balancer firewall */
KUBE-SERVICES  all  --  anywhere             anywhere             ctstate NEW /* kubernetes service portals */
KUBE-FIREWALL  all  --  anywhere             anywhere            

Chain KUBE-EXTERNAL-SERVICES (2 references)
target     prot opt source               destination         

Chain KUBE-FIREWALL (2 references)
target     prot opt source               destination         
DROP       all  -- !127.0.0.0/8          127.0.0.0/8          /* block incoming localnet connections */ ! ctstate RELATED,ESTABLISHED,DNAT

Chain KUBE-FORWARD (1 references)
target     prot opt source               destination         
DROP       all  --  anywhere             anywhere             ctstate INVALID
ACCEPT     all  --  anywhere             anywhere             /* kubernetes forwarding rules */
ACCEPT     all  --  anywhere             anywhere             /* kubernetes forwarding conntrack rule */ ctstate RELATED,ESTABLISHED

Chain KUBE-KUBELET-CANARY (0 references)
target     prot opt source               destination         

Chain KUBE-NODEPORTS (1 references)
target     prot opt source               destination         

Chain KUBE-PROXY-CANARY (0 references)
target     prot opt source               destination         

Chain KUBE-PROXY-FIREWALL (3 references)
target     prot opt source               destination         

Chain KUBE-SERVICES (2 references)
target     prot opt source               destination         

Chain WEAVE-CANARY (0 references)
target     prot opt source               destination         

Chain WEAVE-NPC (1 references)
target     prot opt source               destination         
ACCEPT     all  --  anywhere             anywhere             state RELATED,ESTABLISHED
ACCEPT     all  --  anywhere             base-address.mcast.net/4 
ACCEPT     all  --  anywhere             anywhere             PHYSDEV match --physdev-out vethwe-bridge --physdev-is-bridged
WEAVE-NPC-DEFAULT  all  --  anywhere             anywhere             state NEW
WEAVE-NPC-INGRESS  all  --  anywhere             anywhere             state NEW

Chain WEAVE-NPC-DEFAULT (1 references)
target     prot opt source               destination         
ACCEPT     all  --  anywhere             anywhere             match-set weave-;rGqyMIl1HN^cfDki~Z$3]6!N dst /* DefaultAllow ingress isolation for namespace: default */
ACCEPT     all  --  anywhere             anywhere             match-set weave-]B*(W?)t*z5O17G044[gUo#$l dst /* DefaultAllow ingress isolation for namespace: kube-node-lease */
ACCEPT     all  --  anywhere             anywhere             match-set weave-Rzff}h:=]JaaJl/G;(XJpGjZ[ dst /* DefaultAllow ingress isolation for namespace: kube-public */
ACCEPT     all  --  anywhere             anywhere             match-set weave-P.B|!ZhkAr5q=XZ?3}tMBA+0 dst /* DefaultAllow ingress isolation for namespace: kube-system */

Chain WEAVE-NPC-EGRESS (2 references)
target     prot opt source               destination         
ACCEPT     all  --  anywhere             anywhere             state RELATED,ESTABLISHED
RETURN     all  --  anywhere             anywhere             PHYSDEV match --physdev-in vethwe-bridge --physdev-is-bridged
RETURN     all  --  anywhere             anywhere             ADDRTYPE match dst-type LOCAL
RETURN     all  --  anywhere             base-address.mcast.net/4 
WEAVE-NPC-EGRESS-DEFAULT  all  --  anywhere             anywhere             state NEW
WEAVE-NPC-EGRESS-CUSTOM  all  --  anywhere             anywhere             state NEW mark match ! 0x40000/0x40000

Chain WEAVE-NPC-EGRESS-ACCEPT (4 references)
target     prot opt source               destination         
MARK       all  --  anywhere             anywhere             MARK or 0x40000

Chain WEAVE-NPC-EGRESS-CUSTOM (1 references)
target     prot opt source               destination         

Chain WEAVE-NPC-EGRESS-DEFAULT (1 references)
target     prot opt source               destination         
WEAVE-NPC-EGRESS-ACCEPT  all  --  anywhere             anywhere             match-set weave-s_+ChJId4Uy_$}G;WdH|~TK)I src /* DefaultAllow egress isolation for namespace: default */
RETURN     all  --  anywhere             anywhere             match-set weave-s_+ChJId4Uy_$}G;WdH|~TK)I src /* DefaultAllow egress isolation for namespace: default */
WEAVE-NPC-EGRESS-ACCEPT  all  --  anywhere             anywhere             match-set weave-sui%__gZ}{kX~oZgI_Ttqp=Dp src /* DefaultAllow egress isolation for namespace: kube-node-lease */
RETURN     all  --  anywhere             anywhere             match-set weave-sui%__gZ}{kX~oZgI_Ttqp=Dp src /* DefaultAllow egress isolation for namespace: kube-node-lease */
WEAVE-NPC-EGRESS-ACCEPT  all  --  anywhere             anywhere             match-set weave-41s)5vQ^o/xWGz6a20N:~?#|E src /* DefaultAllow egress isolation for namespace: kube-public */
RETURN     all  --  anywhere             anywhere             match-set weave-41s)5vQ^o/xWGz6a20N:~?#|E src /* DefaultAllow egress isolation for namespace: kube-public */
WEAVE-NPC-EGRESS-ACCEPT  all  --  anywhere             anywhere             match-set weave-E1ney4o[ojNrLk.6rOHi;7MPE src /* DefaultAllow egress isolation for namespace: kube-system */
RETURN     all  --  anywhere             anywhere             match-set weave-E1ney4o[ojNrLk.6rOHi;7MPE src /* DefaultAllow egress isolation for namespace: kube-system */

Chain WEAVE-NPC-INGRESS (1 references)
target     prot opt source               destination         

node01 ~ ➜  


controlplane ~ ➜  ps -ef | grep proxy
root        3725    3222  0 Mar20 ?        00:04:00 kube-apiserver --advertise-address=192.2.79.12 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root        3740    3232  0 Mar20 ?        00:01:26 kube-controller-manager --allocate-node-cidrs=true --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf --bind-address=127.0.0.1 --client-ca-file=/etc/kubernetes/pki/ca.crt --cluster-cidr=10.244.0.0/16 --cluster-name=kubernetes --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt --cluster-signing-key-file=/etc/kubernetes/pki/ca.key --controllers=*,bootstrapsigner,tokencleaner --kubeconfig=/etc/kubernetes/controller-manager.conf --leader-elect=true --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --root-ca-file=/etc/kubernetes/pki/ca.crt --service-account-private-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --use-service-account-credentials=true
root        4511       1  0 Mar20 ?        00:00:00 /usr/bin/kubectl proxy --port=8888 --address=0.0.0.0 --accept-hosts=^.*$ --kubeconfig /root/.kube/config
root        4865    4623  0 Mar20 ?        00:00:01 /usr/local/bin/kube-proxy --config=/var/lib/kube-proxy/config.conf --hostname-override=controlplane
root       15091   13083  0 01:26 pts/0    00:00:00 grep --color=auto proxy

controlplane ~ ➜  ls /var/lib/
apt       cni         dbus    dpkg  gems  k0s      man-db  PackageKit  polkit-1  python   shells.state  systemd  vim
buildkit  containerd  docker  etcd  git   kubelet  misc    pam         private   rancher  sudo          ucf      weave

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS       AGE
kube-system   coredns-69f9c977-kmmmb                 1/1     Running   0              103m
kube-system   coredns-69f9c977-x6fb4                 1/1     Running   0              103m
kube-system   etcd-controlplane                      1/1     Running   0              103m
kube-system   kube-apiserver-controlplane            1/1     Running   0              103m
kube-system   kube-controller-manager-controlplane   1/1     Running   0              103m
kube-system   kube-proxy-dm8df                       1/1     Running   0              103m
kube-system   kube-proxy-fl992                       1/1     Running   0              102m
kube-system   kube-scheduler-controlplane            1/1     Running   0              103m
kube-system   weave-net-kvfg2                        2/2     Running   1 (103m ago)   103m
kube-system   weave-net-nngzd                        2/2     Running   0              102m

controlplane ~ ➜  kubectl describe pod kube-proxy-dm8df -n kube-system
Name:                 kube-proxy-dm8df
Namespace:            kube-system
Priority:             2000001000
Priority Class Name:  system-node-critical
Service Account:      kube-proxy
Node:                 controlplane/192.2.79.12
Start Time:           Wed, 20 Mar 2024 23:44:55 +0000
Labels:               controller-revision-hash=7958dbcbd9
                      k8s-app=kube-proxy
                      pod-template-generation=1
Annotations:          <none>
Status:               Running
IP:                   192.2.79.12
IPs:
  IP:           192.2.79.12
Controlled By:  DaemonSet/kube-proxy
Containers:
  kube-proxy:
    Container ID:  containerd://0130df208f6abfe393dae01f3bfe99216cbf04e307f62168a2df2d34c933c563
    Image:         registry.k8s.io/kube-proxy:v1.29.0
    Image ID:      registry.k8s.io/kube-proxy@sha256:8da4de35c4929411300eb8052fdfd34095b6090ed0c8dbc776d58bf1c61a2c89
    Port:          <none>
    Host Port:     <none>
    Command:
      /usr/local/bin/kube-proxy
      --config=/var/lib/kube-proxy/config.conf
      --hostname-override=$(NODE_NAME)
    State:          Running
      Started:      Wed, 20 Mar 2024 23:44:56 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      NODE_NAME:   (v1:spec.nodeName)
    Mounts:
      /lib/modules from lib-modules (ro)
      /run/xtables.lock from xtables-lock (rw)
      /var/lib/kube-proxy from kube-proxy (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-sb6b5 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-proxy:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      kube-proxy
    Optional:  false
  xtables-lock:
    Type:          HostPath (bare host directory volume)
    Path:          /run/xtables.lock
    HostPathType:  FileOrCreate
  lib-modules:
    Type:          HostPath (bare host directory volume)
    Path:          /lib/modules
    HostPathType:  
  kube-api-access-sb6b5:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              kubernetes.io/os=linux
Tolerations:                 op=Exists
                             node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/network-unavailable:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists
Events:                      <none>

controlplane ~ ➜  


et configmap
NAME               DATA   AGE
kube-root-ca.crt   1      104m

controlplane ~ ➜  kubectl get configmap -A
NAMESPACE         NAME                                                   DATA   AGE
default           kube-root-ca.crt                                       1      104m
kube-node-lease   kube-root-ca.crt                                       1      104m
kube-public       cluster-info                                           3      104m
kube-public       kube-root-ca.crt                                       1      104m
kube-system       coredns                                                1      104m
kube-system       extension-apiserver-authentication                     6      104m
kube-system       kube-apiserver-legacy-service-account-token-tracking   1      104m
kube-system       kube-proxy                                             2      104m
kube-system       kube-root-ca.crt                                       1      104m
kube-system       kubeadm-config                                         1      104m
kube-system       kubelet-config                                         1      104m
kube-system       weave-net                                              0      104m

controlplane ~ ➜  
controlplane ~ ➜  kubectl get configmap kube-proxy -n kube-system
NAME         DATA   AGE
kube-proxy   2      104m

controlplane ~ ➜  kubectl get configmap kube-proxy -n kube-system -o yaml
apiVersion: v1
data:
  config.conf: |-
    apiVersion: kubeproxy.config.k8s.io/v1alpha1
    bindAddress: 0.0.0.0
    bindAddressHardFail: false
    clientConnection:
      acceptContentTypes: ""
      burst: 0
      contentType: ""
      kubeconfig: /var/lib/kube-proxy/kubeconfig.conf
      qps: 0
    clusterCIDR: 10.244.0.0/16
    configSyncPeriod: 0s
    conntrack:
      maxPerCore: null
      min: null
      tcpBeLiberal: false
      tcpCloseWaitTimeout: null
      tcpEstablishedTimeout: null
      udpStreamTimeout: 0s
      udpTimeout: 0s
    detectLocal:
      bridgeInterface: ""
      interfaceNamePrefix: ""
    detectLocalMode: ""
    enableProfiling: false
    healthzBindAddress: ""
    hostnameOverride: ""
    iptables:
      localhostNodePorts: null
      masqueradeAll: false
      masqueradeBit: null
      minSyncPeriod: 0s
      syncPeriod: 0s
    ipvs:
      excludeCIDRs: null
      minSyncPeriod: 0s
      scheduler: ""
      strictARP: false
      syncPeriod: 0s
      tcpFinTimeout: 0s
      tcpTimeout: 0s
      udpTimeout: 0s
    kind: KubeProxyConfiguration
    logging:
      flushFrequency: 0
      options:
        json:
          infoBufferSize: "0"
      verbosity: 0
    metricsBindAddress: ""
    mode: ""
    nftables:
      masqueradeAll: false
      masqueradeBit: null
      minSyncPeriod: 0s
      syncPeriod: 0s
    nodePortAddresses: null
    oomScoreAdj: null
    portRange: ""
    showHiddenMetricsForVersion: ""
    winkernel:
      enableDSR: false
      forwardHealthCheckVip: false
      networkName: ""
      rootHnsEndpointName: ""
      sourceVip: ""
  kubeconfig.conf: |-
    apiVersion: v1
    kind: Config
    clusters:
    - cluster:
        certificate-authority: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        server: https://controlplane:6443
      name: default
    contexts:
    - context:
        cluster: default
        namespace: default
        user: default
      name: default
    current-context: default
    users:
    - name: default
      user:
        tokenFile: /var/run/secrets/kubernetes.io/serviceaccount/token
kind: ConfigMap
metadata:
  annotations:
    kubeadm.kubernetes.io/component-config.hash: sha256:a58bc934e3784937e225f9d601a6a87d49d87707757c3825c91340be984ace5a
  creationTimestamp: "2024-03-20T23:44:42Z"
  labels:
    app: kube-proxy
  name: kube-proxy
  namespace: kube-system
  resourceVersion: "268"
  uid: 58ed69c1-d4e4-46a6-98de-6ba1d50a2746

controlplane ~ ➜  


















How does this Kubernetes cluster ensure that a kube-proxy pod runs on all nodes in the cluster?

Inspect the kube-proxy pods and try to identify how they are deployed.
