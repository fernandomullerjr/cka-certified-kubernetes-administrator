





# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# push

git status
git add .
git commit -m "165. Practice Test - Cluster Roles and Role Bindings."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# 165. Practice Test - Cluster Roles and Role Bindings


For the first few questions of this lab, you would have to inspect the existing ClusterRoles and ClusterRoleBindings that have been created in this cluster.


controlplane ~ ➜  kubectl get clusterrole
NAME                                                                   CREATED AT
cluster-admin                                                          2023-10-18T00:30:20Z
system:discovery                                                       2023-10-18T00:30:20Z
system:monitoring                                                      2023-10-18T00:30:20Z
system:basic-user                                                      2023-10-18T00:30:20Z
system:public-info-viewer                                              2023-10-18T00:30:20Z
system:aggregate-to-admin                                              2023-10-18T00:30:20Z
system:aggregate-to-edit                                               2023-10-18T00:30:20Z
system:aggregate-to-view                                               2023-10-18T00:30:20Z
system:heapster                                                        2023-10-18T00:30:21Z
system:node                                                            2023-10-18T00:30:21Z
system:node-problem-detector                                           2023-10-18T00:30:21Z
system:kubelet-api-admin                                               2023-10-18T00:30:21Z
system:node-bootstrapper                                               2023-10-18T00:30:21Z
system:auth-delegator                                                  2023-10-18T00:30:21Z
system:kube-aggregator                                                 2023-10-18T00:30:21Z
system:kube-controller-manager                                         2023-10-18T00:30:21Z
system:kube-dns                                                        2023-10-18T00:30:21Z
system:persistent-volume-provisioner                                   2023-10-18T00:30:21Z
system:certificates.k8s.io:certificatesigningrequests:nodeclient       2023-10-18T00:30:21Z
system:certificates.k8s.io:certificatesigningrequests:selfnodeclient   2023-10-18T00:30:21Z
system:volume-scheduler                                                2023-10-18T00:30:21Z
system:certificates.k8s.io:legacy-unknown-approver                     2023-10-18T00:30:21Z
system:certificates.k8s.io:kubelet-serving-approver                    2023-10-18T00:30:21Z
system:certificates.k8s.io:kube-apiserver-client-approver              2023-10-18T00:30:21Z
system:certificates.k8s.io:kube-apiserver-client-kubelet-approver      2023-10-18T00:30:21Z
system:service-account-issuer-discovery                                2023-10-18T00:30:21Z
system:node-proxier                                                    2023-10-18T00:30:21Z
system:kube-scheduler                                                  2023-10-18T00:30:21Z
system:controller:attachdetach-controller                              2023-10-18T00:30:21Z
system:controller:clusterrole-aggregation-controller                   2023-10-18T00:30:21Z
system:controller:cronjob-controller                                   2023-10-18T00:30:21Z
system:controller:daemon-set-controller                                2023-10-18T00:30:21Z
system:controller:deployment-controller                                2023-10-18T00:30:21Z
system:controller:disruption-controller                                2023-10-18T00:30:21Z
system:controller:endpoint-controller                                  2023-10-18T00:30:21Z
system:controller:endpointslice-controller                             2023-10-18T00:30:21Z
system:controller:endpointslicemirroring-controller                    2023-10-18T00:30:21Z
system:controller:expand-controller                                    2023-10-18T00:30:21Z
system:controller:ephemeral-volume-controller                          2023-10-18T00:30:21Z
system:controller:generic-garbage-collector                            2023-10-18T00:30:21Z
system:controller:horizontal-pod-autoscaler                            2023-10-18T00:30:21Z
system:controller:job-controller                                       2023-10-18T00:30:21Z
system:controller:namespace-controller                                 2023-10-18T00:30:21Z
system:controller:node-controller                                      2023-10-18T00:30:21Z
system:controller:persistent-volume-binder                             2023-10-18T00:30:21Z
system:controller:pod-garbage-collector                                2023-10-18T00:30:21Z
system:controller:replicaset-controller                                2023-10-18T00:30:21Z
system:controller:replication-controller                               2023-10-18T00:30:21Z
system:controller:resourcequota-controller                             2023-10-18T00:30:21Z
system:controller:route-controller                                     2023-10-18T00:30:21Z
system:controller:service-account-controller                           2023-10-18T00:30:21Z
system:controller:service-controller                                   2023-10-18T00:30:21Z
system:controller:statefulset-controller                               2023-10-18T00:30:21Z
system:controller:ttl-controller                                       2023-10-18T00:30:21Z
system:controller:certificate-controller                               2023-10-18T00:30:21Z
system:controller:pvc-protection-controller                            2023-10-18T00:30:21Z
system:controller:pv-protection-controller                             2023-10-18T00:30:21Z
system:controller:ttl-after-finished-controller                        2023-10-18T00:30:21Z
system:controller:root-ca-cert-publisher                               2023-10-18T00:30:21Z
k3s-cloud-controller-manager                                           2023-10-18T00:30:25Z
system:coredns                                                         2023-10-18T00:30:26Z
local-path-provisioner-role                                            2023-10-18T00:30:26Z
system:aggregated-metrics-reader                                       2023-10-18T00:30:26Z
system:metrics-server                                                  2023-10-18T00:30:27Z
clustercidrs-node                                                      2023-10-18T00:30:28Z
system:k3s-controller                                                  2023-10-18T00:30:28Z
view                                                                   2023-10-18T00:30:20Z
edit                                                                   2023-10-18T00:30:20Z
admin                                                                  2023-10-18T00:30:20Z
traefik-kube-system                                                    2023-10-18T00:31:15Z

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get clusterrolebind
error: the server doesn't have a resource type "clusterrolebind"

controlplane ~ ✖ kubectl get clusterrolebinding
NAME                                                   ROLE                                                               AGE
cluster-admin                                          ClusterRole/cluster-admin                                          17m
system:monitoring                                      ClusterRole/system:monitoring                                      17m
system:discovery                                       ClusterRole/system:discovery                                       17m
system:basic-user                                      ClusterRole/system:basic-user                                      17m
system:public-info-viewer                              ClusterRole/system:public-info-viewer                              17m
system:node-proxier                                    ClusterRole/system:node-proxier                                    17m
system:kube-controller-manager                         ClusterRole/system:kube-controller-manager                         17m
system:kube-dns                                        ClusterRole/system:kube-dns                                        17m
system:kube-scheduler                                  ClusterRole/system:kube-scheduler                                  17m
system:volume-scheduler                                ClusterRole/system:volume-scheduler                                17m
system:node                                            ClusterRole/system:node                                            17m
system:service-account-issuer-discovery                ClusterRole/system:service-account-issuer-discovery                17m
system:controller:attachdetach-controller              ClusterRole/system:controller:attachdetach-controller              17m
system:controller:clusterrole-aggregation-controller   ClusterRole/system:controller:clusterrole-aggregation-controller   17m
system:controller:cronjob-controller                   ClusterRole/system:controller:cronjob-controller                   17m
system:controller:daemon-set-controller                ClusterRole/system:controller:daemon-set-controller                17m
system:controller:deployment-controller                ClusterRole/system:controller:deployment-controller                17m
system:controller:disruption-controller                ClusterRole/system:controller:disruption-controller                17m
system:controller:endpoint-controller                  ClusterRole/system:controller:endpoint-controller                  17m
system:controller:endpointslice-controller             ClusterRole/system:controller:endpointslice-controller             17m
system:controller:endpointslicemirroring-controller    ClusterRole/system:controller:endpointslicemirroring-controller    17m
system:controller:expand-controller                    ClusterRole/system:controller:expand-controller                    17m
system:controller:ephemeral-volume-controller          ClusterRole/system:controller:ephemeral-volume-controller          17m
system:controller:generic-garbage-collector            ClusterRole/system:controller:generic-garbage-collector            17m
system:controller:horizontal-pod-autoscaler            ClusterRole/system:controller:horizontal-pod-autoscaler            17m
system:controller:job-controller                       ClusterRole/system:controller:job-controller                       17m
system:controller:namespace-controller                 ClusterRole/system:controller:namespace-controller                 17m
system:controller:node-controller                      ClusterRole/system:controller:node-controller                      17m
system:controller:persistent-volume-binder             ClusterRole/system:controller:persistent-volume-binder             17m
system:controller:pod-garbage-collector                ClusterRole/system:controller:pod-garbage-collector                17m
system:controller:replicaset-controller                ClusterRole/system:controller:replicaset-controller                17m
system:controller:replication-controller               ClusterRole/system:controller:replication-controller               17m
system:controller:resourcequota-controller             ClusterRole/system:controller:resourcequota-controller             17m
system:controller:route-controller                     ClusterRole/system:controller:route-controller                     17m
system:controller:service-account-controller           ClusterRole/system:controller:service-account-controller           17m
system:controller:service-controller                   ClusterRole/system:controller:service-controller                   17m
system:controller:statefulset-controller               ClusterRole/system:controller:statefulset-controller               17m
system:controller:ttl-controller                       ClusterRole/system:controller:ttl-controller                       17m
system:controller:certificate-controller               ClusterRole/system:controller:certificate-controller               17m
system:controller:pvc-protection-controller            ClusterRole/system:controller:pvc-protection-controller            17m
system:controller:pv-protection-controller             ClusterRole/system:controller:pv-protection-controller             17m
system:controller:ttl-after-finished-controller        ClusterRole/system:controller:ttl-after-finished-controller        17m
system:controller:root-ca-cert-publisher               ClusterRole/system:controller:root-ca-cert-publisher               17m
k3s-cloud-controller-manager                           ClusterRole/k3s-cloud-controller-manager                           17m
k3s-cloud-controller-manager-auth-delegator            ClusterRole/system:auth-delegator                                  17m
system:coredns                                         ClusterRole/system:coredns                                         17m
local-path-provisioner-bind                            ClusterRole/local-path-provisioner-role                            17m
metrics-server:system:auth-delegator                   ClusterRole/system:auth-delegator                                  17m
system:metrics-server                                  ClusterRole/system:metrics-server                                  17m
clustercidrs-node                                      ClusterRole/clustercidrs-node                                      17m
kube-apiserver-kubelet-admin                           ClusterRole/system:kubelet-api-admin                               17m
system:k3s-controller                                  ClusterRole/system:k3s-controller                                  17m
helm-kube-system-traefik                               ClusterRole/cluster-admin                                          17m
helm-kube-system-traefik-crd                           ClusterRole/cluster-admin                                          17m
traefik-kube-system                                    ClusterRole/traefik-kube-system                                    16m

