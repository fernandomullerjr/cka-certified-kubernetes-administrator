

# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# push

git status
git add .
git commit -m "162. Practice Test - RBAC."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# 162. Practice Test - RBAC

Inspect the environment and identify the authorization modes configured on the cluster.

Check the kube-apiserver settings.

controlplane /etc/kubernetes ➜  ls manifests/
etcd.yaml  kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml

controlplane /etc/kubernetes ➜  cd manifests/

controlplane /etc/kubernetes/manifests ➜  cat kube-apiserver.yaml 
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 192.35.222.3:6443
  creationTimestamp: null
  labels:
    component: kube-apiserver
    tier: control-plane
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
    - --advertise-address=192.35.222.3
    - --allow-privileged=true
    - --authorization-mode=Node,RBAC
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --enable-admission-plugins=NodeRestriction
    - --enable-bootstrap-token-auth=true
    - --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
    - --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
    - --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key
    - --etcd-servers=https://127.0.0.1:2379
    - --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt
    - --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key
    - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
    - --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt
    - --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key
    - --requestheader-allowed-names=front-proxy-client
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --requestheader-extra-headers-prefix=X-Remote-Extra-
    - --requestheader-group-headers=X-Remote-Group
    - --requestheader-username-headers=X-Remote-User
    - --secure-port=6443
    - --service-account-issuer=https://kubernetes.default.svc.cluster.local
    - --service-account-key-file=/etc/kubernetes/pki/sa.pub
    - --service-account-signing-key-file=/etc/kubernetes/pki/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --tls-cert-file=/etc/kubernetes/pki/apiserver.crt
    - --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
    image: registry.k8s.io/kube-apiserver:v1.27.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 192.35.222.3
        path: /livez
        port: 6443
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-apiserver
    readinessProbe:
      failureThreshold: 3
      httpGet:
        host: 192.35.222.3
        path: /readyz
        port: 6443
        scheme: HTTPS
      periodSeconds: 1
      timeoutSeconds: 15
    resources:
      requests:
        cpu: 250m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 192.35.222.3
        path: /livez
        port: 6443
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /etc/ssl/certs
      name: ca-certs
      readOnly: true
    - mountPath: /etc/ca-certificates
      name: etc-ca-certificates
      readOnly: true
    - mountPath: /etc/kubernetes/pki
      name: k8s-certs
      readOnly: true
    - mountPath: /usr/local/share/ca-certificates
      name: usr-local-share-ca-certificates
      readOnly: true
    - mountPath: /usr/share/ca-certificates
      name: usr-share-ca-certificates
      readOnly: true
  hostNetwork: true
  priority: 2000001000
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/ssl/certs
      type: DirectoryOrCreate
    name: ca-certs
  - hostPath:
      path: /etc/ca-certificates
      type: DirectoryOrCreate
    name: etc-ca-certificates
  - hostPath:
      path: /etc/kubernetes/pki
      type: DirectoryOrCreate
    name: k8s-certs
  - hostPath:
      path: /usr/local/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-local-share-ca-certificates
  - hostPath:
      path: /usr/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-share-ca-certificates
status: {}

controlplane /etc/kubernetes/manifests ➜  


- RESPOSTA

    - --authorization-mode=Node,RBAC








How many roles exist in the default namespace?

controlplane /etc/kubernetes/manifests ➜  kubectl get roles
No resources found in default namespace.

controlplane /etc/kubernetes/manifests ➜  









How many roles exist in all namespaces together?
controlplane /etc/kubernetes/manifests ➜  kubectl get roles -A | wc
     13      40    1082

controlplane /etc/kubernetes/manifests ➜  kubectl get roles -A 
NAMESPACE     NAME                                             CREATED AT
blue          developer                                        2023-10-11T18:02:59Z
kube-public   kubeadm:bootstrap-signer-clusterinfo             2023-10-11T18:01:07Z
kube-public   system:controller:bootstrap-signer               2023-10-11T18:01:05Z
kube-system   extension-apiserver-authentication-reader        2023-10-11T18:01:05Z
kube-system   kube-proxy                                       2023-10-11T18:01:09Z
kube-system   kubeadm:kubelet-config                           2023-10-11T18:01:06Z
kube-system   kubeadm:nodes-kubeadm-config                     2023-10-11T18:01:06Z
kube-system   system::leader-locking-kube-controller-manager   2023-10-11T18:01:05Z
kube-system   system::leader-locking-kube-scheduler            2023-10-11T18:01:05Z
kube-system   system:controller:bootstrap-signer               2023-10-11T18:01:05Z
kube-system   system:controller:cloud-provider                 2023-10-11T18:01:05Z
kube-system   system:controller:token-cleaner                  2023-10-11T18:01:05Z

