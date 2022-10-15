

# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 41. Practice Test - Namespaces. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 41. Practice Test - Namespaces


# How many namespaces exist in the system?

controlplane ~ ➜  kubectl get ns
NAME              STATUS   AGE
default           Active   26m
kube-system       Active   26m
kube-public       Active   26m
kube-node-lease   Active   26m
finance           Active   19s
marketing         Active   19s
dev               Active   19s
prod              Active   19s
manufacturing     Active   19s
research          Active   19s

controlplane ~ ➜  




# How many pods exist in the research namespace?


controlplane ~ ➜  kubectl get pods -n research
NAME    READY   STATUS             RESTARTS      AGE
dna-2   0/1     CrashLoopBackOff   2 (51s ago)   73s
dna-1   0/1     CrashLoopBackOff   3 (27s ago)   73s

controlplane ~ ➜  







# Create a POD in the finance namespace.

Use the spec given below.
    Name: redis
    Image Name: redis

kubectl run redis --image=redis --dry-run=client -o yaml > redis-pod.yaml
kubectl run redis --image=redis --namespace=finance


controlplane ~ ➜  kubectl run redis --image=redis --namespace=finance
pod/redis created

controlplane ~ ➜  kubectl get pods -A
NAMESPACE       NAME                                      READY   STATUS             RESTARTS      AGE
kube-system     local-path-provisioner-7b7dc8d6f5-2xc7x   1/1     Running            0             38m
kube-system     coredns-b96499967-j2m8k                   1/1     Running            0             38m
kube-system     helm-install-traefik-crd-6dn5c            0/1     Completed          0             38m
kube-system     helm-install-traefik-l5dnt                0/1     Completed          1             38m
kube-system     svclb-traefik-ck9dx                       2/2     Running            0             37m
kube-system     metrics-server-668d979685-9mm2q           1/1     Running            0             38m
kube-system     traefik-7cd4fcff68-68mc8                  1/1     Running            0             37m
marketing       redis-db                                  1/1     Running            0             12m
dev             redis-db                                  1/1     Running            0             12m
marketing       blue                                      1/1     Running            0             12m
manufacturing   red-app                                   1/1     Running            0             12m
finance         payroll                                   1/1     Running            0             12m
research        dna-1                                     0/1     CrashLoopBackOff   7 (88s ago)   12m
research        dna-2                                     0/1     CrashLoopBackOff   7 (59s ago)   12m
default         redis                                     1/1     Running            0             25s
finance         redis                                     1/1     Running            0             7s

controlplane ~ ➜  







# Which namespace has the blue pod in it?
marketing






# Access the Blue web application using the link above your terminal!!

From the UI you can ping other services.










# What DNS name should the Blue application use to access the database db-service in its own namespace - marketing?

You can try it in the web application UI. Use port 6379.


kubectl get all -n marketing


controlplane ~ ➜  kubectl get all -n marketing
NAME           READY   STATUS    RESTARTS   AGE
pod/redis-db   1/1     Running   0          15m
pod/blue       1/1     Running   0          15m

NAME                   TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/blue-service   NodePort   10.43.167.93   <none>        8080:30082/TCP   15m
service/db-service     NodePort   10.43.244.10   <none>        6379:30741/TCP   15m

controlplane ~ ➜  



- resposta:
db-service








# What DNS name should the Blue application use to access the database db-service in the dev namespace?

You can try it in the web application UI. Use port 6379.

kubectl get all -n dev

controlplane ~ ➜  kubectl get all -n dev
NAME           READY   STATUS    RESTARTS   AGE
pod/redis-db   1/1     Running   0          18m

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/db-service   ClusterIP   10.43.83.84   <none>        6379/TCP   18m

controlplane ~ ➜  