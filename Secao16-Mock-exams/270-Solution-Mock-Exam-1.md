#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "270. Solution - Mock Exam -1."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
##  270. Solution - Mock Exam -1

### RECOMENDAÇÃO - CONFIGURAR ATALHOS

<https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/>
kubectl Cheat Sheet

Esta página contém uma lista de comandos kubectl e flags frequentemente usados.

Kubectl Autocomplete

~~~~BASH
source <(kubectl completion bash) # configuração de autocomplete no bash do shell atual, o pacote bash-completion precisa ter sido instalado primeiro.
echo "source <(kubectl completion bash)" >> ~/.bashrc # para adicionar o autocomplete permanentemente no seu shell bash.
~~~~


Você também pode usar uma abreviação para o atalho para kubectl que também funciona com o auto completar:

~~~~BASH
alias k=kubectl
complete -o default -F __start_kubectl k
~~~~








### 1 / 12
Weight: 6

Deploy a pod named nginx-pod using the nginx:alpine image.

Once done, click on the Next Question button in the top right corner of this panel. You may navigate back and forth freely between all questions. Once done with all questions, click on End Exam. Your work will be validated at the end and score shown. Good Luck!

Name: nginx-pod

Image: nginx:alpine


- Ideia é fornecer resposta rápida, usando comando imperativo:
k run pod