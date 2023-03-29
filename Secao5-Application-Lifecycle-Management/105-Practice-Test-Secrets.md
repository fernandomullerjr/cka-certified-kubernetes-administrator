



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "Aula 105. Practice Test - Secrets"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 105. Practice Test - Secrets



How many Secrets exist on the system?

In the current(default) namespace.
                                                   

controlplane ~ ➜  kubectl get secrets -A
NAMESPACE     NAME                                TYPE                                  DATA   AGE
kube-system   k3s-serving                         kubernetes.io/tls                     2      18m
kube-system   controlplane.node-password.k3s      Opaque                                1      18m
kube-system   sh.helm.release.v1.traefik-crd.v1   helm.sh/release.v1                    1      17m
kube-system   sh.helm.release.v1.traefik.v1       helm.sh/release.v1                    1      17m
default       dashboard-token                     kubernetes.io/service-account-token   3      96s

controlplane ~ ➜  


- RESPOSTA:
1








How many secrets are defined in the dashboard-token secret?

controlplane ~ ✖ kubectl get secret dashboard-token
NAME              TYPE                                  DATA   AGE
dashboard-token   kubernetes.io/service-account-token   3      2m36s

controlplane ~ ➜  kubectl describe secret dashboard-token
Name:         dashboard-token
Namespace:    default
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: dashboard-sa
              kubernetes.io/service-account.uid: 9d9dfe58-107c-462b-8e90-5eca0bc89486

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     570 bytes
namespace:  7 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IjFJam5uNWxEX1RVSnJfRlg2RnNVN1BETlJmQ1BqLTdISFZTWlZiSlIwTkEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRhc2hib2FyZC10b2tlbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJkYXNoYm9hcmQtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI5ZDlkZmU1OC0xMDdjLTQ2MmItOGU5MC01ZWNhMGJjODk0ODYiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpkYXNoYm9hcmQtc2EifQ.klw-15U6f7kUCOxwy6r5_zRarOoKDj_ehD61yu7okh87lOxuxeCCwPcTPtrQ-u9fkyYy3382JtpKCrna09YB2YMU4GZh7MVQoKoHBuQkfL8DIHrHSdGwfpU7FXrWj-xyeAuIzDTZLyQaaq8biGOs2vXQe8dTWg3uXu8LxVT2opoljTFIhgIW-bZY60l27hSPB-krefamgUIvnG7YBRA5aj-sKqfeLeVF38hXS5PUk8D3LcYVrAtgjgMkX7lF36Q2IB3LMKcYXfaBm3JvaCOidN1CnnhhCPpQX8s2teZyJeDxvah6nI4-Ii-ghASFXgTKm2yKhLKQa53wvGIjEuiYFw

controlplane ~ ➜  


- RESPOSTA:
3












What is the type of the dashboard-token secret?


- resposta:
kubernetes.io/service-account-token














Which of the following is not a secret data defined in dashboard-token secret?

- RESPOSTA:
type














e are going to deploy an application with the below architecture

We have already deployed the required pods and services. Check out the pods and services created. Check out the web application using the Webapp MySQL link above your terminal, next to the Quiz Portal Link.



controlplane ~ ➜  kubectl get all
NAME             READY   STATUS    RESTARTS   AGE
pod/webapp-pod   1/1     Running   0          33s
pod/mysql        1/1     Running   0          33s

NAME                     TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.43.0.1      <none>        443/TCP          21m
service/webapp-service   NodePort    10.43.177.41   <none>        8080:30080/TCP   33s
service/sql01            ClusterIP   10.43.200.71   <none>        3306/TCP         33s

controlplane ~ ➜  








