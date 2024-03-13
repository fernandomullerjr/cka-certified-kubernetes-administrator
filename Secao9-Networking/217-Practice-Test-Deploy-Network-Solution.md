
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "217. Practice Test - Deploy Network Solution"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  217. Practice Test - Deploy Network Solution

Picture yourself as an indomitable power filled with positive attitude and faith that you are achieving your goals.

– Napolean Hill



In this practice test we will install weave-net POD networking solution to the cluster. Let us first inspect the setup.

We have deployed an application called app in the default namespace. What is the state of the pod?


controlplane ~ ➜  kubectl get all
NAME      READY   STATUS              RESTARTS   AGE
pod/app   0/1     ContainerCreating   0          30s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   88m

controlplane ~ ➜  






Inspect why the POD is not running.


controlplane ~ ✖ kubectl describe pod app
Name:             app
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.47.84.6
Start Time:       Wed, 13 Mar 2024 23:01:14 +0000
Labels:           run=app
Annotations:      <none>
Status:           Pending
IP:               
IPs:              <none>
Containers:
  app:
    Container ID:  
    Image:         busybox
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Args:
      sleep
      1000
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-cwrzg (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   False 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-cwrzg:
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
  Type     Reason                  Age               From               Message
  ----     ------                  ----              ----               -------
  Normal   Scheduled               55s               default-scheduler  Successfully assigned default/app to controlplane
  Warning  FailedCreatePodSandBox  54s               kubelet            Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox "3e468d772d792f88fd817f5653457d5f71cebebd97a39c1587f92ea0badf35cd": plugin type="weave-net" name="weave" failed (add): unable to allocate IP address: Post "http://127.0.0.1:6784/ip/3e468d772d792f88fd817f5653457d5f71cebebd97a39c1587f92ea0badf35cd": dial tcp 127.0.0.1:6784: connect: connection refused
  Normal   SandboxChanged          0s (x5 over 54s)  kubelet            Pod sandbox changed, it will be killed and re-created.

controlplane ~ ➜  




















Deploy weave-net networking solution to the cluster.


NOTE: - We already have provided a weave manifest file under the /root/weave directory. 

controlplane ~ ➜  kubectl get pods
NAME   READY   STATUS              RESTARTS   AGE
app    0/1     ContainerCreating   0          102s

controlplane ~ ➜  ls /root/weave/
weave-daemonset-k8s.yaml

controlplane ~ ➜  


controlplane ~ ➜  cat /root/weave/weave-daemonset-k8s.yaml 
apiVersion: v1
kind: List
items:
  - apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: weave-net
      labels:
        name: weave-net
      namespace: kube-system
  - apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: weave-net
      labels:
        name: weave-net
    rules:
      - apiGroups:
          - ''
        resources:
          - pods
          - namespaces
          - nodes
        verbs:
          - get
          - list
          - watch
      - apiGroups:
          - extensions
        resources:
          - networkpolicies
        verbs:
          - get
          - list
          - watch
      - apiGroups:
          - 'networking.k8s.io'
        resources:
          - networkpolicies
        verbs:
          - get
          - list
          - watch
      - apiGroups:
        - ''
        resources:
        - nodes/status
        verbs:
        - patch
        - update
  - apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      name: weave-net
      labels:
        name: weave-net
    roleRef:
      kind: ClusterRole
      name: weave-net
      apiGroup: rbac.authorization.k8s.io
    subjects:
      - kind: ServiceAccount
        name: weave-net
        namespace: kube-system
  - apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      name: weave-net
      namespace: kube-system
      labels:
        name: weave-net
    rules:
      - apiGroups:
          - ''
        resources:
          - configmaps
        resourceNames:
          - weave-net
        verbs:
          - get
          - update
      - apiGroups:
          - ''
        resources:
          - configmaps
        verbs:
          - create
  - apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: weave-net
      namespace: kube-system
      labels:
        name: weave-net
    roleRef:
      kind: Role
      name: weave-net
      apiGroup: rbac.authorization.k8s.io
    subjects:
      - kind: ServiceAccount
        name: weave-net
        namespace: kube-system
  - apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: weave-net
      labels:
        name: weave-net
      namespace: kube-system
    spec:
      # Wait 5 seconds to let pod connect before rolling next pod
      selector:
        matchLabels:
          name: weave-net
      minReadySeconds: 5
      template:
        metadata:
          labels:
            name: weave-net
        spec:
          initContainers:
            - name: weave-init
              image: 'weaveworks/weave-kube:2.8.1'
              command:
                - /home/weave/init.sh
              env:
              securityContext:
                privileged: true
              volumeMounts:
                - name: cni-bin
                  mountPath: /host/opt
                - name: cni-bin2
                  mountPath: /host/home
                - name: cni-conf
                  mountPath: /host/etc
                - name: lib-modules
                  mountPath: /lib/modules
                - name: xtables-lock
                  mountPath: /run/xtables.lock
                  readOnly: false
          containers:
            - name: weave
              command:
                - /home/weave/launch.sh
              env:
                - name: IPALLOC_RANGE
                  value: 10.32.1.0/24
                - name: INIT_CONTAINER
                  value: "true"
                - name: HOSTNAME
                  valueFrom:
                    fieldRef:
                      apiVersion: v1
                      fieldPath: spec.nodeName
              image: 'weaveworks/weave-kube:2.8.1'
              readinessProbe:
                httpGet:
                  host: 127.0.0.1
                  path: /status
                  port: 6784
              resources:
                requests:
                  cpu: 50m
              securityContext:
                privileged: true
              volumeMounts:
                - name: weavedb
                  mountPath: /weavedb
                - name: dbus
                  mountPath: /host/var/lib/dbus
                  readOnly: true
                - mountPath: /host/etc/machine-id
                  name: cni-machine-id
                  readOnly: true
                - name: xtables-lock
                  mountPath: /run/xtables.lock
                  readOnly: false
            - name: weave-npc
              env:
                - name: HOSTNAME
                  valueFrom:
                    fieldRef:
                      apiVersion: v1
                      fieldPath: spec.nodeName
              image: 'weaveworks/weave-npc:2.8.1'
#npc-args
              resources:
                requests:
                  cpu: 50m
              securityContext:
                privileged: true
              volumeMounts:
                - name: xtables-lock
                  mountPath: /run/xtables.lock
                  readOnly: false
          hostNetwork: true
          dnsPolicy: ClusterFirstWithHostNet
          hostPID: false
          restartPolicy: Always
          securityContext:
            seLinuxOptions: {}
          serviceAccountName: weave-net
          tolerations:
            - effect: NoSchedule
              operator: Exists
            - effect: NoExecute
              operator: Exists
          volumes:
            - name: weavedb
              hostPath:
                path: /var/lib/weave
            - name: cni-bin
              hostPath:
                path: /opt
            - name: cni-bin2
              hostPath:
                path: /home
            - name: cni-conf
              hostPath:
                path: /etc
            - name: cni-machine-id
              hostPath:
                path: /etc/machine-id
            - name: dbus
              hostPath:
                path: /var/lib/dbus
            - name: lib-modules
              hostPath:
                path: /lib/modules
            - name: xtables-lock
              hostPath:
                path: /run/xtables.lock
                type: FileOrCreate
          priorityClassName: system-node-critical
      updateStrategy:
        type: RollingUpdate

controlplane ~ ➜  


controlplane ~ ➜  kubectl apply -f /root/weave/weave-daemonset-k8s.yaml 
serviceaccount/weave-net created
clusterrole.rbac.authorization.k8s.io/weave-net created
clusterrolebinding.rbac.authorization.k8s.io/weave-net created
role.rbac.authorization.k8s.io/weave-net created
rolebinding.rbac.authorization.k8s.io/weave-net created
daemonset.apps/weave-net created

controlplane ~ ➜  

Every 2.0s: kubectl get pods                                                                                                                controlplane: Wed Mar 13 23:03:57 2024

NAME   READY   STATUS    RESTARTS   AGE
app    1/1     Running   0          2m43s



controlplane ~ ➜  kubectl get pods
NAME   READY   STATUS    RESTARTS   AGE
app    1/1     Running   0          2m53s

controlplane ~ ➜  date
Wed Mar 13 11:04:08 PM UTC 2024

controlplane ~ ➜  