
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "207. Cluster Networking"
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  207. Cluster Networking

# Pre-requisite Cluster Networking

In this section, we will take a look at **Pre-requisite of the Cluster Networking**

- Set the unique hostname.
- Get the IP addr of the system (master and worker node).
- Check the Ports.

## IP and Hostname

- To view the hostname

```
$ hostname 
```

- To view the IP addr of the system

```
$ ip a
```


## Set the hostname

```
$ hostnamectl set-hostname <host-name>

$ exec bash
```

## View the Listening Ports of the system

```
$ netstat -nltp
```



#### References Docs

- https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-required-ports
- https://kubernetes.io/docs/concepts/cluster-administration/networking/




# ###################################################################################################################### 
# ###################################################################################################################### 
##  207. Cluster Networking




# ###################################################################################################################### 
# ###################################################################################################################### 
##  RESUMO

- Kubelet fica nos workers nodes, mas pode estar no Master Node também.

- Listagem de portas e protocolos
<https://kubernetes.io/docs/reference/networking/ports-and-protocols/>