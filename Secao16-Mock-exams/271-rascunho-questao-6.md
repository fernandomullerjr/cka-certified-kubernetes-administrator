Segue o processo completo e detalhado para responder à questão apresentada, incluindo exemplos de manifestos e etapas para configurar o acesso ao cluster Kubernetes para o usuário "john" com as permissões solicitadas.

---

### **1. Criação do Certificado e do CSR**
Para criar um usuário no Kubernetes, o primeiro passo é gerar um **CSR (Certificate Signing Request)** e aprová-lo.

#### **Manifesto para CertificateSigningRequest (CSR)**
O manifesto do CSR para o usuário `john` ficaria assim:

```yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: john-developer
spec:
  request: $(cat /root/CKA/john.csr | base64 | tr -d '\n') # Converta o CSR para base64
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400 # Opcional, define duração do certificado (1 dia neste exemplo)
  usages:
  - client auth
```

**Observação importante**: 
- O campo `signerName` foi introduzido no Kubernetes 1.19 e é obrigatório. 
- Use `kubernetes.io/kube-apiserver-client` para indicar que o certificado será usado para autenticação do cliente.

#### **Comandos para aplicar o CSR**
1. **Criar o CSR no cluster:**
   ```bash
   kubectl apply -f csr-john.yaml
   ```

2. **Aprovar o CSR:**
   ```bash
   kubectl certificate approve john-developer
   ```

3. **Obter o certificado assinado:**
   Após aprovação, baixe o certificado assinado:
   ```bash
   kubectl get csr john-developer -o jsonpath='{.status.certificate}' | base64 -d > /root/CKA/john.crt
   ```

Agora você terá o arquivo `/root/CKA/john.crt` contendo o certificado aprovado.

---

### **2. Configuração do Usuário no Cluster**
Depois de obter o certificado assinado, é necessário configurar o usuário e o contexto no `kubeconfig`.

#### **Adicionar o usuário ao kubeconfig**
Execute o seguinte comando para adicionar o usuário `john` ao arquivo kubeconfig:

```bash
kubectl config set-credentials john \
  --client-certificate=/root/CKA/john.crt \
  --client-key=/root/CKA/john.key
```

#### **Criar o contexto para o usuário**
Associe o usuário `john` ao cluster e namespace `development`:

```bash
kubectl config set-context john-context \
  --cluster=<nome-do-cluster> \
  --namespace=development \
  --user=john
```

Para usar este contexto, ative-o com:
```bash
kubectl config use-context john-context
```

---

### **3. Configuração de Permissões no Cluster**
Agora, é necessário criar as permissões de acesso para o usuário `john`. Isso envolve a criação de um **Role** e um **RoleBinding**.

#### **Manifesto para Role**
A **Role** define as permissões para os recursos no namespace `development`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: development
  name: developer
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["create", "list", "get", "update", "delete"]
```

Aplique o manifesto:
```bash
kubectl apply -f role-developer.yaml
```

#### **Manifesto para RoleBinding**
O **RoleBinding** vincula o usuário `john` à Role `developer` no namespace `development`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  namespace: development
  name: john-developer-binding
subjects:
- kind: User
  name: john
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: developer
  apiGroup: rbac.authorization.k8s.io
```

Aplique o manifesto:
```bash
kubectl apply -f rolebinding-john.yaml
```

---

### **Resumo das Etapas**
1. Gerar o par de chaves privada/pública para o usuário `john`:
   ```bash
   openssl genrsa -out /root/CKA/john.key 2048
   openssl req -new -key /root/CKA/john.key -out /root/CKA/john.csr -subj "/CN=john/O=development"
   ```
2. Criar o CSR no cluster (`csr-john.yaml`) e aprová-lo:
   - `kubectl apply -f csr-john.yaml`
   - `kubectl certificate approve john-developer`
   - Baixar o certificado com: `kubectl get csr john-developer -o jsonpath='{.status.certificate}' | base64 -d > /root/CKA/john.crt`
3. Adicionar o usuário `john` ao kubeconfig:
   - `kubectl config set-credentials john --client-certificate=/root/CKA/john.crt --client-key=/root/CKA/john.key`
   - `kubectl config set-context john-context --cluster=<nome-do-cluster> --namespace=development --user=john`
4. Criar as permissões:
   - Criar o Role (`role-developer.yaml`)
   - Criar o RoleBinding (`rolebinding-john.yaml`)

---

### **Observações Adicionais**
- Certifique-se de que o namespace `development` existe:
  ```bash
  kubectl create namespace development
  ```
- Teste o acesso do usuário `john`:
  ```bash
  kubectl --context=john-context auth can-i create pods -n development
  ```

Com essas etapas, o usuário `john` terá as permissões solicitadas no cluster Kubernetes. Se precisar de mais explicações ou ajustes, avise!