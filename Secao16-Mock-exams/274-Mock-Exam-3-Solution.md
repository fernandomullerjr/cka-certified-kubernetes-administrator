# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "274. Mock Exam - 3 - Solution."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
##  274. Mock Exam - 3 - Solution

# Mock Exam 3 Solution


1. Run the below command for solution: 

     <details>

     ```
     kubectl create serviceaccount pvviewer
     kubectl create clusterrole pvviewer-role --resource=persistentvolumes --verb=list
     kubectl create clusterrolebinding pvviewer-role-binding --clusterrole=pvviewer-role --serviceaccount=default:pvviewer
     ```

     ```
     apiVersion: v1
     kind: Pod
     metadata:
       creationTimestamp: null
       labels:
         run: pvviewer
       name: pvviewer
     spec:
       containers:
       - image: redis
         name: pvviewer
         resources: {}
       serviceAccountName: pvviewer
     ```
     </details>

2. Run the below command for solution: 

     <details>
 
     ```
     kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' > /root/CKA/node_ips
     ```
     </details>
 
3. Run the below command for solution:  
 
     <details>
 
     ```
     apiVersion: v1
     kind: Pod
     metadata:
       name: multi-pod
     spec:
       containers:
       - image: nginx
         name: alpha
         env:
         - name: name
           value: alpha
       - image: busybox
         name: beta
         command: ["sleep", "4800"]
         env:
         - name: name
           value: beta
     status: {}
     ```
     </details>
 
4. Run the below command for solution:
 
     <details>
     
     ```
     apiVersion: v1
     kind: Pod
     metadata:
       name: non-root-pod
     spec:
       securityContext:
         runAsUser: 1000
         fsGroup: 2000
       containers:
       - name: non-root-pod
         image: redis:alpine
     ```
     </details>
 
5. Run the below command for solution:  
 
     <details>
 
     ```
     apiVersion: networking.k8s.io/v1
     kind: NetworkPolicy
     metadata:
       name: ingress-to-nptest
       namespace: default
     spec:
       podSelector:
         matchLabels:
           run: np-test-1
       policyTypes:
       - Ingress
       ingress:
       - ports:
         - protocol: TCP
           port: 80
     ```
     </details>
   
6. Run the below command for solution: 
 
     <details>
 
     ```
     kubectl taint node node01 env_type=production:NoSchedule
     ```

     Deploy `dev-redis` pod and to ensure that workloads are not scheduled to this `node01` worker node.
     ```
     kubectl run dev-redis --image=redis:alpine

     kubectl get pods -owide
     ```

     Deploy new pod `prod-redis` with toleration to be scheduled on `node01` worker node.
     ```
     apiVersion: v1
     kind: Pod
     metadata:
       name: prod-redis
     spec:
       containers:
       - name: prod-redis
         image: redis:alpine
       tolerations:
       - effect: NoSchedule
         key: env_type
         operator: Equal
         value: production     
     ```

     View the pods with short details: 
     ```
     kubectl get pods -owide | grep prod-redis
     ```
     </details>
 
7. Run the below command for solution: 
 
     <details>
 
     ```
     kubectl create namespace hr
     kubectl run hr-pod --image=redis:alpine --namespace=hr --labels=environment=production,tier=frontend
     ```
     </details>

8. Run the below command for solution:

     <details>

     ```
     vi /root/CKA/super.kubeconfig

     Change the 2379 port to 6443 and run the below command to verify
     
     kubectl cluster-info --kubeconfig=/root/CKA/super.kubeconfig     
     ```
     </details>

9. Run the below command for solution:
   
     <details>
     
     ```
     sed -i 's/kube-contro1ler-manager/kube-controller-manager/g' kube-controller-manager.yaml
     ```
     </details>



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
##  274. Mock Exam - 3 - Solution



# ###################################################################################################################### 
### 1 / 9
- Revisado como criar os ServiceAccount, ClusterRole, ClusterRoleBinding, etc, via comando imperativo.
- Revisado como criar o Pod com ServiceAccountName.



# ###################################################################################################################### 
### 2 / 9
kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' > /root/CKA/node_ips


- Revisando como usar jsonpath.
- Como chegar na informação para formar o comando.


kubectl get nodes -o json | grep -i internalip -B 100

- Testando local o comando:

~~~~bash

