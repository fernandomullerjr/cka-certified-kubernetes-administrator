##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 68. Practice Test - Resource Requirements and Limits"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 68. Practice Test - Resource Requirements and Limits

# Practice Test - Resource Limits
  - Take me to [Practice Test](https://kodekloud.com/topic/practice-test-resource-limits/)
  
Solutions to practice test - resource limtis
- Run the command 'kubectl describe pod rabbit' and inspect requests.
  
  <details>

  ```
  $ kubectl describe pod rabbit
  ```
  </details>

- Run the command 'kubectl delete pod rabbit'.

  <details>

  ```
  $ kubectl delete pod rabbit
  ```
  </details>

- Run the command 'kubectl get pods' and inspect the status of the pod elephant

  <details>

  ```
  $ kubectl get pods
  ```
  </details>

- The status 'OOMKilled' indicates that the pod ran out of memory. Identify the memory limit set on the POD.

- Generate a template of the existing pod.

  <details>

  ```
  $ kubectl get pods elephant -o yaml > elephant.yaml
  ```
  </details>

  Update the elephant.yaml pod definition with the resource memory limits to 20Mi
  
  <details>

  ```
  resources:
      limits:
        memory: 20Mi
  ---
  ```
  </details>

  Delete the pod and recreate it.
  
  <details>

  ```
  $ kubectl delete pod elephant
  $ kubectl create -f elephant.yaml
  ```
  </details>

- Inspect the status of POD. Make sure it's running
  
  <details>

  ```
  $ kubectl get pods
  ```
  </details>

- Run the command 'kubectl delete pod elephant'.

  <details>

  ```
  $ kubectl delete pod elephant
  ```
  </details>




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 68. Practice Test - Resource Requirements and Limits

Practice Test - Resource Requirements and Limits

Practice Test: https://uklabs.kodekloud.com/topic/practice-test-resource-limits-2/







# A pod called rabbit is deployed. Identify the CPU requirements set on the Pod

in the current(default) namespace


controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: Pod
  metadata:
    creationTimestamp: "2022-12-07T03:20:56Z"
    name: rabbit
    namespace: default
    resourceVersion: "779"
    uid: 50243e5c-c1e0-435d-beff-21f3103b5e82
  spec:
    containers:
    - args:
      - sleep
      - "1000"
      image: ubuntu
      imagePullPolicy: Always
      name: cpu-stress
      resources:
        limits:
          cpu: "2"
        requests:
          cpu: "1"
      terminationMessagePath: /dev/te




# The elephant pod runs a process that consume 15Mi of memory. Increase the limit of the elephant pod to 20Mi.

Delete and recreate the pod if required. Do not modify anything other than the required fields.

    Pod Name: elephant

    Image Name: polinux/stress

    Memory Limit: 20Mi


- Verificado o limit atual do Pod via describe.
- Obtido o manifesto atual, para criar uma nova versão do manifesto:
    8  kubectl describe pod elephant
    9  kubectl get pod elephant -o yaml > pod-editado.yaml


- Criado novo manifesto.
- Deletado o pod antigo que tava crashando.

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2022-12-07T03:33:09Z"
  name: elephant
  namespace: default
  resourceVersion: "959"
  uid: b536898f-7cb1-4ebb-8dee-0042e355c270
spec:
  containers:
    - args:
        - --vm
        - "1"
        - --vm-bytes
        - 15M
        - --vm-hang
        - "1"
      command:
        - stress
      image: polinux/stress
      imagePullPolicy: Always
      name: mem-stress
      resources:
        limits:
          memory: 20Mi
        requests:
          memory: 5Mi
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      volumeMounts:
        - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
          name: kube-api-access-rr8n4
          readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: controlplane
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
    - effect: NoExecute
      key: node.kubernetes.io/not-ready
      operator: Exists
      tolerationSeconds: 300
    - effect: NoExecute
      key: node.kubernetes.io/unreachable
      operator: Exists
      tolerationSeconds: 300
  volumes:
    - name: kube-api-access-rr8n4
      projected:
        defaultMode: 420
        sources:
          - serviceAccountToken:
              expirationSeconds: 3607
              path: token
          - configMap:
              items:
                - key: ca.crt
                  path: ca.crt
              name: kube-root-ca.crt
          - downwardAPI:
              items:
                - fieldRef:
                    apiVersion: v1
                    fieldPath: metadata.namespace
                  path: namespace
~~~~


19  cat pod2.yaml 
   20  vi pod2.yaml 
   21  kubectl get pods
   22  kubectl delete pod elephant
   23  kubectl get pods
   24  kubectl apply -f pod2.yaml 
   25  kubectl get pods
   26  kubectl get pods
   27  kubectl describe pod elephant 
   28  history 




- Procedimento para corrigir o Limit do Pod, poderia ter sido realizado usando o replace:
# Force replace, delete and then re-create the resource. Will cause a service outage.
kubectl replace --force -f ./pod.yaml