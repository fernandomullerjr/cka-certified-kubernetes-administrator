
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


Leader Election - RAFT






Getting Started
wget -q --https-only \
"https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz"
tar -xvf etcd-v3.3.9-linux-amd64.tar.gz
mv etcd-v3.3.9-linux-amd64/etcd* /usr/local/bin/
mkdir -p /etc/etcd /var/lib/etcd
cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd




## Quorum

<https://www.linkedin.com/pulse/demystifying-kubernetes-etcd-high-availability-mohammad-akif-gc1ac/>

 Quorum = N/2 +1

    For 1 node: (1/2)+1~=1 minimum of 1 node is required for successful write
    For 2 nodes: (2/2)+1~=2minimum of 2 node is required for successful write. So If 1 node gets down quorum is not met and write operation wont be completed==no fault tolerance. No benefit of having 2 nodes over 1 node.
    For 3 nodes: (3/2)+1~=2minimum of 2 node is required for successful write. So If 1 node gets down,2 nodes are left, write operation will be completed==fault tolerance 
    For 4 nodes: (4/2)+1~=3minimum of 3 node is required for successful write. So If 1 node gets down,3 nodes are left, write operation will be completed==fault tolerance.if 2 goes down, quorum is not met, no benefit of having 4 node over 3 nodes
    For 5 nodes: (5/2)+1~=3minimum of 3 node is required for successful write. even If 2 node gets down,3 nodes are left, write operation will be completed==fault tolerance 

 So it is Best Practice to have odd number of ETCD nodes for the highest fault tolerance. 


# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO

- ETCD is a distributed and reliable key-value store

- ETCD em HA elege um lider.
- O lider processa os dados e envia uma cópia aos demais membros.