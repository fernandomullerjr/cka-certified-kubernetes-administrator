



# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# push

git status
git add .
git commit -m "164. Cluster Roles and Role Bindings."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
#  164. Cluster Roles and Role Bindings

# Cluster Roles  
In this section, we will take a look at cluster roles

## Roles
- Roles and Rolebindings are namespaced meaning they are created within namespaces.
  
  
## Namespaces
- Can you group or isolate nodes within  a namespace?
  - No, those are cluster wide or cluster scoped resources. They cannot be associated to any particular namespace.
  
  
- So the resources are categorized as either namespaced or cluster scoped.
  
- To see namespaced resources
  ```
  $ kubectl api-resources --namespaced=true
  ```
- To see non-namespaced resources
  ```
  $ $ kubectl api-resources --namespaced=false
  ```
  
  
## Cluster Roles and Cluster Role Bindings
- Cluster Roles are roles except they are for a cluster scoped resources. Kind as **`CLusterRole`** 
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRole
  metadata:
    name: cluster-administrator
  rules:
  - apiGroups: [""] # "" indicates the core API group
    resources: ["nodes"]
    verbs: ["get", "list", "delete", "create"]
  ```
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRoleBinding
  metadata:
    name: cluster-admin-role-binding
  subjects:
  - kind: User
    name: cluster-admin
    apiGroup: rbac.authorization.k8s.io
  roleRef:
    kind: ClusterRole
    name: cluster-administrator
    apiGroup: rbac.authorization.k8s.io
  ```
  ```
  $ kubectl create -f cluster-admin-role.yaml
  $ kubectl create -f cluster-admin-role-binding.yaml
  ```
  
  
- You can create a cluster role for namespace resources as well. When you do that user will have access to these resources across all namespaces.

#### K8s Reference Docs
- https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole
- https://kubernetes.io/docs/reference/access-authn-authz/rbac/#command-line-utilities
  
  




# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
#  164. Cluster Roles and Role Bindings


## Roles

Roles and Rolebindings are namespaced meaning they are created within namespaces.


## Namespaces

Can you group or isolate nodes within a namespace?

    No, those are cluster wide or cluster scoped resources. They cannot be associated to any particular namespace.






So the resources are categorized as either namespaced or cluster scoped.

To see namespaced resources

~~~~bash
$ kubectl api-resources --namespaced=true
~~~~

To see non-namespaced resources

~~~~bash
$ kubectl api-resources --namespaced=false
~~~~




- Exemplos de recursos Namespaced:

~~~~bash
fernando@debian10x64:~$ kubectl api-resources --namespaced=true
NAME                        SHORTNAMES     APIVERSION                     NAMESPACED   KIND
bindings                                   v1                             true         Binding
configmaps                  cm             v1                             true         ConfigMap
endpoints                   ep             v1                             true         Endpoints
events                      ev             v1                             true         Event
limitranges                 limits         v1                             true         LimitRange
persistentvolumeclaims      pvc            v1                             true         PersistentVolumeClaim
pods                        po             v1                             true         Pod
podtemplates                               v1                             true         PodTemplate
replicationcontrollers      rc             v1                             true         ReplicationController
resourcequotas              quota          v1                             true         ResourceQuota
secrets                                    v1                             true         Secret
serviceaccounts             sa             v1                             true         ServiceAccount
services                    svc            v1                             true         Service
controllerrevisions                        apps/v1                        true         ControllerRevision
daemonsets                  ds             apps/v1                        true         DaemonSet
deployments                 deploy         apps/v1                        true         Deployment
replicasets                 rs             apps/v1                        true         ReplicaSet
statefulsets                sts            apps/v1                        true         StatefulSet
localsubjectaccessreviews                  authorization.k8s.io/v1        true         LocalSubjectAccessReview
horizontalpodautoscalers    hpa            autoscaling/v2                 true         HorizontalPodAutoscaler
cronjobs                    cj             batch/v1                       true         CronJob
jobs                                       batch/v1                       true         Job
ciliumendpoints             cep,ciliumep   cilium.io/v2                   true         CiliumEndpoint
ciliumnetworkpolicies       cnp,ciliumnp   cilium.io/v2                   true         CiliumNetworkPolicy
ciliumnodeconfigs                          cilium.io/v2alpha1             true         CiliumNodeConfig
leases                                     coordination.k8s.io/v1         true         Lease
endpointslices                             discovery.k8s.io/v1            true         EndpointSlice
events                      ev             events.k8s.io/v1               true         Event
ingresses                   ing            networking.k8s.io/v1           true         Ingress
networkpolicies             netpol         networking.k8s.io/v1           true         NetworkPolicy
poddisruptionbudgets        pdb            policy/v1                      true         PodDisruptionBudget
rolebindings                               rbac.authorization.k8s.io/v1   true         RoleBinding
roles                                      rbac.authorization.k8s.io/v1   true         Role
csistoragecapacities                       storage.k8s.io/v1              true         CSIStorageCapacity
fernando@debian10x64:~$

