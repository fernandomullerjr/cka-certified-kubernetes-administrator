
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m " 198. Networking - Section Introduction."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
## 198. Networking - Section Introduction

# Section Introduction

  - Take me to [Introduction](https://kodekloud.com/topic/networking-introduction/)

In this section, we will take a look at **Networking Section**

- Prerequisite 
    - Switching, Routing and Gateways
      - Switching
      - Routing
      - Default Gateway
    - DNS
      - DNS Configuration on Linux
    - CoreDNS
    - Network Namespace
    - Docker Networking
    - CNI
- Cluster Networking
- Pod Networking
- CNI in Kubernetes
- CoreDNS
- Ingress
 