
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "240. Configure High Availability."
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
## 240. Configure High Availability


- Como os nodes Master lidam quando tem o "Active" e mais um node "Standby":

Kube-controller-manager 
Endpoint
master1

kube-controller-manager --leader-elect true [other options]

--leader-elect-lease-duration 15s
--leader-elect-renew-deadline 10s
--leader-elect-retry-period 2s


também é necessário um Load Balancer, para balancear as requisições entre os nodes.



## Tipos de topologia

Stacked Topology
✓ Easier to setup
✓ Easier to manage
✓ Fewer Servers
❖ Risk during failures

External ETCD Topology
✓ Less Risky
❖ Harder to Setup
❖ More Servers



- Exemplo de configuração com múltiplos etcd:

~~~~bash
cat /etc/systemd/system/kube-apiserver.service
[Service]
ExecStart=/usr/local/bin/kube-apiserver \\
--advertise-address=${INTERNAL_IP} \\
--allow-privileged=true \\
--apiserver-count=3 \\
--etcd-cafile=/var/lib/kubernetes/ca.pem \\
--etcd-certfile=/var/lib/kubernetes/kubernetes.pem \\
--etcd-keyfile=/var/lib/kubernetes/kubernetes-key.pem \\
--etcd-servers=https://10.240.0.10:2379,https://10.240.0.11:2379
~~~~




# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO

- Quando temos mais de um Master Node, temos que configurar os parametros --leader-elect

- também é necessário um Load Balancer, para balancear as requisições entre os nodes.