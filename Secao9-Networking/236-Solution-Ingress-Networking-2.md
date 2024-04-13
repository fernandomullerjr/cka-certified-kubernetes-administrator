
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "236. Solution - Ingress Networking - 2 ."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  236. Solution - Ingress Networking - 2

# Practice Test CKA Ingress 2

#### Solution 

  1. Check the Solution

     <details>

      ```
      OK
      ```
     </details>

  1. Check the Solution

     <details>

      ```
      kubectl create namespace ingress-nginx
      ```
     </details>

  1. Check the Solution

     <details>

      ```
      kubectl create configmap ingress-nginx-controller --namespace ingress-nginx
      ```
     </details>

  1. Check the Solution

     <details>

      ```
      kubectl create serviceaccount ingress-nginx --namespace ingress-nginx
      kubectl create serviceaccount ingress-nginx-admission --namespace ingress-nginx
      ```
     </details>

  1. Check the Solution

     <details>

      ```
      Ok

      kubectl get roles,rolebindings --namespace ingress-nginx
      ```
     </details>

  1. Check the Solution

     <details>

     Fix the issues

     ```
     vi /root/ingress-controller.yaml
     ```

     There is a `Deployment` and a `Service` in this file, There are issues with each.


     1. The `namespace` of the deployment is incorrect.
     1. indentation error at line 74 (use `:set nu` in vi to turn on line numbers)
     1. `name` of the service is incorrect
     1. `nodeport` on service is incorrect case. Should be `nodePort`

      ```yaml
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        labels:
          app.kubernetes.io/component: controller
          app.kubernetes.io/instance: ingress-nginx
          app.kubernetes.io/managed-by: Helm
          app.kubernetes.io/name: ingress-nginx
          app.kubernetes.io/part-of: ingress-nginx
          app.kubernetes.io/version: 1.1.2
          helm.sh/chart: ingress-nginx-4.0.18
        name: ingress-nginx-controller
        namespace: ingress-nginx
      spec:
        minReadySeconds: 0
        revisionHistoryLimit: 10
        selector:
          matchLabels:
            app.kubernetes.io/component: controller
            app.kubernetes.io/instance: ingress-nginx
            app.kubernetes.io/name: ingress-nginx
        template:
          metadata:
            labels:
              app.kubernetes.io/component: controller
              app.kubernetes.io/instance: ingress-nginx
              app.kubernetes.io/name: ingress-nginx
          spec:
            containers:
            - args:
              - /nginx-ingress-controller
              - --publish-service=$(POD_NAMESPACE)/ingress-nginx-controller
              - --election-id=ingress-controller-leader
              - --watch-ingress-without-class=true
              - --default-backend-service=app-space/default-http-backend
              - --controller-class=k8s.io/ingress-nginx
              - --ingress-class=nginx
              - --configmap=$(POD_NAMESPACE)/ingress-nginx-controller
              - --validating-webhook=:8443
              - --validating-webhook-certificate=/usr/local/certificates/cert
              - --validating-webhook-key=/usr/local/certificates/key
              env:
              - name: POD_NAME
                valueFrom:
                  fieldRef:
                    fieldPath: metadata.name
              - name: POD_NAMESPACE
                valueFrom:
                  fieldRef:
                    fieldPath: metadata.namespace
              - name: LD_PRELOAD
                value: /usr/local/lib/libmimalloc.so
              image: registry.k8s.io/ingress-nginx/controller:v1.1.2@sha256:28b11ce69e57843de44e3db6413e98d09de0f6688e33d4bd384002a44f78405c
              imagePullPolicy: IfNotPresent
              lifecycle:
                preStop:
                  exec:
                    command:
                    - /wait-shutdown
              livenessProbe:
                failureThreshold: 5
                httpGet:
                  path: /healthz
                  port: 10254
                  scheme: HTTP
                initialDelaySeconds: 10
                periodSeconds: 10
                successThreshold: 1
                timeoutSeconds: 1
              name: controller
              ports:
              - name: http
                containerPort: 80
                protocol: TCP
              - containerPort: 443
                name: https
                protocol: TCP
              - containerPort: 8443
                name: webhook
                protocol: TCP
              readinessProbe:
                failureThreshold: 3
                httpGet:
                  path: /healthz
                  port: 10254
                  scheme: HTTP
                initialDelaySeconds: 10
                periodSeconds: 10
                successThreshold: 1
                timeoutSeconds: 1
              resources:
                requests:
                  cpu: 100m
                  memory: 90Mi
              securityContext:
                allowPrivilegeEscalation: true
                capabilities:
                  add:
                  - NET_BIND_SERVICE
                  drop:
                  - ALL
                runAsUser: 101
              volumeMounts:
              - mountPath: /usr/local/certificates/
                name: webhook-cert
                readOnly: true
            dnsPolicy: ClusterFirst
            nodeSelector:
              kubernetes.io/os: linux
            serviceAccountName: ingress-nginx
            terminationGracePeriodSeconds: 300
            volumes:
            - name: webhook-cert
              secret:
                secretName: ingress-nginx-admission

      ---

      apiVersion: v1
      kind: Service
      metadata:
        creationTimestamp: null
        labels:
          app.kubernetes.io/component: controller
          app.kubernetes.io/instance: ingress-nginx
          app.kubernetes.io/managed-by: Helm
          app.kubernetes.io/name: ingress-nginx
          app.kubernetes.io/part-of: ingress-nginx
          app.kubernetes.io/version: 1.1.2
          helm.sh/chart: ingress-nginx-4.0.18
        name: ingress-nginx-controller
        namespace: ingress-nginx
      spec:
        ports:
        - port: 80
          protocol: TCP
          targetPort: 80
          nodePort: 30080
        selector:
          app.kubernetes.io/component: controller
          app.kubernetes.io/instance: ingress-nginx
          app.kubernetes.io/name: ingress-nginx
        type: NodePort      
        ```
     </details>
  
  1. Check the Solution

     <details>

      ```yaml
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: ingress-wear-watch
        namespace: app-space
        annotations:
          nginx.ingress.kubernetes.io/rewrite-target: /
          nginx.ingress.kubernetes.io/ssl-redirect: "false"
      spec:
        rules:
        - http:
            paths:
            - path: /wear
              pathType: Prefix
              backend:
                service:
                name: wear-service
                port: 
                  number: 8080
            - path: /watch
              pathType: Prefix
              backend:
                service:
                name: video-service
                port:
                  number: 8080
      ```
     </details>

  1. Check the Solution

     <details>

      Press the `Ingress` button above the terminal pane. 
      In the browser tab that opens, try appending `/wear` or `/watch` after `labs.kodekloud.com` in the browser address bar.

     </details>






