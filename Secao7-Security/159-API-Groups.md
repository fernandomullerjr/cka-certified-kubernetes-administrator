



# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# push

git status
git add .
git commit -m "159. API Groups."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# 159. API Groups

159. API Groups

# API Groups
  
In this section, we will take a look at API Groups in kubernetes

## To return version and list pods via API's 

 
- The kubernetes API is grouped into multiple such groups based on their purpose. Such as one for **`APIs`**, one for **`healthz`**, **`metrics`** and **`logs`** etc.

 
## API and APIs
- These APIs are catagorized into two.
  - The core group - Where all the functionality exists
    
 
  - The Named group - More organized and going forward all the newer features are going to be made available to these named groups.
  
    
- To list all the api groups

  
## Note on accessing the kube-apiserver
- You have to authenticate by passing the certificate files.

  
- An alternate is to start a **`kubeproxy`** client
  
  
## kube proxy vs kubectl proxy
   
## Key Takeaways

#### K8s Reference Docs
- https://kubernetes.io/docs/concepts/overview/kubernetes-api/
- https://kubernetes.io/docs/reference/using-api/api-concepts/
- https://kubernetes.io/docs/tasks/extend-kubernetes/http-proxy-access-api/



# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# 159. API Groups

- Exemplos de comandos curl, para consulta a api:

curl -v -k https://master node ip:6443/api/v1/pods -u "user1:password123"
curl -v -k https://master node ip:6443/api/v1/pods -u "user1:password123"

~~~~bash

fernando@debian10x64:~$ ps -ef | grep kube-api
root       1859   1540 14 20:40 ?        00:01:57 kube-apiserver --advertise-address=192.168.92.129 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
fernando   4015   3899  0 20:53 pts/1    00:00:00 grep kube-api
fernando@debian10x64:~$

~~~~




- Comando editado:

curl -v -k https://192.168.92.129:6443/version

~~~~bash

fernando@debian10x64:~$ curl https://192.168.92.129:6443/version
curl: (60) SSL certificate problem: unable to get local issuer certificate
More details here: https://curl.haxx.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ curl -k https://192.168.92.129:6443/version
{
  "major": "1",
  "minor": "28",
  "gitVersion": "v1.28.2",
  "gitCommit": "89a4ea3e1e4ddd7f7572286090359983e0387b2f",
  "gitTreeState": "clean",
  "buildDate": "2023-09-13T09:29:07Z",
  "goVersion": "go1.20.8",
  "compiler": "gc",
  "platform": "linux/amd64"
}fernando@debian10x64:~$

~~~~



- Importante utilizar o -k neste comando, para que o curl seja executado no modo inseguro, para não ter que passar o certificado:

       -k, --insecure
              (TLS)  By  default, every SSL connection curl makes is verified to be secure. This option allows curl to proceed and operate even for server connections otherwise con‐
              sidered insecure.

              The server connection is verified by making sure the server's certificate contains the right name and verifies successfully using the cert store.

              See this online resource for further details:
               https://curl.haxx.se/docs/sslcerts.html

              See also --proxy-insecure and --cacert.






- Comando para verificar os Pods:

curl -k https://192.168.92.129:6443/api/v1/pods

ocorreu erro

~~~~bash
fernando@debian10x64:~$ curl -k https://192.168.92.129:6443/api/v1/pods
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {},
  "status": "Failure",
  "message": "pods is forbidden: User \"system:anonymous\" cannot list resource \"pods\" in API group \"\" at the cluster scope",
  "reason": "Forbidden",
  "details": {
    "kind": "pods"
  },
  "code": 403
}fernando@debian10x64:~$

~~~~






curl https://192.168.64.4:8443/apis --key /Users/$USER/.minikube/certs/ca-key.pem --cert /Users/$USER/.minikube/certs/cert.pem --cacert /Users/$USER/.minikube/certs/ca.pem --cert-type PEM


curl https://kube-apiserver:6443/api/v1/pods 1 --key admin.key --cert admin.crt --cacert ca.crt





- Ajustando o comando, para utilizar o certificado e chave do APISERVER:

