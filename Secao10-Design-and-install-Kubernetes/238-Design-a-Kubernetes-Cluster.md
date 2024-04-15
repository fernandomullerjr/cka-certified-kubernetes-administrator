
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "238. Design a Kubernetes Cluster."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
## 238. Design a Kubernetes Cluster

## Objectives

• Node Considerations
• Resource Requirements
• Network Considerations


## Ask
• Purpose
• Education
• Development & Testing
• Hosting Production Applications
• Cloud or OnPrem?
• Workloads
• How many? 
• What kind?
• Web
• Big Data/Analytics
• Application Resource Requirements
• CPU Intensive
• Memory Intensive
• Traffic
• Heavy traffic
• Burst Traffic



## Purpose

• Education
    • Minikube
    • Single node cluster with kubeadm/GCP/AWS

• Development & Testing
    • Multi-node cluster with a Single Master and Multiple workers
    • Setup using kubeadm tool or quick provision on GCP or AWS or AKS


• Hosting Production Applications



## Storage
 
• High Performance – SSD Backed Storage
• Multiple Concurrent connections – Network based storage
• Persistent shared volumes for shared access across multiple PODs
• Label nodes with specific disk types
• Use Node Selectors to assign applications to nodes with specific disk types




## Nodes
• Virtual or Physical Machines
• Minimum of 4 Node Cluster (Size based on workload)
• Master vs Worker Nodes
• Linux X86_64 Architecture

• Master nodes can host workloads
• Best practice is to not host workloads on Master nodes







- Normalmente o etcd vem acoplado ao Master Node. Uma boa prática é separar o etcd do Master Node e deixar o etcd num local separado.




# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO

- SSD storage - Alto desempenho – armazenamento com SSD

- Network storage - Múltiplas conexões simultâneas – armazenamento baseado em rede.

- Node Selector - Use seletores de nó para atribuir aplicativos a nós com tipos de disco específicos

- Best practice is to not host workloads on Master nodes.

- Normalmente o etcd vem acoplado ao Master Node. Uma boa prática é separar o etcd do Master Node e deixar o etcd num local separado.