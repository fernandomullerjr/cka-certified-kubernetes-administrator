
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

https://kubernetes.io/docs/reference/scheduling/config/

<https://kubernetes.io/docs/reference/scheduling/config/>

# Profiles

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
  na fase de "Scoring", temos o plugin "NodeResourcesFit", que também é usado na fase de Filtering.
  um plugin pode ser usado em múltiplos stages.
    NodeResourcesFit: Checks if the node has all the resources that the Pod is requesting. The score can use one of three strategies: LeastAllocated (default), MostAllocated and RequestedToCapacityRatio. Extension points: preFilter, filter, score.









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