>
> kubectl get nodes -o json | grep -i internalip -B 100
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "v1",
            "kind": "Node",
            "metadata": {
                "annotations": {
                    "kubeadm.alpha.kubernetes.io/cri-socket": "unix:///var/run/containerd/containerd.sock",
                    "node.alpha.kubernetes.io/ttl": "0",
                    "volumes.kubernetes.io/controller-managed-attach-detach": "true"
                },
                "creationTimestamp": "2024-09-21T21:23:12Z",
                "labels": {
                    "beta.kubernetes.io/arch": "amd64",
                    "beta.kubernetes.io/os": "linux",
                    "kubernetes.io/arch": "amd64",
                    "kubernetes.io/hostname": "wsl2",
                    "kubernetes.io/os": "linux",
                    "node-role.kubernetes.io/control-plane": "",
                    "node.kubernetes.io/exclude-from-external-load-balancers": ""
                },
                "name": "wsl2",
                "resourceVersion": "1062863",
                "uid": "d54bd298-16c0-41ee-a65b-0c81d2245499"
            },
            "spec": {
                "podCIDR": "192.168.0.0/24",
                "podCIDRs": [
                    "192.168.0.0/24"
                ]
            },
            "status": {
                "addresses": [
                    {
                        "address": "192.168.0.102",
                        "type": "InternalIP"

 ~                                               
~~~~


No comando fornecido:

```bash
kubectl get nodes -o json | grep -i internalip -B 100
```

O parâmetro `-B` da ferramenta `grep` significa **"before context"** (contexto anterior). Ele faz com que o `grep` exiba **linhas anteriores** àquela que contém o padrão de busca.

No caso específico do comando:

- **`kubectl get nodes -o json`**: Obtém os nós do cluster Kubernetes em formato JSON.
- **`grep -i internalip`**: Procura (ignorando maiúsculas e minúsculas, por causa do `-i`) pelo termo **`internalip`** no JSON de saída.
- **`-B 100`**: Exibe **as 100 linhas anteriores** a cada linha onde o termo `internalip` foi encontrado.

### Resumo do que o comando faz:
1. Lista os nós do Kubernetes em formato JSON.
2. Procura pelo termo `internalip`.
3. Inclui 100 linhas anteriores a cada ocorrência do termo `internalip` na saída.

Isso é útil para obter o contexto em torno da linha que contém `internalip`, especialmente porque o JSON gerado pelo `kubectl` pode ser extenso e hierárquico.


- Trazendo os "saltos"
kubectl get nodes -o json | jq -c 'paths'

    A opção -c compacta a saída (uma única linha para cada caminho).

    paths: Este filtro do jq retorna todos os caminhos possíveis dentro da estrutura do JSON. Um caminho é basicamente a sequência de chaves ou índices que levam a cada valor no JSON.


### 3. **`jq -c 'paths'`**
   - **Descrição**: O **`jq`** é uma ferramenta de manipulação de JSON. A opção **`-c`** compacta a saída (uma única linha para cada caminho).
   - **`paths`**: Este filtro do `jq` retorna **todos os caminhos possíveis** dentro da estrutura do JSON. Um caminho é basicamente a sequência de chaves ou índices que levam a cada valor no JSON.

   - **Exemplo de Saída do `jq -c 'paths'`**:
     Se o JSON for:
     ```json
     {
       "key1": {
         "key2": "value",
         "key3": [1, 2]
       }
     }
     ```
     O comando `jq -c 'paths'` retornará:
     ```text
     ["key1","key2"]
     ["key1","key3",0]
     ["key1","key3",1]
     ```
     Cada linha representa um caminho para acessar valores no JSON.

---



- Efetuando teste local no WSL2:
kubectl get nodes -o json | jq -c 'paths' | grep type
Como eu só tenho 1 node, retorna só o item 0 mesmo

~~~~bash
> kubectl get nodes -o json | jq -c 'paths' | grep type
["items",0,"status","addresses",0,"type"]
["items",0,"status","addresses",1,"type"]
["items",0,"status","conditions",0,"type"]
["items",0,"status","conditions",1,"type"]
["items",0,"status","conditions",2,"type"]
["items",0,"status","conditions",3,"type"]
["items",0,"status","conditions",4,"type"]
~~~~


- Sacando fora os conditions
kubectl get nodes -o json | jq -c 'paths' | grep type | grep -v conditions

~~~~bash
> kubectl get nodes -o json | jq -c 'paths' | grep type | grep -v conditions
["items",0,"status","addresses",0,"type"]
["items",0,"status","addresses",1,"type"]
~~~~


- Pegando estes caminhos
fazendo alguns testes


kubectl get nodes -o jsonpath='{.items[0].status.addresses}' | jq

>
> kubectl get nodes -o jsonpath='{.items[0].status.addresses}' | jq
[
  {
    "address": "192.168.0.102",
    "type": "InternalIP"
  },
  {
    "address": "wsl2",
    "type": "Hostname"
  }
]


- Teste:
kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}'

> kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}'
192.168.0.102%



- Comando final para resposta:

kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}'






