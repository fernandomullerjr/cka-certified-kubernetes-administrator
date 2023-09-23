


# ############################################################################
# ############################################################################
# ############################################################################
#  Dia 03/09/2023



# ############################################################################
# ############################################################################
# ############################################################################
# Kubeadm
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







root@debian10x64:/home/fernando# ^C
root@debian10x64:/home/fernando# helm ls -A
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
cilium  kube-system     1               2023-09-03 14:03:41.764492047 -0300 -03 deployed        cilium-1.14.1   1.14.1

root@debian10x64:/home/fernando# helm get values cilium -n kube-system
USER-SUPPLIED VALUES:
null
root@debian10x64:/home/fernando#



helm upgrade minhaapi /home/fernando/cursos/helm-cursos/DevOps-Pro-Helm/009-Material-chart-novo/api-produto
helm upgrade minhaapi /home/fernando/cursos/helm-cursos/DevOps-Pro-Helm/009-Material-chart-novo/api-produto








Para ajustar o número de réplicas do operador Cilium usando o Helm, você pode seguir estas etapas:

    Primeiro, você precisa criar ou editar um arquivo de valores personalizados do Helm. Esse arquivo conterá os valores que você deseja substituir ou adicionar ao gráfico Helm padrão do Cilium. Você pode criar um arquivo chamado cilium-values.yaml ou escolher qualquer outro nome de sua preferência.

    Abra o arquivo cilium-values.yaml e adicione o seguinte conteúdo, substituindo <número de réplicas desejado> pelo número de réplicas que você deseja para o operador Cilium:

yaml

operator:
  replicas: <número de réplicas desejado>

    Agora, você pode instalar ou atualizar o gráfico Helm do Cilium, passando o arquivo de valores personalizados que você acabou de criar. Certifique-se de substituir cilium pelo nome do release que você deseja usar:

bash

helm upgrade --install cilium cilium/cilium -f cilium-values.yaml

Isso irá instalar ou atualizar o gráfico Helm do Cilium com o número de réplicas especificado para o operador Cilium.

Lembre-se de que o Helm é uma ferramenta poderosa para gerenciar aplicativos no Kubernetes, e os valores no arquivo cilium-values.yaml não se limitam apenas ao número de réplicas. Você pode personalizar muitos outros aspectos do seu ambiente Cilium usando esse arquivo de valores personalizados. Certifique-se de verificar a documentação do gráfico Helm do Cilium para obter informações detalhadas sobre as opções de configuração disponíveis.





- Ajustando número de réplicas do Cilium:

helm upgrade --install cilium cilium/cilium -n kube-system -f /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/148-x-cilium-values.yaml

~~~~bash
root@debian10x64:/home/fernando# helm upgrade --install cilium cilium/cilium -n kube-system -f /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/148-x-cilium-values.yaml
Release "cilium" has been upgraded. Happy Helming!
NAME: cilium
LAST DEPLOYED: Sun Sep  3 14:23:34 2023
NAMESPACE: kube-system
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
You have successfully installed Cilium with Hubble.

Your release version is 1.14.1.

For any further help, visit https://docs.cilium.io/en/v1.14/gettinghelp
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Sun 03 Sep 2023 02:23:37 PM -03
root@debian10x64:/home/fernando# helm ls -A
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
cilium  kube-system     2               2023-09-03 14:23:34.279418209 -0300 -03 deployed        cilium-1.14.1   1.14.1
root@debian10x64:/home/fernando#

~~~~




- Status do Cilium

~~~~bash

root@debian10x64:/home/fernando# cilium status --wait
    /¯¯\
 /¯¯\__/¯¯\    Cilium:             OK
 \__/¯¯\__/    Operator:           OK
 /¯¯\__/¯¯\    Envoy DaemonSet:    disabled (using embedded mode)
 \__/¯¯\__/    Hubble Relay:       disabled
    \__/       ClusterMesh:        disabled

Deployment             cilium-operator    Desired: 1, Ready: 1/1, Available: 1/1
DaemonSet              cilium             Desired: 1, Ready: 1/1, Available: 1/1
Containers:            cilium             Running: 1
                       cilium-operator    Running: 1
Cluster Pods:          2/5 managed by Cilium
Helm chart version:    1.14.1
Image versions         cilium-operator    quay.io/cilium/operator-generic:v1.14.1@sha256:e061de0a930534c7e3f8feda8330976367971238ccafff42659f104effd4b5f7: 1
                       cilium             quay.io/cilium/cilium:v1.14.1@sha256:edc1d05ea1365c4a8f6ac6982247d5c145181704894bb698619c3827b6963a72: 1
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Sun 03 Sep 2023 02:24:35 PM -03
root@debian10x64:/home/fernando#

~~~~






- Testando

