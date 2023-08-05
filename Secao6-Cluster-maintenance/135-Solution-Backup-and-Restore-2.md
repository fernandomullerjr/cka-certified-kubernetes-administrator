


------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "135. Solution: Backup and Restore 2."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 135. Solution: Backup and Restore 2


Explore the student-node and the clusters it has access to.

kubectl config get-contexts



- Para verificar os clusters configurados, melhor maneira é usar os comandos:
kubectl config get-contexts
kubectl config view
kubectl config view # Show Merged kubeconfig settings.


If you want to see what the configuration file contains, then you can use the following command.

[user@host ~]$ kubectl config view

The kubectl configuration file comprehends three topics:

    Cluster: the URL for the API of a Kubernetes cluster. This URL identifies the cluster itself.

    User: credentials that identify a user connecting to the Kubernetes cluster.

    Context: puts together a cluster (the API URL) and a user (who is connecting to that cluster).

For example, you might have two contexts that are using different clusters but the same user.


~~~~bash

fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl config get-contexts
CURRENT   NAME                                                 CLUSTER                                              AUTHINFO                                             NAMESPACE
          arn:aws:eks:us-east-1:261106957109:cluster/eks-lab   arn:aws:eks:us-east-1:261106957109:cluster/eks-lab   arn:aws:eks:us-east-1:261106957109:cluster/eks-lab
*         minikube                                             minikube                                             minikube                                             default
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://bc1qzk3kxhdxnzkpdgdn9ueg34y08smxgfv0hxvcu3.gr7.us-east-1.eks.amazonaws.com
  name: arn:aws:eks:us-east-1:261106957109:cluster/eks-lab
- cluster:
    certificate-authority: /home/fernando/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Thu, 03 Aug 2023 00:05:48 -03
        provider: minikube.sigs.k8s.io
        version: v1.23.2
      name: cluster_info
    server: https://192.168.49.2:8443
  name: minikube
contexts:
- context:
    cluster: arn:aws:eks:us-east-1:261106957109:cluster/eks-lab
    user: arn:aws:eks:us-east-1:261106957109:cluster/eks-lab
  name: arn:aws:eks:us-east-1:261106957109:cluster/eks-lab
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Thu, 03 Aug 2023 00:05:48 -03
        provider: minikube.sigs.k8s.io
        version: v1.23.2
      name: context_info
    namespace: default
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: arn:aws:eks:us-east-1:261106957109:cluster/eks-lab
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - --region
      - us-east-1
      - eks
      - get-token
      - --cluster-name
      - eks-lab
      - --output
      - json
      command: aws
      env: null
      interactiveMode: IfAvailable
      provideClusterInfo: false
- name: minikube
  user:
    client-certificate: /home/fernando/.minikube/profiles/minikube/client.crt
    client-key: /home/fernando/.minikube/profiles/minikube/client.key
fernando@debian10x64:~$

~~~~












How is ETCD configured for cluster1?

- O jeito mais fácil de verificar a resposta para esta questão é utilizando o comando:
kubectl get pods -n kube-system
Deve existir um Pod do etcd, indicando que é um Stacked ETCD.

- Outra maneira para validar que o ETCD é Stacked, é verificando o apiserver:
kubectl describe pod kube-apiserver-cluster1-controlplane -n kube-system
Se houver uma linha na conf de etcd-server contendo ip de localhost(127.0.0.1), indica que o ETCD é Stacked.








How is ETCD configured for cluster2?

kubectl config use-context cluster2
kubectl get pods -n kube-system

    From the output we can see no pod for etcd. Since no etcd is not an option for a functioning cluster the answer must therefore be External ETCD

- SSH no controlplane do cluster2
verificando a pasta de manifests, não tem manifesto para o etcd.

- Verificando o apiserver:
kubectl describe pod kube-apiserver-cluster2-controlplane -n kube-system
Consta um ip externo na linha de conf sobre etcd-server, indicando que o etcd-server é externo(External ETCD)









What is the default data directory used the for ETCD datastore used in cluster1?

For this, we need to examine the etcd manifest on the control plane node, and we need to find out the hostpath of its etcd-data volume.

kubectl config use-context cluster1
kubectl get pods -n kube-system etcd-cluster1-controlplane -o yaml

In the output, find the volumes section. The host path of the volume named etcd-data is the answer.

    /var/lib/etcd






What is the IP address of the External ETCD datastore used in cluster2?

For this, we need to exampine the API server configuration

kubectl config use-context cluster2
kubectl get pods -n kube-system kube-apiserver-cluster2-controlplane -o yaml | grep etcd

    From the output, locate --etcd-servers. The IP address in this line is the answer.









What is the default data directory used the for ETCD datastore used in cluster2?

For this, we need to examine the system unit file for the etcd service. Remember that for external etcd, it is running as an operating system service.

ssh etcd-server

# Verify the name of the service
systemctl list-unit-files | grep etcd

# Using the output from above command
systemctl cat etcd.service

Note the comment line in the output. This tells you where the service unit file is. We are going to need to edit this file in a later question!

From the output, locate --data-dir

    /var/lib/etcd-data

Return to the student node:

exit













How many other nodes are part of the ETCD cluster that etcd-server is a part of?

This question is somewhat contentious. It ought not to contain the word other. The required answer is

    1

- Na questão original, fiz assim:

~~~~bash
How many nodes are part of the ETCD cluster that etcd-server is a part of?


etcd-server ~ ➜  etcdctl member list
{"level":"warn","ts":"2023-07-29T02:24:18.026Z","caller":"clientv3/retry_interceptor.go:62","msg":"retrying of unary invoker failed","target":"endpoint://client-93cf8af8-64e9-45db-9833-3da43ee7c129/127.0.0.1:2379","attempt":0,"error":"rpc error: code = DeadlineExceeded desc = latest balancer error: all SubConns are in TransientFailure, latest connection error: connection closed"}
Error: context deadline exceeded

etcd-server ~ ✖ 

~~~~

- O correto seria utilizar o ps -ef e o comando ETCDCTL_API=3 etcdctl, passando os parametros obtidos via ps -ef

 EXEMPLO

cluster2-controlplane ~ ➜  ps -ef | grep etcd
root        1756    1358  4 01:01 ?        00:03:08 kube-apiserver --advertise-address=192.2.217.10 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.pem --etcd-certfile=/etc/kubernetes/pki/etcd/etcd.pem --etcd-keyfile=/etc/kubernetes/pki/etcd/etcd-key.pem --etcd-servers=https://192.2.217.18:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root       11491   11395  0 02:20 pts/0    00:00:00 grep etcd

etcd-server ~ ➜  ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 01:00 ?        00:00:00 /sbin/init --log-level=err
root         237       1  0 01:00 ?        00:00:00 /lib/systemd/systemd-journald
root         318       1  0 01:00 ?        00:00:00 /lib/systemd/systemd-udevd
systemd+     444       1  0 01:00 ?        00:00:00 /lib/systemd/systemd-resolved
root         654       1  0 01:00 ?        00:00:00 /usr/bin/ttyd -p 8080 --ping-interval 30 -t fontSize=16 -t theme={"foreground": "#ef
message+     656       1  0 01:00 ?        00:00:00 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-acti
root         668       1  0 01:00 ?        00:00:00 /lib/systemd/systemd-logind
root         669       1  0 01:00 ?        00:00:00 /usr/sbin/sshd -D
etcd         860       1  1 01:00 ?        00:01:07 /usr/local/bin/etcd --name etcd-server --data-dir=/var/lib/etcd-data --cert-file=/et
root        1003     669  0 02:21 ?        00:00:00 sshd: root@pts/0
root        1014    1003  0 02:21 pts/0    00:00:00 -bash
root        1186    1014  0 02:22 pts/0    00:00:00 ps -ef

etcd-server ~ ➜  

Comando ajustado, ficaria algo parecido com isto:

ETCDCTL_API=3 etcdctl --endpoints=127.0.0.1:2379 --cacert=/etc/etcd/pki/ca.pem --cert=/etc/etcd/pki/etcd.pem --key=/etc/etcd/pki/etcd-key.pem member list

Que retorna apenas 1 membro da lista.




## CONTINUA EM
09:36



# Dia 04/08/2023




Take a backup of etcd on cluster1 and save it on the student-node at the path /opt/cluster1.db

If needed, make sure to set the context to cluster1 (on the student-node):

student-node ~ ➜  kubectl config use-context cluster1
Switched to context "cluster1".

student-node ~ ➜  



- Coletar os dados do etcd
    advertise-url, para usar no endpoints
    key
    cert
    cacert