controlplane ~ ➜  

controlplane ~ ➜  











How many ClusterRoles do you see defined in the cluster?

controlplane ~ ➜  kubectl get clusterrole --no-headers | wc
       70       140      6440

controlplane ~ ➜  












How many ClusterRoleBindings exist on the cluster?


controlplane ~ ➜  kubectl get clusterrolebinding --no-headers | wc
       55       165      6930

controlplane ~ ➜  











What namespace is the cluster-admin clusterrole part of?

controlplane ~ ➜  kubectl get clusterrole | grep admin
cluster-admin                                                          2023-10-18T00:30:20Z
system:aggregate-to-admin                                              2023-10-18T00:30:20Z
system:kubelet-api-admin                                               2023-10-18T00:30:21Z
admin                                                                  2023-10-18T00:30:20Z

controlplane ~ ➜  kubectl describe clusterrole cluster-admin
Name:         cluster-admin
Labels:       kubernetes.io/bootstrapping=rbac-defaults
Annotations:  rbac.authorization.kubernetes.io/autoupdate: true
PolicyRule:
  Resources  Non-Resource URLs  Resource Names  Verbs
  ---------  -----------------  --------------  -----
  *.*        []                 []              [*]
             [*]                []              [*]

controlplane ~ ➜  kubectl get clusterrole cluster-admin -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  creationTimestamp: "2023-10-18T00:30:20Z"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
  name: cluster-admin
  resourceVersion: "68"
  uid: a3addf41-697f-427d-b29d-3cfeea890a6e
rules:
- apiGroups:
  - '*'
  resources:
  - '*'
  verbs:
  - '*'
- nonResourceURLs:
  - '*'
  verbs:
  - '*'

