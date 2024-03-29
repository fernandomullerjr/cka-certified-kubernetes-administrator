
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m " 192. Solution - Persistent Volumes and Persistent Volume Claims."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  192. Solution - Persistent Volumes and Persistent Volume Claims

# Practice Test - Persistent Volume Claims

  - Take me to [Practice Test](https://kodekloud.com/topic/practice-test-persistent-volume-claims/)

#### Solution

  1. Check the Solution

     <details>

      ```
      OK
      ```
    
     </details>

  2. Check the Solution

     <details>

      ```
      OK
      ```
     </details>
 
  3. Check the Solution

     <details>

      ```
      No
      ```
     </details>

  4. Check the Solution
    
     <details>

      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: webapp
      spec:
        containers:
        - name: event-simulator
          image: kodekloud/event-simulator
          env:
          - name: LOG_HANDLERS
            value: file
          volumeMounts:
          - mountPath: /log
            name: log-volume
      
        volumes:
        - name: log-volume
          hostPath:
            # directory location on host
            path: /var/log/webapp
            # this field is optional
            type: Directory
      ```
      </details>

  5. Check the Solution

     <details>

      ```
      apiVersion: v1
      kind: PersistentVolume
      metadata:
        name: pv-log
      spec:
        accessModes:
          - ReadWriteMany
        capacity:
          storage: 100Mi
        hostPath:
          path: /pv/log
      ```

     </details>

  6. Check the Solution

     <details>

      ```
      kind: PersistentVolumeClaim
      apiVersion: v1
      metadata:
        name: claim-log-1
      spec:
        accessModes:
          - ReadWriteOnce
        resources:
          requests:
            storage: 50Mi
      ```
     </details>

  7. Check the Solution

     <details>

      ```
      PENDING
      ```
     </details>

  8. Check the Solution

     <details>

      ```
      AVAILABLE
      ```
     </details>

  9. Check the Solution

     <details>

      ```
      Access Modes Mismatch
      ```
     </details>

  10. Check the Solution

      <details>
 
       ```
       kind: PersistentVolumeClaim
       apiVersion: v1
       metadata:
         name: claim-log-1
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 50Mi
       ```
      </details>

  11. Check the Solution

      <details>
 
       ```
       100Mi
       ```
      </details>

  12. Check the Solution

      <details>
 
       ```
       apiVersion: v1
       kind: Pod
       metadata:
         name: webapp
       spec:
         containers:
         - name: event-simulator
           image: kodekloud/event-simulator
           env:
           - name: LOG_HANDLERS
             value: file
           volumeMounts:
           - mountPath: /log
             name: log-volume
       
         volumes:
         - name: log-volume
           persistentVolumeClaim:
             claimName: claim-log-1
       ```
      </details>

  13. Check the Solution

      <details>
 
       ```
       Retain
       ```
      </details>

  14. Check the Solution

      <details>
 
       ```
       The PV is not delete but not available
       ```
      </details>

  15. Check the Solution

      <details>
 
       ```
       The PVC is stuck in `terminating` state
       ```
      </details>

  16. Check the Solution

      <details>
 
       ```
       The PVC is being used by a POD
       ```
      </details>

  17. Check the Solution

      <details>
 
       ```
       kubectl delete pod webapp
       ```
      </details>

  18. Check the Solution

      <details>
 
       ```
       Deleted
       ```
      </details>

  19. Check the Solution

      <details>
 
       ```
       Released
       ```
      </details>





# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  192. Solution - Persistent Volumes and Persistent Volume Claims



If the POD was to get deleted now, would you be able to view these logs.

- ORIGINAL
Foi verificado se existia algum PV ou PVC.

- ALTERNATIVA
Verificar via describe no Pod se ele tem outros volumes configurados.










Configure a volume to store these logs at /var/log/webapp on the host.

- ORIGINAL
Criei pv, pvc e pod usando referencias a cada item.

- ALTERNATIVA
Criar o volume apenas passando "hostPath" na especificação do Pod:

~~~~bash
apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  volumes:
    - name: log-volume
      hostPath:
        path: "/var/log/webapp"
  containers:
    - name: webapp
      image: kodekloud/event-simulator
      volumeMounts:
        - mountPath: "/log"
          name: log-volume
~~~~

- OBSERVAÇÃO
Edições foram via:
kubectl edit
kubectl replace (utilizando o YAML temporário do /tmp)

Validar se os logs estão disponiveis no host no devido diretório "/var/log/webapp"






Why is the claim not bound to the available Persistent Volume?

- RESPOSTA
Access mode mismatch






## pendente
- Ver melhor sobre "Access mode mismatch" entre pv e pvc.
- Entender porque o capacity do pvc ficou 100Mi na questão "You requested for 50Mi, how much capacity is now available to the PVC?"
 