#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "241. ETCD in HA."
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
## 241. ETCD in HA

Objectives
• What is ETCD?
• What is a Key-Value Store?
• How to get started quickly?
• How to operate ETCD?
• What is a distributed system?
• How ETCD Operates
• RAFT Protocol
• Best practices on number of nodes



ETCD is a distributed and reliable key-value store.




##  Getting Started

~~~~bash
wget -q --https-only \
"https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz"
tar -xvf etcd-v3.3.9-linux-amd64.tar.gz
mv etcd-v3.3.9-linux-amd64/etcd* /usr/local/bin/
mkdir -p /etc/etcd /var/lib/etcd
cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd
~~~~



~~~~bash
etcd.service
ExecStart=/usr/local/bin/etcd \\
--name ${ETCD_NAME} \\
--cert-file=/etc/etcd/kubernetes.pem \\
--key-file=/etc/etcd/kubernetes-key.pem \\
--peer-cert-file=/etc/etcd/kubernetes.pem \\
--peer-key-file=/etc/etcd/kubernetes-key.pem \\
--trusted-ca-file=/etc/etcd/ca.pem \\
--peer-trusted-ca-file=/etc/etcd/ca.pem \\
--peer-client-cert-auth \\
--client-cert-auth \\
--initial-advertise-peer-urls https://${INTERNAL_IP}:2380 \\
--listen-peer-urls https://${INTERNAL_IP}:2380 \\
--listen-client-urls https://${INTERNAL_IP}:2379,https://127.0.0.1:2379 \\
--advertise-client-urls https://${INTERNAL_IP}:2379 \\
--initial-cluster-token etcd-cluster-0 \\
--initial-cluster controller-0=https://${CONTROLLER0_IP}:2380,controller-1=https://${CONTROLLER1_IP}:2380 \\
--initial-cluster-state new \\
--data-dir=/var/lib/etcd
~~~~





## Leader Election - RAFT

algoritmo RAFT

Resumidamente:

     Todos os nós começam como seguidores. Se um seguidor não receber notícias de um líder ou candidato dentro de um prazo definido (tempo limite da eleição), ele se tornará um candidato.
     O candidato busca votos de outros nós do cluster.
     Se o candidato obtiver votos da maioria dos nós, ele se tornará o novo líder para o próximo mandato.




## Quorum

<https://www.linkedin.com/pulse/demystifying-kubernetes-etcd-high-availability-mohammad-akif-gc1ac/>

 Quorum = N/2 +1

    For 1 node: (1/2)+1~=1 minimum of 1 node is required for successful write
    For 2 nodes: (2/2)+1~=2minimum of 2 node is required for successful write. So If 1 node gets down quorum is not met and write operation wont be completed==no fault tolerance. No benefit of having 2 nodes over 1 node.
    For 3 nodes: (3/2)+1~=2minimum of 2 node is required for successful write. So If 1 node gets down,2 nodes are left, write operation will be completed==fault tolerance 
    For 4 nodes: (4/2)+1~=3minimum of 3 node is required for successful write. So If 1 node gets down,3 nodes are left, write operation will be completed==fault tolerance.if 2 goes down, quorum is not met, no benefit of having 4 node over 3 nodes
    For 5 nodes: (5/2)+1~=3minimum of 3 node is required for successful write. even If 2 node gets down,3 nodes are left, write operation will be completed==fault tolerance 

 So it is Best Practice to have odd number of ETCD nodes for the highest fault tolerance. 





## ETCDCTL
etcdctl put name john
etcdctl get name
export ETCDCTL_API=3
name






# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO

- ETCD is a distributed and reliable key-value store

- ETCD em HA elege um lider.
- O lider processa os dados e envia uma cópia aos demais membros.
- Após certo tempo, o algoritmo RAFT inicia uma nova votação e descarta aquele candidato que não enviar um sinal que está online ainda.

- Quorum = N/2 +1

- Principal material
<https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/>

- ETCDCTL é utilizado para inserir ou obter dados do etcd. Ele existe nas versões 2 ou 3. Importante setar a versão via variável "export ETCDCTL_API=3", pois alguns comandos podem não funcionar entre as versões.

- As quantidades de 3, 5 ou 7, são bons números para se usar, na quantidade de etcd para HA.
3 suporta 1 instancia down.
5 suporta 2 instancias down.
7 suporta 3 instancias down.