# ###################################################################################################################### 
### 3 / 9

Weight: 12

Create a pod called multi-pod with two containers.
Container 1: name: alpha, image: nginx
Container 2: name: beta, image: busybox, command: sleep 4800

Environment Variables:
container 1:
name: alpha

Container 2:
name: beta

Pod Name: multi-pod

Container 1: alpha

Container 2: beta

Container beta commands set correctly?

Container 1 Environment Value Set

Container 2 Environment Value Set



3. Run the below command for solution:  
 
     <details>
 
     ```
     apiVersion: v1
     kind: Pod
     metadata:
       name: multi-pod
     spec:
       containers:
       - image: nginx
         name: alpha
         env:
         - name: name
           value: alpha
       - image: busybox
         name: beta
         command: ["sleep", "4800"]
         env:
         - name: name
           value: beta
     status: {}
     ```
     </details>







# ###################################################################################################################### 
### 4 / 9
Weight: 8

Create a Pod called non-root-pod , image: redis:alpine

runAsUser: 1000

fsGroup: 2000

Pod non-root-pod fsGroup configured

Pod non-root-pod runAsUser configured


4. Run the below command for solution:
 
     <details>
     
     ```
     apiVersion: v1
     kind: Pod
     metadata:
       name: non-root-pod
     spec:
       securityContext:
         runAsUser: 1000
         fsGroup: 2000
       containers:
       - name: non-root-pod
         image: redis:alpine
     ```
     </details>





# ###################################################################################################################### 
### 5 / 9
Weight: 14

We have deployed a new pod called np-test-1 and a service called np-test-service. Incoming connections to this service are not working. Troubleshoot and fix it.
Create NetworkPolicy, by the name ingress-to-nptest that allows incoming connections to the service over port 80.

Important: Don't delete any current objects deployed.

Important: Don't Alter Existing Objects!

NetworkPolicy: Applied to All sources (Incoming traffic from all pods)?

NetWorkPolicy: Correct Port?

NetWorkPolicy: Applied to correct Pod?


5. Run the below command for solution:  
 
     <details>
 
     ```
     apiVersion: networking.k8s.io/v1
     kind: NetworkPolicy
     metadata:
       name: ingress-to-nptest
       namespace: default
     spec:
       podSelector:
         matchLabels:
           run: np-test-1
       policyTypes:
       - Ingress
       ingress:
       - ports:
         - protocol: TCP
           port: 80
     ```
     </details>
   


- Poderia ter sido utilizado o comando para mostrar Labels do Pod:

kubectl get pods --show-labels

NAME         READY   STATUS    RESTARTS   AGE   LABELS
nginx-123    1/1     Running   0          5m    app=nginx,env=prod
nginx-456    1/1     Running   0          3m    app=nginx,env=dev



- Para responder a questão sobre Network Policy e liberar o sentido ingress, pode ser utilizada uma versão simplificada, sem conter o "from" e tendo apenas a parte do "ports", por exemplo:

~~~~yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: ingress-to-nptest
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: np-test-1
  policyTypes:
  - Ingress
  ingress:
  - ports:
    - protocol: TCP
      port: 80
~~~~



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
## PENDENTE
- continua em
12:13
pegar dicas de jq, jsonpath, grep, 


- Retomar nos 12:13, retroceder, pegar dicas
pegar dicas de jq, jsonpath, grep, 

- Questões de comandos e paths do JSON,


- continua em
25:11
na questão 6




# ###################################################################################################################### 
### 6 / 9
Weight: 12

Taint the worker node node01 to be Unschedulable. Once done, create a pod called dev-redis, image redis:alpine, to ensure workloads are not scheduled to this worker node. Finally, create a new pod called prod-redis and image: redis:alpine with toleration to be scheduled on node01.

