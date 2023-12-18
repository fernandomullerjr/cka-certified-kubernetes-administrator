
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "179. Practice Test - Network Policy."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  179. Practice Test - Network Policy


How many network policies do you see in the environment?

We have deployed few web applications, services and network policies. Inspect the environment.



controlplane ~ ➜  kubectl api-resources | grep netw
ingressclasses                                 networking.k8s.io/v1                   false        IngressClass
ingresses                         ing          networking.k8s.io/v1                   true         Ingress
networkpolicies                   netpol       networking.k8s.io/v1                   true         NetworkPolicy

controlplane ~ ➜  
controlplane ~ ➜  kubectl get netpol
NAME             POD-SELECTOR   AGE
payroll-policy   name=payroll   107s

controlplane ~ ➜  kubectl get netpol -A
NAMESPACE   NAME             POD-SELECTOR   AGE
default     payroll-policy   name=payroll   110s

controlplane ~ ➜  kubectl get netpol -A -o wide
NAMESPACE   NAME             POD-SELECTOR   AGE
default     payroll-policy   name=payroll   116s

controlplane ~ ➜  









What is the name of the Network Policy?

payroll-policy










Which pod is the Network Policy applied on?

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE
default       external                               1/1     Running   0             2m42s
default       internal                               1/1     Running   0             2m42s
default       mysql                                  1/1     Running   0             2m42s
default       payroll                                1/1     Running   0             2m42s
kube-system   coredns-5d78c9869d-dgljz               1/1     Running   0             65m
kube-system   coredns-5d78c9869d-fxx92               1/1     Running   0             65m
kube-system   etcd-controlplane                      1/1     Running   0             65m
kube-system   kube-apiserver-controlplane            1/1     Running   0             65m
kube-system   kube-controller-manager-controlplane   1/1     Running   0             65m
kube-system   kube-proxy-5g6zg                       1/1     Running   0             65m
kube-system   kube-scheduler-controlplane            1/1     Running   0             65m
kube-system   weave-net-62lp5                        2/2     Running   1 (65m ago)   65m

controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE     IP             NODE           NOMINATED NODE   READINESS GATES
default       external                               1/1     Running   0             2m46s   10.244.0.5     controlplane   <none>           <none>
default       internal                               1/1     Running   0             2m46s   10.244.0.4     controlplane   <none>           <none>
default       mysql                                  1/1     Running   0             2m46s   10.244.0.6     controlplane   <none>           <none>
default       payroll                                1/1     Running   0             2m46s   10.244.0.7     controlplane   <none>           <none>
kube-system   coredns-5d78c9869d-dgljz               1/1     Running   0             65m     10.244.0.2     controlplane   <none>           <none>
kube-system   coredns-5d78c9869d-fxx92               1/1     Running   0             65m     10.244.0.3     controlplane   <none>           <none>
kube-system   etcd-controlplane                      1/1     Running   0             65m     192.27.180.6   controlplane   <none>           <none>
kube-system   kube-apiserver-controlplane            1/1     Running   0             65m     192.27.180.6   controlplane   <none>           <none>
kube-system   kube-controller-manager-controlplane   1/1     Running   0             65m     192.27.180.6   controlplane   <none>           <none>
kube-system   kube-proxy-5g6zg                       1/1     Running   0             65m     192.27.180.6   controlplane   <none>           <none>
kube-system   kube-scheduler-controlplane            1/1     Running   0             65m     192.27.180.6   controlplane   <none>           <none>
kube-system   weave-net-62lp5                        2/2     Running   1 (65m ago)   65m     192.27.180.6   controlplane   <none>           <none>

controlplane ~ ➜  kubectl get pods -A -l name=payroll
NAMESPACE   NAME      READY   STATUS    RESTARTS   AGE
default     payroll   1/1     Running   0          3m4s

controlplane ~ ➜  

















What type of traffic is this Network Policy configured to handle?


controlplane ~ ➜  kubectl get netpol payroll-policy -o yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"networking.k8s.io/v1","kind":"NetworkPolicy","metadata":{"annotations":{},"name":"payroll-policy","namespace":"default"},"spec":{"ingress":[{"from":[{"podSelector":{"matchLabels":{"name":"internal"}}}],"ports":[{"port":8080,"protocol":"TCP"}]}],"podSelector":{"matchLabels":{"name":"payroll"}},"policyTypes":["Ingress"]}}
  creationTimestamp: "2023-12-16T21:12:25Z"
  generation: 1
  name: payroll-policy
  namespace: default
  resourceVersion: "5380"
  uid: 4a494283-996f-4b4f-b61d-93091edf7af0
spec:
  ingress:
  - from:
    - podSelector:
        matchLabels:
          name: internal
    ports:
    - port: 8080
      protocol: TCP
  podSelector:
    matchLabels:
      name: payroll
  policyTypes:
  - Ingress
status: {}

controlplane ~ ➜  












What is the impact of the rule configured on this Network Policy?









What is the impact of the rule configured on this Network Policy?








Access the UI of these applications using the link given above the terminal.







Perform a connectivity test using the User Interface in these Applications to access the payroll-service at port 8080.


controlplane ~ ➜  kubectl get svc 
NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
db-service         ClusterIP   10.107.214.236   <none>        3306/TCP         7m5s
external-service   NodePort    10.100.54.234    <none>        8080:30080/TCP   7m6s
internal-service   NodePort    10.105.44.124    <none>        8080:30082/TCP   7m5s
kubernetes         ClusterIP   10.96.0.1        <none>        443/TCP          69m
payroll-service    NodePort    10.99.94.241     <none>        8080:30083/TCP   7m5s

controlplane ~ ➜  

payroll-service
8080
 Success! 