controlplane ~ ➜  


- RESPOSTA
ClusterRole abrange o cluster inteiro, não é definida por Namespace.













What user/groups are the cluster-admin role bound to?

The ClusterRoleBinding for the role is with the same name.


controlplane ~ ➜  kubectl get clusterrolebinding cluster-admin -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  creationTimestamp: "2023-10-18T00:30:21Z"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
  name: cluster-admin
  resourceVersion: "133"
  uid: ab9bd73a-f8f8-4af6-9c78-336109a01840
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: system:masters

controlplane ~ ➜  kubectl describe clusterrolebinding cluster-admin
Name:         cluster-admin
Labels:       kubernetes.io/bootstrapping=rbac-defaults
Annotations:  rbac.authorization.kubernetes.io/autoupdate: true
Role:
  Kind:  ClusterRole
  Name:  cluster-admin
Subjects:
  Kind   Name            Namespace
  ----   ----            ---------
  Group  system:masters  

controlplane ~ ➜  












What level of permission does the cluster-admin role grant?

Inspect the cluster-admin role's privileges.

- RESPOSTA
Todas ações

















A new user michelle joined the team. She will be focusing on the nodes in the cluster. Create the required ClusterRoles and ClusterRoleBindings so she gets access to the nodes.

    Grant permission to access nodes

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/165-clusterrole.yaml
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/165-clusterrolebinding.yaml

controlplane ~ ➜  vi clusterrole.yaml 

controlplane ~ ➜  vi clusterrolebinding.yaml

controlplane ~ ➜  kubectl apply -f clusterrole.yaml 
clusterrole.rbac.authorization.k8s.io/mich-admin created

controlplane ~ ➜  kubectl apply -f clusterrolebinding.yaml
clusterrolebinding.rbac.authorization.k8s.io/mich-admin created

controlplane ~ ➜  




controlplane ~ ➜  vi clusterrolebinding.yaml

controlplane ~ ➜  v clusterrolebinding.yaml
-bash: v: command not found

controlplane ~ ✖ kubectl apply -f clusterrolebinding.yaml
clusterrolebinding.rbac.authorization.k8s.io/mich-admin configured

controlplane ~ ➜  kubectl get clusterrolebinding | grep mich
mich-admin                                             ClusterRole/mich-admin                                             4m3s

controlplane ~ ➜  kubectl get clusterrolebinding mich-admin 
NAME         ROLE                     AGE
mich-admin   ClusterRole/mich-admin   4m12s

controlplane ~ ➜  kubectl get clusterrolebinding mich-admin -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRoleBinding","metadata":{"annotations":{},"name":"mich-admin"},"roleRef":{"apiGroup":"rbac.authorization.k8s.io","kind":"ClusterRole","name":"mich-admin"},"subjects":[{"apiGroup":"rbac.authorization.k8s.io","kind":"User","name":"michelle"}]}
  creationTimestamp: "2023-10-18T01:01:52Z"
  name: mich-admin
  resourceVersion: "1247"
  uid: eadc5605-84cb-48c4-892e-62f5d5c38667
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: mich-admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: michelle

controlplane ~ ➜  kubectl describe clusterrolebinding mich-admin
Name:         mich-admin
Labels:       <none>
Annotations:  <none>
Role:
  Kind:  ClusterRole
  Name:  mich-admin
Subjects:
  Kind  Name      Namespace
  ----  ----      ---------
  User  michelle  

controlplane ~ ➜  



















michelle's responsibilities are growing and now she will be responsible for storage as well. Create the required ClusterRoles and ClusterRoleBindings to allow her access to Storage.

Get the API groups and resource names from command kubectl api-resources. Use the given spec:

    ClusterRole: storage-admin

    Resource: persistentvolumes

    Resource: storageclasses

    ClusterRoleBinding: michelle-storage-admin

    ClusterRoleBinding Subject: michelle

    ClusterRoleBinding Role: storage-admin



