


# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 96. Commands and Arguments."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################

#  96. Commands and Arguments

# Commands and Arguments in Kubernetes
  - Take me to [Video Tutorial](https://kodekloud.com/topic/commands-and-arguments-in-kubernetes-2/)

In this section, we will take a look at commands and arguments in kubernetes

- Anything that is appended to the docker run command will go into the **`args`** property of the pod definition file in the form of an array.
- The command field corresponds to the entrypoint instruction in the Dockerfile so to summarize there are 2 fields that correspond to 2 instructions in the Dockerfile.
  ```
  apiVersion: v1
  kind: Pod
  metadata:
    name: ubuntu-sleeper-pod
  spec:
   containers:
   - name: ubuntu-sleeper
     image: ubuntu-sleeper
     command: ["sleep2.0"]
     args: ["10"]
  ```
  ![args](../../images/args.PNG)
  
#### K8s Reference Docs
- https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/















# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################

#  96. Commands and Arguments


- Pod editado:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-sleeper-pod
spec:
  containers:
    - name: ubuntu-sleeper
      image: ubuntu-sleeper
      command: ["sleep2.0"]
      args: ["10"]
~~~~