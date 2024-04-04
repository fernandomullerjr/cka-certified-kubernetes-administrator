
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "234. Solution - Ingress Networking 1 ."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  234. Solution - Ingress Networking 1 

# Practice Test CKA Ingress 1

  - Take me to [Practice Test](https://kodekloud.com/topic/practice-test-cka-ingress-networking-1/)

#### Solution 

  1. Check the Solution

     <details>

      ```
      Ok
      ```
     </details>
  
  2. Check the Solution

     <details>

      ```
      INGRESS-SPACE
      ```
     </details>

  3. Check the Solution

     <details>

      ```
      NGINX-INGRESS-CONTROLLER
      ```
     </details>

  4. Check the Solution

     <details>

      ```
      APP-SPACE
      ```
     </details>

  5. Check the Solution

     <details>

      ```
      3
      ```
     </details>

  6. Check the Solution

     <details>

      ```
      APP-SPACE
      ```
     </details>

  7. Check the Solution

     <details>

      ```
      INGRESS-WEAR-WATCH
      ```
     </details>

  8. Check the Solution

     <details>

      ```
      ALL-HOSTS(*)
      ```
     </details>

  9. Check the Solution

     <details>

      ```
      WEAR-SERVICE
      ```
     </details>

  10. Check the Solution

      <details>

       ```
        /WATCH
       ```
      </details>

  11. Check the Solution

      <details>

       ```
        DEFAULT-HTTP-BACKEND
       ```
      </details>

  12. Check the Solution

      <details>

       ```
        404-ERROR-PAGE
       ```
      </details>

  13. Check the Solution

      <details>

       ```
        OK
       ```
      </details>

  14. Check the Solution

      <details>
 
        ```
        kubectl edit ingress --namespace app-space
        ```
        Change the path from /watch to /stream
    
        OR
 
        ```yaml
        apiVersion: v1
        items:
        - apiVersion: extensions/v1beta1
          kind: Ingress
          metadata:
            annotations:
              nginx.ingress.kubernetes.io/rewrite-target: /
              nginx.ingress.kubernetes.io/ssl-redirect: "false"
            name: ingress-wear-watch
            namespace: app-space
          spec:
            rules:
            - http:
                paths:
                - backend:
                    serviceName: wear-service
                    servicePort: 8080
                  path: /wear
                  pathType: ImplementationSpecific
                - backend:
                    serviceName: video-service
                    servicePort: 8080
                  path: /stream
                  pathType: ImplementationSpecific
          status:
            loadBalancer:
              ingress:
              - {}
        kind: List
        metadata:
          resourceVersion: ""
          selfLink: ""
       ```
      </details>

  15. Check the Solution

      <details>

       ```
        OK
       ```
      </details>

  16. Check the Solution

      <details>

       ```
        404 ERROR PAGE
       ```
      </details>

  17. Check the Solution

      <details>

       ```
        OK
       ```
      </details>

  18. Check the Solution

      <details>

        Run the command `kubectl edit ingress --namespace app-space` and add a new Path entry for the new service.

        OR

       ```yaml
       apiVersion: v1
       items:
       - apiVersion: extensions/v1beta1
         kind: Ingress
         metadata:
           annotations:
             nginx.ingress.kubernetes.io/rewrite-target: /
             nginx.ingress.kubernetes.io/ssl-redirect: "false"
           name: ingress-wear-watch
           namespace: app-space
         spec:
           rules:
           - http:
               paths:
               - backend:
                   serviceName: wear-service
                   servicePort: 8080
                 path: /wear
                 pathType: ImplementationSpecific
               - backend:
                   serviceName: video-service
                   servicePort: 8080
                 path: /stream
                 pathType: ImplementationSpecific
               - backend:
                   serviceName: food-service
                   servicePort: 8080
                 path: /eat
                 pathType: ImplementationSpecific
         status:
           loadBalancer:
             ingress:
             - {}
       kind: List
       metadata:
         resourceVersion: ""
         selfLink: ""
       ```
      </details>

  19. Check the Solution

      <details>

       ```
        OK
       ```
      </details>

  20. Check the Solution

      <details>

       ```
        CRITICAL-SPACE
       ```
      </details>

  21. Check the Solution

      <details>

       ```
        WEBAPP-PAY
       ```
      </details>

  22. Check the Solution

      <details>

      ```yaml
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: test-ingress
        namespace: critical-space
        annotations:
          nginx.ingress.kubernetes.io/rewrite-target: /
          nginx.ingress.kubernetes.io/ssl-redirect: "false"
      spec:
        rules:
        - http:
            paths:
            - path: /pay
              pathType: Prefix
              backend:
                service:
                  name: pay-service
                  port:
                    number: 8282 
       ```
        </details>

  23. Check the Solution

      <details>

       ```
        OK
       ```
      </details>





# ###################################################################################################################### 
# ###################################################################################################################### 
##  234. Solution - Ingress Networking 1 


## PENDENTE
- Revisar a questão
    If the requirement does not match any of the configured paths in the Ingress, to which service are the requests forwarded?
pois não tem default configurado, apesar de existir o service/default-backend-service no namespace, ele nao ta setado no ingress





- Revisar a questão
    If the requirement does not match any of the configured paths in the Ingress, to which service are the requests forwarded?
pois não tem default configurado, apesar de existir o service/default-backend-service no namespace, ele nao ta setado no ingress

- Solução
no video existe um "default-http-backend" configurado no campo "Default backend", já no lab do browser não tinha.








- Sobre a questão do ingress
no exemplo ele é criado já direto no namespace critical-space
é criado de forma imperativa

~~~~bash

fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$
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

~~~~


- Importante lembrar de adicionar o annotations de "rewrite-target":
nginx.ingress.kubernetes.io/rewrite-target: /