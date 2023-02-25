
- Outra opção para criar este pod:
kubectl run webapp-green --image=kodekloud/webapp-color --dry-run=client -o yaml --command -- sleep 1000 > webapp-green.yaml

  # Start the nginx pod using the default command, but use custom arguments (arg1 .. argN) for that command
  kubectl run nginx --image=nginx -- <arg1> <arg2> ... <argN>
kubectl run webapp-green --image=kodekloud/webapp-color --dry-run=client -o yaml -- sleep 1000 > webapp-green.yaml


fernando@debian10x64:~$ kubectl run webapp-green --image=kodekloud/webapp-color --dry-run=client -o yaml -- sleep 1000 > webapp-green.yaml
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ cat webapp-green.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: webapp-green
  name: webapp-green
spec:
  containers:
  - args:
    - sleep
    - "1000"
    image: kodekloud/webapp-color
    name: webapp-green
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
fernando@debian10x64:~$










# RESUMO
Reforçar sobre o uso do replace:
- Uma alternativa é usar o comando kubectl replace
    kubectl replace --force -f /tmp/kubectl-edit-5486654s4566181.yaml
Efetuar Replace do Pod, deletando e recriando o recurso


- O command passado via manifesto se sobrepõe ao CMD e ENTRYPOINT do Dockerfile.
- O args passado via manifesto se sobrepõe ao CMD e ENTRYPOINT do Dockerfile.