# ###################################################################################################################### 
# ###################################################################################################################### 
##  236. Solution - Ingress Networking - 2


## PENDENTE
- Ver sobre manifesto ingress, estrutura e yaml base.






## Service

- No video de solução tem uma questão separada que trata de criar o Service que vai ser usado no ingress, diferente do teste prático que não tinha esta questão separada.

- No video de solução é utilizado o "kubectl expose" ao invés do manifesto do Service.

- Exemplo de comando:

  # Create a service for an nginx deployment, which serves on port 80 and connects to the containers on port 8000
  kubectl expose deployment nginx --port=80 --target-port=8000


- No uso do "kubectl expose", não é possível definir o nodePort via comando imperativo.
- É necessário editar o recurso do Service e adicionar o nodePort desejado.

- Ajustando o comando:
kubectl expose deployment nginx --port=80 --target-port=8000










## Questão de ingress com paths


Create the ingress resource to make the applications available at /wear and /watch on the Ingress service.

Also, make use of rewrite-target annotation field: -

nginx.ingress.kubernetes.io/rewrite-target: /


Ingress resource comes under the namespace scoped, so don't forget to create the ingress in the app-space namespace.

Ingress Created

Path: /wear

Path: /watch

Configure correct backend service for /wear

Configure correct backend service for /watch

