

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "154. Solution Certificates API."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 154. Solution Certificates API

# Practice Test - Certificates API

Solutions to the practice test - certificate API
- A new member akshay joined our team. He requires access to our cluster. The Certificate Signing Request is at the /root location.

  <details>
  ```
  $ ls -l /root
  ```
  </details>
  
- View the answer at /var/answers/akshay-csr.yaml
  
  <details>
  ```
  $ kubectl create -f /var/answers/akshay-csr.yaml
  ```
  </details>
  
- Run the command kubectl get csr
  
  <details>
  ```
  $ kubectl get csr
  ```
  </details>
    
- Run the command kubectl certificate approve akshay
  
  <details>
  ```
  $ kubectl certificate approve akshay
  ```
  </details>
  
- Run the command kubectl get csr
  
  <details>
  ```
  $ kubectl get csr
  ```
  </details>
  
- Run the command kubectl get csr and look at the Requestor column
  
  <details>
  ```
  $ kubectl get csr
  ```
  </details>
  
- The other CSR's are requested during the TLS Bootstrapping process. We will discuss more about it later in the course when we go through the TLS bootstrap section.

- Run the command kubectl get csr
  
  <details>
  ```
  $ kubectl get csr
  ```
  </details>
  
- Run the command kubectl get csr agent-smith -o yaml
  
  <details>
  ```
  $ kubectl get csr agent-smith -o yaml
  ```
  </details>
  
- Run the command kubectl certificate deny agent-smith
  
  <details>
  ```
  $ kubectl certificate deny agent-smith
  ```
  </details>
  
- Run the command kubectl delete csr agent-smith
  
  <details>
  ```
  $ kubectl delete csr agent-smith
  ```
  </details>
  





------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 154. Solution Certificates API


cat akshay.csr | base64 -w 0	


 este comando lê o conteúdo do arquivo ""akshay.csr"", converte-o em formato Base64 e produz a saída em uma única linha, sem quebras de linha, devido à opção -w 0.

base64 -w 0: Isso codifica o conteúdo do arquivo em formato Base64, mas com uma opção específica. A opção -w 0 é usada para especificar que não deve haver quebras de linha na saída codificada em Base64. Portanto, o resultado será uma única linha de texto contendo a representação Base64 do conteúdo do arquivo ""akshay.csr"", sem quebras de linha.
