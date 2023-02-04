
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 79. Configuring Scheduler Profiles"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
#  79. Configuring Scheduler Profiles


# Profiles

https://kubernetes.io/docs/reference/scheduling/config/
<https://kubernetes.io/docs/reference/scheduling/config/>

A scheduling Profile allows you to configure the different stages of scheduling in the kube-scheduler. Each stage is exposed in an extension point. Plugins provide scheduling behaviors by implementing one or more of these extension points.

You can configure a single instance of kube-scheduler to run multiple profiles.




# Processo - Scheduler

- Pods vão para uma "Scheduling Queue".
- O Pod é provisionado conforme a sua prioridade, que é definida pela PriorityClass.
- Depois de selecionada a prioridade, o Pod entra na fase de "Filtering".
- Scoring
- Binding


# Example PriorityClass

~~~~YAML
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000000
globalDefault: false
description: "This priority class should be used for XYZ service pods only."
~~~~




# Pod com priority setado

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  priorityClassName: high-priority
~~~~





# PENDENTE
- Video continua em 02:44
- Video continua em 02:44




# Dia 01/02/2023





# Processo - Scheduler - RESUMIDO

- Scheduling Queue
- Filtering
- Scoring
- Binding





- Em cada fase, são usados Plugins para as atividades.

- Na fase de "Scheduling Queue", são usados os Plugins "PrioritySort":
PrioritySort: Provides the default priority based sorting. Extension points: queueSort.

- Na fase de "Filtering" são usados os Plugins de "NodeResourcesFit", "NodeName", "NodeUnschedulable", por exemplo:
  NodeResourcesFit: Checks if the node has all the resources that the Pod is requesting. The score can use one of three strategies: LeastAllocated (default), MostAllocated and RequestedToCapacityRatio. Extension points: preFilter, filter, score.
  NodeName: Checks if a Pod spec node name matches the current node. Extension points: filter.
  NodeUnschedulable: Filters out nodes that have .spec.unschedulable set to true. Extension points: filter.


- Scoring:
  na fase de "Scoring", temos o plugin "NodeResourcesFit", que também é usado na fase de Filtering, temos o "ImageLocality", que pontua aqueles nodes que já tem a imagem do Container que o Pod vai precisar.
  um plugin pode ser usado em múltiplos stages.
    NodeResourcesFit: Checks if the node has all the resources that the Pod is requesting. The score can use one of three strategies: LeastAllocated (default), MostAllocated and RequestedToCapacityRatio. Extension points: preFilter, filter, score.
    ImageLocality: Favors nodes that already have the container images that the Pod runs. Extension points: score.


- Binding








# EXEMPLO - FILTERING

- Filtrando pelo "nodeName".

- Crie um pod que é agendado em um nó específico

Você pode também agendar um pod para um nó específico usando nodeName.
pods/pod-nginx-specific-node.yaml [Copy pods/pod-nginx-specific-node.yaml to clipboard]

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  nodeName: foo-node # schedule pod to specific node
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
~~~~





- Verificando status da flash "Unschedulable" no Node:

~~~~bash
fernando@debian10x64:~$ kubectl get nodes
NAME       STATUS   ROLES                  AGE   VERSION
minikube   Ready    control-plane,master   34d   v1.22.2
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl describe node minikube | grep "Unschedulable"
Unschedulable:      false
fernando@debian10x64:~$
fernando@debian10x64:~$
~~~~


caso a flag "NodeUnschedulable" esteja setada como true, os Pods não podem usar este Node.






- Cada stage tem um extension point.






# Extension points

Scheduling happens in a series of stages that are exposed through the following extension points:

    queueSort: These plugins provide an ordering function that is used to sort pending Pods in the scheduling queue. Exactly one queue sort plugin may be enabled at a time.
    preFilter: These plugins are used to pre-process or check information about a Pod or the cluster before filtering. They can mark a pod as unschedulable.
    filter: These plugins are the equivalent of Predicates in a scheduling Policy and are used to filter out nodes that can not run the Pod. Filters are called in the configured order. A pod is marked as unschedulable if no nodes pass all the filters.
    postFilter: These plugins are called in their configured order when no feasible nodes were found for the pod. If any postFilter plugin marks the Pod schedulable, the remaining plugins are not called.
    preScore: This is an informational extension point that can be used for doing pre-scoring work.
    score: These plugins provide a score to each node that has passed the filtering phase. The scheduler will then select the node with the highest weighted scores sum.
    reserve: This is an informational extension point that notifies plugins when resources have been reserved for a given Pod. Plugins also implement an Unreserve call that gets called in the case of failure during or after Reserve.
    permit: These plugins can prevent or delay the binding of a Pod.
    preBind: These plugins perform any work required before a Pod is bound.
    bind: The plugins bind a Pod to a Node. bind plugins are called in order and once one has done the binding, the remaining plugins are skipped. At least one bind plugin is required.
    postBind: This is an informational extension point that is called after a Pod has been bound.
    multiPoint: This is a config-only field that allows plugins to be enabled or disabled for all of their applicable extension points simultaneously.

For each extension point, you could disable specific default plugins or enable your own. For example:

~~~~YAML
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
  - plugins:
      score:
        disabled:
        - name: PodTopologySpread
        enabled:
        - name: MyCustomPluginA
          weight: 2
        - name: MyCustomPluginB
          weight: 1
~~~~



# Scheduling plugins

The following plugins, enabled by default, implement one or more of these extension points:

    ImageLocality: Favors nodes that already have the container images that the Pod runs. Extension points: score.
    TaintToleration: Implements taints and tolerations. Implements extension points: filter, preScore, score.
    NodeName: Checks if a Pod spec node name matches the current node. Extension points: filter.
    NodePorts: Checks if a node has free ports for the requested Pod ports. Extension points: preFilter, filter.
    NodeAffinity: Implements node selectors and node affinity. Extension points: filter, score.
    PodTopologySpread: Implements Pod topology spread. Extension points: preFilter, filter, preScore, score.
    NodeUnschedulable: Filters out nodes that have .spec.unschedulable set to true. Extension points: filter.
    NodeResourcesFit: Checks if the node has all the resources that the Pod is requesting. The score can use one of three strategies: LeastAllocated (default), MostAllocated and RequestedToCapacityRatio. Extension points: preFilter, filter, score.
    NodeResourcesBalancedAllocation: Favors nodes that would obtain a more balanced resource usage if the Pod is scheduled there. Extension points: score.
    VolumeBinding: Checks if the node has or if it can bind the requested volumes. Extension points: preFilter, filter, reserve, preBind, score.
    Note: score extension point is enabled when VolumeCapacityPriority feature is enabled. It prioritizes the smallest PVs that can fit the requested volume size.
    VolumeRestrictions: Checks that volumes mounted in the node satisfy restrictions that are specific to the volume provider. Extension points: filter.
    VolumeZone: Checks that volumes requested satisfy any zone requirements they might have. Extension points: filter.
    NodeVolumeLimits: Checks that CSI volume limits can be satisfied for the node. Extension points: filter.
    EBSLimits: Checks that AWS EBS volume limits can be satisfied for the node. Extension points: filter.
    GCEPDLimits: Checks that GCP-PD volume limits can be satisfied for the node. Extension points: filter.
    AzureDiskLimits: Checks that Azure disk volume limits can be satisfied for the node. Extension points: filter.
    InterPodAffinity: Implements inter-Pod affinity and anti-affinity. Extension points: preFilter, filter, preScore, score.
    PrioritySort: Provides the default priority based sorting. Extension points: queueSort.
    DefaultBinder: Provides the default binding mechanism. Extension points: bind.
    DefaultPreemption: Provides the default preemption mechanism. Extension points: postFilter.

You can also enable the following plugins, through the component config APIs, that are not enabled by default:

    CinderLimits: Checks that OpenStack Cinder volume limits can be satisfied for the node. Extension points: filter.









- A partir da versão 1.18 do Kubernetes, surgiu uma feature para suportar múltiplos profiles num único Scheduler.


# Multiple profiles

You can configure kube-scheduler to run more than one profile. Each profile has an associated scheduler name and can have a different set of plugins configured in its extension points.

With the following sample configuration, the scheduler will run with two profiles: one with the default plugins and one with all scoring plugins disabled.

~~~~YAML
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
  - schedulerName: default-scheduler
  - schedulerName: no-scoring-scheduler
    plugins:
      preScore:
        disabled:
        - name: '*'
      score:
        disabled:
        - name: '*'
~~~~













# ###############################################################################################################################################################  #   ##########################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# Múltiplos Scheduler + Múltiplos Profiles

- Fonte:
https://www.sobyte.net/post/2022-08/k8s-schedule-ext-prometheus/
<https://www.sobyte.net/post/2022-08/k8s-schedule-ext-prometheus/>

Since kubernetes provides multiple schedulers, it is natural for profiles to support multiple profiles, and profiles are also in the form of lists, so just specify multiple configuration lists. Here is an example of multiple profiles, where multiple extension points can also be configured for each scheduler if they exist.

~~~~YAML
apiVersion: kubescheduler.config.k8s.io/v1beta2
kind: KubeSchedulerConfiguration
profiles:
  - schedulerName: default-scheduler
    plugins:
      preScore:
        disabled:
        - name: '*'
      score:
        disabled:
        - name: '*'
  - schedulerName: no-scoring-scheduler
    plugins:
      preScore:
        disabled:
        - name: '*'
      score:
        disabled:
        - name: '*'
~~~~


