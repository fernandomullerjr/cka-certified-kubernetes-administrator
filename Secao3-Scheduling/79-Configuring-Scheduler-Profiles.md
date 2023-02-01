
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 79. Configuring Scheduler Profiles"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
#  79. Configuring Scheduler Profiles

https://kubernetes.io/docs/reference/scheduling/config/

<https://kubernetes.io/docs/reference/scheduling/config/>

# Profiles

A scheduling Profile allows you to configure the different stages of scheduling in the kube-scheduler. Each stage is exposed in an extension point. Plugins provide scheduling behaviors by implementing one or more of these extension points.

You can configure a single instance of kube-scheduler to run multiple profiles.




# Processo

- Pods vão para uma "Scheduling Queue".
- O Pod é provisionado conforme a sua prioridade, que é definida pela PriorityClass.
- Depois de selecionada a prioridade, o Pod entra na fase de "Filtering".
- Scoring
- Binding


# Example PriorityClass

~~~~YAML
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000000
globalDefault: false
description: "This priority class should be used for XYZ service pods only."
~~~~




# Pod com priority setado

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  priorityClassName: high-priority
~~~~





# PENDENTE
- Video continua em 02:44
- Video continua em 02:44




# Dia 01/02/2023


