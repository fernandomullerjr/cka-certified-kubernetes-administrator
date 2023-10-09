



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












O Kubernetes API tem uma estrutura de endpoints bem definida para diferentes operações. Em geral, a maioria dos endpoints segue o padrão /api/{version}/{resource}, onde {version} é a versão da API do Kubernetes (por exemplo, v1) e {resource} é o tipo de objeto Kubernetes com o qual você está interagindo (por exemplo, pods, services, deployments, etc.). Abaixo estão alguns exemplos de paths da API do Kubernetes para a versão v1:

    Listar todos os pods:

    bash

GET /api/v1/pods

Obter informações sobre um pod específico:

bash

GET /api/v1/namespaces/{namespace}/pods/{pod-name}

Listar todos os serviços:

bash

GET /api/v1/services

Obter informações sobre um serviço específico em um namespace:

bash

GET /api/v1/namespaces/{namespace}/services/{service-name}

Listar todos os namespaces:

bash

GET /api/v1/namespaces

Obter informações sobre um namespace específico:

bash

GET /api/v1/namespaces/{namespace}

Listar todos os deployments:

bash

GET /api/v1/deployments

Obter informações sobre um deployment específico em um namespace:

bash

GET /api/v1/namespaces/{namespace}/deployments/{deployment-name}

Listar todos os nodes:

bash

GET /api/v1/nodes

Obter informações sobre um node específico:

bash

    GET /api/v1/nodes/{node-name}

Lembre-se de que os endpoints acima são exemplos gerais e podem variar com base na configuração específica do seu cluster Kubernetes. Além disso, a autenticação e autorização adequadas são necessárias para acessar esses endpoints com sucesso. Certifique-se de consultar a documentação oficial do Kubernetes para obter informações detalhadas sobre os endpoints da API para a versão específica que você está usando.








O Kubernetes API também oferece endpoints sob o caminho /apis. Esses endpoints são usados para acessar recursos personalizados (Custom Resources) definidos por operadores e desenvolvedores. Aqui estão alguns exemplos de paths da API do Kubernetes sob o caminho /apis:

    Listar todos os recursos personalizados (Custom Resources) em um grupo:

    sql

GET /apis/{group}/{version}/{resourcePlural}

Por exemplo:

bash

GET /apis/mygroup.example.com/v1alpha1/mycustomresources

Obter informações sobre um recurso personalizado específico em um grupo:

sql

GET /apis/{group}/{version}/{resourcePlural}/{resourceName}

Por exemplo:

bash

GET /apis/mygroup.example.com/v1alpha1/mycustomresources/myresource-1

Listar todos os recursos personalizados (Custom Resources) em um namespace:

vbnet

GET /apis/{group}/{version}/namespaces/{namespace}/{resourcePlural}

Por exemplo:

bash

GET /apis/mygroup.example.com/v1alpha1/namespaces/default/mycustomresources

Obter informações sobre um recurso personalizado específico em um namespace:

vbnet

GET /apis/{group}/{version}/namespaces/{namespace}/{resourcePlural}/{resourceName}

Por exemplo:

bash

GET /apis/mygroup.example.com/v1alpha1/namespaces/default/mycustomresources/myresource-1

Listar todos os grupos de recursos personalizados disponíveis:

bash

GET /apis/

Listar todas as versões de um grupo de recursos personalizados específico:

sql

GET /apis/{group}

Por exemplo:

bash

GET /apis/mygroup.example.com

Listar todas as versões de um recurso personalizado em um grupo:

sql

GET /apis/{group}/{version}

Por exemplo:

bash

GET /apis/mygroup.example.com/v1alpha1

Obter informações sobre um recurso personalizado específico em uma versão específica de um grupo:

sql

GET /apis/{group}/{version}/{resourcePlural}/{resourceName}

Por exemplo:

bash

    GET /apis/mygroup.example.com/v1alpha1/mycustomresources/myresource-1

