
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "206. Prerequisite - CNI"
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  206. Prerequisite - CNI

# Pre-requisite CNI

  In this section, we will take a look at **Pre-requisite Container Network Interface(CNI)**

## Third Party Network Plugin Providers

- [Weave](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/#-installation)
- [Calico](https://docs.projectcalico.org/getting-started/kubernetes/quickstart)
- [Flannel](https://github.com/coreos/flannel/blob/master/Documentation/kubernetes.md)
- [Cilium](https://github.com/cilium/cilium)


## To view the CNI Network Plugins

- CNI comes with the set of supported network plugins. 

```
$ ls /opt/cni/bin/
bridge  dhcp  flannel  host-device  host-local  ipvlan  loopback  macvlan  portmap  ptp  sample  tuning  vlan
```

#### References Docs

- https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/





# ###################################################################################################################### 
# ###################################################################################################################### 
##  206. Prerequisite - CNI


Em Kubernetes, CNI significa Container Network Interface. É uma especificação e uma API que define como contêineres em um cluster Kubernetes se comunicam entre si e com o mundo exterior através da rede. O CNI permite que diferentes plugins de rede sejam usados para fornecer funcionalidades de rede, como roteamento, isolamento, balanceamento de carga, etc. Esses plugins podem ser escolhidos com base nas necessidades específicas do ambiente Kubernetes, permitindo uma flexibilidade significativa na configuração da rede.