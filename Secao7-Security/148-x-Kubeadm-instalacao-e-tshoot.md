

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# Dia 03/09/2023


Kubeadm
https://www.padok.fr/en/blog/kubeadm-kubernetes-cluster
https://www.hostafrica.com/blog/servers/kubernetes-cluster-debian-11-containerd/
https://kubernetes.io/docs/concepts/cluster-administration/addons/
https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart#install-calico
https://docs.cilium.io/en/stable/installation/k8s-install-kubeadm/



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







Events:
  Type     Reason            Age    From               Message
  ----     ------            ----   ----               -------
  Warning  FailedScheduling  2m14s  default-scheduler  0/1 nodes are available: 1 node(s) didn't match pod anti-affinity rules. preemption: 0/1 nodes are available: 1 No preemption victims found for incoming pod..







- Verificando detalhes do Pod

~~~~bash

root@debian10x64:/home/fernando# kubectl get pod cilium-operator-788c4f69bc-jv5tk -n kube-system -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-09-03T17:03:42Z"
  generateName: cilium-operator-788c4f69bc-
  labels:
    app.kubernetes.io/name: cilium-operator
    app.kubernetes.io/part-of: cilium
    io.cilium/app: operator
    name: cilium-operator
    pod-template-hash: 788c4f69bc
  name: cilium-operator-788c4f69bc-jv5tk
  namespace: kube-system
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: cilium-operator-788c4f69bc
    uid: 157310e5-47e0-4e1f-bc3c-8e4d4dc76d15
  resourceVersion: "1345"
  uid: 7fe48837-056c-4922-9eaa-c4ba4a699f49
spec:
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            io.cilium/app: operator
        topologyKey: kubernetes.io/hostname
  automountServiceAccountToken: true
  containers:
  - args:
    - --config-dir=/tmp/cilium/config-map
    - --debug=$(CILIUM_DEBUG)
    command:
    - cilium-operator-generic
    env:
    - name: K8S_NODE_NAME
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: spec.nodeName
    - name: CILIUM_K8S_NAMESPACE
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.namespace
    - name: CILIUM_DEBUG
      valueFrom:
        configMapKeyRef:
          key: debug
          name: cilium-config
          optional: true
    image: quay.io/cilium/operator-generic:v1.14.1@sha256:e061de0a930534c7e3f8feda8330976367971238ccafff42659f104effd4b5f7
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 3
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 9234
        scheme: HTTP
      initialDelaySeconds: 60
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 3
    name: cilium-operator
    readinessProbe:
      failureThreshold: 5
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 9234
        scheme: HTTP
      periodSeconds: 5
      successThreshold: 1
      timeoutSeconds: 3
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: FallbackToLogsOnError
    volumeMounts:
    - mountPath: /tmp/cilium/config-map
      name: cilium-config-path
      readOnly: true
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-4lvf2
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  hostNetwork: true
  nodeSelector:
    kubernetes.io/os: linux
  preemptionPolicy: PreemptLowerPriority
  priority: 2000000000
  priorityClassName: system-cluster-critical
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: cilium-operator
  serviceAccountName: cilium-operator
  terminationGracePeriodSeconds: 30
  tolerations:
  - operator: Exists
  volumes:
  - configMap:
      defaultMode: 420
      name: cilium-config
    name: cilium-config-path
  - name: kube-api-access-4lvf2
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
    lastTransitionTime: "2023-09-03T17:03:42Z"
    message: '0/1 nodes are available: 1 node(s) didn''t match pod anti-affinity rules.
      preemption: 0/1 nodes are available: 1 No preemption victims found for incoming
      pod..'
    reason: Unschedulable
    status: "False"
    type: PodScheduled
  phase: Pending
  qosClass: BestEffort
root@debian10x64:/home/fernando#

~~~~







- Pod tem o podAntiAffinity abaixo:

spec:
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            io.cilium/app: operator
        topologyKey: kubernetes.io/hostname










O trecho de código que você forneceu é uma parte de um manifesto de Pod no Kubernetes e descreve a afinidade (affinity) do Pod em relação a outros Pods em relação à anti-afinidade (podAntiAffinity). Mais especificamente, ele define uma regra de anti-afinidade que instrui o Kubernetes a evitar agendar Pods deste aplicativo (io.cilium/app: operator) no mesmo nó (host) Kubernetes.

Aqui está uma explicação mais detalhada do que esse trecho de código faz:

    affinity: Isso indica que você está configurando regras de afinidade para o Pod.

    podAntiAffinity: Isso especifica que você está criando uma regra de anti-afinidade para o Pod.

    requiredDuringSchedulingIgnoredDuringExecution: Isso significa que a regra é exigida durante o agendamento dos Pods, mas pode ser ignorada após a execução.

    - labelSelector: Isso define um seletor de rótulo que identifica os Pods que devem ser considerados para a anti-afinidade. Neste caso, está procurando por Pods que tenham o rótulo io.cilium/app definido como "operator".

    topologyKey: Especifica a chave de topologia na qual a anti-afinidade deve ser aplicada. No caso, está configurado para o nome do nó (hostname) do Kubernetes, ou seja, kubernetes.io/hostname.

Portanto, esse trecho de código garante que os Pods com o rótulo io.cilium/app: operator não sejam agendados no mesmo nó Kubernetes. Isso ajuda a distribuir a carga e aumentar a disponibilidade e a tolerância a falhas, garantindo que os Pods do mesmo aplicativo não estejam todos concentrados em um único nó. Isso é particularmente útil em cenários de alta disponibilidade em que você deseja que seus aplicativos sejam distribuídos em vários nós para mitigar falhas de hardware ou manutenção programada.








- ANTES

~~~~BASH

root@debian10x64:/home/fernando# kubectl get all -n kube-system
NAME                                      READY   STATUS    RESTARTS   AGE
pod/cilium-operator-788c4f69bc-jv5tk      0/1     Pending   0          12m
pod/cilium-operator-788c4f69bc-kxc29      1/1     Running   0          12m
pod/cilium-p29l7                          1/1     Running   0          12m
pod/coredns-5dd5756b68-2d2b4              1/1     Running   0          21m
pod/coredns-5dd5756b68-cxks8              1/1     Running   0          21m
pod/etcd-debian10x64                      1/1     Running   0          21m
pod/kube-apiserver-debian10x64            1/1     Running   0          21m
pod/kube-controller-manager-debian10x64   1/1     Running   0          21m
pod/kube-proxy-vvdqq                      1/1     Running   0          21m
pod/kube-scheduler-debian10x64            1/1     Running   0          21m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                  AGE
service/hubble-peer   ClusterIP   10.97.197.189   <none>        443/TCP                  12m
service/kube-dns      ClusterIP   10.96.0.10      <none>        53/UDP,53/TCP,9153/TCP   21m

NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/cilium       1         1         1       1            1           kubernetes.io/os=linux   12m
daemonset.apps/kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   21m

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/cilium-operator   1/2     2            1           12m
deployment.apps/coredns           2/2     2            2           21m

NAME                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/cilium-operator-788c4f69bc   2         2         1       12m
replicaset.apps/coredns-5dd5756b68           2         2         2       21m
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Sun 03 Sep 2023 02:16:39 PM -03
root@debian10x64:/home/fernando#

~~~~
















https://artifacthub.io/packages/helm/cilium/cilium
<https://artifacthub.io/packages/helm/cilium/cilium>
operator.replicas	int	2	Number of replicas to run for the cilium-operator deployment








git status
git add .
git commit -m "TSHOOT - Kubeadm + Cilium."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status
