
- Dica:
para colar no terminal do Lab
shift+insert


ctrl + shift + C to copy








# NODE - CONECTAR

- Conectar num Node, nos laboratórios da KodeKloud:

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   46m   v1.24.0
node01         Ready    <none>          45m   v1.24.0

controlplane ~ ➜  ssh node01

root@node01 ~ ➜  

Usa o crictl ao invés do Docker, para gerenciar os Containers:
root@node01 /etc/kubernetes ➜  crictl ps
CONTAINER           IMAGE               CREATED             STATE               NAME                ATTEMPT             POD ID              POD
919ee2fcc7b51       334e4a014c81b       10 minutes ago      Running             static-greenbox     0                   05dfaa6b56008       static-greenbox-node01
6a26ebb4ef511       f03a23d55e578       47 minutes ago      Running             kube-flannel        0                   41927b68b32af       kube-flannel-ds-jdwzc
5a94f315aa9a1       77b49675beae1       47 minutes ago      Running             kube-proxy          0                   da411fa8fa32c       kube-proxy-wsfmh

root@node01 /etc/kubernetes ➜  
