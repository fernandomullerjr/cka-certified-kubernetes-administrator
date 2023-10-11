
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# push

git status
git add .
git commit -m "163. Solution Role Based Access Controls."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
#  163. Solution Role Based Access Controls

# Practice Test - RBAC
  - Take me to [Practice Test](https://kodekloud.com/topic/practice-test-role-based-access-controls/)

Solutions to practice test - RBAC
- Run the command kubectl describe pod kube-apiserver-controlplane -n kube-system and look for --authorization-mode
  
  <details>
  
  ```
  $ kubectl describe pod kube-apiserver-controlplane -n kube-system
  ```
  
  </details>
  
- Run the command kubectl get roles

  <details>
  
  ```
  $ kubectl get roles
  ```
  
  </details>
  
- Run the command kubectl get roles --all-namespaces
  
  <details>
  
  ```
  $ kubectl get roles --all-namespaces
  ```
  
  </details>
  
- Run the command kubectl describe role kube-proxy -n kube-system
  
  <details>
  
  ```
  $ kubectl describe role kube-proxy -n kube-system
  ```
  
  </details>
  
- Check the verbs associated to the kube-proxy role
  
  <details>
  ```
  $ kubectl describe role kube-proxy -n kube-system
  ```
  </details>
  
- Which of the following statements are true?
  
  <details>
  ```
  kube-proxy role can get details of configmap object by the name kube-proxy
  ```
  </details>
  
- Run the command kubectl describe rolebinding kube-proxy -n kube-system
  
  <details>
  ```
  $ kubectl describe rolebinding kube-proxy -n kube-system
  ```
  </details>
  
- Run the command kubectl get pods --as dev-user
  
  <details>
  ```
  $ kubectl get pods --as dev-user
  ```
  </details>
  
- Answer file located at /var/answers
  
  <details>
  
  ```
  $ kubectl create -f /var/answers/developer-role.yaml
  ```
  
  </details>
  
- New roles and role bindings are created in the blue namespace. Check it out. Check the resourceNames configured on the role
  
  <details>
  
  ```
  $ kubectl get roles,rolebindings -n blue
  $ kubectl describe role developer -n blue
  $ kubectl edit role developer -n blue (update the resourceNames)
  ```
  
  </details>
  
- View the answer file located at /var/answers/dev-user-deploy.yaml
  
  <details>
  
  ```
  $ kubectl create -f /var/answers/dev-user-deploy.yaml
  ```
  
  </details>



# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
#  163. Solution Role Based Access Controls


- Outro método para verificar o "authorization-mode" configurado no Cluster:

~~~~bash

fernando@debian10x64:~$ ps -ef | grep "authorization-mode"
root       1710   1479  6 11:10 ?        00:23:43 kube-apiserver --advertise-address=192.168.92.129 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetadmission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-kpki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pkent.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/--requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheadte-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernet-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki
fernando   7952   7928  0 17:08 pts/1    00:00:00 grep authorization-mode
fernando@debian10x64:~$ ^C
fernando@debian10x64:~$ ps -ef | grep "authorization-mode"

~~~~


- Também é possível via comando:

```
$ kubectl describe pod kube-apiserver-controlplane -n kube-system
```





- Verificar quantidade de roles
Verificar as roles sem os cabeçalhos usando o "--no-headers"

kubectl get roles -A --no-headers

~~~~bash
fernando@debian10x64:~$ kubectl get roles -A --no-headers
kube-public   kubeadm:bootstrap-signer-clusterinfo             2023-09-22T23:33:03Z
kube-public   system:controller:bootstrap-signer               2023-09-22T23:33:01Z
kube-system   cilium-config-agent                              2023-09-22T23:58:04Z
kube-system   extension-apiserver-authentication-reader        2023-09-22T23:33:01Z
kube-system   kube-proxy                                       2023-09-22T23:33:04Z
kube-system   kubeadm:kubelet-config                           2023-09-22T23:33:01Z
kube-system   kubeadm:nodes-kubeadm-config                     2023-09-22T23:33:01Z
kube-system   system::leader-locking-kube-controller-manager   2023-09-22T23:33:01Z
kube-system   system::leader-locking-kube-scheduler            2023-09-22T23:33:01Z
kube-system   system:controller:bootstrap-signer               2023-09-22T23:33:01Z
kube-system   system:controller:cloud-provider                 2023-09-22T23:33:01Z
kube-system   system:controller:token-cleaner                  2023-09-22T23:33:01Z
fernando@debian10x64:~$ kubectl get roles -A --no-headers | wc
     12      36    1008
fernando@debian10x64:~$

~~~~








- Run the command kubectl describe rolebinding kube-proxy -n kube-system
  
  <details>
  ```
  $ kubectl describe rolebinding kube-proxy -n kube-system
  ```


~~~~bash
fernando@debian10x64:~$ kubectl describe rolebinding kube-proxy -n kube-system
Name:         kube-proxy
Labels:       <none>
Annotations:  <none>
Role:
  Kind:  Role
  Name:  kube-proxy
Subjects:
  Kind   Name                                             Namespace
  ----   ----                                             ---------
  Group  system:bootstrappers:kubeadm:default-node-token
fernando@debian10x64:~$

~~~~








- Na questão "A user dev-user is created. User's details have been added to the kubeconfig file. Inspect the permissions granted to the user. Check if the user can list pods in the default namespace.

Use the --as dev-user option with kubectl to run commands as the dev-user.
"


- Run the command kubectl get pods --as dev-user
  
  <details>
  ```
  $ kubectl get pods --as dev-user
  ```












- Sobre como criar role e rolebinding
usar o help para pegar o comando imperativo para efetuar criação, como uma forma alternativa

~~~~bash

fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ kubectl create role --help
Create a role with single rule.

Examples:
  # Create a role named "pod-reader" that allows user to perform "get", "watch" and "list" on pods
  kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods

  # Create a role named "pod-reader" with ResourceName specified
  kubectl create role pod-reader --verb=get --resource=pods --resource-name=readablepod --resource-name=anotherpod

  # Create a role named "foo" with API Group specified
  kubectl create role foo --verb=get,list,watch --resource=rs.extensions

  # Create a role named "foo" with SubResource specified
  kubectl create role foo --verb=get,list,watch --resource=pods,pods/status


fernando@debian10x64:~$ kubectl create rolebinding --help
Create a role binding for a particular role or cluster role.

Examples:
  # Create a role binding for user1, user2, and group1 using the admin cluster role
  kubectl create rolebinding admin --clusterrole=admin --user=user1 --user=user2 --group=group1


~~~~