key: env_type, value: production, operator: Equal and effect: NoSchedule

Key = env_type

Value = production

Effect = NoSchedule

pod 'dev-redis' (no tolerations) is not scheduled on node01?

Create a pod 'prod-redis' to run on node01



- solução da kodekloud:

6. Run the below command for solution: 
 
     <details>
 
     ```
     kubectl taint node node01 env_type=production:NoSchedule
     ```

     Deploy `dev-redis` pod and to ensure that workloads are not scheduled to this `node01` worker node.
     ```
     kubectl run dev-redis --image=redis:alpine

     kubectl get pods -owide
     ```

     Deploy new pod `prod-redis` with toleration to be scheduled on `node01` worker node.
     ```
     apiVersion: v1
     kind: Pod
     metadata:
       name: prod-redis
     spec:
       containers:
       - name: prod-redis
         image: redis:alpine
       tolerations:
       - effect: NoSchedule
         key: env_type
         operator: Equal
         value: production     
     ```

     View the pods with short details: 
     ```
     kubectl get pods -owide | grep prod-redis
     ```
     </details>



- Na minha questão 6 original
errei parte da questão 6

- Questão 6 só esta parte:
pod 'dev-redis' (no tolerations) is not scheduled on node01?

- Utilizei os comandos:
kubectl run dev-redis --image=redis:alpine
kubectl taint nodes node01 env_type=production:NoSchedule
kubectl run prod-redis --image=redis:alpine -o yaml --dry-run=client
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao16-Mock-exams/273-x--questao6-pod-toleration.yaml

- Possível que seja porque o pod dev-redis subiu no node01 antes de ter aplicado a Taint.
- Possível solução:
Aplicar a Taint primeiro.








# ###################################################################################################################### 
### 7 / 9
Weight: 8

Create a pod called hr-pod in hr namespace belonging to the production environment and frontend tier .
image: redis:alpine

Use appropriate labels and create all the required objects if it does not exist in the system already.

hr-pod labeled with environment production?

hr-pod labeled with tier frontend?


- Solução da Kodekloud:
7. Run the below command for solution: 
 
     <details>
 
     ```
     kubectl create namespace hr
     kubectl run hr-pod --image=redis:alpine --namespace=hr --labels=environment=production,tier=frontend
     ```
     </details>


- Minha solução tá ok:

### 7 / 9
kubectl create ns hr
kubectl run hr-pod --namespace=hr --image=redis:alpine --labels="environment=production,tier=frontend"





# ###################################################################################################################### 
### 8 / 9
Weight: 8

A kubeconfig file called super.kubeconfig has been created under /root/CKA. There is something wrong with the configuration. Troubleshoot and fix it.

Fix /root/CKA/super.kubeconfig


- Solução da KodeKloud:

8. Run the below command for solution:

     <details>

     ```
     vi /root/CKA/super.kubeconfig

     Change the 2379 port to 6443 and run the below command to verify
     
     kubectl cluster-info --kubeconfig=/root/CKA/super.kubeconfig     
     ```
     </details>


- Minha solução tá ok:

### 8 / 9
- Ajustando porta
de
9999
para
6443

vi /root/CKA/super.kubeconfig

- Pode ser utilizado o comando kubectl get nodes para ver com um kubeconfig personalizado e tomar o erro sobre a porta incorreta no Kubeconfig.
kubectl get nodes --kubeconfig=/root/CKA/super.kubeconfig   
ou pode ser usado este comando também:
kubectl cluster-info --kubeconfig=/root/CKA/super.kubeconfig   









# ###################################################################################################################### 
### 9 / 9
Weight: 14

We have created a new deployment called nginx-deploy. scale the deployment to 3 replicas. Has the replica's increased? Troubleshoot the issue and fix it.

deployment has 3 replicas




controlplane ~ ➜  kubectl get pods -n kube-system
NAME                                   READY   STATUS             RESTARTS      AGE
coredns-77d6fd4654-b6fk6               1/1     Running            0             48m
coredns-77d6fd4654-drl2c               1/1     Running            0             48m
etcd-controlplane                      1/1     Running            0             48m
kube-apiserver-controlplane            1/1     Running            0             48m
kube-contro1ler-manager-controlplane   0/1     ImagePullBackOff   0             40m
kube-proxy-2wvbl                       1/1     Running            0             48m
kube-proxy-cksrl                       1/1     Running            0             48m
kube-scheduler-controlplane            1/1     Running            0             48m
weave-net-hn7nn                        2/2     Running            1 (48m ago)   48m
weave-net-vbdgh                        2/2     Running            0             48m

