




# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# push

git status
git add .
git commit -m "160. Authorization."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# 160. Authorization

# Authorization
  
In this section, we will take a look at authorization in kubernetes

## Why do you need Authorization in your cluster?
- As an admin, you can do all operations
  ```
  $ kubectl get nodes
  $ kubectl get pods
  $ kubectl delete node worker-2
  ```
  
  
## Authorization Mechanisms
- There are different authorization mechanisms supported by kubernetes
  - Node Authorization
  - Attribute-based Authorization (ABAC)
  - Role-Based Authorization (RBAC)
  - Webhook
  
## Node Authorization
  
## ABAC

  
## RBAC


## Webhook
  
  
## Authorization Modes
- The mode options can be defined on the kube-apiserver

  
- When you specify multiple modes, it will authorize in the order in which it is specified
  
  #### K8s Reference Docs
  - https://kubernetes.io/docs/reference/access-authn-authz/authorization/
  




# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# 160. Authorization


Authorization Mechanisms

    There are different authorization mechanisms supported by kubernetes
        Node Authorization
        Attribute-based Authorization (ABAC)
        Role-Based Authorization (RBAC)
        Webhook


Authorization Modes

The mode options can be defined on the kube-apiserver
mode
When you specify multiple modes, it will authorize in the order in which it is specified
