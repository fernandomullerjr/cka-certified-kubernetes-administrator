#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "257. Solution - Control Plane Failure."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
##  257. Solution - Control Plane Failure

# Solution Control Plane Failure

  - Lets have a look at the [Practice Test](https://kodekloud.com/topic/practice-test-control-plane-failure/) of the Control Plane Failure

    ### Solution

    1. Check Solution 

       <details>

        ```
        kubectl get pods -n kube-system
        ```

        ```
        sed -i 's/kube-schedulerrrr/kube-scheduler/g' /etc/kubernetes/manifests/kube-scheduler.yaml
        ```
       </details>

    2. Check Solution

       <details>

        ```
        kubectl scale deploy app --replicas=2
        ```
       </details>

    3. Check Solution

       <details>

        ```
        sed -i 's/controller-manager-XXXX.conf/controller-manager.conf/' /etc/kubernetes/manifests/kube-controller-manager.yaml
        ```
       </details>

    4. Check Solution

       <details>

        ```
        sed -i 's/WRONG-PKI-DIRECTORY/pki/' /etc/kubernetes/manifests/kube-controller-manager.yaml
        ```
       </details>





# ###################################################################################################################### 
# ###################################################################################################################### 
##  257. Solution - Control Plane Failure


- Procurar pelo Cheat Sheet via doc:
<https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/>

- Neste DOC tem o trecho sobre Autocomplete:

Kubectl Autocomplete

~~~~BASH
source <(kubectl completion bash) # configuração de autocomplete no bash do shell atual, o pacote bash-completion precisa ter sido instalado primeiro.
echo "source <(kubectl completion bash)" >> ~/.bashrc # para adicionar o autocomplete permanentemente no seu shell bash.
~~~~






- Questão1:

Quando um Pod não provisiona os Containers, avaliar via describe se ele tem um Node atribuido.
Neste caso, havia um problema no kube-scheduler.
Outra questão é que o Pod do Scheduler é um Pod Estático, pois está no diretório /etc/kubernetes/manifests e tem o sufixo -controlplane.
Verificando via ls /etc/kubernetes/manifests.


- SOLUÇÃO1:

via solução do Fernando:
pt1, ajustar o manifesto /etc/kubernetes/manifests/kube-scheduler.yaml
pt2, deletar o pod com erro.
pt3, aplicar kubectl apply -f /etc/kubernetes/manifests/kube-scheduler.yaml

via material do KodeKloud:
~~~~BASH
kubectl get pods -n kube-system
sed -i 's/kube-schedulerrrr/kube-scheduler/g' /etc/kubernetes/manifests/kube-scheduler.yaml
~~~~





- QUESTÃO2:

Scale the deployment app to 2 pods.
Scale Deployment to 2 PODs
kubectl scale --replicas=2 deployment.apps/app


- SOLUÇÃO2

~~~~BASH
kubectl scale --replicas=2 deployment.apps/app
~~~~





- QUESTÃO3:

Even though the deployment was scaled to 2, the number of PODs does not seem to increase. Investigate and fix the issue.
Inspect the component responsible for managing deployments and replicasets.
Fix issue

- SOLUÇÃO3:

via solução do Fernando:

Ajustar o arquivo "/etc/kubernetes/manifests/kube-controller-manager.yaml"
vi /etc/kubernetes/manifests/kube-controller-manager.yaml
DE:
    - --kubeconfig=/etc/kubernetes/controller-manager-XXXX.conf
PARA:
    - --kubeconfig=/etc/kubernetes/controller-manager.conf


via KodeKloud:

```bash
        sed -i 's/controller-manager-XXXX.conf/controller-manager.conf/' /etc/kubernetes/manifests/kube-controller-manager.yaml
```







- QUESTÃO4:

Something is wrong with scaling again. We just tried scaling the deployment to 3 replicas. But it's not happening.
Investigate and fix the issue.
Fix Issue
Wait for deployment to actually scale


- SOLUÇÃO4

Verificado problema no kube-controller-manager.
Volume com path incorreto.

via solução do Fernando:

AJUSTAR O path
path: /etc/kubernetes/WRONG-PKI-DIRECTORY
vi /etc/kubernetes/manifests/kube-controller-manager.yaml 

via KodeKloud:

        ```
        sed -i 's/WRONG-PKI-DIRECTORY/pki/' /etc/kubernetes/manifests/kube-controller-manager.yaml
        ```









# ###################################################################################################################### 
# ###################################################################################################################### 
##  RESUMO

- Ativar o Autocomplete:

~~~~BASH
source <(kubectl completion bash) # configuração de autocomplete no bash do shell atual, o pacote bash-completion precisa ter sido instalado primeiro.
~~~~


- Quando um Pod não provisiona os Containers, avaliar via describe se ele tem um Node atribuido.


- Verificar por Pods Estáticos:
ls /etc/kubernetes/manifests


- Utilizar o sed para os casos onde precisam ser ajustada uma palavra, que precisa ser substituida:

~~~~BASH
kubectl get pods -n kube-system
sed -i 's/kube-schedulerrrr/kube-scheduler/g' /etc/kubernetes/manifests/kube-scheduler.yaml
~~~~