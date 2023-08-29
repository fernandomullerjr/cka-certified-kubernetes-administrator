

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "147. TLS in Kubernetes - Certificate Creation."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 147. TLS in Kubernetes - Certificate Creation

# TLS in kubernetes - Certificate Creation
  - Take me to [Video Tutorial](https://kodekloud.com/topic/tls-in-kubernetes-certificate-creation/)
  
In this section, we will take a look at TLS certificate creation in kubernetes

## Generate Certificates
- There are different tools available such as easyrsa, openssl or cfssl etc. or many others for generating certificates.

## Certificate Authority (CA)

- Generate Keys
  ```
  $ openssl genrsa -out ca.key 2048
  ```
- Generate CSR
  ```
  $ openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
  ```
- Sign certificates
  ```
  $ openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
  ```
 
 ![ca1](../../images/ca1.PNG)
 
## Generating Client Certificates

#### Admin User Certificates

- Generate Keys
  ```
  $ openssl genrsa -out admin.key 2048
  ```
- Generate CSR
  ```
  $ openssl req -new -key admin.key -subj "/CN=kube-admin" -out admin.csr
  ```
- Sign certificates
  ```
  $ openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt
  ```
  
  ![ca2](../../images/ca2.PNG)
  
- Certificate with admin privilages
  ```
  $ openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:masters" -out admin.csr
  ```
  
#### We follow the same procedure to generate client certificate for all other components that access the kube-apiserver.

  ![crt1](../../images/crt1.PNG)
  
  ![crt2](../../images/crt2.PNG)
  
  ![crt3](../../images/crt3.PNG)
   
  ![crt4](../../images/crt4.PNG)
  
## Generating Server Certificates

## ETCD Server certificate

  ![etc1](../../images/etc1.PNG)
  
  ![etc2](../../images/etc2.PNG)
  
## Kube-apiserver certificate

  ![api1](../../images/api1.PNG)
  
  ![api2](../../images/api2.PNG)
  
## Kubectl Nodes (Server Cert)

   ![kctl1](../../images/kctl1.PNG)
   
## Kubectl Nodes (Client Cert)

   ![kctl2](../../images/kctl2.PNG)
   
   
   
  
  

  

  


  
  
  
  
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 147. TLS in Kubernetes - Certificate Creation


## Generate Certificates

    There are different tools available such as easyrsa, openssl or cfssl etc. or many others for generating certificates.


## Certificate Authority (CA)

    Generate Keys

~~~~bash
    $ openssl genrsa -out ca.key 2048
~~~~



## Generate CSR(Certificate Signing Request)

~~~~bash
$ openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
~~~~


## Sign certificates

~~~~bash
$ openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
~~~~







# Generating Client Certificates

## Admin User Certificates

    Generate Keys

~~~~bash
    $ openssl genrsa -out admin.key 2048
~~~~


## Generate CSR

~~~~bash
$ openssl req -new -key admin.key -subj "/CN=kube-admin" -out admin.csr
~~~~


## Sign certificates

~~~~bash
$ openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt
~~~~


## Certificate with admin privilages

~~~~bash
$ openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:masters" -out admin.csr
~~~~


- Esta parte do comando que diz que este certificado é para um admin:
O=system:masters







- We follow the same procedure to generate client certificate for all other components that access the kube-apiserver.

- Para todos os componentes do cluster, o procedimento de geração de certificados de cliente é o mesmo.