Lembre-se de que os exemplos acima são genéricos e os nomes dos grupos, versões e recursos personalizados variarão com base na configuração do seu cluster Kubernetes e nas definições específicas do operador ou desenvolvedor. Certifique-se de consultar a documentação relevante ou a especificação do recurso personalizado para obter informações precisas sobre os endpoints da API sob o caminho /apis.








curl https://192.168.92.129:6443/api/v1/nodes --key /root/admin.key --cert /root/admin.crt --cacert /root/ca.crt






# API and APIs

These APIs are catagorized into two.

The core group - Where all the functionality exists

core
/v1
bindings
configmaps
rc
events
namespaces
nodes
PV
pods
PVC
secrets
services
/api/v1/namespaces
/api/v1/pods
/api/v1/namespaces/my-namespace/pods


The Named group - More organized and going forward all the newer features are going to be made available to these named groups.

named
/apps
/extensions
/certificates.k8s.io
/networking.k8s.io
/storage.k8s.io
/authentication.k8s.io
/v1
/deployments
/
replicasets
/
statefulsets
/v1
/
networkpolicies
/v1
/
certificatesigningrequests
API Groups
Resources
create
delete
get
list
update
watch
Verbs




To list all the api groups

curl https://192.168.92.129:6443 --key /root/admin.key --cert /root/admin.crt --cacert /root/ca.crt

~~~~bash

