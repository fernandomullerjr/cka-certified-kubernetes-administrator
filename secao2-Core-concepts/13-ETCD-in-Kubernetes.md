
# ETCD in Kubernetes

- O ETCD Datastore armazena informações a respeito do Cluster, como:

• Nodes
• PODs
• Configs
• Secrets
• Accounts
• Roles
• Bindings
• Others


- Todas informações obtidas a partir do comando "kubectl get" é obtida do ETCD server.


# Setup - Manual

~~~~bash
wget -q --https-only \
"https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz"

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



- Ponto de atenção
a porta padrão onde o ETCD escuta é a porta 2379
    --advertise-client-urls https://${INTERNAL_IP}:2379 \\



# Setup - kubeadm

- Ao efetuar o deploy do Kubernetes via Kubeadm, tem um Pod do etcd no namespace kube-system.
- Exemplo do PDF:

~~~~bash
kubectl get pods -n kube-system
NAMESPACE NAME READY STATUS RESTARTS AGE
kube-system coredns-78fcdf6894-prwvl 1/1 Running 0 1h
kube-system coredns-78fcdf6894-vqd9w 1/1 Running 0 1h
kube-system etcd-master 1/1 Running 0 1h
kube-system kube-apiserver-master 1/1 Running 0 1h
kube-system kube-controller-manager-master 1/1 Running 0 1h
kube-system kube-proxy-f6k26 1/1 Running 0 1h
kube-system kube-proxy-hnzsw 1/1 Running 0 1h
kube-system kube-scheduler-master 1/1 Running 0 1h
kube-system weave-net-924k8 2/2 Running 1 1h
kube-system weave-net-hzfcz 2/2 Running 1 1h

Run inside the etcdmaster POD
kubectl exec etcd-master –n kube-system etcdctl get / --prefix –keys-only
/registry/apiregistration.k8s.io/apiservices/v1.
/registry/apiregistration.k8s.io/apiservices/v1.apps
/registry/apiregistration.k8s.io/apiservices/v1.authentication.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.authorization.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.autoscaling
/registry/apiregistration.k8s.io/apiservices/v1.batch
/registry/apiregistration.k8s.io/apiservices/v1.networking.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.rbac.authorization.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.storage.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.admissionregistration.k8s.io
~~~~



- Exemplo do meu Minikube:

~~~~bash
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ kubectl get pods -n kube-system
NAME                               READY   STATUS    RESTARTS      AGE
coredns-78fcd69978-8jj6b           1/1     Running   3 (91m ago)   5d23h
etcd-minikube                      1/1     Running   3 (91m ago)   5d23h
kube-apiserver-minikube            1/1     Running   3 (91m ago)   5d23h
kube-controller-manager-minikube   1/1     Running   4 (90m ago)   5d23h
kube-proxy-p7jhs                   1/1     Running   3 (91m ago)   5d23h
kube-scheduler-minikube            1/1     Running   3 (91m ago)   5d23h
storage-provisioner                1/1     Running   7 (89m ago)   5d23h
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$
~~~~


- Comando adaptado para o meu ambiente local no Minikube:
    kubectl exec etcd-minikube -n kube-system -- etcdctl get / --prefix --keys-only

- ERRO:

~~~~bash
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ kubectl exec etcd-minikube -n kube-system -- etcdctl get / --prefix --keys-only
{"level":"warn","ts":"2022-09-03T02:30:43.077Z","logger":"etcd-client","caller":"v3/retry_interceptor.go:62","msg":"retrying of unary invoker failed","target":"etcd-endpoints://0xc0005f6380/#initially=[127.0.0.1:2379]","attempt":0,"error":"rpc error: code = DeadlineExceeded desc = latest balancer error: last connection error: connection closed"}
Error: context deadline exceeded
command terminated with exit code 1
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$
~~~~



-NÑOK
alias etcdctl_mini="MY_IP=$(hostname -I |awk '{print $1}'|tr -d ' '); \
    ETCDCTL_API=3; \
    etcdctl --endpoints ${MY_IP}:2379 \
    --cacert='/var/lib/minikube/certs/etcd/ca.crt' \
    --cert='/var/lib/minikube/certs/etcd/peer.crt' \
    --key='/var/lib/minikube/certs/etcd/peer.key'"
etcdctl_mini put foo bar



- SOLUÇÃO:
- Fonte:
<https://stackoverflow.com/questions/47807892/how-to-access-kubernetes-keys-in-etcd>

kubectl -it exec etcd-minikube -n kube-system -- etcdctl --cacert='/var/lib/minikube/certs/etcd/ca.crt' --cert='/var/lib/minikube/certs/etcd/peer.crt' --key='/var/lib/minikube/certs/etcd/peer.key' put foo bar


fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$ kubectl -it exec etcd-minikube -n kube-system -- etcdctl --cacert='/var/lib/minikube/certs/etcd/ca.crt' --cert='/var/lib/minikube/certs/etcd/peer.crt' --key='/var/lib/minikube/certs/etcd/peer.key' put foo bar
OK
fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$



kubectl -it exec etcd-minikube -n kube-system -- etcdctl --cacert='/var/lib/minikube/certs/etcd/ca.crt' --cert='/var/lib/minikube/certs/etcd/peer.crt' --key='/var/lib/minikube/certs/etcd/peer.key' get foo


fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$ kubectl -it exec etcd-minikube -n kube-system -- etcdctl --cacert='/var/lib/minikube/certs/etcd/ca.crt' --cert='/var/lib/minikube/certs/etcd/peer.crt' --key='/var/lib/minikube/certs/etcd/peer.key' get foo
foo
bar
fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$



kubectl -it exec etcd-minikube -n kube-system -- etcdctl --cacert='/var/lib/minikube/certs/etcd/ca.crt' --cert='/var/lib/minikube/certs/etcd/peer.crt' --key='/var/lib/minikube/certs/etcd/peer.key' get / --prefix --keys-only


fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$
fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$ kubectl -it exec etcd-minikube -n kube-system -- etcdctl --cacert='/var/lib/minikube/certs/etcd/ca.crt' --cert='/var/lib/minikube/certs/etcd/peer.crt' --key='/var/lib/minikube/certs/etcd/peer.key' get / --prefix --keys-only
/registry/apiregistration.k8s.io/apiservices/v1.
/registry/apiregistration.k8s.io/apiservices/v1.admissionregistration.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.apiextensions.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.apps
/registry/apiregistration.k8s.io/apiservices/v1.authentication.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.authorization.k8s.io
[..................]
/registry/services/endpoints/kube-system/k8s.io-minikube-hostpath
/registry/services/endpoints/kube-system/kube-dns
/registry/services/specs/default/kubernetes
/registry/services/specs/kube-system/kube-dns
/registry/storageclasses/standard
fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$




# PENDENTE
- Aula continua aos 02:29
- Efetuar KB sobre a solução do meu problema no comando no Pod do etcd.