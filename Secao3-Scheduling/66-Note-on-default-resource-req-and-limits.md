

# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula  66. Note on default resource requirements and limits"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
#  66. Note on default resource requirements and limits

Note on default resource requirements and limits

In the previous lecture, I said - "When a pod is created the containers are assigned a default CPU request of .5 and memory of 256Mi". For the POD to pick up those defaults you must have first set those as default values for request and limit by creating a LimitRange in that namespace.

~~~~yaml
    apiVersion: v1
    kind: LimitRange
    metadata:
      name: mem-limit-range
    spec:
      limits:
      - default:
          memory: 512Mi
        defaultRequest:
          memory: 256Mi
        type: Container
~~~~

https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/memory-default-namespace/

~~~~yaml
    apiVersion: v1
    kind: LimitRange
    metadata:
      name: cpu-limit-range
    spec:
      limits:
      - default:
          cpu: 1
        defaultRequest:
          cpu: 0.5
        type: Container
~~~~

https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-default-namespace/


- References:

https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource