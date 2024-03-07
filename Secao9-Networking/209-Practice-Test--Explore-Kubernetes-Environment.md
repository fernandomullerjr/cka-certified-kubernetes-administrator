
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "209. Practice Test - Explore Kubernetes Environment"
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  209. Practice Test - Explore Kubernetes Environment


How many nodes are part of this cluster?

Including the controlplane and worker nodes.

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   20m   v1.29.0
node01         Ready    <none>          20m   v1.29.0

controlplane ~ ➜  





What is the Internal IP address of the controlplane node in this cluster?


controlplane ~ ➜  kubectl get nodes -o wide
NAME           STATUS   ROLES           AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane   21m   v1.29.0   192.2.177.10   <none>        Ubuntu 22.04.3 LTS   5.4.0-1106-gcp   containerd://1.6.26
node01         Ready    <none>          20m   v1.29.0   192.2.177.3    <none>        Ubuntu 22.04.3 LTS   5.4.0-1106-gcp   containerd://1.6.26

controlplane ~ ➜  




What is the network interface configured for cluster connectivity on the controlplane node?

node-to-node communication

controlplane ~ ➜  ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: flannel.1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UNKNOWN group default 
    link/ether ea:54:16:5f:b7:f2 brd ff:ff:ff:ff:ff:ff
    inet 10.244.0.0/32 scope global flannel.1
       valid_lft forever preferred_lft forever
3: cni0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default qlen 1000
    link/ether da:6b:8f:9a:d4:f2 brd ff:ff:ff:ff:ff:ff
    inet 10.244.0.1/24 brd 10.244.0.255 scope global cni0
       valid_lft forever preferred_lft forever
4: veth7005ee2b@if2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue master cni0 state UP group default 
    link/ether ca:68:ba:ec:56:04 brd ff:ff:ff:ff:ff:ff link-netns cni-41534cd2-caf4-6dba-353f-921554488813
5: veth5e6cd51c@if2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue master cni0 state UP group default 
    link/ether e6:b2:05:3c:20:86 brd ff:ff:ff:ff:ff:ff link-netns cni-2f330487-e3e4-654f-e710-ffe84227a864
55: eth0@if56: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default 
    link/ether 02:42:c0:02:b1:0a brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.2.177.10/24 brd 192.2.177.255 scope global eth0
       valid_lft forever preferred_lft forever
75: eth1@if76: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:19:00:0d brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet 172.25.0.13/24 brd 172.25.0.255 scope global eth1
       valid_lft forever preferred_lft forever

controlplane ~ ➜  

controlplane ~ ✖ crictl ps -a
CONTAINER           IMAGE               CREATED             STATE               NAME                      ATTEMPT             POD ID              POD
2313b5df2f008       ead0a4a53df89       21 minutes ago      Running             coredns                   0                   6b6287bdcd425       coredns-69f9c977-8572c
f31cedf1c2035       ead0a4a53df89       21 minutes ago      Running             coredns                   0                   2da57eb5d2eaf       coredns-69f9c977-tzdcd
ee3b45e2f4b97       01cdfa8dd262f       21 minutes ago      Running             kube-flannel              0                   6e6a401c07f13       kube-flannel-ds-swk8m
45d8d4f88ca66       01cdfa8dd262f       21 minutes ago      Exited              install-cni               0                   6e6a401c07f13       kube-flannel-ds-swk8m
d4a209c1b5878       a55d1bad692b7       21 minutes ago      Exited              install-cni-plugin        0                   6e6a401c07f13       kube-flannel-ds-swk8m
82dbac374b418       98262743b26f9       21 minutes ago      Running             kube-proxy                0                   04a029a73b8f5       kube-proxy-nwzv2
fa835eb799dcc       a0eed15eed449       22 minutes ago      Running             etcd                      0                   35c0e4cd8c216       etcd-controlplane
befe25328eb2c       1443a367b16d3       22 minutes ago      Running             kube-apiserver            0                   ebbe097a1384c       kube-apiserver-controlplane
ab0a3d1fc1dbc       0824682bcdc8e       22 minutes ago      Running             kube-controller-manager   0                   32421ce7d8ec8       kube-controller-manager-controlplane
5a027f8f106b5       7ace497ddb8e8       22 minutes ago      Running             kube-scheduler            0                   8867d92b16a6e       kube-scheduler-controlplane

controlplane ~ ➜  









What is the MAC address of the interface on the controlplane node?

if56: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default 
    link/ether 02:42:c0:02:b1:0a brd ff:ff:ff:ff:ff:ff link-netns











What is the IP address assigned to node01?

controlplane ~ ➜  kubectl get nodes -o wide
NAME           STATUS   ROLES           AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane   21m   v1.29.0   192.2.177.10   <none>        Ubuntu 22.04.3 LTS   5.4.0-1106-gcp   containerd://1.6.26
node01         Ready    <none>          20m   v1.29.0   192.2.177.3    <none>        Ubuntu 22.04.3 LTS   5.4.0-1106-gcp   containerd://1.6.26

controlplane ~ ➜  










What is the MAC address assigned to node01?


controlplane ~ ➜  kubectl get nodes -o wide
NAME           STATUS   ROLES           AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane   21m   v1.29.0   192.2.177.10   <none>        Ubuntu 22.04.3 LTS   5.4.0-1106-gcp   containerd://1.6.26
node01         Ready    <none>          20m   v1.29.0   192.2.177.3    <none>        Ubuntu 22.04.3 LTS   5.4.0-1106-gcp   containerd://1.6.26

controlplane ~ ➜  

controlplane ~ ✖ cat /etc/hosts
127.0.0.1       localhost
::1     localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
192.2.177.10    controlplane
10.0.0.6 docker-registry-mirror.kodekloud.com

controlplane ~ ➜  ssh node01

node01 ~ ➜  
node01 ~ ➜  

node01 ~ ➜  ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: flannel.1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UNKNOWN group default 
    link/ether ea:d9:55:a6:2f:59 brd ff:ff:ff:ff:ff:ff
    inet 10.244.1.0/32 scope global flannel.1
       valid_lft forever preferred_lft forever
63: eth0@if64: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default 
    link/ether 02:42:c0:02:b1:03 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.2.177.3/24 brd 192.2.177.255 scope global eth0
       valid_lft forever preferred_lft forever
69: eth1@if70: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:19:00:0a brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet 172.25.0.10/24 brd 172.25.0.255 scope global eth1
       valid_lft forever preferred_lft forever

node01 ~ ➜  

63: eth0@if64: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default 
    link/ether 02:42:c0:02:b1:03 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.2.177.3/24 brd 192.2.177.255 scope global eth0
       valid_lft forever preferred_lft forever








We use Containerd as our container runtime. What is the interface/bridge created by Containerd on the controlplane node?

https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/troubleshooting-cni-plugin-related-errors/
<https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/troubleshooting-cni-plugin-related-errors/>

<https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/troubleshooting-cni-plugin-related-errors/#an-example-containerd-configuration-file>

An example containerd configuration file
The following example shows a configuration for containerd runtime v1.6.x, which supports a recent version of the CNI specification (v1.0.0).

cat << EOF | tee /etc/cni/net.d/10-containerd-net.conflist
{
 "cniVersion": "1.0.0",
 "name": "containerd-net",
 "plugins": [
   {
     "type": "bridge",
     "bridge": "cni0",
     "isGateway": true,
     "ipMasq": true,
     "promiscMode": true,
     "ipam": {
       "type": "host-local",
       "ranges": [
         [{
           "subnet": "10.88.0.0/16"
         }],
         [{
           "subnet": "2001:db8:4860::/64"
         }]
       ],
       "routes": [
         { "dst": "0.0.0.0/0" },
         { "dst": "::/0" }
       ]
     }
   },
   {
     "type": "portmap",
     "capabilities": {"portMappings": true},
     "externalSetMarkChain": "KUBE-MARK-MASQ"
   }
 ]
}
EOF


controlplane ~ ➜  cat /etc/cni/net.d/10-containerd-net.conflist
cat: /etc/cni/net.d/10-containerd-net.conflist: No such file or directory

controlplane ~ ✖ cat /etc/cni/net.d/
10-flannel.conflist   .kubernetes-cni-keep  

controlplane ~ ✖ cat /etc/cni/net.d/10-flannel.conflist 
{
  "name": "cbr0",
  "cniVersion": "0.3.1",
  "plugins": [
    {
      "type": "flannel",
      "delegate": {
        "hairpinMode": true,
        "isDefaultGateway": true
      }
    },
    {
      "type": "portmap",
      "capabilities": {
        "portMappings": true
      }
    }
  ]
}

controlplane ~ ➜  date
Thu Mar  7 01:11:20 AM UTC 2024

controlplane ~ ➜  