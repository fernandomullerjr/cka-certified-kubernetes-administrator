# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 16 - kube-controller-manager. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# kube-controller-manager
Watch Status
Remediate Situation

Watch Status
Remediate Situation

Node-Controller kube-apiserver
UNREACHABLE

Node Monitor Period = 5s
Node Monitor Grace Period = 40s
POD Eviction Timeout = 5m


kubectl get nodes
Ready NAME STATUS ROLES AGE VERSION
worker-1 Ready <none> 8d v1.13.0
worker-2 NotReady <none> 8d v1.13.0





# kube-controller-manager

Esse componente é responsável por executar o cluster enquanto os controladores de gerenciamento do kubernetes executam varias funções de maneira unificada, como forma de garantir o último estado definido no etcd. O componente permiti que o kubernetes faça a interação de diversos provedores, com diferentes capacidades, recurso e APIS, enquanto faz a construção internamente.

Por exemplo: Caso esteja a executar um deploy, e nele ter 10 ReplicaSet em um pod, kube-controller-manager é responsável por verificar se todos subiram ou não.

Temos os seguintes controladores:

    Controlador do nó: responsável por identificar se o estado do nó está ativos ou não;
    Controlador de trabalho (job): responsável por observar e criar os pods para executar tarefas até finalização da sua execução;
    Controlador de endpoints: responsável pelo objeto do endpoints e a sua junção para a comunicação entre serviços e pod;
    Controlador autenticação: responsável por criar as contas de autenticação usando padrões de tokens para acesso de API e gerência de novos namespaces.




# Kube-controller-manager

O kube-controller-manager baseia-se no servidor API para supervisionar o estado do servidor. Este serviço implementará um nó e irá administrá-lo durante toda a sua existência. Este componente é o responsável por garantir a integridade e a disponibilidade da arquitetura.





# Installing kube-controller-manager
wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-controller-manager

ExecStart=/usr/local/bin/kube-controller-manager \\
--address=0.0.0.0 \\
--cluster-cidr=10.200.0.0/16 \\
--cluster-name=kubernetes \\
--cluster-signing-cert-file=/var/lib/kubernetes/ca.pem \\
--cluster-signing-key-file=/var/lib/kubernetes/ca-key.pem \\
--kubeconfig=/var/lib/kubernetes/kube-controller-manager.kubeconfig \\
--leader-elect=true \\
--root-ca-file=/var/lib/kubernetes/ca.pem \\
--service-account-private-key-file=/var/lib/kubernetes/service-account-key.pem \\
--service-cluster-ip-range=10.32.0.0/24 \\
--use-service-account-credentials=true \\
--v=2

kube-controller-manager.service
Node Monitor Period = 5s
Node Monitor Grace Period = 40s
POD Eviction Timeout = 5m

# Outras opções que podem ser definidas no Kube Controller:
--node-monitor-period=5s
--node-monitor-grace-period=40s
--pod-eviction-timeout=5m0s
--controllers stringSlice Default: [*]

A list of controllers to enable. '*' enables all on-by-default controllers, 'foo' enables the controller
named 'foo', '-foo' disables the controller named 'foo'.
All controllers: attachdetach, bootstrapsigner, clusterrole-aggregation, cronjob, csrapproving,
csrcleaner, csrsigning, daemonset, deployment, disruption, endpoint, garbagecollector,
horizontalpodautoscaling, job, namespace, nodeipam, nodelifecycle, persistentvolume-binder,
persistentvolume-expander, podgc, pv-protection, pvc-protection, replicaset, replicationcontroller,

Por padrão, são ativados todos os controllers.
Mas podem ser selecionados poucos, caso queira.



Installing
kube controller manager
--
controllers stringSlice Default: [*]
A list of controllers to enable. '*' enables all on
by default controllers, 'foo' enables the controller
named 'foo', ' foo' disables the controller named 'foo'.
All controllers:
attachdetach , bootstrapsigner , clusterrole aggregation, cronjob, csrapproving ,
csrcleaner , csrsigning , daemonset , deployment, disruption, endpoint, garbagecollector ,
horizontalpodautoscaling , job, namespace, nodeipam , nodelifecycle , persistentvolume binder,
persistentvolume expander, podgc , pv protection, pvc protection, replicaset , replicationcontroller ,
resourcequota , root ca cert publisher, route, service, serviceaccount , serviceaccount token, statefulset ,
tokencleaner , ttl , ttl after finished
Disabled
by default controllers: bootstrapsigner , tokencleaner




# View kube-controller-manager - kubeadm

kubectl get pods -n kube-system

NAMESPACE NAME READY STATUS RESTARTS AGE
kube-system coredns-78fcdf6894-hwrq9 1/1 Running 0 16m
kube-system coredns-78fcdf6894-rzhjr 1/1 Running 0 16m
kube-system etcd-master 1/1 Running 0 15m
kube-system kube-apiserver-master 1/1 Running 0 15m
kube-system kube-controller-manager-master 1/1 Running 0 15m
kube-system kube-proxy-lzt6f 1/1 Running 0 16m
kube-system kube-proxy-zm5qd 1/1 Running 0 16m
kube-system kube-scheduler-master 1/1 Running 0 15m
kube-system weave-net-29z42 2/2 Running 1 16m
kube-system weave-net-snmdl 2/2 Running 1 16m



# push
git status
git add .
git commit -m "Aula 16 - kube-controller-manager. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status