



167-Service-Accounts.md




# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# push

git status
git add .
git commit -m "167-Service-Accounts."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# 167-Service-Accounts



~~~~bash
fernando@debian10x64:~$ kubectl get sa
NAME      SECRETS   AGE
default   0         31d
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl get sa -A
NAMESPACE         NAME                                 SECRETS   AGE
backstage         default                              0         22h
default           default                              0         31d
kube-node-lease   default                              0         31d
kube-public       default                              0         31d
kube-system       attachdetach-controller              0         31d
kube-system       bootstrap-signer                     0         31d
kube-system       certificate-controller               0         31d
kube-system       cilium                               0         31d
kube-system       cilium-operator                      0         31d
kube-system       clusterrole-aggregation-controller   0         31d
kube-system       coredns                              0         31d
kube-system       cronjob-controller                   0         31d
kube-system       daemon-set-controller                0         31d
kube-system       default                              0         31d
kube-system       deployment-controller                0         31d
kube-system       disruption-controller                0         31d
kube-system       endpoint-controller                  0         31d
kube-system       endpointslice-controller             0         31d
kube-system       endpointslicemirroring-controller    0         31d
kube-system       ephemeral-volume-controller          0         31d
kube-system       expand-controller                    0         31d
kube-system       generic-garbage-collector            0         31d
kube-system       horizontal-pod-autoscaler            0         31d
kube-system       job-controller                       0         31d
kube-system       kube-proxy                           0         31d
kube-system       namespace-controller                 0         31d
kube-system       node-controller                      0         31d
kube-system       persistent-volume-binder             0         31d
kube-system       pod-garbage-collector                0         31d
kube-system       pv-protection-controller             0         31d
kube-system       pvc-protection-controller            0         31d
kube-system       replicaset-controller                0         31d
kube-system       replication-controller               0         31d
kube-system       resourcequota-controller             0         31d
kube-system       root-ca-cert-publisher               0         31d
kube-system       service-account-controller           0         31d
kube-system       service-controller                   0         31d
kube-system       statefulset-controller               0         31d
kube-system       token-cleaner                        0         31d
kube-system       ttl-after-finished-controller        0         31d
kube-system       ttl-controller                       0         31d
fernando@debian10x64:~$

~~~~