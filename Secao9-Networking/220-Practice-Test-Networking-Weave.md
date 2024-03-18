
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "220. Practice Test - Networking Weave."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
## 220. Practice Test - Networking Weave

How many Nodes are part of this cluster?

Including master and worker nodes

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   37m   v1.29.0
node01         Ready    <none>          36m   v1.29.0

controlplane ~ ➜  



What is the Networking Solution used by this cluster?

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE
kube-system   coredns-69f9c977-nvflp                 1/1     Running   0             37m
kube-system   coredns-69f9c977-sd4rl                 1/1     Running   0             37m
kube-system   etcd-controlplane                      1/1     Running   0             38m
kube-system   kube-apiserver-controlplane            1/1     Running   0             38m
kube-system   kube-controller-manager-controlplane   1/1     Running   0             38m
kube-system   kube-proxy-pl7cc                       1/1     Running   0             37m
kube-system   kube-proxy-t4l84                       1/1     Running   0             37m
kube-system   kube-scheduler-controlplane            1/1     Running   0             38m
kube-system   weave-net-rgk8k                        2/2     Running   0             37m
kube-system   weave-net-rzl46                        2/2     Running   1 (37m ago)   37m

controlplane ~ ➜  











How many weave agents/peers are deployed in this cluster?


controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE
kube-system   coredns-69f9c977-nvflp                 1/1     Running   0             37m
kube-system   coredns-69f9c977-sd4rl                 1/1     Running   0             37m
kube-system   etcd-controlplane                      1/1     Running   0             38m
kube-system   kube-apiserver-controlplane            1/1     Running   0             38m
kube-system   kube-controller-manager-controlplane   1/1     Running   0             38m
kube-system   kube-proxy-pl7cc                       1/1     Running   0             37m
kube-system   kube-proxy-t4l84                       1/1     Running   0             37m
kube-system   kube-scheduler-controlplane            1/1     Running   0             38m
kube-system   weave-net-rgk8k                        2/2     Running   0             37m
kube-system   weave-net-rzl46                        2/2     Running   1 (37m ago)   37m

controlplane ~ ➜  

node01 ~ ✖ crictl ps
CONTAINER           IMAGE               CREATED             STATE               NAME                ATTEMPT             POD ID              POD
a521ba4a4be72       7f92d556d4ffe       37 minutes ago      Running             weave-npc           0                   1141e6d14aeb2       weave-net-rgk8k
9f86edbd7fba4       df29c0a4002c0       37 minutes ago      Running             weave               0                   1141e6d14aeb2       weave-net-rgk8k
3b20eab33b28e       98262743b26f9       37 minutes ago      Running             kube-proxy          0                   70e0b08bd5a8a       kube-proxy-t4l84

node01 ~ ➜  





On which nodes are the weave peers present?



Identify the name of the bridge network/interface created by weave on each node.


