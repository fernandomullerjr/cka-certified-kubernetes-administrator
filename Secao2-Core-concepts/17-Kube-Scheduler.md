
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 17. Kube Scheduler. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
#  17. Kube Scheduler

- O "Kube Scheduler" não cria o Pod no node, esse trabalho é do Kubelet.
- O "Kube Scheduler" apenas decide qual Pod vai aonde.



<https://kubernetes.io/pt-br/docs/concepts/scheduling-eviction/kube-scheduler/>

Visão geral do Escalonamento

Um escalonador observa Pods recém-criados que não possuem um Node atribuído. Para cada Pod que o escalonador descobre, ele se torna responsável por encontrar o melhor Node para execução do Pod. O escalonador chega a essa decisão de alocação levando em consideração os princípios de programação descritos abaixo.

Se você quiser entender por que os Pods são alocados em um Node específico ou se planeja implementar um escalonador personalizado, esta página ajudará você a aprender sobre escalonamento.

kube-scheduler

kube-scheduler é o escalonador padrão do Kubernetes e é executado como parte do control plane. O kube-scheduler é projetado para que, se você quiser e precisar, possa escrever seu próprio componente de escalonamento e usá-lo.

Para cada Pod recém-criado ou outros Pods não escalonados, o kube-scheduler seleciona um Node ideal para execução. No entanto, todos os contêineres nos Pods têm requisitos diferentes de recursos e cada Pod também possui requisitos diferentes. Portanto, os Nodes existentes precisam ser filtrados de acordo com os requisitos de escalonamento específicos.

Em um cluster, Nodes que atendem aos requisitos de escalonamento para um Pod são chamados de Nodes viáveis. Se nenhum dos Nodes for adequado, o Pod permanece não escalonado até que o escalonador possa alocá-lo.

O escalonador encontra Nodes viáveis para um Pod e, em seguida, executa um conjunto de funções para pontuar os Nodes viáveis e escolhe um Node com a maior pontuação entre os possíveis para executar o Pod. O escalonador então notifica o servidor da API sobre essa decisão em um processo chamado binding.

Fatores que precisam ser levados em consideração para decisões de escalonamento incluem requisitos individuais e coletivos de recursos, restrições de hardware / software / política, especificações de afinidade e anti-afinidade, localidade de dados, interferência entre cargas de trabalho e assim por diante.





<https://dominik-tornow.medium.com/the-kubernetes-scheduler-cd429abac02f>

The Kubernetes Scheduler is a core component of Kubernetes: 
After a user or a controller creates a Pod, the Kubernetes Scheduler, monitoring the Object Store for unassigned Pods, will assign the Pod to a Node. Then, the Kubelet, monitoring the Object Store for assigned Pods, will execute the Pod.





# KUBE SCHEDULER - Steps
- O Kube Scheduler faz alguns steps:

1. Filtra os nodes, avaliando os recursos disponíveis em cada um.
2. Ele faz um "Rank Nodes", categorizando cada node com uma nota, escolhendo aquele com a melhor nota. Baseado nos recursos disponíveis em cada um.


# More Later…
• Resource Requirements and Limits
• Taints and Tolerations
• Node Selectors/Affinity



# Installing kube-scheduler

wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-scheduler

~~~~bash
kube-scheduler.service
ExecStart=/usr/local/bin/kube-scheduler \\
--config=/etc/kubernetes/config/kube-scheduler.yaml \\
--v=2
~~~~




# View kube-scheduler options - kubeadm

cat /etc/kubernetes/manifests/kube-scheduler.yaml

~~~~yaml
spec:
containers:
- command:
- kube-scheduler
- --address=127.0.0.1
- --kubeconfig=/etc/kubernetes/scheduler.conf
- --leader-elect=true
~~~~




# View kube-scheduler options

~~~~bash
ps -aux | grep kube-scheduler
root 2477 0.8 1.6 48524 34044 ? Ssl 17:31 0:08 kube-scheduler --
address=127.0.0.1 --kubeconfig=/etc/kubernetes/scheduler.conf --leader-elect=true
~~~~







# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# Kube Scheduler - detalhes 

<https://kubernetes.io/docs/concepts/scheduling-eviction/kube-scheduler/>

Kubernetes Scheduler

In Kubernetes, scheduling refers to making sure that Pods are matched to Nodes so that Kubelet can run them.
Scheduling overview

A scheduler watches for newly created Pods that have no Node assigned. For every Pod that the scheduler discovers, the scheduler becomes responsible for finding the best Node for that Pod to run on. The scheduler reaches this placement decision taking into account the scheduling principles described below.

If you want to understand why Pods are placed onto a particular Node, or if you're planning to implement a custom scheduler yourself, this page will help you learn about scheduling.
kube-scheduler

kube-scheduler is the default scheduler for Kubernetes and runs as part of the control plane. kube-scheduler is designed so that, if you want and need to, you can write your own scheduling component and use that instead.

For every newly created pod or other unscheduled pods, kube-scheduler selects an optimal node for them to run on. However, every container in pods has different requirements for resources and every pod also has different requirements. Therefore, existing nodes need to be filtered according to the specific scheduling requirements.

In a cluster, Nodes that meet the scheduling requirements for a Pod are called feasible nodes. If none of the nodes are suitable, the pod remains unscheduled until the scheduler is able to place it.

The scheduler finds feasible Nodes for a Pod and then runs a set of functions to score the feasible Nodes and picks a Node with the highest score among the feasible ones to run the Pod. The scheduler then notifies the API server about this decision in a process called binding.

Factors that need to be taken into account for scheduling decisions include individual and collective resource requirements, hardware / software / policy constraints, affinity and anti-affinity specifications, data locality, inter-workload interference, and so on.
Node selection in kube-scheduler

kube-scheduler selects a node for the pod in a 2-step operation:

    Filtering
    Scoring

The filtering step finds the set of Nodes where it's feasible to schedule the Pod. For example, the PodFitsResources filter checks whether a candidate Node has enough available resource to meet a Pod's specific resource requests. After this step, the node list contains any suitable Nodes; often, there will be more than one. If the list is empty, that Pod isn't (yet) schedulable.

In the scoring step, the scheduler ranks the remaining nodes to choose the most suitable Pod placement. The scheduler assigns a score to each Node that survived filtering, basing this score on the active scoring rules.

Finally, kube-scheduler assigns the Pod to the Node with the highest ranking. If there is more than one node with equal scores, kube-scheduler selects one of these at random.

There are two supported ways to configure the filtering and scoring behavior of the scheduler:

    Scheduling Policies allow you to configure Predicates for filtering and Priorities for scoring.
    Scheduling Profiles allow you to configure Plugins that implement different scheduling stages, including: QueueSort, Filter, Score, Bind, Reserve, Permit, and others. You can also configure the kube-scheduler to run different profiles.