root@debian10x64:~# curl https://192.168.92.129:6443 --key /root/admin.key --cert /root/admin.crt --cacert /root/ca.crt
{
  "paths": [
    "/.well-known/openid-configuration",
    "/api",
    "/api/v1",
    "/apis",
    "/apis/",
    "/apis/admissionregistration.k8s.io",
    "/apis/admissionregistration.k8s.io/v1",
    "/apis/apiextensions.k8s.io",
    "/apis/apiextensions.k8s.io/v1",
    "/apis/apiregistration.k8s.io",
    "/apis/apiregistration.k8s.io/v1",
    "/apis/apps",
    "/apis/apps/v1",
    "/apis/authentication.k8s.io",
    "/apis/authentication.k8s.io/v1",
    "/apis/authorization.k8s.io",
    "/apis/authorization.k8s.io/v1",
    "/apis/autoscaling",
    "/apis/autoscaling/v1",
    "/apis/autoscaling/v2",
    "/apis/batch",
    "/apis/batch/v1",
    "/apis/certificates.k8s.io",
    "/apis/certificates.k8s.io/v1",
    "/apis/cilium.io",
    "/apis/cilium.io/v2",
    "/apis/cilium.io/v2alpha1",
    "/apis/coordination.k8s.io",
    "/apis/coordination.k8s.io/v1",
    "/apis/discovery.k8s.io",
    "/apis/discovery.k8s.io/v1",
    "/apis/events.k8s.io",
    "/apis/events.k8s.io/v1",
    "/apis/flowcontrol.apiserver.k8s.io",
    "/apis/flowcontrol.apiserver.k8s.io/v1beta2",
    "/apis/flowcontrol.apiserver.k8s.io/v1beta3",
    "/apis/networking.k8s.io",
    "/apis/networking.k8s.io/v1",
    "/apis/node.k8s.io",
    "/apis/node.k8s.io/v1",
    "/apis/policy",
    "/apis/policy/v1",
    "/apis/rbac.authorization.k8s.io",
    "/apis/rbac.authorization.k8s.io/v1",
    "/apis/scheduling.k8s.io",
    "/apis/scheduling.k8s.io/v1",
    "/apis/storage.k8s.io",
    "/apis/storage.k8s.io/v1",
    "/healthz",
    "/healthz/autoregister-completion",
    "/healthz/etcd",
    "/healthz/log",
    "/healthz/ping",
    "/healthz/poststarthook/aggregator-reload-proxy-client-cert",
    "/healthz/poststarthook/apiservice-discovery-controller",
    "/healthz/poststarthook/apiservice-openapi-controller",
    "/healthz/poststarthook/apiservice-openapiv3-controller",
    "/healthz/poststarthook/apiservice-registration-controller",
    "/healthz/poststarthook/apiservice-status-available-controller",
    "/healthz/poststarthook/bootstrap-controller",
    "/healthz/poststarthook/crd-informer-synced",
    "/healthz/poststarthook/generic-apiserver-start-informers",
    "/healthz/poststarthook/kube-apiserver-autoregistration",
    "/healthz/poststarthook/priority-and-fairness-config-consumer",
    "/healthz/poststarthook/priority-and-fairness-config-producer",
    "/healthz/poststarthook/priority-and-fairness-filter",
    "/healthz/poststarthook/rbac/bootstrap-roles",
    "/healthz/poststarthook/scheduling/bootstrap-system-priority-classes",
    "/healthz/poststarthook/start-apiextensions-controllers",
    "/healthz/poststarthook/start-apiextensions-informers",
    "/healthz/poststarthook/start-cluster-authentication-info-controller",
    "/healthz/poststarthook/start-deprecated-kube-apiserver-identity-lease-garbage-collector",
    "/healthz/poststarthook/start-kube-aggregator-informers",
    "/healthz/poststarthook/start-kube-apiserver-admission-initializer",
    "/healthz/poststarthook/start-kube-apiserver-identity-lease-controller",
    "/healthz/poststarthook/start-kube-apiserver-identity-lease-garbage-collector",
    "/healthz/poststarthook/start-legacy-token-tracking-controller",
    "/healthz/poststarthook/start-service-ip-repair-controllers",
    "/healthz/poststarthook/start-system-namespaces-controller",
    "/healthz/poststarthook/storage-object-count-tracker-hook",
    "/livez",
    "/livez/autoregister-completion",
    "/livez/etcd",
    "/livez/log",
    "/livez/ping",
    "/livez/poststarthook/aggregator-reload-proxy-client-cert",
    "/livez/poststarthook/apiservice-discovery-controller",
    "/livez/poststarthook/apiservice-openapi-controller",
    "/livez/poststarthook/apiservice-openapiv3-controller",
    "/livez/poststarthook/apiservice-registration-controller",
    "/livez/poststarthook/apiservice-status-available-controller",
    "/livez/poststarthook/bootstrap-controller",
    "/livez/poststarthook/crd-informer-synced",
    "/livez/poststarthook/generic-apiserver-start-informers",
    "/livez/poststarthook/kube-apiserver-autoregistration",
    "/livez/poststarthook/priority-and-fairness-config-consumer",
    "/livez/poststarthook/priority-and-fairness-config-producer",
    "/livez/poststarthook/priority-and-fairness-filter",
    "/livez/poststarthook/rbac/bootstrap-roles",
    "/livez/poststarthook/scheduling/bootstrap-system-priority-classes",
    "/livez/poststarthook/start-apiextensions-controllers",
    "/livez/poststarthook/start-apiextensions-informers",
    "/livez/poststarthook/start-cluster-authentication-info-controller",
    "/livez/poststarthook/start-deprecated-kube-apiserver-identity-lease-garbage-collector",
    "/livez/poststarthook/start-kube-aggregator-informers",
    "/livez/poststarthook/start-kube-apiserver-admission-initializer",
    "/livez/poststarthook/start-kube-apiserver-identity-lease-controller",
    "/livez/poststarthook/start-kube-apiserver-identity-lease-garbage-collector",
    "/livez/poststarthook/start-legacy-token-tracking-controller",
    "/livez/poststarthook/start-service-ip-repair-controllers",
    "/livez/poststarthook/start-system-namespaces-controller",
    "/livez/poststarthook/storage-object-count-tracker-hook",
    "/logs",
    "/metrics",
    "/metrics/slis",
    "/openapi/v2",
    "/openapi/v3",
    "/openapi/v3/",
    "/openid/v1/jwks",
    "/readyz",
    "/readyz/autoregister-completion",
    "/readyz/etcd",
    "/readyz/etcd-readiness",
    "/readyz/informer-sync",
    "/readyz/log",
    "/readyz/ping",
    "/readyz/poststarthook/aggregator-reload-proxy-client-cert",
    "/readyz/poststarthook/apiservice-discovery-controller",
    "/readyz/poststarthook/apiservice-openapi-controller",
    "/readyz/poststarthook/apiservice-openapiv3-controller",
    "/readyz/poststarthook/apiservice-registration-controller",
    "/readyz/poststarthook/apiservice-status-available-controller",
    "/readyz/poststarthook/bootstrap-controller",
    "/readyz/poststarthook/crd-informer-synced",
    "/readyz/poststarthook/generic-apiserver-start-informers",
    "/readyz/poststarthook/kube-apiserver-autoregistration",
    "/readyz/poststarthook/priority-and-fairness-config-consumer",
    "/readyz/poststarthook/priority-and-fairness-config-producer",
    "/readyz/poststarthook/priority-and-fairness-filter",
    "/readyz/poststarthook/rbac/bootstrap-roles",
    "/readyz/poststarthook/scheduling/bootstrap-system-priority-classes",
    "/readyz/poststarthook/start-apiextensions-controllers",
    "/readyz/poststarthook/start-apiextensions-informers",
    "/readyz/poststarthook/start-cluster-authentication-info-controller",
    "/readyz/poststarthook/start-deprecated-kube-apiserver-identity-lease-garbage-collector",
    "/readyz/poststarthook/start-kube-aggregator-informers",
    "/readyz/poststarthook/start-kube-apiserver-admission-initializer",
    "/readyz/poststarthook/start-kube-apiserver-identity-lease-controller",
    "/readyz/poststarthook/start-kube-apiserver-identity-lease-garbage-collector",
    "/readyz/poststarthook/start-legacy-token-tracking-controller",
    "/readyz/poststarthook/start-service-ip-repair-controllers",
    "/readyz/poststarthook/start-system-namespaces-controller",
    "/readyz/poststarthook/storage-object-count-tracker-hook",
    "/readyz/shutdown",
    "/version"
  ]
}root@debian10x64:~#