~~~~bash
root@debian10x64:/home/fernando# cilium connectivity test
ℹ️  Single-node environment detected, enabling single-node connectivity test
ℹ️  Monitor aggregation detected, will skip some flow validation steps
⌛ [kubernetes] Waiting for deployment cilium-test/client to become ready...

root@debian10x64:/home/fernando# cilium connectivity test
ℹ️  Single-node environment detected, enabling single-node connectivity test
ℹ️  Monitor aggregation detected, will skip some flow validation steps
⌛ [kubernetes] Waiting for deployment cilium-test/client to become ready...
connectivity test failed: timeout reached waiting for deployment cilium-test/client to become ready (last error: only 0 of 1 replicas are available)
root@debian10x64:/home/fernando#

root@debian10x64:/home/fernando# kubectl get pods -n cilium-test
NAME                                                     READY   STATUS    RESTARTS   AGE
client-78f9dffc84-47nmp                                  0/1     Pending   0          26m
client2-59b578d4bb-rqhc6                                 0/1     Pending   0          26m
echo-a-846dcb4-xpvqc                                     0/1     Pending   0          8s
echo-b-58f67d5b86-5x9v4                                  0/1     Pending   0          8s
echo-b-host-84d7468c8d-kqgkq                             0/1     Pending   0          8s
echo-same-node-79d996cb79-tc7s4                          0/2     Pending   0          26m
host-to-b-multi-node-clusterip-b98ff785c-ktgsr           0/1     Pending   0          7s
host-to-b-multi-node-headless-5c55d85dfc-wbgkk           0/1     Pending   0          6s
pod-to-a-6b996b7675-dl842                                0/1     Pending   0          8s
pod-to-a-allowed-cnp-c958b55bf-c2qhj                     0/1     Pending   0          7s
pod-to-a-denied-cnp-6d9b8cbff5-fs8ph                     0/1     Pending   0          8s
pod-to-b-intra-node-nodeport-5f9c4c866f-b2pgp            0/1     Pending   0          6s
pod-to-b-multi-node-clusterip-7cb4bf5495-h4mp8           0/1     Pending   0          7s
pod-to-b-multi-node-headless-68975fc557-74xts            0/1     Pending   0          7s
pod-to-b-multi-node-nodeport-559c54c6fc-q5wn9            0/1     Pending   0          6s
pod-to-external-1111-5c4cfd9497-hzsqp                    0/1     Pending   0          8s
pod-to-external-fqdn-allow-google-cnp-7d65d9b747-sk2r8   0/1     Pending   0          7s
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Sun 03 Sep 2023 02:31:35 PM -03
root@debian10x64:/home/fernando#



root@debian10x64:/home/fernando# kubectl describe pod pod-to-b-multi-node-clusterip-7cb4bf5495-h4mp8 -n cilium-test

                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  61s   default-scheduler  0/1 nodes are available: 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling..
root@debian10x64:/home/fernando#
~~~~




## PENDENTE

- Ver sobre
Cluster Pods:          2/5 managed by Cilium










Estou tomando o erro abaixo nos Pods do Cilium.
Como posso fazer para utilizar o Cilium num cluster com apenas 1 node para tudo?

"
  Warning  FailedScheduling  61s   default-scheduler  0/1 nodes are available: 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling.."
ChatGPT

O erro que você está enfrentando é devido a um problema de programação no Kubernetes. O taint que está causando esse problema é node-role.kubernetes.io/control-plane, que é aplicado automaticamente a nós que desempenham o papel de control plane (mestre) no cluster Kubernetes. Nós de control plane são geralmente reservados para componentes internos do Kubernetes e não são recomendados para a execução de aplicativos de usuário.

Se você deseja executar o Cilium em um cluster Kubernetes com apenas um nó (single-node cluster), você pode fazer o seguinte:

Importante: Lembre-se de que um único nó Kubernetes não é a configuração recomendada para um ambiente de produção, pois não oferece alta disponibilidade ou tolerância a falhas.

    Remova o taint de control plane: Você pode remover o taint do nó para permitir que os Pods sejam programados nele. Use o seguinte comando para remover o taint do nó:

bash

kubectl taint nodes <nome-do-seu-nodo> node-role.kubernetes.io/control-plane:NoSchedule-

Substitua <nome-do-seu-nodo> pelo nome do nó onde você deseja executar o Cilium. Isso permitirá que os Pods sejam agendados nesse nó.

    Instale o Cilium: Após remover o taint, você pode instalar o Cilium normalmente no seu cluster, usando Helm ou qualquer outra abordagem que você preferir.

Lembre-se de que, ao executar um único nó Kubernetes, você não terá a mesma alta disponibilidade e tolerância a falhas que um cluster de vários nós proporcionaria. Certifique-se de entender os riscos associados a essa configuração e considere migrar para um ambiente de vários nós se for adequado para o seu caso de uso.










kubectl taint nodes <nome-do-seu-nodo> node-role.kubernetes.io/control-plane:NoSchedule-








Estou tomando o erro abaixo nos Pods do Cilium.
Como posso fazer para utilizar o Cilium num cluster com apenas 1 node para tudo?

"
  Warning  FailedScheduling  61s   default-scheduler  0/1 nodes are available: 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling.."
ChatGPT
2 / 2

O erro que você está enfrentando é devido a um taint aplicado ao seu nó único do Kubernetes que impede que os Pods sejam agendados nele. O taint com a chave node-role.kubernetes.io/control-plane indica que o nó é destinado a ser um nó de plano de controle e não deve ser usado para fins de execução de carga de trabalho regular.

Se você deseja executar Pods do Cilium em um cluster com apenas 1 nó, você precisará remover ou modificar esse taint no nó. No entanto, é importante entender que, em um cluster com apenas 1 nó, você não terá a capacidade de alta disponibilidade e tolerância a falhas que é uma das principais vantagens do Kubernetes.

Para remover o taint do nó único, você pode seguir estas etapas:

    Identifique o nome do nó único onde você deseja remover o taint. Você pode fazer isso executando o seguinte comando:

bash

kubectl get nodes

    Remova o taint usando o comando kubectl taint com a opção node-role.kubernetes.io/control-plane-.

bash

kubectl taint nodes <nome-do-nó> node-role.kubernetes.io/control-plane-

Por exemplo, se o nome do seu nó único for my-node, o comando seria:

bash

kubectl taint nodes my-node node-role.kubernetes.io/control-plane-

Isso removerá o taint do nó, permitindo que os Pods do Cilium sejam agendados nele.

Lembre-se de que, embora seja possível executar um único nó Kubernetes para fins de teste ou desenvolvimento, isso não é recomendado para ambientes de produção, pois elimina a capacidade de alta disponibilidade do Kubernetes. Certifique-se de entender as implicações antes de prosseguir com essa configuração.











- ANTES

~~~~bash
root@debian10x64:/home/fernando# kubectl describe node debian10x64
Name:               debian10x64
Roles:              control-plane
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=debian10x64
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/control-plane=
                    node.kubernetes.io/exclude-from-external-load-balancers=
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Sun, 03 Sep 2023 13:55:17 -0300
Taints:             node-role.kubernetes.io/control-plane:NoSchedule
~~~~






With a taint on a node we can repel Pods as we saw on the post regarding taints and tolerations. So, if we want to taint a node we use kubectl taint as follows:

$ kubectl taint nodes minikube application=example:NoSchedule
node/minikube tainted

How do we untaint a node?

We can use kubectl taint but adding an hyphen at the end to remove the taint (untaint the node):

$ kubectl taint nodes minikube application=example:NoSchedule-
node/minikubee untainted






- Removendo

kubectl taint nodes debian10x64 node-role.kubernetes.io/control-plane-








- DEPOIS

~~~~bash
root@debian10x64:/home/fernando# kubectl taint nodes debian10x64 node-role.kubernetes.io/control-plane-
node/debian10x64 untainted
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# date
Sun 03 Sep 2023 02:40:57 PM -03
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl describe node debian10x64
Name:               debian10x64
Roles:              control-plane
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=debian10x64
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/control-plane=
                    node.kubernetes.io/exclude-from-external-load-balancers=
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Sun, 03 Sep 2023 13:55:17 -0300
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  debian10x64
  AcquireTime:     <unset>
  RenewTime:       Sun, 03 Sep 2023 14:40:52 -0300
~~~~









- Pods de teste do Cilium, alguns NÃO-OK

