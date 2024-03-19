
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "222. Service Networking."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  222. Service Networking

# Service Networking

  In this section, we will take a look at **Service Networking**

## Service Types

- ClusterIP 


```
clusterIP.yaml

apiVersion: v1
kind: Service
metadata:
  name: local-cluster
spec:
  ports:
  - port: 80
    targetPort: 80
  selector:
    app: nginx
```

- NodePort

```
nodeportIP.yaml

apiVersion: v1
kind: Service
metadata:
  name: nodeport-wide
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
  selector:
    app: nginx
```

## To create the service 

```
$ kubectl create -f clusterIP.yaml
service/local-cluster created

$ kubectl create -f nodeportIP.yaml
service/nodeport-wide created
```

## To get the Additional Information

```
$ kubectl get pods -o wide
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE     NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          1m   10.244.1.3   node01   <none>           <no
```

## To get the Service

```
$ kubectl get service
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes      ClusterIP   10.96.0.1       <none>        443/TCP        5m22s
local-cluster   ClusterIP   10.101.67.139   <none>        80/TCP         3m
nodeport-wide   NodePort    10.102.29.204   <none>        80:30016/TCP   2m
```

## To check the Service Cluster IP Range 

```
$ ps -aux | grep kube-apiserver
--secure-port=6443 --service-account-key-file=/etc/kubernetes/pki/sa.pub --
service-cluster-ip-range=10.96.0.0/12

```

## To check the rules created by kube-proxy in the iptables

```
$ iptables -L -t nat | grep local-cluster
KUBE-MARK-MASQ  all  --  10.244.1.3           anywhere             /* default/local-cluster: */
DNAT       tcp  --  anywhere             anywhere             /* default/local-cluster: */ tcp to:10.244.1.3:80
KUBE-MARK-MASQ  tcp  -- !10.244.0.0/16        10.101.67.139        /* default/local-cluster: cluster IP */ tcp dpt:http
KUBE-SVC-SDGXHD6P3SINP7QJ  tcp  --  anywhere             10.101.67.139        /* default/local-cluster: cluster IP */ tcp dpt:http
KUBE-SEP-GEKJR4UBUI5ONAYW  all  --  anywhere             anywhere             /* default/local-cluster: */
```

## To check the logs of kube-proxy

- May this file location is vary depends on your installation process.

```
$ cat /var/log/kube-proxy.log

```


#### References Docs

- https://kubernetes.io/docs/concepts/services-networking/service/








# ###################################################################################################################### 
# ###################################################################################################################### 
##  222. Service Networking

## To check the Service Cluster IP Range 

```
$ ps -aux | grep kube-apiserver
--secure-port=6443 --service-account-key-file=/etc/kubernetes/pki/sa.pub --
service-cluster-ip-range=10.96.0.0/12

```

## To check the rules created by kube-proxy in the iptables

```
$ iptables -L -t nat | grep local-cluster
KUBE-MARK-MASQ  all  --  10.244.1.3           anywhere             /* default/local-cluster: */
DNAT       tcp  --  anywhere             anywhere             /* default/local-cluster: */ tcp to:10.244.1.3:80
KUBE-MARK-MASQ  tcp  -- !10.244.0.0/16        10.101.67.139        /* default/local-cluster: cluster IP */ tcp dpt:http
KUBE-SVC-SDGXHD6P3SINP7QJ  tcp  --  anywhere             10.101.67.139        /* default/local-cluster: cluster IP */ tcp dpt:http
KUBE-SEP-GEKJR4UBUI5ONAYW  all  --  anywhere             anywhere             /* default/local-cluster: */
```

## To check the logs of kube-proxy

- May this file location is vary depends on your installation process.

```
$ cat /var/log/kube-proxy.log

```



## KUBE-PROXY

kube-proxy pode usar, iptables
    userspace
    ipvs


~~~~BASH
root@debian10x64:/home/fernando#
root@debian10x64:/home/fernando# ps -aux | grep kube-apiserver
root       1543  0.0  0.0  80368  2180 ?        Ssl  19:42   0:00 /usr/bin/conmon -b /run/containers/storage/overlay-containers/73b3709f1bd20111dbefcb304f25ad95f18d27048667b32f1f88b3aca8049209/userdata -c 73b3709f1bd20111dbefcb304f25ad95f18d27048667b32f1f88b3aca8049209 --exit-dir /var/run/crio/exits -l /var/log/pods/kube-system_kube-apiserver-debian10x64_f1dc312c54ea8cde6987d9898b19f903/kube-apiserver/18.log --log-level info -n k8s_kube-apiserver_kube-apiserver-debian10x64_kube-system_f1dc312c54ea8cde6987d9898b19f903_18 -P /run/containers/storage/overlay-containers/73b3709f1bd20111dbefcb304f25ad95f18d27048667b32f1f88b3aca8049209/userdata/conmon-pidfile -p /run/containers/storage/overlay-containers/73b3709f1bd20111dbefcb304f25ad95f18d27048667b32f1f88b3aca8049209/userdata/pidfile --persist-dir /var/lib/containers/storage/overlay-containers/73b3709f1bd20111dbefcb304f25ad95f18d27048667b32f1f88b3aca8049209/userdata -r /usr/lib/cri-o-runc/sbin/runc --runtime-arg --root=/run/runc --socket-dir-path /var/run/crio -u 73b3709f1bd20111dbefcb304f25ad95f18d27048667b32f1f88b3aca8049209 -s
root       1649  3.7  2.5 1486104 254148 ?      Ssl  19:42   1:12 kube-apiserver --advertise-address=192.168.136.128 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root       7149  0.0  0.0   6204   828 pts/1    S+   20:14   0:00 grep kube-apiserver
root@debian10x64:/home/fernando#
~~~~



--service-cluster-ip-range=10.96.0.0/12



~~~~BASH

root@debian10x64:/home/fernando# kubectl get service
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   23d
root@debian10x64:/home/fernando#



root@debian10x64:/home/fernando# iptables -L -t nat | grep -i cluster
KUBE-SVC-NPX46M4PTMTKRN6Y  tcp  --  anywhere             10.96.0.1            /* default/kubernetes:https cluster IP */
root@debian10x64:/home/fernando#

~~~~




# ###################################################################################################################### 
# ###################################################################################################################### 
##  RESUMO

- O Service não é atrelado a um node especifico, ele abrange o Cluster num todo.

- O Service do tipo "ClusterIP" é acessível apenas dentro do cluster.

- O Service do tipo "NodePort" é acessível de fora do cluster.
Além do ip que é atribuido ao Service, o Service do tipo "NodePort" também atribui uma porta aos Nodes que acessível externamente.


- Kubelet cuida da criação de Pods.

- Kube-apiserver comunica com o Kubelet.

- Services são criados a nível do Cluster.

- kube-proxy cria as regras que definem para o ip e porta do service onde vai a comunicação.
default é iptables

- CIDR/Bloco de ip para os Pods não podem ter overlap com o range de ips para os Services
verificando range de ip, services
ps -aux | grep kube-apiserver   
    --service-cluster-ip-range=10.96.0.0/12
