






------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "145. TLS Basics."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 145. TLS Basics



# TLS Basics
  - Take me to [Video Tutorial](https://kodekloud.com/topic/tls-basics/)
  
In this section, we will take a look at TLS Basics

## Certificate
- A certificate is used to guarantee trust between 2 parties during a transaction.
- Example: when a user tries to access web server, tls certificates ensure that the communication between them is encrypted.

  ![cert1](../../images/cert1.PNG)
  
  
## Symmetric Encryption
- It is a secure way of encryption, but it uses the same key to encrypt and decrypt the data and the key has to be exchanged between the sender and the receiver, there is a risk of a hacker gaining access to the key and decrypting the data.

  ![cert2](../../images/cert2.PNG)
  
## Asymmetric Encryption
- Instead of using single key to encrypt and decrypt data, asymmetric encryption uses a pair of keys, a private key and a public key.

  ![cert3](../../images/cert3.PNG)
  
  ![cert4](../../images/cert4.PNG)
  
  ![cert5](../../images/cert5.PNG)
  
  ![cert6](../../images/cert6.PNG)
  

#### How do you look at a certificate and verify if it is legit?
- who signed and issued the certificate.
- If you generate the certificate then you will have it sign it by yourself; that is known as self-signed certificate.

  ![cert7](../../images/cert7.PNG)
  
#### How do you generate legitimate certificate? How do you get your certificates singed by someone with authority?
- That's where **`Certificate Authority (CA)`** comes in for you. Some of the popular ones are Symantec, DigiCert, Comodo, GlobalSign etc.

  ![cert8](../../images/cert8.PNG)
  
  ![cert9](../../images/cert9.PNG)
  
  ![cert10](../../images/cert10.PNG)
  
## Public Key Infrastructure
   
   ![pki](../../images/pki.PNG)
   
## Certificates naming convention

  ![cert11](../../images/cert11.PNG)
  
  

  
   
  
  

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 145. TLS Basics


openssl genrsa -out key.pem 2048



Certificate Authority(CA)

Symantec, GlobalSign, 









## Gerando um certificado autoassinado usando OpenSSL

Atualizado pela última vez: 2021-07-08

OpenSSL é uma implementação de software livre dos protocolos SSL e TLS. Ele fornece a segurança da camada de transporte sobre a camada de comunicações normal, permitindo que ela seja entrelaçada com muitos aplicativos e serviços de rede.
Antes de Iniciar

É necessário ter uma das funções a seguir para concluir esta tarefa:

    Administrador
    Proprietário
    Administrador de topologia
    Função customizada com as permissões Configurações: gerenciar

Sobre Esta Tarefa

Este tópico informa como gerar uma solicitação de certificado SSL autoassinado utilizando o kit de ferramentas OpenSSL para ativar conexões HTTPS.
Procedimento

Para gerar um certificado SSL autoassinado usando o OpenSSL, conclua as etapas a seguir:

    Anote o Nome comum (CN) do Certificado SSL. O CN é o nome completo do sistema que usa o certificado. Para o DNS estático, use o nome do host ou endereço IP configurado no Cluster de gateway (por exemplo: 192.16.183.131 ou dp1.acme.com).
    Execute o comando OpenSSL a seguir para gerar sua chave privada e seu certificado público. Responda às perguntas e insira o Nome comum quando solicitado.

    openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem

Revise o certificado criado:

openssl x509 -text -noout -in certificate.pem

Combine sua chave e o certificado em um pacote configurável PKCS#12 (P12):

 openssl pkcs12 -inkey key.pem -in certificate.pem -export -out certificate.p12

Valide seu arquivo P2.

openssl pkcs12 -in certificate.p12 -noout -info

Depois que o certificado for criado, ele poderá ser transferido por upload para um keystore.
No Gerenciador de Nuvem, clique em RecursosRecursos.
Selecione TLS.
Clique em Criar na tabela Keystore.
Crie um Keystore e faça upload do arquivo de certificado seguindo as instruções em Criando um keystore.
Nota:

    O API Connect suporta somente o arquivo de formato P12 (PKCS12) para o certificado presente.
    Seu arquivo P12 deve conter a chave privada, o certificado público da Autoridade de certificação e todos os certificados intermediários usados para assinatura.
    Seu arquivo P12 pode conter no máximo 10 certificados intermediários.

Clique em Salvar. 