


------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "140. Kubernetes Security Primitives."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 140. Kubernetes Security Primitives

# Kubernetes Security Primitives
  
In this section, we will take a look at kubernetes security primitives

## Secure Hosts

  
## Secure Kubernetes
- We need to make two types of decisions.
  - Who can access?
  - What can they do?
 
 
## Authentication
- Who can access the API Server is defined by the Authentication mechanisms.
  
## Authorization
- Once they gain access to the cluster, what they can do is defined by authorization mechanisms.

## TLS Certificates
- All communication with the cluster, between the various components such as the ETCD Cluster, kube-controller-manager, scheduler, api server, as well as those running on the working nodes such as the kubelet and kubeproxy is secured using TLS encryption.

 
## Network Policies
What about communication between applications within the cluster?

  




------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 140. Kubernetes Security Primitives

Authentication

    Who can access the API Server is defined by the Authentication mechanisms.

Authorization

    Once they gain access to the cluster, what they can do is defined by authorization mechanisms.



Auth
Who can access?
        Files(username and passwords)
        Files(username and tokens)
        Certificates
        External Authentication providers - LDAP
        Service Accounts


What can they do?
        RBAC Authorization
        ABAC Authorization
        Node Authorization
        Webhook Mode


TLS
- Todas as comunicações entre os componentes do Kubernetes são feitas com encriptação TLS(TLS Encryption).



- Todos os Pods podem acessar todos os Pods do Cluster.
- Com as Network Policies, é possível restringir o acesso a alguns Pods do Cluster.