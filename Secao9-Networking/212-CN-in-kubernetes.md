
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "212. CNI in kubernetes"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##   212. CNI in kubernetes

# CNI in Kubernetes

In this section, we will take a look at **Container Networking Interface (CNI) in Kubernetes**

## Configuring CNI


- Check the status of the Kubelet Service

```
$ systemctl status kubelet.service
```

## View Kubelet Options

```
$ ps -aux | grep kubelet
```

## Check the Supportable Plugins 

- To check the all supportable plugins available in the `/opt/cni/bin` directory.

```
$ ls /opt/cni/bin

```

## Check the CNI Plugins

- To check the cni plugins which kubelet needs to be used.

```
ls /etc/cni/net.d

```

## Format of Configuration File  


#### References Docs

- https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/
- https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/





# ###################################################################################################################### 
# ###################################################################################################################### 
##   212. CNI in kubernetes

Container Runtime must create network namespace

Identify network the container must attach to

Container Runtime to invoke Network Plugin (bridge) when container is ADDed

Container Runtime to invoke Network Plugin (bridge) when container is DELeted

JSON format of the Network Configuration