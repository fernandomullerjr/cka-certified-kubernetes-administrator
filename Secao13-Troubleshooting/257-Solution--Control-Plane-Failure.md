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






- Questão1

~~~~BASH
kubectl get pods -n kube-system
sed -i 's/kube-schedulerrrr/kube-scheduler/g' /etc/kubernetes/manifests/kube-scheduler.yaml
~~~~




# ###################################################################################################################### 
# ###################################################################################################################### 
##  RESUMO

- Ativar o Autocomplete:

~~~~BASH
source <(kubectl completion bash) # configuração de autocomplete no bash do shell atual, o pacote bash-completion precisa ter sido instalado primeiro.
~~~~