~~~~BASH
^Croot@debian10x64:/home/fernando# kubectl get pods -n cilium-test
NAME                                                     READY   STATUS                   RESTARTS   AGE
client-78f9dffc84-47nmp                                  1/1     Running                  0          39m
client2-59b578d4bb-rqhc6                                 1/1     Running                  0          39m
echo-a-846dcb4-xpvqc                                     0/1     ContainerStatusUnknown   1          12m
echo-a-846dcb4-ztrdf                                     0/1     Pending                  0          34s
echo-b-58f67d5b86-4fl75                                  0/1     Pending                  0          66s
echo-b-58f67d5b86-5x9v4                                  0/1     Error                    0          12m
echo-b-host-84d7468c8d-kqgkq                             0/1     ContainerStatusUnknown   1          12m
echo-b-host-84d7468c8d-vlw5x                             0/1     Pending                  0          2s
echo-same-node-79d996cb79-fqcq6                          0/2     Pending                  0          98s
echo-same-node-79d996cb79-tc7s4                          0/2     ContainerStatusUnknown   2          39m
host-to-b-multi-node-clusterip-b98ff785c-ktgsr           0/1     Pending                  0          12m
host-to-b-multi-node-headless-5c55d85dfc-wbgkk           0/1     Pending                  0          12m
pod-to-a-6b996b7675-dl842                                0/1     Running                  0          12m
pod-to-a-allowed-cnp-c958b55bf-c2qhj                     0/1     Running                  0          12m
pod-to-a-denied-cnp-6d9b8cbff5-fs8ph                     1/1     Running                  0          12m
pod-to-b-intra-node-nodeport-5f9c4c866f-4vm59            0/1     Pending                  0          2m10s
pod-to-b-intra-node-nodeport-5f9c4c866f-b2pgp            0/1     Error                    0          12m
pod-to-b-multi-node-clusterip-7cb4bf5495-h4mp8           0/1     Pending                  0          12m
pod-to-b-multi-node-headless-68975fc557-74xts            0/1     Pending                  0          12m
pod-to-b-multi-node-nodeport-559c54c6fc-q5wn9            0/1     Pending                  0          12m
pod-to-external-1111-5c4cfd9497-hzsqp                    1/1     Running                  0          12m
pod-to-external-fqdn-allow-google-cnp-7d65d9b747-sk2r8   1/1     Running                  0          12m
root@debian10x64:/home/fernando# cilium connectivity test
ℹ️  Single-node environment detected, enabling single-node connectivity test
ℹ️  Monitor aggregation detected, will skip some flow validation steps
⌛ [kubernetes] Waiting for deployment cilium-test/client to become ready...
⌛ [kubernetes] Waiting for deployment cilium-test/client2 to become ready...
⌛ [kubernetes] Waiting for deployment cilium-test/echo-same-node to become ready...


~~~~









- Porém, status do Cilium tá ok

~~~~bash
root@debian10x64:/home/fernando# cilium status
    /¯¯\
 /¯¯\__/¯¯\    Cilium:             OK
 \__/¯¯\__/    Operator:           OK
 /¯¯\__/¯¯\    Envoy DaemonSet:    disabled (using embedded mode)
 \__/¯¯\__/    Hubble Relay:       disabled
    \__/       ClusterMesh:        disabled

Deployment             cilium-operator    Desired: 1, Ready: 1/1, Available: 1/1
DaemonSet              cilium             Desired: 1, Ready: 1/1, Available: 1/1
Containers:            cilium             Running: 1
                       cilium-operator    Running: 1
Cluster Pods:          9/16 managed by Cilium
Helm chart version:    1.14.1
Image versions         cilium             quay.io/cilium/cilium:v1.14.1@sha256:edc1d05ea1365c4a8f6ac6982247d5c145181704894bb698619c3827b6963a72: 1
                       cilium-operator    quay.io/cilium/operator-generic:v1.14.1@sha256:e061de0a930534c7e3f8feda8330976367971238ccafff42659f104effd4b5f7: 1
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# kubectl -n kube-system get pods -l k8s-app=cilium
NAME           READY   STATUS    RESTARTS   AGE
cilium-p29l7   1/1     Running   0          41m
root@debian10x64:/home/fernando# kubectl -n kube-system get pods
NAME                                  READY   STATUS    RESTARTS   AGE
cilium-operator-788c4f69bc-kxc29      1/1     Running   0          41m
cilium-p29l7                          1/1     Running   0          41m
coredns-5dd5756b68-2d2b4              1/1     Running   0          49m
coredns-5dd5756b68-cxks8              1/1     Running   0          49m
etcd-debian10x64                      1/1     Running   0          49m
kube-apiserver-debian10x64            1/1     Running   0          49m
kube-controller-manager-debian10x64   1/1     Running   0          49m
kube-proxy-vvdqq                      1/1     Running   0          49m
kube-scheduler-debian10x64            1/1     Running   0          49m
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








# ############################################################################
# ############################################################################
# ############################################################################
# RESUMO

sudo kubeadm init

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

helm repo add cilium https://helm.cilium.io/
helm install cilium cilium/cilium --version 1.14.1 --namespace kube-system
kubectl get pod cilium-operator-788c4f69bc-jv5tk -n kube-system -o yaml

- Ajustando número de réplicas do Cilium:

helm upgrade --install cilium cilium/cilium -n kube-system -f /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/148-x-cilium-values.yaml

cilium status
cilium connectivity test
kubectl get pods -n cilium-test
kubectl describe pod pod-to-b-multi-node-clusterip-7cb4bf5495-h4mp8 -n cilium-test

- Removendo

kubectl taint nodes debian10x64 node-role.kubernetes.io/control-plane-

cilium status