controlplane ~ ✖ kubectl api-resources
NAME                              SHORTNAMES   APIVERSION                             NAMESPACED   KIND
bindings                                       v1                                     true         Binding
componentstatuses                 cs           v1                                     false        ComponentStatus
configmaps                        cm           v1                                     true         ConfigMap
endpoints                         ep           v1                                     true         Endpoints
events                            ev           v1                                     true         Event
limitranges                       limits       v1                                     true         LimitRange
namespaces                        ns           v1                                     false        Namespace
nodes                             no           v1                                     false        Node
persistentvolumeclaims            pvc          v1                                     true         PersistentVolumeClaim
persistentvolumes                 pv           v1                                     false        PersistentVolume
pods                              po           v1                                     true         Pod
podtemplates                                   v1                                     true         PodTemplate
replicationcontrollers            rc           v1                                     true         ReplicationController
resourcequotas                    quota        v1                                     true         ResourceQuota
secrets                                        v1                                     true         Secret
serviceaccounts                   sa           v1                                     true         ServiceAccount
services                          svc          v1                                     true         Service
mutatingwebhookconfigurations                  admissionregistration.k8s.io/v1        false        MutatingWebhookConfiguration
validatingwebhookconfigurations                admissionregistration.k8s.io/v1        false        ValidatingWebhookConfiguration
customresourcedefinitions         crd,crds     apiextensions.k8s.io/v1                false        CustomResourceDefinition
apiservices                                    apiregistration.k8s.io/v1              false        APIService
controllerrevisions                            apps/v1                                true         ControllerRevision
daemonsets                        ds           apps/v1                                true         DaemonSet
deployments                       deploy       apps/v1                                true         Deployment
replicasets                       rs           apps/v1                                true         ReplicaSet
statefulsets                      sts          apps/v1                                true         StatefulSet
tokenreviews                                   authentication.k8s.io/v1               false        TokenReview
localsubjectaccessreviews                      authorization.k8s.io/v1                true         LocalSubjectAccessReview
selfsubjectaccessreviews                       authorization.k8s.io/v1                false        SelfSubjectAccessReview
selfsubjectrulesreviews                        authorization.k8s.io/v1                false        SelfSubjectRulesReview
subjectaccessreviews                           authorization.k8s.io/v1                false        SubjectAccessReview
horizontalpodautoscalers          hpa          autoscaling/v2                         true         HorizontalPodAutoscaler
cronjobs                          cj           batch/v1                               true         CronJob
jobs                                           batch/v1                               true         Job
certificatesigningrequests        csr          certificates.k8s.io/v1                 false        CertificateSigningRequest
leases                                         coordination.k8s.io/v1                 true         Lease
endpointslices                                 discovery.k8s.io/v1                    true         EndpointSlice
events                            ev           events.k8s.io/v1                       true         Event
flowschemas                                    flowcontrol.apiserver.k8s.io/v1beta3   false        FlowSchema
prioritylevelconfigurations                    flowcontrol.apiserver.k8s.io/v1beta3   false        PriorityLevelConfiguration
helmchartconfigs                               helm.cattle.io/v1                      true         HelmChartConfig
helmcharts                                     helm.cattle.io/v1                      true         HelmChart
addons                                         k3s.cattle.io/v1                       true         Addon
nodes                                          metrics.k8s.io/v1beta1                 false        NodeMetrics
pods                                           metrics.k8s.io/v1beta1                 true         PodMetrics
ingressclasses                                 networking.k8s.io/v1                   false        IngressClass
ingresses                         ing          networking.k8s.io/v1                   true         Ingress
networkpolicies                   netpol       networking.k8s.io/v1                   true         NetworkPolicy
runtimeclasses                                 node.k8s.io/v1                         false        RuntimeClass
poddisruptionbudgets              pdb          policy/v1                              true         PodDisruptionBudget
clusterrolebindings                            rbac.authorization.k8s.io/v1           false        ClusterRoleBinding
clusterroles                                   rbac.authorization.k8s.io/v1           false        ClusterRole
rolebindings                                   rbac.authorization.k8s.io/v1           true         RoleBinding
roles                                          rbac.authorization.k8s.io/v1           true         Role
priorityclasses                   pc           scheduling.k8s.io/v1                   false        PriorityClass
csidrivers                                     storage.k8s.io/v1                      false        CSIDriver
csinodes                                       storage.k8s.io/v1                      false        CSINode
csistoragecapacities                           storage.k8s.io/v1                      true         CSIStorageCapacity
storageclasses                    sc           storage.k8s.io/v1                      false        StorageClass
volumeattachments                              storage.k8s.io/v1                      false        VolumeAttachment
ingressroutes                                  traefik.containo.us/v1alpha1           true         IngressRoute
ingressroutetcps                               traefik.containo.us/v1alpha1           true         IngressRouteTCP
ingressrouteudps                               traefik.containo.us/v1alpha1           true         IngressRouteUDP
middlewares                                    traefik.containo.us/v1alpha1           true         Middleware
middlewaretcps                                 traefik.containo.us/v1alpha1           true         MiddlewareTCP
serverstransports                              traefik.containo.us/v1alpha1           true         ServersTransport
tlsoptions                                     traefik.containo.us/v1alpha1           true         TLSOption
tlsstores                                      traefik.containo.us/v1alpha1           true         TLSStore
traefikservices                                traefik.containo.us/v1alpha1           true         TraefikService