curl https://192.168.92.129:6443/api/v1/pods --key /etc/kubernetes/pki/apiserver.key --cert /etc/kubernetes/pki/apiserver.crt --cacert /etc/kubernetes/pki/ca.crt

root@debian10x64:/home/fernando# ps -ef | grep kube-api
root       1859   1540 13 20:40 ?        00:02:53 kube-apiserver 
--advertise-address=192.168.92.129 --allow-privileged=true --authorization-mode=Node,RBAC 
--client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true 
--etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 
--kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname 
--proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client 
--requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 
--tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root       4140   4109  0 21:01 pts/2    00:00:00 grep kube-api
root@debian10x64:/home/fernando#


- ERRO

~~~~BASH

root@debian10x64:/home/fernando# curl https://192.168.92.129:6443/api/v1/pods --key /etc/kubernetes/pki/apiserver.key --cert /etc/kubernetes/pki/apiserver.crt --cacert /etc/kubernetes/pki/ca.crt
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {},
  "status": "Failure",
  "message": "Unauthorized",
  "reason": "Unauthorized",
  "code": 401
}root@debian10x64:/home/fernando#

~~~~





- Ajustando o comando, para utilizar o certificado e chave do ETCD:

curl https://192.168.92.129:6443/api/v1/pods --key /etc/kubernetes/pki/apiserver-etcd-client.key --cert /etc/kubernetes/pki/apiserver-etcd-client.crt --cacert /etc/kubernetes/pki/ca.crt

ERRO

~~~~BASH

root@debian10x64:/home/fernando# curl https://192.168.92.129:6443/api/v1/pods --key /etc/kubernetes/pki/apiserver-etcd-client.key --cert /etc/kubernetes/pki/apiserver-etcd-client.crt --cacert /etc/kubernetes/pki/ca.crt
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {},
  "status": "Failure",
  "message": "Unauthorized",
  "reason": "Unauthorized",
  "code": 401
}root@debian10x64:/home/fernando#

~~~~



- Ajustando o comando, para utilizar o certificado e chave do ETCD:

curl https://192.168.92.129:6443/api/v1/pods --key /etc/kubernetes/pki/apiserver-etcd-client.key --cert /etc/kubernetes/pki/apiserver-etcd-client.crt --cacert /etc/kubernetes/pki/etcd/ca.crt




- Verificando solução

https://stackoverflow.com/questions/66292362/kubernetes-api-access-forbidden
<https://stackoverflow.com/questions/66292362/kubernetes-api-access-forbidden>


Solved by capturing certs from the .kube/config file

client-key-data:

echo -n "LS0...Cg==" | base64 -d > admin.key

client-certificate-data:

echo -n "LS0...C==" | base64 -d > admin.crt

certificate-authority-data:

echo -n "LS0...g==" | base64 -d > ca.crt

Then, use

curl https://172.26.2.101:6443 \
--key admin.key \
--cert admin.crt 
--cacert ca.crt 



- Coletando os dados locais:

~~~~bash

root@debian10x64:/home/fernando# kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://192.168.92.129:6443
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
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
root@debian10x64:/home/fernando#

~~~~



root@debian10x64:/home/fernando# cd ~
root@debian10x64:~# pwd
/root
root@debian10x64:~#



- Gerados os certificados:

root@debian10x64:~# ls
admin.crt  admin.key  ca.crt  gitlab-cleanse-2021-11-24T23:32  gitlab-cleanse-2021-11-24T23:33
root@debian10x64:~# pwd
/root
root@debian10x64:~#




curl https://192.168.92.129:6443/api/v1/pods --key /root/admin.key --cert /root/admin.crt --cacert /root/ca.crt

~~~~json

