# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 15 - Kube api Server. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 


# kube-controller-manager

Esse componente é responsável por executar o cluster enquanto os controladores de gerenciamento do kubernetes executam varias funções de maneira unificada, como forma de garantir o último estado definido no etcd. O componente permiti que o kubernetes faça a interação de diversos provedores, com diferentes capacidades, recurso e APIS, enquanto faz a construção internamente.

Por exemplo: Caso esteja a executar um deploy, e nele ter 10 ReplicaSet em um pod, kube-controller-manager é responsável por verificar se todos subiram ou não.

Temos os seguintes controladores:

    Controlador do nó: responsável por identificar se o estado do nó está ativos ou não;
    Controlador de trabalho (job): responsável por observar e criar os pods para executar tarefas até finalização da sua execução;
    Controlador de endpoints: responsável pelo objeto do endpoints e a sua junção para a comunicação entre serviços e pod;
    Controlador autenticação: responsável por criar as contas de autenticação usando padrões de tokens para acesso de API e gerência de novos namespaces.




# Kube-controller-manager

O kube-controller-manager baseia-se no servidor API para supervisionar o estado do servidor. Este serviço implementará um nó e irá administrá-lo durante toda a sua existência. Este componente é o responsável por garantir a integridade e a disponibilidade da arquitetura.