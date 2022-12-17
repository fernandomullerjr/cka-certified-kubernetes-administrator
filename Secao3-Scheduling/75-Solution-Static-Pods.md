
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 75. Solution - Static Pods"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ##############################################################################################################################################################
#  75. Solution - Static Pods

# How many static pods exist in this cluster in all namespaces?

- Detalhando
Para verificar se um Pod é Static Pod ou não, é possível verificar quando o Pod tem o nome do Node ao final do nome dele, normalmente.
Por exemplo:

Para verificar se um Pod é Static Pod ou não, é possível verificar o owner do Pod também, é uma segunda maneira.
Por exemplo:
