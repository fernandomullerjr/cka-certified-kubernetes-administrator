

# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "210. Solution - Explore Environment"
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
## 210. Solution - Explore Environment


- Nesta questão:
    We use Containerd as our container runtime. What is the interface/bridge created by Containerd on the controlplane node?

- O comando para obter a interface correta seria este:
    ip address show type bridge

- Que traria apenas:

controlplane ~ ➜  ip address show type bridge
3: cni0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default qlen 1000
    link/ether da:6b:8f:9a:d4:f2 brd ff:ff:ff:ff:ff:ff
    inet 10.244.0.1/24 brd 10.244.0.255 scope global cni0
       valid_lft forever preferred_lft forever

controlplane ~ ➜  






- Nesta questão:

What is the port the kube-scheduler is listening on in the controlplane node?


- É utilizado o netstat ao invés do ss no video.

netstat -npl | grep -i scheduler

~~~~bash

root@debian10x64:/home/fernando/cursos/cka-certified-kubernetes-administrator# netstat -npl | grep -i scheduler
tcp        0      0 127.0.0.1:10259         0.0.0.0:*               LISTEN      1673/kube-scheduler
root@debian10x64:/home/fernando/cursos/cka-certified-kubernetes-administrator#
root@debian10x64:/home/fernando/cursos/cka-certified-kubernetes-administrator# date
Wed 06 Mar 2024 10:59:18 PM -03
root@debian10x64:/home/fernando/cursos/cka-certified-kubernetes-administrator#

fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ netstat
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 localhost:45450         localhost:2379          ESTABLISHED
tcp        0      0 localhost:2379          localhost:45570         ESTABLISHED
tcp        0      0 debian10x64:ssh         192.168.136.1:55023     ESTABLISHED
tcp        0      0 localhost:2379          localhost:45392         ESTABLISHED
tcp        0      0 localhost:45342         localhost:2379          ESTABLISHED
tcp        0      0 localhost:2379          localhost:45382         ESTABLISHED
tcp        0      0 localhost:45752         localhost:2379          ESTABLISHED
tcp        0      0 localhost:10257         localhost:33208         TIME_WAIT
tcp        0      0 localhost:2379          localhost:45356         ESTABLISHED
tcp        0      0 localhost:45356         localhost:2379          ESTABLISHED
tcp        0      0 localhost:2379          localhost:45702         ESTABLISHED
tcp        0      0 localhost:2379          localhost:45686         ESTABLISHED
tcp        0      0 localhost:45808         localhost:2379          ESTABLISHED
tcp        0      0 localhost:2379          localhost:45776         ESTABLISHED
tcp        0      0 localhost:45320         localhost:2379          ESTABLISHED
tcp        0      0 localhost:2379          localhost:45470         ESTABLISHED
tcp        0      0 localhost:45796         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45732         localhost:2379          ESTABLISHED
tcp        0      0 localhost:2379          localhost:45808         ESTABLISHED
tcp        0      0 localhost:45470         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45382         localhost:2379          ESTABLISHED
tcp        0      0 debian10x64:53174       debian10x64:6443        ESTABLISHED
tcp        0      0 localhost:2381          localhost:37384         TIME_WAIT
tcp        0      0 localhost:2379          localhost:45746         ESTABLISHED
tcp        0      0 localhost:45510         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45502         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45318         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45482         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45726         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45532         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45724         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45458         localhost:2379          ESTABLISHED
tcp        0      0 localhost:2379          localhost:45414         ESTABLISHED
tcp        0      0 localhost:2379          localhost:45482         ESTABLISHED
tcp        0      0 localhost:45700         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45780         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45406         localhost:2379          ESTABLISHED
tcp        0      0 localhost:2379          localhost:45696         ESTABLISHED
tcp        0      0 localhost:45422         localhost:2379          ESTABLISHED
tcp        0      0 localhost:2379          localhost:45612         ESTABLISHED
tcp        0      0 debian10x64:56616       162.247.241.2:https     ESTABLISHED
tcp        0      0 localhost:2379          localhost:45562         ESTABLISHED
tcp        0      0 localhost:45326         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45392         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45486         localhost:2379          ESTABLISHED
tcp        0      0 localhost:2379          localhost:45714         ESTABLISHED
tcp        0      0 localhost:2379          localhost:45400         ESTABLISHED
tcp        0      0 localhost:45460         localhost:2379          ESTABLISHED
tcp        0      0 localhost:45560         localhost:2379          ESTABLISHED
tcp        0      0 debian10x64:57272       162.247.241.2:https     ESTABLISHED
tcp        0      0 localhost:2379          localhost:45752         ESTABLISHED
tcp        0      0 localhost:2379          localhost:45780         ESTABLISHED
tcp        0      0 localhost:2379          localhost:45656         ESTABLISHED
tcp        0      0 localhost:2379          localhost:45700         ESTABLISHED
tcp        0      0 localhost:2379          localhost:45560         ESTABLISHED
tcp        0      0 localhost:2379          localhost:45766         ESTABLISHED
tcp        0      0 localhost:2381          localhost:50718         TIME_WAIT
q^C
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ netstat --help
usage: netstat [-vWeenNcCF] [<Af>] -r         netstat {-V|--version|-h|--help}
       netstat [-vWnNcaeol] [<Socket> ...]
       netstat { [-vWeenNac] -i | [-cnNe] -M | -s [-6tuw] }

        -r, --route              display routing table
        -i, --interfaces         display interface table
        -g, --groups             display multicast group memberships
        -s, --statistics         display networking statistics (like SNMP)
        -M, --masquerade         display masqueraded connections

        -v, --verbose            be verbose
        -W, --wide               don't truncate IP addresses
        -n, --numeric            don't resolve names
        --numeric-hosts          don't resolve host names
        --numeric-ports          don't resolve port names
        --numeric-users          don't resolve user names
        -N, --symbolic           resolve hardware names
        -e, --extend             display other/more information
        -p, --programs           display PID/Program name for sockets
        -o, --timers             display timers
        -c, --continuous         continuous listing

        -l, --listening          display listening server sockets
        -a, --all                display all sockets (default: connected)
        -F, --fib                display Forwarding Information Base (default)
        -C, --cache              display routing cache instead of FIB
        -Z, --context            display SELinux security context for sockets

  <Socket>={-t|--tcp} {-u|--udp} {-U|--udplite} {-S|--sctp} {-w|--raw}
           {-x|--unix} --ax25 --ipx --netrom
  <AF>=Use '-6|-4' or '-A <af>' or '--<af>'; default: inet
  List of possible address families (which support routing):
    inet (DARPA Internet) inet6 (IPv6) ax25 (AMPR AX.25)
    netrom (AMPR NET/ROM) ipx (Novell IPX) ddp (Appletalk DDP)
    x25 (CCITT X.25)
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$

~~~~


- Obtendo resultado via ss:

~~~~bash

root@debian10x64:/home/fernando/cursos/cka-certified-kubernetes-administrator# ss -tulp | grep -i scheduler
tcp    LISTEN  0       1024           127.0.0.1:10259             0.0.0.0:*      users:(("kube-scheduler",pid=1673,fd=3))
root@debian10x64:/home/fernando/cursos/cka-certified-kubernetes-administrator#

~~~~







- Questão:
Notice that ETCD is listening on two ports. Which of these have more client connections established?

- Usar:
netstat -npa | grep -i etcd | grep -i 2379 | wc -l
comparar com
netstat -npa | grep -i etcd | grep -i 2380 | wc -l




## PENDENTE
- Criar resumo.