root@debian10x64:~# curl https://192.168.92.129:6443/api/v1/pods --key /root/admin.key --cert /root/admin.crt --cacert /root/ca.crt
{
  "kind": "PodList",
  "apiVersion": "v1",
  "metadata": {
    "resourceVersion": "70936"
  },
  "items": [
    {
      "metadata": {
        "name": "cilium-krwv4",
        "generateName": "cilium-",
        "namespace": "kube-system",
        "uid": "712231b3-afd9-48a1-9f4a-eff9b5f87a84",
        "resourceVersion": "66771",
        "creationTimestamp": "2023-09-22T23:58:05Z",
        "labels": {
          "app.kubernetes.io/name": "cilium-agent",
          "app.kubernetes.io/part-of": "cilium",
          "controller-revision-hash": "86467b5c9c",
          "k8s-app": "cilium",
          "pod-template-generation": "1"
        },
        "annotations": {
          "container.apparmor.security.beta.kubernetes.io/apply-sysctl-overwrites": "unconfined",
          "container.apparmor.security.beta.kubernetes.io/cilium-agent": "unconfined",
          "container.apparmor.security.beta.kubernetes.io/clean-cilium-state": "unconfined",
          "container.apparmor.security.beta.kubernetes.io/mount-cgroup": "unconfined"
        },
        "ownerReferences": [
          {
            "apiVersion": "apps/v1",
            "kind": "DaemonSet",
            "name": "cilium",
            "uid": "b574aa2a-d14d-409a-ab72-bc852901463f",
            "controller": true,
            "blockOwnerDeletion": true
          }
        ],
        "managedFields": [
          {
            "manager": "kube-controller-manager",
            "operation": "Update",
            "apiVersion": "v1",
            "time": "2023-09-22T23:58:05Z",
            "fieldsType": "FieldsV1",
            "fieldsV1": {
              "f:metadata": {
                "f:annotations": {
                  ".": {},
                  "f:container.apparmor.security.beta.kubernetes.io/apply-sysctl-overwrites": {},
                  "f:container.apparmor.security.beta.kubernetes.io/cilium-agent": {},
                  "f:container.apparmor.security.beta.kubernetes.io/clean-cilium-state": {},
                  "f:container.apparmor.security.beta.kubernetes.io/mount-cgroup": {}
                },
                "f:generateName": {},
                "f:labels": {
                  ".": {},
                  "f:app.kubernetes.io/name": {},
                  "f:app.kubernetes.io/part-of": {},
                  "f:controller-revision-hash": {},
                  "f:k8s-app": {},
                  "f:pod-template-generation": {}
                },
                "f:ownerReferences": {
                  ".": {},
                  "k:{\"uid\":\"b574aa2a-d14d-409a-ab72-bc852901463f\"}": {}
                }
              },
              "f:spec": {
                "f:affinity": {
                  ".": {},
                  "f:nodeAffinity": {
                    ".": {},
                    "f:requiredDuringSchedulingIgnoredDuringExecution": {}
                  },
                  "f:podAntiAffinity": {
                    ".": {},
                    "f:requiredDuringSchedulingIgnoredDuringExecution": {}
                  }
                },
                "f:automountServiceAccountToken": {},
                "f:containers": {
                  "k:{\"name\":\"cilium-agent\"}": {

        "hostIP": "192.168.92.129",
        "podIP": "192.168.92.129",
        "podIPs": [
          {
            "ip": "192.168.92.129"
          }
        ],
        "startTime": "2023-10-08T23:40:05Z",
        "containerStatuses": [
          {
            "name": "kube-scheduler",
            "state": {
              "running": {
                "startedAt": "2023-10-08T23:40:12Z"
              }
            },
            "lastState": {
              "terminated": {
                "exitCode": 255,
                "reason": "Unknown",
                "startedAt": "2023-10-07T22:27:39Z",
                "finishedAt": "2023-10-08T23:40:04Z",
                "containerID": "containerd://94dd67b4c8701a7d00639e21f3cb87a8abee82888284fc01a9da1e3315e2763e"
              }
            },
            "ready": true,
            "restartCount": 5,
            "image": "registry.k8s.io/kube-scheduler:v1.28.2",
            "imageID": "registry.k8s.io/kube-scheduler@sha256:6511193f8114a2f011790619698efe12a8119ed9a17e2e36f4c1c759ccf173ab",
            "containerID": "containerd://0d99ebd7d530fb7d317497166b59a95d6fc15a460266651f919acf0bb07c3cdd",
            "started": true
          }
        ],
        "qosClass": "Burstable"
      }
    }
  ]
~~~~



- Solução funcionou, foi possível consultar a api usando os certificados gerados:

https://stackoverflow.com/questions/66292362/kubernetes-api-access-forbidden