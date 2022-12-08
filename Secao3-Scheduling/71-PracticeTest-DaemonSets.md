


############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 71. Practice Test - DaemonSets "
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status






############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 71. Practice Test - DaemonSets






# How many DaemonSets are created in the cluster in all namespaces?

Check all namespaces



controlplane ~ ➜  kubectl get ds -A
NAMESPACE     NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   kube-flannel-ds   1         1         1       1            1           <none>                   7m10s
kube-system   kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   7m12s

controlplane ~ ➜  


- RESPOSTA:
2








# Which namespace are the DaemonSets created in?

controlplane ~ ➜  kubectl get ds -A
NAMESPACE     NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   kube-flannel-ds   1         1         1       1            1           <none>                   7m10s
kube-system   kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   7m12s

controlplane ~ ➜  

- RESPOSTA:
kube-system









# Which of the below is a DaemonSet?

kube-flannel-ds










# On how many nodes are the pods scheduled by the DaemonSet kube-proxy

controlplane ~ ➜  kubectl describe ds kube-proxy -n kube-system
Name:           kube-proxy
Selector:       k8s-app=kube-proxy
Node-Selector:  kubernetes.io/os=linux
Labels:         k8s-app=kube-proxy
Annotations:    deprecated.daemonset.template.generation: 1
Desired Number of Nodes Scheduled: 1
Current Number of Nodes Scheduled: 1
Number of Nodes Scheduled with Up-to-date Pods: 1
Number of Nodes Scheduled with Available Pods: 1
Number of Nodes Misscheduled: 0
Pods Status:  1 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:           k8s-app=kube-proxy
  Service Account:  kube-proxy
  Containers:
   kube-proxy:
    Image:      k8s.gcr.io/kube-proxy:v1.24.0
    Port:       <none>
    Host Port:  <none>
    Command:
      /usr/local/bin/kube-proxy
      --config=/var/lib/kube-proxy/config.conf
      --hostname-override=$(NODE_NAME)
    Environment:
      NODE_NAME:   (v1:spec.nodeName)
    Mounts:
      /lib/modules from lib-modules (ro)
      /run/xtables.lock from xtables-lock (rw)
      /var/lib/kube-proxy from kube-proxy (rw)
  Volumes:
   kube-proxy:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      kube-proxy
    Optional:  false
   xtables-lock:
    Type:          HostPath (bare host directory volume)
    Path:          /run/xtables.lock
    HostPathType:  FileOrCreate
   lib-modules:
    Type:               HostPath (bare host directory volume)
    Path:               /lib/modules
    HostPathType:       
  Priority Class Name:  system-node-critical
Events:
  Type    Reason            Age    From                  Message
  ----    ------            ----   ----                  -------
  Normal  SuccessfulCreate  9m41s  daemonset-controller  Created pod: kube-proxy-6q98g

controlplane ~ ➜  


- RESPOSTA:
1






# What is the image used by the POD deployed by the kube-flannel-ds DaemonSet?

kubectl describe ds kube-flannel-ds -n kube-system