~~~~







- Listando a named:

curl https://192.168.92.129:6443/apis --key /root/admin.key --cert /root/admin.crt --cacert /root/ca.crt | grep "name"

~~~~bash

root@debian10x64:~# curl https://192.168.92.129:6443/apis --key /root/admin.key --cert /root/admin.crt --cacert /root/ca.crt | grep "name"
      "name": "apps",
      "name": "events.k8s.io",
      "name": "authentication.k8s.io",
      "name": "authorization.k8s.io",
      "name": "autoscaling",
      "name": "batch",
      "name": "certificates.k8s.io",
      "name": "networking.k8s.io",
      "name": "policy",
      "name": "rbac.authorization.k8s.io",
      "name": "storage.k8s.io",
      "name": "admissionregistration.k8s.io",
      "name": "apiextensions.k8s.io",
      "name": "scheduling.k8s.io",
      "name": "coordination.k8s.io",
      "name": "node.k8s.io",
      "name": "discovery.k8s.io",
      "name": "flowcontrol.apiserver.k8s.io",
      "name": "cilium.io",
root@debian10x64:~#

~~~~




## API Groups

/apps
/extensions
/certificates.k8s.io
/networking.k8s.io
/storage.k8s.io
/authentication.k8s.io

## Resources

/v1
/deployments
/
replicasets
/
statefulsets
/v1
/
networkpolicies
/v1
/
certificatesigningrequests

## Verbs

create
delete
get
list
update
watch
Verbs