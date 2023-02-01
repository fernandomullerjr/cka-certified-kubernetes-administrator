
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 77. Practice Test - Multiple Schedulers"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
#  77. Practice Test - Multiple Schedulers


# What is the name of the POD that deploys the default kubernetes scheduler in this environment?

                                             

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
kube-flannel   kube-flannel-ds-bcg9n                  1/1     Running   0          6m24s
kube-system    coredns-787d4945fb-cpngd               1/1     Running   0          6m23s
kube-system    coredns-787d4945fb-gxqn8               1/1     Running   0          6m23s
kube-system    etcd-controlplane                      1/1     Running   0          6m32s
kube-system    kube-apiserver-controlplane            1/1     Running   0          6m32s
kube-system    kube-controller-manager-controlplane   1/1     Running   0          6m36s
kube-system    kube-proxy-6n28d                       1/1     Running   0          6m24s
kube-system    kube-scheduler-controlplane            1/1     Running   0          6m38s

controlplane ~ ➜  kubectl get pods -A | grep sched
kube-system    kube-scheduler-controlplane            1/1     Running   0          6m55s

controlplane ~ ➜  



- RESPOSTA:
  kube-scheduler-controlplane








# What is the image used to deploy the kubernetes scheduler?

Inspect the kubernetes scheduler pod and identify the image



controlplane ~ ➜  kubectl get pod kube-scheduler-controlplane -n kube-system -o yaml | grep image
    image: registry.k8s.io/kube-scheduler:v1.26.0
    imagePullPolicy: IfNotPresent
    image: registry.k8s.io/kube-scheduler:v1.26.0
    imageID: registry.k8s.io/kube-scheduler@sha256:34a142549f94312b41d4a6cd98e7fddabff484767a199333acb7503bf46d7410

controlplane ~ ➜  


- RESPOSTA:
registry.k8s.io/kube-scheduler:v1.26.0











# We have already created the ServiceAccount and ClusterRoleBinding that our custom scheduler will make use of.

Checkout the following Kubernetes objects:

ServiceAccount: my-scheduler (kube-system namespace)
ClusterRoleBinding: my-scheduler-as-kube-scheduler
ClusterRoleBinding: my-scheduler-as-volume-scheduler

Run the command: kubectl get serviceaccount -n kube-system and kubectl get clusterrolebinding

Note: - Don't worry if you are not familiar with these resources. We will cover it later on.


controlplane ~ ➜  kubectl get serviceaccount -n kube-system
NAME                                 SECRETS   AGE
attachdetach-controller              0         8m41s
bootstrap-signer                     0         8m41s
certificate-controller               0         8m41s
clusterrole-aggregation-controller   0         8m39s
coredns                              0         8m47s
cronjob-controller                   0         8m41s
daemon-set-controller                0         8m39s
default                              0         8m38s
deployment-controller                0         8m41s
disruption-controller                0         8m52s
endpoint-controller                  0         8m41s
endpointslice-controller             0         8m52s
endpointslicemirroring-controller    0         8m41s
ephemeral-volume-controller          0         8m41s
expand-controller                    0         8m41s
generic-garbage-collector            0         8m41s
horizontal-pod-autoscaler            0         8m51s
job-controller                       0         8m39s
kube-proxy                           0         8m47s
my-scheduler                         0         30s
namespace-controller                 0         8m41s
node-controller                      0         8m51s
persistent-volume-binder             0         8m41s
pod-garbage-collector                0         8m52s
pv-protection-controller             0         8m39s
pvc-protection-controller            0         8m40s
replicaset-controller                0         8m51s
replication-controller               0         8m52s
resourcequota-controller             0         8m39s
root-ca-cert-publisher               0         8m41s
service-account-controller           0         8m40s
service-controller                   0         8m40s
statefulset-controller               0         8m51s
token-cleaner                        0         8m41s
ttl-after-finished-controller        0         8m40s
ttl-controller                       0         8m40s

controlplane ~ ➜  



kubectl get clusterrolebinding