controlplane /etc/kubernetes/manifests ➜  

- RESPOSTA
12








What are the resources the kube-proxy role in the kube-system namespace is given access to?


controlplane /etc/kubernetes/manifests ➜  kubectl get role kube-proxy -n kube-system
NAME         CREATED AT
kube-proxy   2023-10-11T18:01:09Z

controlplane /etc/kubernetes/manifests ➜  kubectl describe role kube-proxy -n kube-system
Name:         kube-proxy
Labels:       <none>
Annotations:  <none>
PolicyRule:
  Resources   Non-Resource URLs  Resource Names  Verbs
  ---------   -----------------  --------------  -----
  configmaps  []                 [kube-proxy]    [get]

controlplane /etc/kubernetes/manifests ➜  

- RESPOSTA
configmaps









What actions can the kube-proxy role perform on configmaps?

-resposta
get








Which of the following statements are true?

- RESPOSTA
ver configmaps com nome kube-proxy







Which account is the kube-proxy role assigned to?


controlplane /etc/kubernetes/manifests ➜  kubectl get rolebindings
No resources found in default namespace.

controlplane /etc/kubernetes/manifests ➜  kubectl get rolebindings -A
NAMESPACE     NAME                                                ROLE                                                  AGE
blue          dev-user-binding                                    Role/developer                                        6m39s
kube-public   kubeadm:bootstrap-signer-clusterinfo                Role/kubeadm:bootstrap-signer-clusterinfo             8m31s
kube-public   system:controller:bootstrap-signer                  Role/system:controller:bootstrap-signer               8m33s
kube-system   kube-proxy                                          Role/kube-proxy                                       8m29s
kube-system   kubeadm:kubelet-config                              Role/kubeadm:kubelet-config                           8m32s
kube-system   kubeadm:nodes-kubeadm-config                        Role/kubeadm:nodes-kubeadm-config                     8m32s
kube-system   system::extension-apiserver-authentication-reader   Role/extension-apiserver-authentication-reader        8m33s
kube-system   system::leader-locking-kube-controller-manager      Role/system::leader-locking-kube-controller-manager   8m33s
kube-system   system::leader-locking-kube-scheduler               Role/system::leader-locking-kube-scheduler            8m33s
kube-system   system:controller:bootstrap-signer                  Role/system:controller:bootstrap-signer               8m33s
kube-system   system:controller:cloud-provider                    Role/system:controller:cloud-provider                 8m33s
kube-system   system:controller:token-cleaner                     Role/system:controller:token-cleaner                  8m33s

controlplane /etc/kubernetes/manifests ➜  
controlplane /etc/kubernetes/manifests ✖ kubectl get rolebindings -n kube-system kube-proxy
NAME         ROLE              AGE
kube-proxy   Role/kube-proxy   10m

controlplane /etc/kubernetes/manifests ➜  kubectl get rolebindings -n kube-system kube-proxy -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  creationTimestamp: "2023-10-11T18:01:09Z"
  name: kube-proxy
  namespace: kube-system
  resourceVersion: "285"
  uid: 32765480-eca3-4080-97f1-84fe7f3a1bf6
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: kube-proxy
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: system:bootstrappers:kubeadm:default-node-token

controlplane /etc/kubernetes/manifests ➜  


- RESPOSTA
Grupo system:bootstrappers:kubeadm:default-node-token











A user dev-user is created. User's details have been added to the kubeconfig file. Inspect the permissions granted to the user. Check if the user can list pods in the default namespace.

Use the --as dev-user option with kubectl to run commands as the dev-user.


controlplane /etc/kubernetes/manifests ➜  kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: dev-user
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED
- name: kubernetes-admin
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED

controlplane /etc/kubernetes/manifests ➜  

kubectl auth can-i list pods --namespace default --as dev-user

controlplane /etc/kubernetes/manifests ➜  kubectl auth can-i list pods --namespace default --as dev-user
no

controlplane /etc/kubernetes/manifests ✖ 









Create the necessary roles and role bindings required for the dev-user to create, list and delete pods in the default namespace.

Use the given spec:

    Role: developer

    Role Resources: pods

    Role Actions: list

    Role Actions: create

    Role Actions: delete

    RoleBinding: dev-user-binding

    RoleBinding: Bound to dev-user


/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/162-role.yaml

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/162-rolebinding.yaml


controlplane /etc/kubernetes/manifests ✖ vi role.yaml

controlplane /etc/kubernetes/manifests ➜  kubectl apply -f role.yaml
role.rbac.authorization.k8s.io/developer created

controlplane /etc/kubernetes/manifests ➜  vi rolebind.yaml

