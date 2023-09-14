



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "152. Certificates API."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 152. Certificates API


# Certificate API
  - Take me to [Video Tutorial](https://kodekloud.com/topic/certificates-api/)
  
In this section, we will take a look at how to manage certificates and certificate API's in kubernetes

## CA (Certificate Authority)
- The CA is really just the pair of key and certificate files that we have generated, whoever gains access to these pair of files can sign any certificate for the kubernetes environment.

#### Kubernetes has a built-in certificates API that can do this for you. 
- With the certificate API, we now send a certificate signing request (CSR) directly to kubernetes through an API call.
   
  ![csr](../../images/csr.PNG)
   
#### This certificate can then be extracted and shared with the user.
- A user first creates a key
  ```
  $ openssl genrsa -out jane.key 2048
  ```
- Generates a CSR
  ```
  $ openssl req -new -key jane.key -subj "/CN=jane" -out jane.csr 
  ```
- Sends the request to the administrator and the adminsitrator takes the key and creates a CSR object, with kind as "CertificateSigningRequest" and a encoded "jane.csr"
  ```
  apiVersion: certificates.k8s.io/v1beta1
  kind: CertificateSigningRequest
  metadata:
    name: jane
  spec:
    groups:
    - system:authenticated
    usages:
    - digital signature
    - key encipherment
    - server auth
    request:
      <certificate-goes-here>
  ```
  $ cat jane.csr |base64 
  $ kubectl create -f jane.yaml
  ```
 ![csr1](../../images/csr1.PNG)
  
- To list the csr's
  ```
  $ kubectl get csr
  ```
- Approve the request
  ```
  $ kubectl certificate approve jane
  ```
- To view the certificate
  ```
  $ kubectl get csr jane -o yaml
  ```
- To decode it
  ```
  $ echo "<certificate>" |base64 --decode
  ```
  
  ![csr2](../../images/csr2.PNG)
  
#### All the certificate releated operations are carried out by the controller manager. 
- If anyone has to sign the certificates they need the CA Servers, root certificate and private key. The controller manager configuration has two options where you can specify this.

  ![csr3](../../images/csr3.PNG)
  
  ![csr4](../../images/csr4.PNG)
  
  
#### K8s Reference Docs
- https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/
- https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/
 
  











------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 152. Certificates API

CA (Certificate Authority)

    The CA is really just the pair of key and certificate files that we have generated, whoever gains access to these pair of files can sign any certificate for the kubernetes environment.

Kubernetes has a built-in certificates API that can do this for you.

    With the certificate API, we now send a certificate signing request (CSR) directly to kubernetes through an API call.


This certificate can then be extracted and shared with the user.

    A user first creates a key
~~~~bash
openssl genrsa -out jane.key 2048
~~~~

Generates a CSR

~~~~bash
openssl req -new -key jane.key -subj "/CN=jane" -out jane.csr 
~~~~


Sends the request to the administrator and the adminsitrator takes the key and creates a CSR object, with kind as "CertificateSigningRequest" and a encoded "jane.csr"

~~~~yaml
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: jane
spec:
  groups:
  - system:authenticated
  usages:
  - digital signature
  - key encipherment
  - server auth
  request:
    <certificate-goes-here>
~~~~




~~~~bash
cat jane.csr |base64 $ kubectl create -f jane.yaml 
~~~~




To list the csr's

~~~~bash
kubectl get csr
~~~~

Approve the request

~~~~bash
kubectl certificate approve jane
~~~~

To view the certificate

~~~~bash
kubectl get csr jane -o yaml
~~~~

To decode it

~~~~bash
echo "<certificate>" |base64 --decode
~~~~



All the certificate releated operations are carried out by the controller manager.

    If anyone has to sign the certificates they need the CA Servers, root certificate and private key. The controller manager configuration has two options where you can specify this.












O processo de geração e aprovação de certificados no Kubernetes desempenha um papel fundamental na segurança e na autenticação das comunicações entre os diversos componentes do cluster, bem como entre os usuários e os recursos do cluster. Os certificados são usados para estabelecer a identidade de entidades dentro do cluster e garantir a confidencialidade e integridade das comunicações. Aqui estão algumas das razões pelas quais o processo de geração e aprovação de certificados é importante no Kubernetes:

    Segurança da Comunicação: Certificados são usados para criptografar as comunicações entre os nós do cluster, o que ajuda a proteger os dados em trânsito contra interceptação e acesso não autorizado.

    Autenticação de Componentes: Os certificados são usados para autenticar os componentes do Kubernetes, como nós, controladores e serviços, garantindo que apenas componentes legítimos possam se comunicar e interagir uns com os outros.

    Autenticação de Usuários: Certificados também podem ser usados para autenticar usuários e serviços fora do cluster que desejam interagir com recursos dentro do cluster. Isso é importante para garantir que apenas entidades autorizadas tenham acesso aos recursos do Kubernetes.

    Autorização Baseada em Certificado: Uma vez autenticadas, as entidades podem ser autorizadas a realizar ações específicas com base em seus certificados, permitindo políticas de acesso granulares.

Aqui estão alguns exemplos de como os certificados podem ser usados no Kubernetes:

    Autenticação de Nós: Cada nó no cluster possui um certificado que o identifica. Isso garante que apenas nós legítimos possam se juntar ao cluster e se comunicar com outros nós.

    Comunicação Segura entre Componentes: Os certificados são usados para garantir que a comunicação entre os componentes do Kubernetes, como os controladores e os pods, seja segura e autenticada.

    Autenticação de Usuários: Os usuários que desejam interagir com o cluster podem autenticar-se usando certificados, garantindo que apenas usuários autorizados tenham acesso aos recursos do cluster.

    Comunicação Segura com API Server: Os clientes que interagem com o API Server do Kubernetes geralmente usam certificados para autenticação, garantindo que apenas clientes autorizados possam fazer solicitações.

    TLS para Serviços: Os serviços que precisam de comunicação segura geralmente usam certificados TLS para criptografar o tráfego entre si, protegendo os dados em trânsito.

Em resumo, os certificados desempenham um papel crítico na segurança e na autenticação do Kubernetes, ajudando a garantir que apenas entidades legítimas tenham acesso ao cluster e que as comunicações dentro do cluster sejam seguras e confiáveis. Eles são uma parte essencial da infraestrutura de segurança do Kubernetes.







- Exemplo de manifesto do 

~~~~yaml

fernando@debian10x64:~$ cat /etc/kubernetes/manifests/kube-controller-manager.yaml
cat: /etc/kubernetes/manifests/kube-controller-manager.yaml: Permission denied
fernando@debian10x64:~$ sudo cat /etc/kubernetes/manifests/kube-controller-manager.yaml
[sudo] password for fernando:
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    component: kube-controller-manager
    tier: control-plane
  name: kube-controller-manager
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-controller-manager
    - --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --bind-address=127.0.0.1
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --cluster-name=kubernetes
    - --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
    - --cluster-signing-key-file=/etc/kubernetes/pki/ca.key
    - --controllers=*,bootstrapsigner,tokencleaner
    - --kubeconfig=/etc/kubernetes/controller-manager.conf
    - --leader-elect=true
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --root-ca-file=/etc/kubernetes/pki/ca.crt
    - --service-account-private-key-file=/etc/kubernetes/pki/sa.key
    - --use-service-account-credentials=true
    image: registry.k8s.io/kube-controller-manager:v1.28.1
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10257
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-controller-manager
    resources:
      requests:
        cpu: 200m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10257
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
    - mountPath: /etc/pki
      name: etc-pki
      readOnly: true
    - mountPath: /usr/libexec/kubernetes/kubelet-plugins/volume/exec
      name: flexvolume-dir
    - mountPath: /etc/kubernetes/pki
      name: k8s-certs
      readOnly: true
    - mountPath: /etc/kubernetes/controller-manager.conf
      name: kubeconfig
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
      path: /etc/pki
      type: DirectoryOrCreate
    name: etc-pki
  - hostPath:
      path: /usr/libexec/kubernetes/kubelet-plugins/volume/exec
      type: DirectoryOrCreate
    name: flexvolume-dir
  - hostPath:
      path: /etc/kubernetes/pki
      type: DirectoryOrCreate
    name: k8s-certs
  - hostPath:
      path: /etc/kubernetes/controller-manager.conf
      type: FileOrCreate
    name: kubeconfig
  - hostPath:
      path: /usr/local/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-local-share-ca-certificates
  - hostPath:
      path: /usr/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-share-ca-certificates
status: {}
fernando@debian10x64:~$

~~~~



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# RESUMO

- Operações relacionadas a certificados são realizadas pelo Controller Manager.

- Localização do certificado e chave utilizados pelo Controller Manager, nas operações relacionadas a certificados:
    - --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
    - --cluster-signing-key-file=/etc/kubernetes/pki/ca.key