controlplane ~ ➜  kubectl get clusterrolebinding
NAME                                                   ROLE                                                                               AGE
cluster-admin                                          ClusterRole/cluster-admin                                                          9m33s
flannel                                                ClusterRole/flannel                                                                9m24s
kubeadm:get-nodes                                      ClusterRole/kubeadm:get-nodes                                                      9m30s
kubeadm:kubelet-bootstrap                              ClusterRole/system:node-bootstrapper                                               9m30s
kubeadm:node-autoapprove-bootstrap                     ClusterRole/system:certificates.k8s.io:certificatesigningrequests:nodeclient       9m30s
kubeadm:node-autoapprove-certificate-rotation          ClusterRole/system:certificates.k8s.io:certificatesigningrequests:selfnodeclient   9m30s
kubeadm:node-proxier                                   ClusterRole/system:node-proxier                                                    9m27s
my-scheduler-as-kube-scheduler                         ClusterRole/system:kube-scheduler                                                  70s
my-scheduler-as-volume-scheduler                       ClusterRole/system:volume-scheduler                                                70s
system:basic-user                                      ClusterRole/system:basic-user                                                      9m33s
system:controller:attachdetach-controller              ClusterRole/system:controller:attachdetach-controller                              9m32s
system:controller:certificate-controller               ClusterRole/system:controller:certificate-controller                               9m32s
system:controller:clusterrole-aggregation-controller   ClusterRole/system:controller:clusterrole-aggregation-controller                   9m32s
system:controller:cronjob-controller                   ClusterRole/system:controller:cronjob-controller                                   9m32s
system:controller:daemon-set-controller                ClusterRole/system:controller:daemon-set-controller                                9m32s
system:controller:deployment-controller                ClusterRole/system:controller:deployment-controller                                9m32s
system:controller:disruption-controller                ClusterRole/system:controller:disruption-controller                                9m32s
system:controller:endpoint-controller                  ClusterRole/system:controller:endpoint-controller                                  9m32s
system:controller:endpointslice-controller             ClusterRole/system:controller:endpointslice-controller                             9m32s
system:controller:endpointslicemirroring-controller    ClusterRole/system:controller:endpointslicemirroring-controller                    9m32s
system:controller:ephemeral-volume-controller          ClusterRole/system:controller:ephemeral-volume-controller                          9m32s
system:controller:expand-controller                    ClusterRole/system:controller:expand-controller                                    9m32s
system:controller:generic-garbage-collector            ClusterRole/system:controller:generic-garbage-collector                            9m32s
system:controller:horizontal-pod-autoscaler            ClusterRole/system:controller:horizontal-pod-autoscaler                            9m32s
system:controller:job-controller                       ClusterRole/system:controller:job-controller                                       9m32s
system:controller:namespace-controller                 ClusterRole/system:controller:namespace-controller                                 9m32s
system:controller:node-controller                      ClusterRole/system:controller:node-controller                                      9m32s
system:controller:persistent-volume-binder             ClusterRole/system:controller:persistent-volume-binder                             9m32s
system:controller:pod-garbage-collector                ClusterRole/system:controller:pod-garbage-collector                                9m32s
system:controller:pv-protection-controller             ClusterRole/system:controller:pv-protection-controller                             9m32s
system:controller:pvc-protection-controller            ClusterRole/system:controller:pvc-protection-controller                            9m32s
system:controller:replicaset-controller                ClusterRole/system:controller:replicaset-controller                                9m32s
system:controller:replication-controller               ClusterRole/system:controller:replication-controller                               9m32s
system:controller:resourcequota-controller             ClusterRole/system:controller:resourcequota-controller                             9m32s
system:controller:root-ca-cert-publisher               ClusterRole/system:controller:root-ca-cert-publisher                               9m32s
system:controller:route-controller                     ClusterRole/system:controller:route-controller                                     9m32s
system:controller:service-account-controller           ClusterRole/system:controller:service-account-controller                           9m32s
system:controller:service-controller                   ClusterRole/system:controller:service-controller                                   9m32s
system:controller:statefulset-controller               ClusterRole/system:controller:statefulset-controller                               9m32s
system:controller:ttl-after-finished-controller        ClusterRole/system:controller:ttl-after-finished-controller                        9m32s
system:controller:ttl-controller                       ClusterRole/system:controller:ttl-controller                                       9m32s
system:coredns                                         ClusterRole/system:coredns                                                         9m27s
system:discovery                                       ClusterRole/system:discovery                                                       9m33s
system:kube-controller-manager                         ClusterRole/system:kube-controller-manager                                         9m33s
system:kube-dns                                        ClusterRole/system:kube-dns                                                        9m33s
system:kube-scheduler                                  ClusterRole/system:kube-scheduler                                                  9m32s
system:monitoring                                      ClusterRole/system:monitoring                                                      9m33s
system:node                                            ClusterRole/system:node                                                            9m32s
system:node-proxier                                    ClusterRole/system:node-proxier                                                    9m33s
system:public-info-viewer                              ClusterRole/system:public-info-viewer                                              9m33s
system:service-account-issuer-discovery                ClusterRole/system:service-account-issuer-discovery                                9m32s
system:volume-scheduler                                ClusterRole/system:volume-scheduler                                                9m32s

controlplane ~ ➜  