controlplane /etc/kubernetes/manifests ➜  kubectl apply -f rolebind.yaml
rolebinding.rbac.authorization.k8s.io/dev-user-binding created

controlplane /etc/kubernetes/manifests ➜  

controlplane /etc/kubernetes/manifests ➜  

controlplane /etc/kubernetes/manifests ➜  

controlplane /etc/kubernetes/manifests ➜  kubectl get role
NAME        CREATED AT
developer   2023-10-11T18:17:55Z

controlplane /etc/kubernetes/manifests ➜  kubectl get rolebinding
NAME               ROLE             AGE
dev-user-binding   Role/developer   9s

controlplane /etc/kubernetes/manifests ➜  










A set of new roles and role-bindings are created in the blue namespace for the dev-user. However, the dev-user is unable to get details of the dark-blue-app pod in the blue namespace. Investigate and fix the issue.

We have created the required roles and rolebindings, but something seems to be wrong.

    Issue Fixed


controlplane /etc/kubernetes/manifests ➜  kubectl get all -n blue
NAME                READY   STATUS    RESTARTS   AGE
pod/blue-app        1/1     Running   0          17m
pod/dark-blue-app   1/1     Running   0          17m

controlplane /etc/kubernetes/manifests ➜  


controlplane /etc/kubernetes/manifests ➜  kubectl get role -n blue
NAME        CREATED AT
developer   2023-10-11T18:02:59Z

controlplane /etc/kubernetes/manifests ➜  kubectl get rolebinding -n blue
NAME               ROLE             AGE
dev-user-binding   Role/developer   17m

controlplane /etc/kubernetes/manifests ➜  


controlplane /etc/kubernetes/manifests ➜  kubectl get role developer -o yaml -n blue
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: "2023-10-11T18:02:59Z"
  name: developer
  namespace: blue
  resourceVersion: "613"
  uid: b86a3d4e-f5a1-49e6-a263-f5fef10b290b
rules:
- apiGroups:
  - ""
  resourceNames:
  - blue-app
  resources:
  - pods
  verbs:
  - get
  - watch
  - create
  - delete

controlplane /etc/kubernetes/manifests ➜  

controlplane /etc/kubernetes/manifests ➜  kubectl get rolebinding dev-user-binding -o yaml -n blue
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  creationTimestamp: "2023-10-11T18:02:59Z"
  name: dev-user-binding
  namespace: blue
  resourceVersion: "614"
  uid: ba0daac3-6ec4-4d52-8cd8-1a4362893153
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: developer
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: dev-user

controlplane /etc/kubernetes/manifests ➜  


Problema deve ser devido o trecho

  resourceNames:
  - blue-app

- Ajustando:

controlplane /etc/kubernetes/manifests ➜  kubectl edit role developer -o yaml -n blue
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: "2023-10-11T18:02:59Z"
  name: developer
  namespace: blue
  resourceVersion: "2208"
  uid: b86a3d4e-f5a1-49e6-a263-f5fef10b290b
rules:
- apiGroups:
  - ""
  resourceNames:
  - blue-app
  - dark-blue-app
  resources:
  - pods
  verbs:
  - get
  - watch
  - create
  - delete

controlplane /etc/kubernetes/manifests ➜  

controlplane /etc/kubernetes/manifests ➜  kubectl get role developer -o yaml -n blue
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: "2023-10-11T18:02:59Z"
  name: developer
  namespace: blue
  resourceVersion: "2208"
  uid: b86a3d4e-f5a1-49e6-a263-f5fef10b290b
rules:
- apiGroups:
  - ""
  resourceNames:
  - blue-app
  - dark-blue-app
  resources:
  - pods
  verbs:
  - get
  - watch
  - create
  - delete

controlplane /etc/kubernetes/manifests ➜  date
Wed 11 Oct 2023 02:23:23 PM EDT

controlplane /etc/kubernetes/manifests ➜  














Add a new rule in the existing role developer to grant the dev-user permissions to create deployments in the blue namespace.

Remember to add api group "apps".

    permissions added to create deployments?

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/162-role-developer-v3.yaml


controlplane /etc/kubernetes/manifests ✖ kubectl edit role developer -o yaml -n blue
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: "2023-10-11T18:02:59Z"
  name: developer
  namespace: blue
  resourceVersion: "2503"
  uid: b86a3d4e-f5a1-49e6-a263-f5fef10b290b
rules:
- apiGroups:
  - ""
  resourceNames:
  - blue-app
  - dark-blue-app
  resources:
  - pods
  verbs:
  - get
  - watch
  - create
  - delete
- apiGroups:
  - apps
  resources:
  - deployments
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete

controlplane /etc/kubernetes/manifests ➜  