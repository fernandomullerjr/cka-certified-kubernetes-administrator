


############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 69. Solution: Resource Limits "
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



69. Solution: Resource Limits : (Optional)



- Procedimento para corrigir o Limit do Pod, poderia ter sido realizado usando o replace:
# Force replace, delete and then re-create the resource. Will cause a service outage.
kubectl replace --force -f ./pod.yaml