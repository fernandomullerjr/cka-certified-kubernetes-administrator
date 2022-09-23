
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 27. Practice Test - Solution. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 27. Practice Test - Solution (Optional)

kubectl run --help

  # Start a nginx pod
  kubectl run nginx --image=nginx

  # Dry run; print the corresponding API objects without creating them
  kubectl run nginx --image=nginx --dry-run=client


  -i, --stdin=false: Keep stdin open on the container(s) in the pod, even if nothing is attached.



kubectl run nginx --image=nginx --dry-run=client
kubectl run redis --image=redis --dry-run=client -o yaml > 27-redis-pod.yaml


fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/secao2-Core-concepts$ kubectl run redis --image=redis --dry-run=client -o yaml > 27-redis-pod.yaml
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/secao2-Core-concepts$ cat 27-redis-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: redis
  name: redis
spec:
  containers:
  - image: redis
    name: redis
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/secao2-Core-concepts$



- Manifesto do pod do Redis, gerado via dry-run:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: redis
  name: redis
spec:
  containers:
  - image: redis
    name: redis
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
~~~~