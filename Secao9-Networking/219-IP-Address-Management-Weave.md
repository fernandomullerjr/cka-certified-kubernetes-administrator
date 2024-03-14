
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "219. IP Address Management - Weave"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
## 219. IP Address Management - Weave

# IPAM weave

  - Take me to [Lecture](https://kodekloud.com/topic/ipam-weave/)

- IP Address Management in the Kubernetes Cluster

![net-3](../../images/net3.PNG)


- How weaveworks Manages IP addresses in the Kubernetes Cluster 

![net-4](../../images/net4.PNG)


## References Docs

- https://www.weave.works/docs/net/latest/kubernetes/kube-addon/
- https://kubernetes.io/docs/concepts/cluster-administration/networking/ 





# ###################################################################################################################### 
# ###################################################################################################################### 
## resumo

- DHCP e Host local, são os plugins do CNI.
- Host local é como se fosse uma tabela de ips.
- Seção "IPAM" do arquivo conf do cni, define o plugin, blocos de rede ,etc