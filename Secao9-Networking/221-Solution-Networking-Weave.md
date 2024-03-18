
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "221. Solution - Networking Weave."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  221. Solution - Networking Weave


## ALTERNATIVA
- Ver conf do diretório:

~~~~bash
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ ls /etc/cni/
net.d
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$
~~~~







What is the POD IP address range configured by weave?
## ALTERNATIVA
- Ver o ipalloc via logs do Pod.







What is the default gateway configured on the PODs scheduled on node01?
Try scheduling a pod on node01 and check ip route output

## ALTERNATIVA
- Lançar um busybox e pegar o ip route por ele:
kubectl run busybox --image=busybox --restart=Never -- /bin/sh -c "sleep 1000"
Isso criará um pod chamado "busybox" usando a imagem do BusyBox, que executará o comando sleep por 1000 segundos. O pod não será reiniciado automaticamente se falhar, pois definimos --restart=Never.

No video o busybox tem o "default" como 10.244.x.x, já no lab do test o "default" iniciava com 172.25.x.x, mas a resposta é 10.244.x.x mesmo(que foi o que eu respondi).