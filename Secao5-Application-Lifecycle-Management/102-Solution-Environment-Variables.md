



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "Aula 102. Solution - Environment Variables"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 102. Solution - Environment Variables


- Efetuar Replace do Pod, deletando e recriando o recurso
kubectl replace --force -f ./pod.yaml	



# Create a ConfigMap using kubectl create configmap
Use the kubectl create configmap command to create ConfigMaps from directories, files, or literal values:

~~~~bash
    kubectl create configmap <map-name> <data-source>
~~~~



# Create the ConfigMap

~~~~bash
kubectl create configmap game-config --from-file=configure-pod-container/configmap/
~~~~


# Use the option --from-env-file to create a ConfigMap from an env-file, for example:

~~~~bash
kubectl create configmap game-config-env-file \
       --from-env-file=configure-pod-container/configmap/game-env-file.properties
~~~~

~~~~bash
kubectl create configmap config-multi-env-files \
        --from-env-file=configure-pod-container/configmap/game-env-file.properties \
        --from-env-file=configure-pod-container/configmap/ui-env-file.properties
~~~~




# Create ConfigMaps from literal values

~~~~bash
kubectl create configmap special-config --from-literal=special.how=very --from-literal=special.type=charm
~~~~
