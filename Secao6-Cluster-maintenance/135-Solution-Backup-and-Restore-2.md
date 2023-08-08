


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

- Coletar os dados do etcd, para poder formar o comando etcdctl com os parametros necessários:
    advertise-url, para usar no endpoints
    key
    cert
    cacert

- A partir do próprio host student-node, verificar os Pods usando:
kubectl get pods -n kube-system

- Como tem um Pod do etcd, indica que é um Stacked Etcd.
- Depois de verificar o Pod, é necessário efetuar um describe nele, para obter os dados informados antes.
kubectl describe pod etcd-cluster1-controlplane -n kube-system

Obtendo:
      
    - --advertise-client-urls=https://192.2.217.8:2379
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt
    - --key-file=/etc/kubernetes/pki/etcd/server.key
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt

- Com as informações acima, idéia é formar um comando estilo este abaixo e enviar o arquivo via SCP para o host student:

~~~~bash
ssh cluster1-controlplane

ETCDCTL_API=3 etcdctl snapshot save \
  --cacert /etc/kubernetes/pki/etcd/ca.crt \
  --cert /etc/kubernetes/pki/etcd/server.crt \
  --key /etc/kubernetes/pki/etcd/server.key \
  cluster1.db

# Return to student node
exit

scp cluster1-controlplane:~/cluster1.db /opt/

~~~~
















15. An ETCD backup for cluster2 is stored at /opt/cluster2.db. Use this snapshot file to carry out a restore on cluster2 to a new path /var/lib/etcd-data-new.

1.  <details>
    <summary>An ETCD backup for cluster2 is stored at /opt/cluster2.db. Use this snapshot file to carry out a restore on cluster2 to a new path <b>/var/lib/etcd-data-new</b>.</summary>

    As you recall, `cluster2` is using _external_ etcd. This means
    * `etcd` does not have to be on the control plane node of the cluster. In this case, it is not.
    * `etcd` runs as an operating system service not a pod, therefore there is no manifest file to edit. Changes are instead made to a service unit file.</br></br>

    There are several parts to this question. Let's go through them one at a time.

    1.  <details>
        <summary>Move the backup to the etcd-server node</summary>

        ```bash
        scp /opt/cluster2.db etcd-server:~/
        ```
        </details>
    1.  <details>
        <summary>Log into etcd-server node</summary>

        ```bash
        ssh etcd-server
        ```

        </details>
    1.  <details>
        <summary>Check the ownership of the current etcd-data directory</summary>

        We will need to ensure correct ownership of our restored data. We determined the location of the data directory in Q12

        ```bash
        ls -ld /var/lib/etcd-data/
        ```

        > Note that owner and group are both `etcd`
        </details>
    1.  <details>
        <summary>Do the restore</summary>

        ```bash
        ETCDCTL_API=3 etcdctl snapshot restore \
            --data-dir /var/lib/etcd-data-new \
            cluster2.db
        ```

        </details>
    1.  <details>
        <summary>Set ownership on the restored directory</summary>

        ```bash
        chown -R etcd:etcd /var/lib/etcd-data-new
        ```

        </detials>
    1.  <details>
        <summary>Reconfigure and restart etcd</summary>

        We will need the location of the service unit file which we also determined in Q12

        ```bash
        vi /etc/systemd/system/etcd.service
        ```

        Edit the `--data-dir` argument to the newly restored directory, and save.

        Finally, reload and restart the `etcd` service. Whenever you have edited a service unit file, a `daemon-reload` is required to reload the in-memory configuration of the `systemd` service.

        ```bash
        systemctl daemon-reload
        systemctl restart etcd.service
        ```

        Return to the student node:

        ```bash
        exit
        ```

        </details>
    1.  <details>
        <summary>Verify the restore</summary>

        ```bash
        kubectl config use-context cluster2
        kubectl get all -n critical
        ```

        </details>
    </details>



15. 
An ETCD backup for cluster2 is stored at /opt/cluster2.db. Use this snapshot file to carry out a restore on cluster2 to a new path /var/lib/etcd-data-new.

As you recall, cluster2 is using external etcd. This means

    etcd does not have to be on the control plane node of the cluster. In this case, it is not.
    etcd runs as an operating system service not a pod, therefore there is no manifest file to edit. Changes are instead made to a service unit file.

There are several parts to this question. Let's go through them one at a time.

    Move the backup to the etcd-server node

    scp /opt/cluster2.db etcd-server:~/

Log into etcd-server node

ssh etcd-server

Check the ownership of the current etcd-data directory

We will need to ensure correct ownership of our restored data. We determined the location of the data directory in Q12

ls -ld /var/lib/etcd-data/

    Note that owner and group are both etcd

Do the restore

ETCDCTL_API=3 etcdctl snapshot restore \
    --data-dir /var/lib/etcd-data-new \
    cluster2.db

Set ownership on the restored directory

chown -R etcd:etcd /var/lib/etcd-data-new

Reconfigure and restart etcd

We will need the location of the service unit file which we also determined in Q12

vi /etc/systemd/system/etcd.service

Edit the --data-dir argument to the newly restored directory, and save.

Finally, reload and restart the etcd service. Whenever you have edited a service unit file, a daemon-reload is required to reload the in-memory configuration of the systemd service.

systemctl daemon-reload
systemctl restart etcd.service

Return to the student node:

exit

Verify the restore

kubectl config use-context cluster2
kubectl get all -n critical



- Efetuar restart dos seguintes serviços, após ajustar o ETCD External:
1. kube-controller-manager
2. scheduler

kubectl delete pods kube-controller-manager scheduler -n kube-system

- Depois é necessário acessar o controlplane do cluster2 via SSH:
ssh cluster2-controlplane

- Reiniciar o serviço do Kubelet
systemctl restart kubelet
systemctl status kubelet