controlplane ~ ➜  



- Solução da KodeKloud:

9. Run the below command for solution:
   
     <details>
     
     ```
     sed -i 's/kube-contro1ler-manager/kube-controller-manager/g' kube-controller-manager.yaml
     ```
     </details>



- Minha solução:

### 9 / 9
kubectl get deployment/nginx-deploy -o yaml

kubectl edit deployment/nginx-deploy

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao16-Mock-exams/273-x--questao9-kube-controller.yaml
https://www.illumine.tw/xkldimedn11/kubernetes-waiting-for-deployment-spec-update-to-be-observed

sed -i 's/kube-contro1ler-manager/kube-controller-manager/g' /etc/kubernetes/manifests/kube-controller-manager.yaml 


kubectl scale --replicas=3 deployment/nginx-deploy
kubectl get pods






# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO - DICAS

### **`jq -c 'paths'`**
   - **Descrição**: O **`jq`** é uma ferramenta de manipulação de JSON. 
   - A opção **`-c`** compacta a saída (uma única linha para cada caminho).
   - **`paths`**: Este filtro do `jq` retorna **todos os caminhos possíveis** dentro da estrutura do JSON. Um caminho é basicamente a sequência de chaves ou índices que levam a cada valor no JSON.


- Filtrando o JSON do Kubernetes:

```bash
kubectl get nodes -o json | grep -i internalip -B 100
```

O parâmetro `-B` da ferramenta `grep` significa **"before context"** (contexto anterior). Ele faz com que o `grep` exiba **linhas anteriores** àquela que contém o padrão de busca.
- **`-B 100`**: Exibe **as 100 linhas anteriores** a cada linha onde o termo `internalip` foi encontrado.



- Filtrando com o 'paths' do jq, e deixando a saída mais limpa sacando fora os conditions com o grep -v que é o oposto de filtrar:
kubectl get nodes -o json | jq -c 'paths' | grep type | grep -v conditions

~~~~bash
> kubectl get nodes -o json | jq -c 'paths' | grep type | grep -v conditions
["items",0,"status","addresses",0,"type"]
["items",0,"status","addresses",1,"type"]
~~~~



- Comando para mostrar as Labels do Pod:
```kubectl get pods --show-labels```



- Para responder a questão sobre Network Policy e liberar o sentido ingress, pode ser utilizada uma versão simplificada, sem conter o "from" e tendo apenas a parte do "ports", por exemplo:

~~~~yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: ingress-to-nptest
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: np-test-1
  policyTypes:
  - Ingress
  ingress:
  - ports:
    - protocol: TCP
      port: 80
~~~~




- Na minha questão 6 original
errei parte da questão 6

- Questão 6 só esta parte:
pod 'dev-redis' (no tolerations) is not scheduled on node01?

- Utilizei os comandos:
kubectl run dev-redis --image=redis:alpine
kubectl taint nodes node01 env_type=production:NoSchedule
kubectl run prod-redis --image=redis:alpine -o yaml --dry-run=client
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao16-Mock-exams/273-x--questao6-pod-toleration.yaml

- Possível que seja porque o pod dev-redis subiu no node01 antes de ter aplicado a Taint.
- Possível solução:
Aplicar a Taint primeiro.




- Pode ser utilizado o comando kubectl get nodes para ver com um kubeconfig personalizado e tomar o erro sobre a porta incorreta no Kubeconfig.
kubectl get nodes --kubeconfig=/root/CKA/super.kubeconfig   
ou pode ser usado este comando também:
kubectl cluster-info --kubeconfig=/root/CKA/super.kubeconfig   




- Em caso de problemas de escala/criação de replicas, conferir o kube-controller-manager via comando ````kubectl get pods -n kube-system````

~~~~bash
controlplane ~ ➜  kubectl get pods -n kube-system
NAME                                   READY   STATUS             RESTARTS      AGE
coredns-77d6fd4654-b6fk6               1/1     Running            0             48m
etcd-controlplane                      1/1     Running            0             48m
kube-contro1ler-manager-controlplane   0/1     ImagePullBackOff   0             40m
~~~~