controlplane ~ ➜  


controlplane ~ ➜  ls
clusterrole.yaml         clusterrolebinding.yaml  sample.yaml

controlplane ~ ➜  vi storage-clusterrole.yaml

controlplane ~ ➜  kubectl apply -f storage-clusterrole.yaml
clusterrole.rbac.authorization.k8s.io/storage-admin created

controlplane ~ ➜  

controlplane ~ ➜  kubectl get clusterrole | grep stora
storage-admin                                                          2023-10-18T01:12:37Z

controlplane ~ ➜  kubectl get clusterrole storage-admin -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRole","metadata":{"annotations":{},"name":"storage-admin"},"rules":[{"apiGroups":["*"],"resources":["persistentvolumes","storageclasses"],"verbs":["*"]},{"nonResourceURLs":["*"],"verbs":["*"]}]}
  creationTimestamp: "2023-10-18T01:12:37Z"
  name: storage-admin
  resourceVersion: "1371"
  uid: 097ab7a8-8199-4e48-8abb-4c48a6d33c73
rules:
- apiGroups:
  - '*'
  resources:
  - persistentvolumes
  - storageclasses
  verbs:
  - '*'
- nonResourceURLs:
  - '*'
  verbs:
  - '*'

controlplane ~ ➜  kubectl describe clusterrole storage-admin -o yaml
error: unknown shorthand flag: 'o' in -o
See 'kubectl describe --help' for usage.

controlplane ~ ✖ kubectl describe clusterrole storage-admin 
Name:         storage-admin
Labels:       <none>
Annotations:  <none>
PolicyRule:
  Resources            Non-Resource URLs  Resource Names  Verbs
  ---------            -----------------  --------------  -----
  persistentvolumes.*  []                 []              [*]
  storageclasses.*     []                 []              [*]
                       [*]                []              [*]

controlplane ~ ➜  


controlplane ~ ➜  vi storage-clusterrolebinding.yaml

controlplane ~ ➜  kubectl apply -f storage-clusterrolebinding.yaml
clusterrolebinding.rbac.authorization.k8s.io/michelle-storage-admin created

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe clusterrolebinding michelle-storage-admin 
Name:         michelle-storage-admin
Labels:       <none>
Annotations:  <none>
Role:
  Kind:  ClusterRole
  Name:  storage-admin
Subjects:
  Kind  Name      Namespace
  ----  ----      ---------
  User  michelle  

controlplane ~ ➜  kubectl get clusterrolebinding michelle-storage-admin -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRoleBinding","metadata":{"annotations":{},"name":"michelle-storage-admin"},"roleRef":{"apiGroup":"rbac.authorization.k8s.io","kind":"ClusterRole","name":"storage-admin"},"subjects":[{"apiGroup":"rbac.authorization.k8s.io","kind":"User","name":"michelle"}]}
  creationTimestamp: "2023-10-18T01:14:26Z"
  name: michelle-storage-admin
  resourceVersion: "1405"
  uid: 555f66a5-773e-4d7e-bc49-7333ed3666b7
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: storage-admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: michelle

controlplane ~ ➜  