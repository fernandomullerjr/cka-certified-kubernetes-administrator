
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "224. Solution - Service Networking."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  224. Solution - Service Networking


What network range are the nodes in the cluster part of?
## ALTERNATIVA
- Utilizar o "ip add" para obter o range de ip da interface eth0.






What is the range of IP addresses configured for PODs on this cluster?
## ALTERNATIVA
- Verificar qual cni está em uso.
- Verificar logs do Pod do Weave.
- Procurar algo com "ipalloc" nos logs.










What is the IP Range configured for the services within the cluster?
## ALTERNATIVA
- Verificar a conf do api-server.
- Na pasta manifests, conf do api-server, ver sobre service-cluster-ip-range.





How many kube-proxy pods are deployed in this cluster?
## ALTERNATIVA
- Respondeu 2 também, mesmo a questão dizendo cluster, daí seriam 3, pq tem 3 pods contando o node01 também.





What type of proxy is the kube-proxy configured to use?
## ALTERNATIVA
- Ver os logs do Pod kube-proxy.
- Nele consta se é iptables.






How does this Kubernetes cluster ensure that a kube-proxy pod runs on all nodes in the cluster?
## ALTERNATIVA
- kubectl get all -A