Configure correct backend port for /wear service

Configure correct backend port for /watch service



- No video de solução é utilizada um comando imperativo, para criar a estrutura do ingress e suas rules de base, para poder ir editando.

- Idéias:

~~~~bash

fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ kubectl create ingress -h
Create an ingress with the specified name.

Aliases:
ingress, ing

Examples:
  # Create a single ingress called 'simple' that directs requests to foo.com/bar to svc
  # svc1:8080 with a tls secret "my-cert"
  kubectl create ingress simple --rule="foo.com/bar=svc1:8080,tls=my-cert"

  # Create a catch all ingress of "/path" pointing to service svc:port and Ingress Class as "otheringress"
  kubectl create ingress catch-all --class=otheringress --rule="/path=svc:port"

  # Create an ingress with two annotations: ingress.annotation1 and ingress.annotations2
  kubectl create ingress annotated --class=default --rule="foo.com/bar=svc:port" \
  --annotation ingress.annotation1=foo \
  --annotation ingress.annotation2=bla

  # Create an ingress with the same host and multiple paths
  kubectl create ingress multipath --class=default \
  --rule="foo.com/=svc:port" \
  --rule="foo.com/admin/=svcadmin:portadmin"

  # Create an ingress with multiple hosts and the pathType as Prefix
  kubectl create ingress ingress1 --class=default \
  --rule="foo.com/path*=svc:8080" \
  --rule="bar.com/admin*=svc2:http"

  # Create an ingress with TLS enabled using the default ingress certificate and different path types
  kubectl create ingress ingtls --class=default \
  --rule="foo.com/=svc:https,tls" \
  --rule="foo.com/path/subpath*=othersvc:8080"

  # Create an ingress with TLS enabled using a specific secret and pathType as Prefix
  kubectl create ingress ingsecret --class=default \
  --rule="foo.com/*=svc:8080,tls=secret1"

  # Create an ingress with a default backend
  kubectl create ingress ingdefault --class=default \
  --default-backend=defaultsvc:http \
  --rule="foo.com/*=svc:8080,tls=secret1"

Options:
      --allow-missing-template-keys=true: If true, ignore any errors in templates when a field or map key is missing in
the template. Only applies to golang and jsonpath output formats.
      --annotation=[]: Annotation to insert in the ingress object, in the format annotation=value
      --class='': Ingress Class to be used
      --default-backend='': Default service for backend, in format of svcname:port
      --dry-run='none': Must be "none", "server", or "client". If client strategy, only print the object that would be
sent, without sending it. If server strategy, submit server-side request without persisting the resource.
      --field-manager='kubectl-create': Name of the manager used to track field ownership.
  -o, --output='': Output format. One of:
json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-as-json|jsonpath-file.
      --rule=[]: Rule in format host/path=service:port[,tls=secretname]. Paths containing the leading character '*' are
considered pathType=Prefix. tls argument is optional.
      --save-config=false: If true, the configuration of current object will be saved in its annotation. Otherwise, the
annotation will be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.
      --show-managed-fields=false: If true, keep the managedFields when printing objects in JSON or YAML format.
      --template='': Template string or path to template file to use when -o=go-template, -o=go-template-file. The
template format is golang templates [http://golang.org/pkg/text/template/#pkg-overview].
      --validate=true: If true, use a schema to validate the input before sending it

Usage:
  kubectl create ingress NAME --rule=host/path=service:port[,tls[=secret]]  [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$

~~~~



# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO

- No video de solução é utilizado o "kubectl expose" ao invés do manifesto do Service.

- Utilizar comandos imperativos, para facilitar a criação do esqueleto em alguns casos.