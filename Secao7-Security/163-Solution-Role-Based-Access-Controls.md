
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