~~~~



- Exemplos de recursos Cluster Scoped:

~~~~bash

fernando@debian10x64:~$ kubectl api-resources --namespaced=false
NAME                               SHORTNAMES                          APIVERSION                             NAMESPACED   KIND
componentstatuses                  cs                                  v1                                     false        ComponentStatus
namespaces                         ns                                  v1                                     false        Namespace
nodes                              no                                  v1                                     false        Node
persistentvolumes                  pv                                  v1                                     false        PersistentVolume
mutatingwebhookconfigurations                                          admissionregistration.k8s.io/v1        false        MutatingWebhookConfiguration
validatingwebhookconfigurations                                        admissionregistration.k8s.io/v1        false        ValidatingWebhookConfiguration
customresourcedefinitions          crd,crds                            apiextensions.k8s.io/v1                false        CustomResourceDefinition
apiservices                                                            apiregistration.k8s.io/v1              false        APIService
selfsubjectreviews                                                     authentication.k8s.io/v1               false        SelfSubjectReview
tokenreviews                                                           authentication.k8s.io/v1               false        TokenReview
selfsubjectaccessreviews                                               authorization.k8s.io/v1                false        SelfSubjectAccessReview
selfsubjectrulesreviews                                                authorization.k8s.io/v1                false        SelfSubjectRulesReview
subjectaccessreviews                                                   authorization.k8s.io/v1                false        SubjectAccessReview
certificatesigningrequests         csr                                 certificates.k8s.io/v1                 false        CertificateSigningRequest
ciliumcidrgroups                   ccg                                 cilium.io/v2alpha1                     false        CiliumCIDRGroup
ciliumclusterwidenetworkpolicies   ccnp                                cilium.io/v2                           false        CiliumClusterwideNetworkPolicy
ciliumexternalworkloads            cew                                 cilium.io/v2                           false        CiliumExternalWorkload
ciliumidentities                   ciliumid                            cilium.io/v2                           false        CiliumIdentity
ciliuml2announcementpolicies       l2announcement                      cilium.io/v2alpha1                     false        CiliumL2AnnouncementPolicy
ciliumloadbalancerippools          ippools,ippool,lbippool,lbippools   cilium.io/v2alpha1                     false        CiliumLoadBalancerIPPool
ciliumnodes                        cn,ciliumn                          cilium.io/v2                           false        CiliumNode
ciliumpodippools                   cpip                                cilium.io/v2alpha1                     false        CiliumPodIPPool
flowschemas                                                            flowcontrol.apiserver.k8s.io/v1beta3   false        FlowSchema
prioritylevelconfigurations                                            flowcontrol.apiserver.k8s.io/v1beta3   false        PriorityLevelConfiguration
ingressclasses                                                         networking.k8s.io/v1                   false        IngressClass
runtimeclasses                                                         node.k8s.io/v1                         false        RuntimeClass
clusterrolebindings                                                    rbac.authorization.k8s.io/v1           false        ClusterRoleBinding
clusterroles                                                           rbac.authorization.k8s.io/v1           false        ClusterRole
priorityclasses                    pc                                  scheduling.k8s.io/v1                   false        PriorityClass
csidrivers                                                             storage.k8s.io/v1                      false        CSIDriver
csinodes                                                               storage.k8s.io/v1                      false        CSINode
storageclasses                     sc                                  storage.k8s.io/v1                      false        StorageClass
volumeattachments                                                      storage.k8s.io/v1                      false        VolumeAttachment
fernando@debian10x64:~$

~~~~












Cluster Roles and Cluster Role Bindings
Cluster Roles are roles except they are for a cluster scoped resources. Kind as CLusterRole

~~~~yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-administrator
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["nodes"]
  verbs: ["get", "list", "delete", "create"]
~~~~


~~~~yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-admin-role-binding
subjects:
- kind: User
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-administrator
  apiGroup: rbac.authorization.k8s.io
~~~~


~~~~bash
$ kubectl create -f cluster-admin-role.yaml
$ kubectl create -f cluster-admin-role-binding.yaml
~~~~










# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# RESUMO

- Existem Roles  namespaced or cluster scoped.
- Para liberar acessos aos Nodes, PV's, etc, são utilizadas ClusterRole.
- É possível utilizar ClusterRole para liberar acesso a Pods de todos os namespaces de uma vez só.