
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# push

git status
git add .
git commit -m "174. Security Contexts."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  174. Security Contexts


# Security Context
  - Take me to [Video Tutorial](https://kodekloud.com/topic/security-contexts-2/)
  
In this section, we will take a look at security context

## Container Security
 ```
 $ docker run --user=1001 ubuntu sleep 3600
 $ docker run -cap-add MAC_ADMIN ubuntu
 ```
 
 ![csec](../../images/csec.PNG)
 
## Kubernetes Security
- You may choose to configure the security settings at a container level or at a pod level.

 ![ksec](../../images/ksec.PNG)

## Security Context
- To add security context on the container and a field called **`securityContext`** under the spec section.
  ```
  apiVersion: v1
  kind: Pod
  metadata:
    name: web-pod
  spec:
    securityContext:
      runAsUser: 1000
    containers:
    - name: ubuntu
      image: ubuntu
      command: ["sleep", "3600"]
  ```
  ![sxc1](../../images/sxc1.PNG)
  
- To set the same context at the container level, then move the whole section under container section.
  
  ```
  apiVersion: v1
  kind: Pod
  metadata:
    name: web-pod
  spec:
    containers:
    - name: ubuntu
      image: ubuntu
      command: ["sleep", "3600"]
      securityContext:
        runAsUser: 1000
  ```
  ![sxc2](../../images/sxc2.PNG)
  
- To add capabilities use the **`capabilities`** option
  ```
  apiVersion: v1
  kind: Pod
  metadata:
    name: web-pod
  spec:
    containers:
    - name: ubuntu
      image: ubuntu
      command: ["sleep", "3600"]
      securityContext:
        runAsUser: 1000
        capabilities: 
          add: ["MAC_ADMIN"]
  ```
  ![cap](../../images/cap.PNG)
  
  
### K8s Reference Docs
- https://kubernetes.io/docs/tasks/configure-pod-container/security-context/








# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  174. Security Contexts


## Security Context

    To add security context on the container and a field called securityContext under the spec section.

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: web-pod
spec:
  securityContext:
    runAsUser: 1000
  containers:
  - name: ubuntu
    image: ubuntu
    command: ["sleep", "3600"]
~~~~






To set the same context at the container level, then move the whole section under container section.

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: web-pod
spec:
  containers:
  - name: ubuntu
    image: ubuntu
    command: ["sleep", "3600"]
    securityContext:
      runAsUser: 1000
~~~~



## capabilities

To add capabilities use the capabilities option

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: web-pod
spec:
  containers:
  - name: ubuntu
    image: ubuntu
    command: ["sleep", "3600"]
    securityContext:
      runAsUser: 1000
      capabilities: 
        add: ["MAC_ADMIN"]
~~~~




# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# RESUMO

- Podemos configurar o securityContext a nível Pod e Container.
- Configuração do securityContext realizada ao nível do Container sobrepõe o que foi configurado a nível Pod.
- Capabilities são suportadas apenas no nível de Container, não é possível definir ao nível do Pod.