
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 26. Practice Test - Pods. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 26. Practice Test - Pods

- Respondendo as questões.
- Rascunho

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS             RESTARTS   AGE
kube-system   local-path-provisioner-7b7dc8d6f5-zbbrh   1/1     Running            0          20m

- A coluna READY indica o número de containers up e o total de containers.


# pods

- DICA DA QUESTÃO
Create a pod definition YAML file and use it to create a pod. Alternatively, use the kubectl run command to create a pod definition YAML file and kubectl create -f command to create a resource from the manifest file.

apiVersion: v1
kind: Pod
metadata:
  name: redis
spec:
  containers:
  - name: redis
    image: redis123



- Criando pod do Redis:

controlplane ~ ➜  vi pod.yaml

controlplane ~ ➜  vi pod.yaml

controlplane ~ ➜  kubectl create -f pod.yaml
pod/redis created

controlplane ~ ➜  kubectl get pods 
NAME                    READY   STATUS         RESTARTS   AGE
nginx-8f458dc5b-p4brz   1/1     Running        0          15m
newpods-lnxj7           1/1     Running        0          15m
newpods-ptnfc           1/1     Running        0          15m
newpods-wq8l5           1/1     Running        0          15m
redis                   0/1     ErrImagePull   0          4s

controlplane ~ ➜  



# QUESTÃO 13
Now change the image on this pod to redis.
Once done, the pod should be in a running state.

CheckCompleteIncomplete
Name: redis

Image Name: redis

<https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#edit>


- Editando o Pod
kubectl edit pod redis


controlplane ~ ✖ kubectl edit pod redis
pod/redis edited

controlplane ~ ➜  kubectl get pods 
NAME                    READY   STATUS             RESTARTS       AGE
nginx-8f458dc5b-p4brz   1/1     Running            0              19m
newpods-lnxj7           1/1     Running            1 (2m7s ago)   18m
newpods-ptnfc           1/1     Running            1 (2m7s ago)   18m
newpods-wq8l5           1/1     Running            1 (2m7s ago)   18m
redis                   0/1     ImagePullBackOff   0              3m46s

controlplane ~ ➜  kubectl get pods 
NAME                    READY   STATUS    RESTARTS        AGE
nginx-8f458dc5b-p4brz   1/1     Running   0               19m
newpods-lnxj7           1/1     Running   1 (2m11s ago)   18m
newpods-ptnfc           1/1     Running   1 (2m11s ago)   18m
newpods-wq8l5           1/1     Running   1 (2m11s ago)   18m
redis                   1/1     Running   0               3m50s

controlplane ~ ➜  





# push
git status
git add .
git commit -m "Aula 26. Practice Test - Pods. pt2"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status