controlplane ~ ➜  kubectl describe ds kube-flannel-ds -n kube-systemName:           kube-flannel-dsSelector:       app=flannelNode-Selector:  <none>Labels:         app=flannel                tier=nodeAnnotations:    deprecated.daemonset.template.generation: 1Desired Number of Nodes Scheduled: 1Current Number of Nodes Scheduled: 1Number of Nodes Scheduled with Up-to-date Pods: 1Number of Nodes Scheduled with Available Pods: 1Number of Nodes Misscheduled: 0Pods Status:  1 Running / 0 Waiting / 0 Succeeded / 0 FailedPod Template:  Labels:           app=flannel                    tier=node  Service Account:  flannel
  Init Containers:
   install-cni:
    Image:      quay.io/coreos/flannel:v0.13.1-rc1
    Port:       <none>
    Host Port:  <none>
    Command:
      cp
    Args:
      -f
      /etc/kube-flannel/cni-conf.json
      /etc/cni/net.d/10-flannel.conflist
    Environment:  <none>
    Mounts:
      /etc/cni/net.d from cni (rw)
      /etc/kube-flannel/ from flannel-cfg (rw)
  Containers:
   kube-flannel:
    Image:      quay.io/coreos/flannel:v0.13.1-rc1
    Port:       <none>
    Host Port:  <none>
    Command:
      /opt/bin/flanneld
    Args:
      --ip-masq
      --kube-subnet-mgr
      --iface=eth0
    Limits:
      cpu:     100m
      memory:  300Mi
    Requests:
      cpu:     100m
      memory:  50Mi
    Environment:
      POD_NAME:        (v1:metadata.name)
      POD_NAMESPACE:   (v1:metadata.namespace)
    Mounts:
      /etc/kube-flannel/ from flannel-cfg (rw)
      /run/flannel from run (rw)
  Volumes:
   run:
    Type:          HostPath (bare host directory volume)
    Path:          /run/flannel
    HostPathType:  
   cni:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/cni/net.d
    HostPathType:  
   flannel-cfg:
    Type:               ConfigMap (a volume populated by a ConfigMap)
    Name:               kube-flannel-cfg
    Optional:           false
  Priority Class Name:  system-node-critical
Events:
  Type    Reason            Age   From                  Message
  ----    ------            ----  ----                  -------
  Normal  SuccessfulCreate  18m   daemonset-controller  Created pod: kube-flannel-ds-2vk7d

controlplane ~ ➜  

controlplane ~ ➜  


- resposta:
quay.io/coreos/flannel:v0.13.1-rc1








# Deploy a DaemonSet for FluentD Logging.

Use the given specifications.

Name: elasticsearch

Namespace: kube-system

Image: k8s.gcr.io/fluentd-elasticsearch:1.20



- Criado um manifesto para o DaemonSet:

~~~~yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: elasticsearch
  namespace: kube-system
  labels:
    app: elasticsearch
spec:
  selector:
    matchLabels:
      app: elasticsearch
  template:
    metadata:
      labels:
        app: elasticsearch
    spec:
      containers:
        - name: elasticsearch
          image: k8s.gcr.io/fluentd-elasticsearch:1.20
~~~~


- Aplicando o manifesto do DaemonSet do FluentD:

controlplane ~ ➜  kubectl apply -f daemonset-fluentd.yaml
daemonset.apps/elasticsearch created

controlplane ~ ➜  kubectl get ds -A
NAMESPACE     NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   elasticsearch     1         1         0       1            0           <none>                   6s
kube-system   kube-flannel-ds   1         1         1       1            1           <none>                   23m
kube-system   kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   23m

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS              RESTARTS   AGE
kube-system   coredns-6d4b75cb6d-87wrq               1/1     Running             0          23m
kube-system   coredns-6d4b75cb6d-pg2hh               1/1     Running             0          23m
kube-system   elasticsearch-npnvs                    0/1     ContainerCreating   0          15s
kube-system   etcd-controlplane                      1/1     Running             0          23m
kube-system   kube-apiserver-controlplane            1/1     Running             0          23m
kube-system   kube-controller-manager-controlplane   1/1     Running             0          23m
kube-system   kube-flannel-ds-2vk7d                  1/1     Running             0          23m
kube-system   kube-proxy-6q98g                       1/1     Running             0          23m
kube-system   kube-scheduler-controlplane            1/1     Running             0          23m

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods -A | grep elastic
kube-system   elasticsearch-npnvs                    1/1     Running   0          93s

controlplane ~ ➜  
controlplane ~ ➜  kubectl get ds -A
NAMESPACE     NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   elasticsearch     1         1         1       1            1           <none>                   108s
kube-system   kube-flannel-ds   1         1         1       1            1           <none>                   25m
kube-system   kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   25m

controlplane ~ ➜  







- Outra maneira de criar este manifesto para o DaemonSet, é criando um manifesto para um Deployment via dry-run, já que os 2 tem estruturas parecidas.

kubectl create deployment elasticsearch --image=k8s.gcr.io/fluentd-elasticsearch:1.20 -n kube-system --dry-run=client -o yaml > fluentd.yaml

- Observação:
o DaemonSet não utiliza replicas.
