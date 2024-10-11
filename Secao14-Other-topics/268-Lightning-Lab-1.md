#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "268 - Lightning Lab - 1."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
##  Lightning Lab - 1



### 1 / 7
Weight: 15

Upgrade the current version of kubernetes from 1.29.0 to 1.30.0 exactly using the kubeadm utility. Make sure that the upgrade is carried out one node at a time starting with the controlplane node. To minimize downtime, the deployment gold-nginx should be rescheduled on an alternate node before upgrading each node.

Upgrade controlplane node first and drain node node01 before upgrading it. Pods for gold-nginx should run on the controlplane node subsequently.

Cluster Upgraded?

pods 'gold-nginx' running on controlplane?



controlplane ~ ➜  kubectl get node
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   69m   v1.29.0
node01         Ready    <none>          68m   v1.29.0

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE     IP             NODE           NOMINATED NODE   READINESS GATES
admin2406     deploy1-67b55d4f9f-9m484               1/1     Running   0             2m22s   10.244.192.2   node01         <none>           <none>
admin2406     deploy2-5d4697f587-g2gld               1/1     Running   0             2m22s   10.244.192.3   node01         <none>           <none>
admin2406     deploy3-59985b7bb9-7zfns               1/1     Running   0             2m21s   10.244.192.4   node01         <none>           <none>
admin2406     deploy4-c669bb985-dgddj                1/1     Running   0             2m21s   10.244.192.5   node01         <none>           <none>
admin2406     deploy5-7d5f6f769b-hwsl9               1/1     Running   0             2m21s   10.244.192.6   node01         <none>           <none>
alpha         alpha-mysql-5b944d484-m8t84            0/1     Pending   0             2m23s   <none>         <none>         <none>           <none>
default       gold-nginx-5d9489d9cc-kgq7g            1/1     Running   0             2m28s   10.244.192.1   node01         <none>           <none>
kube-system   coredns-69f9c977-5k82g                 1/1     Running   0             69m     10.244.0.2     controlplane   <none>           <none>
kube-system   coredns-69f9c977-k9f4g                 1/1     Running   0             69m     10.244.0.3     controlplane   <none>           <none>
kube-system   etcd-controlplane                      1/1     Running   0             69m     192.0.254.6    controlplane   <none>           <none>
kube-system   kube-apiserver-controlplane            1/1     Running   0             69m     192.0.254.6    controlplane   <none>           <none>
kube-system   kube-controller-manager-controlplane   1/1     Running   0             69m     192.0.254.6    controlplane   <none>           <none>
kube-system   kube-proxy-7l5ff                       1/1     Running   0             69m     192.0.254.9    node01         <none>           <none>
kube-system   kube-proxy-gz22h                       1/1     Running   0             69m     192.0.254.6    controlplane   <none>           <none>
kube-system   kube-scheduler-controlplane            1/1     Running   0             69m     192.0.254.6    controlplane   <none>           <none>
kube-system   weave-net-5cxkb                        2/2     Running   1 (69m ago)   69m     192.0.254.6    controlplane   <none>           <none>
kube-system   weave-net-mzb97                        2/2     Running   0             69m     192.0.254.9    node01         <none>           <none>

controlplane ~ ➜  

https://v1-30.docs.kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/

sudo apt update
sudo apt-cache madison kubeadm