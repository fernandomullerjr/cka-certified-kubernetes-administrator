
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "108. Demo: Encrypting Secret Data at Rest"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 108. Demo: Encrypting Secret Data at Rest



- Primeiro, criar um objeto de Secret, usando o comando kubectl create secret generic


Examples:
  # Create a new secret named my-secret with keys for each file in folder bar
  kubectl create secret generic my-secret --from-file=path/to/bar

  # Create a new secret named my-secret with specified keys instead of names on disk
  kubectl create secret generic my-secret --from-file=ssh-privatekey=path/to/id_rsa
--from-file=ssh-publickey=path/to/id_rsa.pub

  # Create a new secret named my-secret with key1=supersecret and key2=topsecret
  kubectl create secret generic my-secret --from-literal=key1=supersecret --from-literal=key2=topsecret

  # Create a new secret named my-secret using a combination of a file and a literal
  kubectl create secret generic my-secret --from-file=ssh-privatekey=path/to/id_rsa --from-literal=passphrase=topsecret

  # Create a new secret named my-secret from env files
  kubectl create secret generic my-secret --from-env-file=path/to/foo.env --from-env-file=path/to/bar.env




- Criar usando esta
kubectl create secret generic my-secret --from-literal=key1=supersecret

~~~~bash
fernando@debian10x64:~$ kubectl create secret generic my-secret --from-literal=key1=supersecret
secret/my-secret created
fernando@debian10x64:~$
~~~~



- Verificando se a Secret foi criada:

~~~~bash
fernando@debian10x64:~$ kubectl get secret
NAME                                             TYPE                                  DATA   AGE
app-secret                                       Opaque                                3      31d
default-token-cb22x                              kubernetes.io/service-account-token   3      96d
meu-ingress-controller-ingress-nginx-admission   Opaque                                3      96d
minhaapi-api-secret                              Opaque                                2      70d
minhaapi-mongodb                                 Opaque                                2      70d
minhaapi-mongodb-token-bk9zr                     kubernetes.io/service-account-token   3      70d
my-secret                                        Opaque                                1      56s
sh.helm.release.v1.minhaapi.v1                   helm.sh/release.v1                    1      83d
sh.helm.release.v1.minhaapi.v10                  helm.sh/release.v1                    1      68d
sh.helm.release.v1.minhaapi.v2                   helm.sh/release.v1                    1      75d
sh.helm.release.v1.minhaapi.v3                   helm.sh/release.v1                    1      75d
sh.helm.release.v1.minhaapi.v4                   helm.sh/release.v1                    1      73d
sh.helm.release.v1.minhaapi.v5                   helm.sh/release.v1                    1      73d
sh.helm.release.v1.minhaapi.v6                   helm.sh/release.v1                    1      70d
sh.helm.release.v1.minhaapi.v7                   helm.sh/release.v1                    1      68d
sh.helm.release.v1.minhaapi.v8                   helm.sh/release.v1                    1      68d
sh.helm.release.v1.minhaapi.v9                   helm.sh/release.v1                    1      68d
fernando@debian10x64:~$
~~~~




- Detalhando a Secret:

kubectl describe secret my-secret

~~~~bash
fernando@debian10x64:~$ kubectl describe secret my-secret
Name:         my-secret
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
key1:  11 bytes
fernando@debian10x64:~$
~~~~






kubectl get secret my-secret -o yaml

~~~~bash
fernando@debian10x64:~$ kubectl get secret my-secret -o yaml
apiVersion: v1
data:
  key1: c3VwZXJzZWNyZXQ=
kind: Secret
metadata:
  creationTimestamp: "2023-04-07T17:57:41Z"
  name: my-secret
  namespace: default
  resourceVersion: "132333"
  uid: e02e2b0b-4be6-4f1b-9f42-2e6e21692787
type: Opaque
fernando@debian10x64:~$
~~~~




- Decodificando a Secret usando o Base64 decode:

cat | echo -n "c3VwZXJzZWNyZXQ=" | base64 --decode

~~~~bash
fernando@debian10x64:~$ cat | echo -n "c3VwZXJzZWNyZXQ=" | base64 --decode
supersecret
fernando@debian10x64:~$
~~~~
