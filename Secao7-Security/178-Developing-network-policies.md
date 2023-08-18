


------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "178. Developing network policies."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 178. Developing network policies


Seguindo este manifesto como base:

~~~~yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
 name: db-policy
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          role: api-pod
    ports:
    - protocol: TCP
      port: 3306
~~~~




- Quando liberamos um tráfego de entrada(ingress), não precisamos liberar o tráfego da resposta desta comunicação. A resposta é liberada automaticamente.


- Este manifesto acima libera o acesso ao Pod do DB para todos os Pods de todos os namespaces que tenham a label "role: api-pod".



- Para restringir o acesso para 1 Namespace especifico, é necessário usar o "namespaceSelector".
- Neste caso, vamos limitar ao namespace de prod, que foi adicionada uma label "name: prod" neste Namespace:

        - namespaceSelector:
            matchLabels:
              name: prod

~~~~yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
 name: db-policy
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          role: api-pod
    - namespaceSelector:
        matchLabels:
          name: prod
    ports:
    - protocol: TCP
      port: 3306
~~~~










- Considerando que temos um Servidor de Backup e ele fica fora do Kubernetes, podemos liberar o acesso usando o bloco "ipBlock" e informar o endereço ip do servidor.

        - ipBlock:
            cidr: 172.17.0.0/16
            except:
              - 172.17.1.0/24

~~~~yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
 name: db-policy
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          role: api-pod
    - namespaceSelector:
        matchLabels:
          name: prod
    - ipBlock:
        cidr: 172.17.0.0/16
        except:
          - 172.17.1.0/24
    ports:
    - protocol: TCP
      port: 3306
~~~~

- As regras da Network Policy funcionam como um operador "or", se uma regra ou outra for compatível, será atendida a permissão.









- Caso o Servidor de Backup receba informações de um agent no Pod do DB, o sentido da comunicação e as regras são egress.

- Considerando isto, podemos configurar uma regra de egress no DB-POD:
adicionar o "- Egress" em policyTypes
egress to, a porta 80 e o ip do servidor de Backup

~~~~yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
 name: db-policy
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          role: api-pod
    ports:
    - protocol: TCP
      port: 3306
  egress:
    - to:
        - ipBlock:
            cidr: 192.168.5.10/32
      ports:
        - protocol: TCP
          port: 80
~~~~