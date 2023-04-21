
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "112. Solution - Multi-Container Pods (Optional)"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 112. Solution - Multi-Container Pods (Optional)





- Para a questão "Create a multi-container pod with 2 containers", além do jeito que foi feito originalmente, poderia ter sido usado o dry-run passando  o parametro da imagem, neste formato:

kubectl run yellow --image=busybox --dry-run=client -o yaml > pod-multiplo.yaml

- Então iria gerar o manifesto abaixo:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: yellow
  name: yellow
spec:
  containers:
  - image: busybox
    name: yellow
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
~~~~


- Aproveitando o manifesto, pode ser editado para ter 2 containers, conforme pedia:
~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: yellow
  name: yellow
spec:
  containers:
  - image: busybox
    name: yellow
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
~~~~