Perform a connectivity test using the User Interface of the Internal Application to access the external-service at port 8080.

 Success! 








Create a network policy to allow traffic from the Internal application only to the payroll-service and db-service.

Use the spec given below. You might want to enable ingress traffic to the pod to test your rules in the UI.

    Policy Name: internal-policy

    Policy Type: Egress

    Egress Allow: payroll

    Payroll Port: 8080

    Egress Allow: mysql

    MySQL Port: 3306



controlplane ~ ➜  kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
external   1/1     Running   0          9m12s
internal   1/1     Running   0          9m12s
mysql      1/1     Running   0          9m12s
payroll    1/1     Running   0          9m12s

controlplane ~ ➜  kubectl get pods -o wide
NAME       READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
external   1/1     Running   0          9m17s   10.244.0.5   controlplane   <none>           <none>
internal   1/1     Running   0          9m17s   10.244.0.4   controlplane   <none>           <none>
mysql      1/1     Running   0          9m17s   10.244.0.6   controlplane   <none>           <none>
payroll    1/1     Running   0          9m17s   10.244.0.7   controlplane   <none>           <none>

controlplane ~ ➜  kubectl describe pod internal
Name:             internal
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.27.180.6
Start Time:       Sat, 16 Dec 2023 16:12:24 -0500
Labels:           name=internal
Annotations:      <none>
Status:           Running
IP:               10.244.0.4
IPs:
  IP:  10.244.0.4
Containers:
  internal:
    Container ID:   containerd://a6138f34548e1c4c33f11e0c305afdaa14d0c2321fa49b637b5d2094a47bc519
    Image:          kodekloud/webapp-conntest
    Image ID:       docker.io/kodekloud/webapp-conntest@sha256:b87d6b99f127ef10274e4447b3a151127688369b82eab09eba6ab6a84e6c5689
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sat, 16 Dec 2023 16:12:49 -0500
    Ready:          True
    Restart Count:  0
    Environment:
      APP_NAME:  Internal Facing Application
      BG_COLOR:  blue
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-fxlql (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-fxlql:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  9m23s  default-scheduler  Successfully assigned default/internal to controlplane
  Normal  Pulling    9m21s  kubelet            Pulling image "kodekloud/webapp-conntest"
  Normal  Pulled     8m59s  kubelet            Successfully pulled image "kodekloud/webapp-conntest" in 363.089535ms (21.991908374s including waiting)
  Normal  Created    8m59s  kubelet            Created container internal
  Normal  Started    8m58s  kubelet            Started container internal

controlplane ~ ➜  


- Editado

Secao7-Security/179-netpol-editada.yaml.yml

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: internal-policy
spec:
  podSelector:
    matchLabels:
      name: internal
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          name: payroll
      ports:
        - protocol: TCP
          port: 8080
    - podSelector:
        matchLabels:
          name: mysql
      ports:
        - protocol: TCP
          port: 3306




vi 179-netpol-editada.yaml.yml


- ERRO


controlplane ~ ➜  vi 179-netpol-editada.yaml.yml

controlplane ~ ➜  kubectl apply -f 179-netpol-editada.yaml.yml
Error from server (BadRequest): error when creating "179-netpol-editada.yaml.yml": NetworkPolicy in version "v1" cannot be handled as a NetworkPolicy: strict decoding error: unknown field "spec.egress[0].to[0].ports", unknown field "spec.egress[0].to[1].ports"

controlplane ~ ✖ 



preciso de exemplo de policy egress com multiplas regras e que permitem portas diferentes
ChatGPT

Se você precisa criar uma política de rede Egress com múltiplas regras e que permita portas diferentes, aqui está um exemplo básico:

yaml

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: egress-policy
spec:
  podSelector:
    matchLabels:
      app: my-app
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          role: api-server
    ports:
    - protocol: TCP
      port: 8080
  - to:
    - podSelector:
        matchLabels:
          role: database
    ports:
    - protocol: TCP
      port: 3306
    - protocol: UDP
      port: 5432
  - to:
    - ipBlock:
        cidr: 10.20.30.40/32
    ports:
    - protocol: TCP
      port: 80

Neste exemplo:

    A política se aplica aos pods com a etiqueta app: my-app.
    A política é do tipo Egress, o que significa que ela controla o tráfego que sai dos pods selecionados.
    Existem três regras de egress diferentes:
        Permitir o tráfego para pods com a etiqueta role: api-server na porta TCP 8080.
        Permitir o tráfego para pods com a etiqueta role: database nas portas TCP 3306 e UDP 5432.
        Permitir o tráfego para o endereço IP 10.20.30.40 na porta TCP 80.

Lembre-se de personalizar as etiquetas de seleção de pod e outras configurações de acordo com suas necessidades específicas. Essas regras são apenas um exemplo e devem ser adaptadas à sua aplicação e ambiente.


- Editada

Secao7-Security/179-netpol-editada-v2.yaml

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: internal-policy
spec:
  podSelector:
    matchLabels:
      name: internal
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          name: payroll
    ports:
    - protocol: TCP
      port: 8080
  - to:
    - podSelector:
        matchLabels:
          name: mysql
    ports:
    - protocol: TCP
      port: 3306



controlplane ~ ✖ vi 179-netpol-editada.yaml.yml

controlplane ~ ➜  kubectl apply -f 179-netpol-editada.yaml.yml
networkpolicy.networking.k8s.io/internal-policy created

controlplane ~ ➜  kubectl get netpol
NAME              POD-SELECTOR    AGE
internal-policy   name=internal   4s
payroll-policy    name=payroll    17m

controlplane ~ ➜  date
Sat 16 Dec 2023 04:30:11 PM EST

controlplane ~ ➜  