node01 ~ ➜  ifconfig -a
datapath: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1376
        ether b6:d3:a7:83:a0:0e  txqueuelen 1000  (Ethernet)
        RX packets 23  bytes 656 (656.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 192.0.23.6  netmask 255.255.255.0  broadcast 192.0.23.255
        ether 02:42:c0:00:17:06  txqueuelen 0  (Ethernet)
        RX packets 5494  bytes 2810629 (2.8 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 5733  bytes 691711 (691.7 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.25.0.47  netmask 255.255.255.0  broadcast 172.25.0.255
        ether 02:42:ac:19:00:2f  txqueuelen 0  (Ethernet)
        RX packets 469  bytes 376040 (376.0 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 242  bytes 25779 (25.7 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2460  bytes 297071 (297.0 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2460  bytes 297071 (297.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vethwe-bridge: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1376
        ether 6a:dd:ca:ef:3b:8b  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 24  bytes 1032 (1.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vethwe-datapath: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1376
        ether ba:f8:a0:33:3f:20  txqueuelen 0  (Ethernet)
        RX packets 24  bytes 1032 (1.0 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vxlan-6784: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 65535
        ether 5e:af:e1:15:14:a7  txqueuelen 1000  (Ethernet)
        RX packets 18  bytes 24768 (24.7 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 18  bytes 24768 (24.7 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

weave: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1376
        inet 10.244.0.1  netmask 255.255.0.0  broadcast 10.244.255.255
        ether d2:d2:7e:37:c7:f5  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 24  bytes 1032 (1.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


node01 ~ ➜  


controlplane ~ ➜  

controlplane ~ ➜  ifconfig -a
datapath: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1376
        ether 5e:83:cf:07:05:b9  txqueuelen 1000  (Ethernet)
        RX packets 36  bytes 2052 (2.0 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 192.0.23.3  netmask 255.255.255.0  broadcast 192.0.23.255
        ether 02:42:c0:00:17:03  txqueuelen 0  (Ethernet)
        RX packets 6790  bytes 804414 (804.4 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 5246  bytes 3282839 (3.2 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.25.0.53  netmask 255.255.255.0  broadcast 172.25.0.255
        ether 02:42:ac:19:00:35  txqueuelen 0  (Ethernet)
        RX packets 1900  bytes 16811835 (16.8 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1675  bytes 135290 (135.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 412102  bytes 68435044 (68.4 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 412102  bytes 68435044 (68.4 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vethwe-bridge: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1376
        ether 6e:aa:b3:b8:27:c0  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 37  bytes 2610 (2.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vethwe-datapath: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1376
        ether d6:16:48:df:0b:68  txqueuelen 0  (Ethernet)
        RX packets 37  bytes 2610 (2.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vethwepl2f5578f: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1376
        ether 62:38:fb:17:25:c9  txqueuelen 0  (Ethernet)
        RX packets 2600  bytes 245465 (245.4 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2640  bytes 256405 (256.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vethwepl77a7b62: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1376
        ether c2:29:9f:d9:46:97  txqueuelen 0  (Ethernet)
        RX packets 2620  bytes 246975 (246.9 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2667  bytes 261306 (261.3 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vxlan-6784: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 65535
        ether 86:e3:20:5d:65:6d  txqueuelen 1000  (Ethernet)
        RX packets 18  bytes 24768 (24.7 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 18  bytes 24768 (24.7 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

weave: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1376
        inet 10.244.0.1  netmask 255.255.0.0  broadcast 10.244.255.255
        ether 1a:66:f0:b0:5c:38  txqueuelen 1000  (Ethernet)
        RX packets 5220  bytes 419360 (419.3 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 5249  bytes 513451 (513.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


controlplane ~ ➜  
















What is the POD IP address range configured by weave?


controlplane ~ ➜  ps -ef | grep -i wea
root        5427    4652  0 22:34 ?        00:00:00 /usr/bin/weave-npc
root        5662    4652  0 22:34 ?        00:00:00 /bin/sh /home/weave/launch.sh
root        5776    5662  0 22:34 ?        00:00:01 /home/weave/weaver --port=6783 --datapath=datapath --name=1a:66:f0:b0:5c:38 --http-addr=127.0.0.1:6784 --metrics-addr=0.0.0.0:6782 --docker-api= --no-dns --db-prefix=/weavedb/weave-net --ipalloc-range=10.244.0.0/16 --nickname=controlplane --ipalloc-init consensus=0 --conn-limit=200 --expect-npc --no-masq-local
root        6372    5662  0 22:34 ?        00:00:00 /home/weave/kube-utils -run-reclaim-daemon -node-name=controlplane -peer-name=1a:66:f0:b0:5c:38 -log-level=debug
root       10670    9822  0 23:14 pts/0    00:00:00 grep --color=auto -i wea

controlplane ~ ➜  

--ipalloc-range=10.244.0.0/16










What is the default gateway configured on the PODs scheduled on node01?

Try scheduling a pod on node01 and check ip route output


node01 ~ ➜  ip route
default via 172.25.0.1 dev eth1 
10.244.0.0/16 dev weave proto kernel scope link src 10.244.0.1 
172.25.0.0/24 dev eth1 proto kernel scope link src 172.25.0.47 
192.0.23.0/24 dev eth0 proto kernel scope link src 192.0.23.6 

node01 ~ ➜  


node01 ~ ✖ crictl exec -ti a521ba4a4be72 sh
/ # 
/ # ip route
default via 172.25.0.1 dev eth1 
10.244.0.0/16 dev weave scope link  src 10.244.0.1 
172.25.0.0/24 dev eth1 scope link  src 172.25.0.47 
192.0.23.0/24 dev eth0 scope link  src 192.0.23.6 
/ # 