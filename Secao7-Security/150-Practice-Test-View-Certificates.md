
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "150. Practice Test - View Certificates."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 150. Practice Test - View Certificates




 Identify the certificate file used for the kube-api server.



controlplane ~ ➜  ls /etc/kubernetes/
admin.conf  controller-manager.conf  kubelet.conf  manifests  pki  scheduler.conf

controlplane ~ ➜  ps -ef | grep api
root        3515    3047  0 22:23 ?        00:00:35 kube-apiserver --advertise-address=192.4.121.9 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root        8435    8194  0 22:35 pts/0    00:00:00 grep --color=auto api

controlplane ~ ➜  



- RESPOSTA:
/etc/kubernetes/pki/apiserver.crt














Identify the Certificate file used to authenticate kube-apiserver as a client to ETCD Server.


- RESPOSTA:
/etc/kubernetes/pki/apiserver-etcd-client.crt








Identify the key used to authenticate kubeapi-server to the kubelet server.

--kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key 














Identify the ETCD Server Certificate used to host ETCD server.


controlplane ~ ➜  ps -ef | grep -i etcd
root        3515    3047  0 22:23 ?        00:00:48 kube-apiserver --advertise-address=192.4.121.9 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root        3554    3031  0 22:23 ?        00:00:26 etcd --advertise-client-urls=https://192.4.121.9:2379 --cert-file=/etc/kubernetes/pki/etcd/server.crt --client-cert-auth=true --data-dir=/var/lib/etcd --experimental-initial-corrupt-check=true --experimental-watch-progress-notify-interval=5s --initial-advertise-peer-urls=https://192.4.121.9:2380 --initial-cluster=controlplane=https://192.4.121.9:2380 --key-file=/etc/kubernetes/pki/etcd/server.key --listen-client-urls=https://127.0.0.1:2379,https://192.4.121.9:2379 --listen-metrics-urls=http://127.0.0.1:2381 --listen-peer-urls=https://192.4.121.9:2380 --name=controlplane --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt --peer-client-cert-auth=true --peer-key-file=/etc/kubernetes/pki/etcd/peer.key --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt --snapshot-count=10000 --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
root        9893    8194  0 22:41 pts/0    00:00:00 grep --color=auto -i etcd

controlplane ~ ➜  


- ERRADAS:
--etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt

--etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt

--etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key


- RESPOSTA:
--cert-file=/etc/kubernetes/pki/etcd/server.crt










Identify the ETCD Server CA Root Certificate used to serve ETCD Server.

ETCD can have its own CA. So this may be a different CA certificate than the one used by kube-api server.


- RESPOSTA:
--peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt












What is the Common Name (CN) configured on the Kube API Server Certificate?

OpenSSL Syntax: openssl x509 -in file-path.crt -text -noout


openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout

controlplane ~ ➜  openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 4588310774978752086 (0x3facf45705b4ae56)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = kubernetes
        Validity
            Not Before: Sep  8 02:23:32 2023 GMT
            Not After : Sep  7 02:23:32 2024 GMT
        Subject: CN = kube-apiserver
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:be:3f:22:31:3d:7e:1c:20:3b:1f:d7:38:de:f8:
                    60:00:32:1d:14:af:a5:f3:92:bb:9d:4f:65:9e:8d:
                    cf:d4:43:38:8d:03:37:61:9c:52:0d:93:bf:17:90:
                    58:c2:f4:d4:5e:e7:f4:a5:f8:c3:f6:a5:f2:27:42:
                    d5:bf:07:08:ce:d5:19:48:a4:d1:f7:d4:8d:ed:29:
                    6a:38:7d:c0:f7:6f:ba:fe:49:ad:1f:27:64:bc:5f:
                    46:92:ee:6a:14:27:63:32:ed:5a:19:b9:b8:d4:da:
                    da:00:b5:7b:93:c3:fa:0f:c1:6a:3e:3f:f3:a7:8d:
                    df:72:0e:3e:02:28:44:7d:71:49:82:f8:77:6d:d3:
                    3e:9f:35:50:90:12:e8:9c:08:94:32:4c:4d:3f:2a:
                    de:52:66:8f:8c:c3:85:b2:b9:40:ac:ea:7c:e9:22:
                    4e:13:62:aa:c1:c3:5e:55:47:69:66:e9:dd:e8:2a:
                    d1:80:92:48:53:0e:2a:55:aa:c0:26:01:7d:18:cb:
                    c7:47:a1:f3:4a:b6:7d:09:74:da:16:ed:8b:4d:ac:
                    60:b7:5d:e5:25:40:d8:82:af:cc:77:48:04:90:30:
                    20:a9:1f:f5:86:43:47:57:59:da:be:bd:23:c1:e0:
                    08:12:9b:f1:29:96:90:3f:cd:d1:4d:59:22:45:f5:
                    7a:11
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 Authority Key Identifier: 
                keyid:8F:7E:00:F0:0F:BD:E3:1F:9E:C6:10:69:23:69:FE:48:09:6E:3C:02

            X509v3 Subject Alternative Name: 
                DNS:controlplane, DNS:kubernetes, DNS:kubernetes.default, DNS:kubernetes.default.svc, DNS:kubernetes.default.svc.cluster.local, IP Address:10.96.0.1, IP Address:192.4.121.9
    Signature Algorithm: sha256WithRSAEncryption
         a2:b2:ca:85:58:ba:cc:11:92:7e:ad:98:87:47:82:f1:bb:21:
         c4:c4:d8:dc:d7:ff:23:81:a4:00:67:10:c0:df:96:e0:ea:db:
         c3:4e:ce:c6:02:13:94:ba:6a:af:90:62:d1:b2:b8:8a:90:4b:
         80:4f:60:2a:bf:52:3e:b1:65:f3:82:51:70:fb:e4:d8:f6:e9:
         17:db:2c:2c:ac:e0:2d:e3:d0:10:96:24:da:5b:36:b8:1b:08:
         6d:28:d1:92:e6:71:78:e3:87:f0:08:98:64:5d:30:08:ea:a6:
         b3:bd:35:10:ec:d7:8f:59:e1:dd:f9:9d:a0:37:3a:6b:b7:40:
         d9:79:e6:eb:51:ea:d3:9f:21:aa:ba:6c:d7:08:4f:d0:52:60:
         0e:8d:dd:62:a2:ba:26:e6:f9:64:53:16:c3:2d:d0:55:32:53:
         e1:0b:c1:b0:93:f6:04:88:3f:4f:20:ec:a4:3a:13:42:fc:96:
         04:88:7f:ff:76:39:2b:3b:87:fd:65:db:f4:22:f4:a6:7d:6a:
         a2:8e:9f:31:83:fc:49:7d:5f:2c:32:fa:8d:cd:2e:71:e7:b6:
         e1:4e:af:1e:09:f5:fd:63:ca:2a:d6:1b:62:4e:fa:a2:67:b1:
         d0:d7:01:7a:6d:21:f8:8e:59:2a:17:64:f1:f0:b7:46:72:94:
         13:53:86:e7

controlplane ~ ➜  


- resposta:

        Subject: CN = kube-apiserver












What is the name of the CA who issued the Kube API Server Certificate?


Issuer: CN = kubernetes







Which of the below alternate names is not configured on the Kube API Server Certificate?

- RESPOSTA:
kube-master






What is the Common Name (CN) configured on the ETCD Server certificate?


openssl x509 -in /etc/kubernetes/pki/etcd/server.crt -text -noout



controlplane ~ ➜  openssl x509 -in /etc/kubernetes/pki/etcd/server.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 8417326739112651614 (0x74d05a128334eb5e)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = etcd-ca
        Validity
            Not Before: Sep  8 02:23:33 2023 GMT
            Not After : Sep  7 02:23:33 2024 GMT
        Subject: CN = controlplane
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:c6:34:3a:44:1a:07:d3:3d:fb:19:4d:22:84:7b:
                    bb:e9:a5:4c:ec:c3:bd:6d:00:12:20:07:25:45:bd:
                    28:37:2f:ae:ae:34:4a:17:46:e5:18:48:ad:bc:98:
                    e7:3a:a7:80:ec:8c:bb:d3:2a:40:cd:64:82:7b:b6:
                    97:af:b2:4d:8f:bb:cd:ec:f4:06:52:57:5b:9b:63:
                    af:ed:c4:34:3c:d8:03:df:de:1d:da:f2:2f:7e:b0:
                    16:aa:4f:19:ce:09:46:e5:13:00:5b:46:1a:6f:16:
                    56:ca:b3:2a:37:c7:c8:af:04:be:cf:55:8e:6b:bb:
                    18:d1:2c:fd:a9:a7:c1:97:83:ea:14:3f:ef:67:b5:
                    bd:c3:e9:c3:3a:fa:36:32:a1:90:f4:9e:02:92:78:
                    81:c1:d6:ee:b8:48:ed:9d:c1:45:0d:08:e8:9f:06:
                    2f:3b:fe:ca:de:75:71:cb:e4:37:53:7c:c3:23:74:
                    e7:89:c4:dd:f6:d2:ae:85:f4:d1:5e:f6:ff:50:ad:
                    5e:90:7e:68:f4:13:8c:bf:83:54:06:6e:31:8d:df:
                    85:cb:ea:1a:90:7b:cd:b8:1c:c2:ff:fe:fe:67:ce:
                    1c:ac:31:65:aa:e4:b7:aa:0c:a9:d1:a1:27:79:6b:
                    20:c5:b7:f0:ba:39:b2:14:1d:c8:e0:f8:32:9b:d4:
                    b9:35
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 Authority Key Identifier: 
                keyid:D9:23:C5:1B:39:09:EB:D5:9A:2A:D7:65:F3:6A:3F:1A:48:12:A9:C4

            X509v3 Subject Alternative Name: 
                DNS:controlplane, DNS:localhost, IP Address:192.4.121.9, IP Address:127.0.0.1, IP Address:0:0:0:0:0:0:0:1
    Signature Algorithm: sha256WithRSAEncryption
         52:5e:c2:3f:74:6d:64:a7:2d:67:ec:87:b2:8a:b6:8d:89:d2:
         a7:6a:26:5a:69:a5:70:3b:d7:b9:e6:02:48:2a:5f:d3:9a:75:
         45:30:70:19:2a:1e:37:87:7c:16:cb:83:f5:b0:5f:a8:23:6f:
         6e:67:dc:e2:b7:25:61:31:3a:75:26:26:e2:45:df:a3:cf:2e:
         22:3b:04:bf:b4:0e:48:01:70:41:a8:69:13:53:d1:77:15:86:
         71:f7:8a:77:f1:e1:d7:f1:d3:b9:ab:24:a9:5b:82:31:0f:b8:
         d2:68:0f:a4:27:a4:f3:dd:46:01:fe:27:4a:f3:24:51:49:f4:
         a0:85:9f:58:9f:dd:38:bf:2d:5d:6b:33:b9:a6:31:35:d1:36:
         80:e2:d5:7a:9e:32:5b:8f:00:2c:ae:f0:8a:2f:fd:7e:71:a1:
         c3:9b:52:37:89:a1:58:1e:9f:27:a4:96:fa:95:15:b3:8d:0a:
         c6:61:e4:61:87:d5:a9:48:0a:87:f6:fb:41:42:6b:c9:3d:87:
         b2:41:01:ce:12:5f:03:49:50:db:90:e6:8a:fd:4b:2f:7f:8c:
         2a:ba:f8:56:6e:00:ae:bd:d6:96:d8:9a:e3:36:a3:79:f3:54:
         76:3d:4a:ac:7c:2a:c7:11:6e:99:fd:b1:85:d2:2e:00:f1:99:
         da:28:67:4d

controlplane ~ ➜  



- RESPOSTA:
        Subject: CN = controlplane

















How long, from the issued date, is the Kube-API Server Certificate valid for?

File: /etc/kubernetes/pki/apiserver.crt

- resposta:
1 year









How long, from the issued date, is the Root CA Certificate valid for?

File: /etc/kubernetes/pki/ca.crt


openssl x509 -in /etc/kubernetes/pki/ca.crt -text -noout


controlplane ~ ➜  

controlplane ~ ➜  openssl x509 -in /etc/kubernetes/pki/ca.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 0 (0x0)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = kubernetes
        Validity
            Not Before: Sep  8 02:23:32 2023 GMT
            Not After : Sep  5 02:23:32 2033 GMT
        Subject: CN = kubernetes
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:b5:79:9a:33:d9:8f:7e:cf:73:b5:2f:16:80:63:
                    c0:8d:a3:1b:bd:0e:d9:a1:55:35:f8:02:45:6b:17:
                    91:66:13:60:ba:2d:73:33:ec:f8:e3:d5:00:96:d5:
                    c9:52:6a:42:24:9b:e6:66:7b:49:e4:ed:63:95:5f:
                    16:a2:4b:92:d9:51:f5:96:e9:05:f8:7c:47:41:16:
                    e2:0a:29:2f:fc:52:18:43:60:70:2c:f3:67:54:67:
                    31:0f:32:53:85:4f:c4:d4:32:9c:a1:58:19:ca:f1:
                    68:69:f8:17:4f:47:7c:85:3c:c9:91:59:d2:af:e7:
                    9c:e2:45:a6:36:28:3f:d9:8d:37:ea:b7:b1:39:34:
                    9b:39:7d:33:4a:34:3b:c1:f1:71:32:53:b0:68:6c:
                    d3:76:1f:08:fa:d4:50:a4:dd:f6:1f:53:c6:07:2f:
                    93:07:b8:f9:08:05:fa:b7:fd:a4:7b:00:9d:d6:e9:
                    7b:f1:18:ba:fd:61:f4:1d:90:74:ab:86:7c:92:7c:
                    33:d2:0c:c9:e5:2a:92:c1:a8:ca:2b:4c:45:b9:1c:
                    16:28:31:ba:96:b8:2e:85:0a:05:39:4a:46:40:79:
                    70:26:ba:8c:24:08:1a:f4:8a:9b:63:30:26:cd:00:
                    15:89:e6:fc:0f:19:98:1a:79:ce:60:93:bb:8a:75:
                    9f:85
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment, Certificate Sign
            X509v3 Basic Constraints: critical
                CA:TRUE
            X509v3 Subject Key Identifier: 
                8F:7E:00:F0:0F:BD:E3:1F:9E:C6:10:69:23:69:FE:48:09:6E:3C:02
            X509v3 Subject Alternative Name: 
                DNS:kubernetes
    Signature Algorithm: sha256WithRSAEncryption
         20:31:ba:51:5b:4e:67:83:6c:47:02:a4:67:46:cb:c4:7b:90:
         c5:a2:f1:24:5b:cb:a0:fe:58:4c:49:ce:81:42:7a:d1:f5:04:
         c7:6c:b2:db:cc:b0:85:2f:64:b0:17:ad:76:47:db:5d:e9:5d:
         ea:13:d0:c0:1b:04:98:fe:07:6b:61:95:43:cf:fc:50:95:d0:
         89:e8:b3:46:f6:68:eb:18:6f:bf:3a:cb:78:7d:ee:35:08:83:
         3b:6e:b1:53:e0:6d:46:82:63:74:45:9d:50:88:32:b4:54:c7:
         db:87:26:47:54:d4:53:b3:fa:38:a4:d7:d4:82:f3:97:ba:15:
         b4:e3:aa:15:51:27:5c:38:37:a7:76:dc:a9:15:f3:a7:ba:ea:
         00:73:05:17:77:ba:ec:b1:fe:79:c2:e7:ff:32:bb:e4:49:28:
         01:09:29:cb:8a:5c:d4:e6:40:5c:a1:4e:54:ce:12:23:ae:0d:
         0d:0d:b5:b5:a9:f1:7f:23:08:12:14:4c:df:08:56:fb:c9:18:
         17:55:d1:1b:3c:fc:03:2b:53:38:c6:b4:90:31:06:6f:fc:ce:
         04:3f:a2:bd:12:86:7f:2e:bf:d7:ee:b6:60:e7:30:89:ae:83:
         2d:9a:fe:0c:3e:a5:1f:16:d4:ed:29:31:1e:ca:99:59:35:90:
         ca:39:e8:06

controlplane ~ ➜  


- RESPOSTA:
10 years











Kubectl suddenly stops responding to your commands. Check it out! Someone recently modified the /etc/kubernetes/manifests/etcd.yaml file

You are asked to investigate and fix the issue. Once you fix the issue wait for sometime for kubectl to respond. Check the logs of the ETCD container.

    Fix the kube-api server




controlplane ~ ➜  kubectl get pods
^C

controlplane ~ ✖ cat /etc/kubernetes/manifests/etcd.yaml 
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/etcd.advertise-client-urls: https://192.4.121.9:2379
  creationTimestamp: null
  labels:
    component: etcd
    tier: control-plane
  name: etcd
  namespace: kube-system
spec:
  containers:
  - command:
    - etcd
    - --advertise-client-urls=https://192.4.121.9:2379
    - --cert-file=/etc/kubernetes/pki/etcd/server-certificate.crt
    - --client-cert-auth=true
    - --data-dir=/var/lib/etcd
    - --experimental-initial-corrupt-check=true
    - --experimental-watch-progress-notify-interval=5s
    - --initial-advertise-peer-urls=https://192.4.121.9:2380
    - --initial-cluster=controlplane=https://192.4.121.9:2380
    - --key-file=/etc/kubernetes/pki/etcd/server.key
    - --listen-client-urls=https://127.0.0.1:2379,https://192.4.121.9:2379
    - --listen-metrics-urls=http://127.0.0.1:2381
    - --listen-peer-urls=https://192.4.121.9:2380
    - --name=controlplane
    - --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
    - --peer-client-cert-auth=true
    - --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
    - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    - --snapshot-count=10000
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    image: registry.k8s.io/etcd:3.5.7-0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /health?exclude=NOSPACE&serializable=true
        port: 2381
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: etcd
    resources:
      requests:
        cpu: 100m
        memory: 100Mi
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /health?serializable=false
        port: 2381
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /var/lib/etcd
      name: etcd-data
    - mountPath: /etc/kubernetes/pki/etcd
      name: etcd-certs
  hostNetwork: true
  priority: 2000001000
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/kubernetes/pki/etcd
      type: DirectoryOrCreate
    name: etcd-certs
  - hostPath:
      path: /var/lib/etcd
      type: DirectoryOrCreate
    name: etcd-data
status: {}

controlplane ~ ➜  







journalctl -u etcd.service -l

controlplane ~ ➜  journalctl -u etcd.service -l
-- Logs begin at Thu 2023-09-07 22:23:19 EDT, end at Thu 2023-09-07 22:54:28 EDT. --
-- No entries --

controlplane ~ ➜  



controlplane ~ ➜  kubectl logs etcd-master
The connection to the server controlplane:6443 was refused - did you specify the right host or port?

controlplane ~ ✖ 






https://kubernetes.io/docs/tasks/debug/debug-cluster/crictl/
<https://kubernetes.io/docs/tasks/debug/debug-cluster/crictl/>


controlplane ~ ➜  crictl pods
POD ID              CREATED             STATE               NAME                                   NAMESPACE           ATTEMPT             RUNTIME
aa0450dec18cd       4 minutes ago       Ready               etcd-controlplane                      kube-system         0                   (default)
49d5002026258       33 minutes ago      Ready               coredns-5d78c9869d-jzvdm               kube-system         0                   (default)
06e4287a9b47a       33 minutes ago      Ready               coredns-5d78c9869d-9cs6z               kube-system         0                   (default)
9eb04025e0e11       33 minutes ago      Ready               kube-proxy-bq69z                       kube-system         0                   (default)
89bcdc505fcd5       33 minutes ago      Ready               kube-flannel-ds-842v9                  kube-flannel        0                   (default)
38f8e2ecafcc5       34 minutes ago      Ready               kube-scheduler-controlplane            kube-system         0                   (default)
6b5c6018d8b95       34 minutes ago      Ready               kube-apiserver-controlplane            kube-system         0                   (default)
c482bafd666a9       34 minutes ago      Ready               kube-controller-manager-controlplane   kube-system         0                   (default)

controlplane ~ ➜  


controlplane ~ ➜  crictl ps -a
CONTAINER           IMAGE               CREATED              STATE               NAME                      ATTEMPT             POD ID              POD
f19197851aebd       6f707f569b572       23 seconds ago       Exited              kube-apiserver            6                   6b5c6018d8b95       kube-apiserver-controlplane
85f8ebad3a139       86b6af7dd652c       About a minute ago   Exited              etcd                      5                   aa0450dec18cd       etcd-controlplane
0e65cc7d63b5f       f73f1b39c3fe8       6 minutes ago        Running             kube-scheduler            1                   38f8e2ecafcc5       kube-scheduler-controlplane
eee8ec45c0b50       95fe52ed44570       6 minutes ago        Running             kube-controller-manager   1                   c482bafd666a9       kube-controller-manager-controlplane
08b4b523818b7       ead0a4a53df89       35 minutes ago       Running             coredns                   0                   49d5002026258       coredns-5d78c9869d-jzvdm
30442ee048708       ead0a4a53df89       35 minutes ago       Running             coredns                   0                   06e4287a9b47a       coredns-5d78c9869d-9cs6z
c5706cff92963       8b675dda11bb1       35 minutes ago       Running             kube-flannel              0                   89bcdc505fcd5       kube-flannel-ds-842v9
d1deb07ceaa4d       8b675dda11bb1       35 minutes ago       Exited              install-cni               0                   89bcdc505fcd5       kube-flannel-ds-842v9
45fce4591ad72       fcecffc7ad4af       35 minutes ago       Exited              install-cni-plugin        0                   89bcdc505fcd5       kube-flannel-ds-842v9
29c0dbf756976       5f82fc39fa816       35 minutes ago       Running             kube-proxy                0                   9eb04025e0e11       kube-proxy-bq69z
3d8480d72e91c       f73f1b39c3fe8       35 minutes ago       Exited              kube-scheduler            0                   38f8e2ecafcc5       kube-scheduler-controlplane
e13196ea86605       95fe52ed44570       35 minutes ago       Exited              kube-controller-manager   0                   c482bafd666a9       kube-controller-manager-controlplane

controlplane ~ ➜  date
Thu 07 Sep 2023 10:59:31 PM EDT

controlplane ~ ➜  




- Verificando logs do container kube-apiserver 

crictl logs f19197851aebd


  "Metadata": null
}. Err: connection error: desc = "transport: Error while dialing dial tcp 127.0.0.1:2379: connect: connection refused"
W0908 02:59:20.819492       1 logging.go:59] [core] [Channel #3 SubChannel #4] grpc: addrConn.createTransport failed to connect to {
  "Addr": "127.0.0.1:2379",
  "ServerName": "127.0.0.1",
  "Attributes": null,
  "BalancerAttributes": null,
  "Type": 0,
  "Metadata": null
}. Err: connection error: desc = "transport: Error while dialing dial tcp 127.0.0.1:2379: connect: connection refused"
W0908 02:59:21.658586       1 logging.go:59] [core] [Channel #5 SubChannel #6] grpc: addrConn.createTransport failed to connect to {
  "Addr": "127.0.0.1:2379",
  "ServerName": "127.0.0.1",
  "Attributes": null,
  "BalancerAttributes": null,
  "Type": 0,
  "Metadata": null
}. Err: connection error: desc = "transport: Error while dialing dial tcp 127.0.0.1:2379: connect: connection refused"
E0908 02:59:24.539335       1 run.go:74] "command failed" err="context deadline exceeded"





- Verificando logs do container etcd

crictl logs 85f8ebad3a139

controlplane ~ ➜  crictl logs 85f8ebad3a139
E0907 23:02:35.108439   17874 remote_runtime.go:415] "ContainerStatus from runtime service failed" err="rpc error: code = NotFound desc = an error occurred when try to find container \"85f8ebad3a139\": not found" containerID="85f8ebad3a139"
FATA[0000] rpc error: code = NotFound desc = an error occurred when try to find container "85f8ebad3a139": not found 

controlplane ~ ✖ 





controlplane ~ ✖ crictl ps -a
CONTAINER           IMAGE               CREATED             STATE               NAME                      ATTEMPT             POD ID              POD
77f5299cdc439       6f707f569b572       45 seconds ago      Exited              kube-apiserver            7                   6b5c6018d8b95       kube-apiserver-controlplane
6be96b4274c4b       86b6af7dd652c       2 minutes ago       Exited              etcd                      6                   aa0450dec18cd       etcd-controlplane
0e65cc7d63b5f       f73f1b39c3fe8       9 minutes ago       Running             kube-scheduler            1                   38f8e2ecafcc5       kube-scheduler-controlplane
eee8ec45c0b50       95fe52ed44570       10 minutes ago      Running             kube-controller-manager   1                   c482bafd666a9       kube-controller-manager-controlplane
08b4b523818b7       ead0a4a53df89       38 minutes ago      Running             coredns                   0                   49d5002026258       coredns-5d78c9869d-jzvdm
30442ee048708       ead0a4a53df89       38 minutes ago      Running             coredns                   0                   06e4287a9b47a       coredns-5d78c9869d-9cs6z
c5706cff92963       8b675dda11bb1       38 minutes ago      Running             kube-flannel              0                   89bcdc505fcd5       kube-flannel-ds-842v9
d1deb07ceaa4d       8b675dda11bb1       38 minutes ago      Exited              install-cni               0                   89bcdc505fcd5       kube-flannel-ds-842v9
45fce4591ad72       fcecffc7ad4af       38 minutes ago      Exited              install-cni-plugin        0                   89bcdc505fcd5       kube-flannel-ds-842v9
29c0dbf756976       5f82fc39fa816       38 minutes ago      Running             kube-proxy                0                   9eb04025e0e11       kube-proxy-bq69z
3d8480d72e91c       f73f1b39c3fe8       39 minutes ago      Exited              kube-scheduler            0                   38f8e2ecafcc5       kube-scheduler-controlplane
e13196ea86605       95fe52ed44570       39 minutes ago      Exited              kube-controller-manager   0                   c482bafd666a9       kube-controller-manager-controlplane

controlplane ~ ➜  




- Verificando logs do container etcd

crictl logs 6be96b4274c4b



controlplane ~ ➜  crictl logs 6be96b4274c4b
{"level":"info","ts":"2023-09-08T03:00:19.321Z","caller":"etcdmain/etcd.go:73","msg":"Running: ","args":["etcd","--advertise-client-urls=https://192.4.121.9:2379","--cert-file=/etc/kubernetes/pki/etcd/server-certificate.crt","--client-cert-auth=true","--data-dir=/var/lib/etcd","--experimental-initial-corrupt-check=true","--experimental-watch-progress-notify-interval=5s","--initial-advertise-peer-urls=https://192.4.121.9:2380","--initial-cluster=controlplane=https://192.4.121.9:2380","--key-file=/etc/kubernetes/pki/etcd/server.key","--listen-client-urls=https://127.0.0.1:2379,https://192.4.121.9:2379","--listen-metrics-urls=http://127.0.0.1:2381","--listen-peer-urls=https://192.4.121.9:2380","--name=controlplane","--peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt","--peer-client-cert-auth=true","--peer-key-file=/etc/kubernetes/pki/etcd/peer.key","--peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt","--snapshot-count=10000","--trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt"]}
{"level":"info","ts":"2023-09-08T03:00:19.322Z","caller":"etcdmain/etcd.go:116","msg":"server has been already initialized","data-dir":"/var/lib/etcd","dir-type":"member"}
{"level":"info","ts":"2023-09-08T03:00:19.323Z","caller":"embed/etcd.go:124","msg":"configuring peer listeners","listen-peer-urls":["https://192.4.121.9:2380"]}
{"level":"info","ts":"2023-09-08T03:00:19.323Z","caller":"embed/etcd.go:484","msg":"starting with peer TLS","tls-info":"cert = /etc/kubernetes/pki/etcd/peer.crt, key = /etc/kubernetes/pki/etcd/peer.key, client-cert=, client-key=, trusted-ca = /etc/kubernetes/pki/etcd/ca.crt, client-cert-auth = true, crl-file = ","cipher-suites":[]}
{"level":"info","ts":"2023-09-08T03:00:19.327Z","caller":"embed/etcd.go:132","msg":"configuring client listeners","listen-client-urls":["https://127.0.0.1:2379","https://192.4.121.9:2379"]}
{"level":"info","ts":"2023-09-08T03:00:19.328Z","caller":"embed/etcd.go:306","msg":"starting an etcd server","etcd-version":"3.5.7","git-sha":"215b53cf3","go-version":"go1.17.13","go-os":"linux","go-arch":"amd64","max-cpu-set":36,"max-cpu-available":36,"member-initialized":true,"name":"controlplane","data-dir":"/var/lib/etcd","wal-dir":"","wal-dir-dedicated":"","member-dir":"/var/lib/etcd/member","force-new-cluster":false,"heartbeat-interval":"100ms","election-timeout":"1s","initial-election-tick-advance":true,"snapshot-count":10000,"max-wals":5,"max-snapshots":5,"snapshot-catchup-entries":5000,"initial-advertise-peer-urls":["https://192.4.121.9:2380"],"listen-peer-urls":["https://192.4.121.9:2380"],"advertise-client-urls":["https://192.4.121.9:2379"],"listen-client-urls":["https://127.0.0.1:2379","https://192.4.121.9:2379"],"listen-metrics-urls":["http://127.0.0.1:2381"],"cors":["*"],"host-whitelist":["*"],"initial-cluster":"","initial-cluster-state":"new","initial-cluster-token":"","quota-backend-bytes":2147483648,"max-request-bytes":1572864,"max-concurrent-streams":4294967295,"pre-vote":true,"initial-corrupt-check":true,"corrupt-check-time-interval":"0s","compact-check-time-enabled":false,"compact-check-time-interval":"1m0s","auto-compaction-mode":"periodic","auto-compaction-retention":"0s","auto-compaction-interval":"0s","discovery-url":"","discovery-proxy":"","downgrade-check-interval":"5s"}
{"level":"info","ts":"2023-09-08T03:00:19.344Z","caller":"etcdserver/backend.go:81","msg":"opened backend db","path":"/var/lib/etcd/member/snap/db","took":"13.902804ms"}
{"level":"info","ts":"2023-09-08T03:00:19.361Z","caller":"etcdserver/server.go:530","msg":"No snapshot found. Recovering WAL from scratch!"}
{"level":"info","ts":"2023-09-08T03:00:19.375Z","caller":"etcdserver/raft.go:529","msg":"restarting local member","cluster-id":"ddf05ee95628ace","local-member-id":"5a66c5a502692d6f","commit-index":3064}
{"level":"info","ts":"2023-09-08T03:00:19.376Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"5a66c5a502692d6f switched to configuration voters=()"}
{"level":"info","ts":"2023-09-08T03:00:19.377Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"5a66c5a502692d6f became follower at term 8"}
{"level":"info","ts":"2023-09-08T03:00:19.377Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"newRaft 5a66c5a502692d6f [peers: [], term: 8, commit: 3064, applied: 0, lastindex: 3064, lastterm: 8]"}
{"level":"warn","ts":"2023-09-08T03:00:19.379Z","caller":"auth/store.go:1234","msg":"simple token is not cryptographically signed"}
{"level":"info","ts":"2023-09-08T03:00:19.379Z","caller":"mvcc/kvstore.go:323","msg":"restored last compact revision","meta-bucket-name":"meta","meta-bucket-name-key":"finishedCompactRev","restored-compact-revision":1994}
{"level":"info","ts":"2023-09-08T03:00:19.383Z","caller":"mvcc/kvstore.go:393","msg":"kvstore restored","current-rev":2694}
{"level":"info","ts":"2023-09-08T03:00:19.385Z","caller":"etcdserver/quota.go:94","msg":"enabled backend quota with default value","quota-name":"v3-applier","quota-size-bytes":2147483648,"quota-size":"2.1 GB"}
{"level":"info","ts":"2023-09-08T03:00:19.386Z","caller":"etcdserver/corrupt.go:95","msg":"starting initial corruption check","local-member-id":"5a66c5a502692d6f","timeout":"7s"}
{"level":"info","ts":"2023-09-08T03:00:19.387Z","caller":"etcdserver/corrupt.go:165","msg":"initial corruption checking passed; no corruption","local-member-id":"5a66c5a502692d6f"}
{"level":"info","ts":"2023-09-08T03:00:19.387Z","caller":"etcdserver/server.go:854","msg":"starting etcd server","local-member-id":"5a66c5a502692d6f","local-server-version":"3.5.7","cluster-version":"to_be_decided"}
{"level":"info","ts":"2023-09-08T03:00:19.387Z","caller":"etcdserver/server.go:754","msg":"starting initial election tick advance","election-ticks":10}
{"level":"info","ts":"2023-09-08T03:00:19.387Z","caller":"fileutil/purge.go:44","msg":"started to purge file","dir":"/var/lib/etcd/member/snap","suffix":"snap.db","max":5,"interval":"30s"}
{"level":"info","ts":"2023-09-08T03:00:19.387Z","caller":"fileutil/purge.go:44","msg":"started to purge file","dir":"/var/lib/etcd/member/snap","suffix":"snap","max":5,"interval":"30s"}
{"level":"info","ts":"2023-09-08T03:00:19.387Z","caller":"fileutil/purge.go:44","msg":"started to purge file","dir":"/var/lib/etcd/member/wal","suffix":"wal","max":5,"interval":"30s"}
{"level":"info","ts":"2023-09-08T03:00:19.388Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"5a66c5a502692d6f switched to configuration voters=(6514111223538724207)"}
{"level":"info","ts":"2023-09-08T03:00:19.388Z","caller":"membership/cluster.go:421","msg":"added member","cluster-id":"ddf05ee95628ace","local-member-id":"5a66c5a502692d6f","added-peer-id":"5a66c5a502692d6f","added-peer-peer-urls":["https://192.4.121.9:2380"]}
{"level":"info","ts":"2023-09-08T03:00:19.388Z","caller":"membership/cluster.go:584","msg":"set initial cluster version","cluster-id":"ddf05ee95628ace","local-member-id":"5a66c5a502692d6f","cluster-version":"3.5"}
{"level":"info","ts":"2023-09-08T03:00:19.388Z","caller":"api/capability.go:75","msg":"enabled capabilities for version","cluster-version":"3.5"}
{"level":"info","ts":"2023-09-08T03:00:19.389Z","caller":"embed/etcd.go:687","msg":"starting with client TLS","tls-info":"cert = /etc/kubernetes/pki/etcd/server-certificate.crt, key = /etc/kubernetes/pki/etcd/server.key, client-cert=, client-key=, trusted-ca = /etc/kubernetes/pki/etcd/ca.crt, client-cert-auth = true, crl-file = ","cipher-suites":[]}
{"level":"info","ts":"2023-09-08T03:00:19.389Z","caller":"embed/etcd.go:586","msg":"serving peer traffic","address":"192.4.121.9:2380"}
{"level":"info","ts":"2023-09-08T03:00:19.389Z","caller":"embed/etcd.go:558","msg":"cmux::serve","address":"192.4.121.9:2380"}
{"level":"info","ts":"2023-09-08T03:00:19.389Z","caller":"embed/etcd.go:275","msg":"now serving peer/client/metrics","local-member-id":"5a66c5a502692d6f","initial-advertise-peer-urls":["https://192.4.121.9:2380"],"listen-peer-urls":["https://192.4.121.9:2380"],"advertise-client-urls":["https://192.4.121.9:2379"],"listen-client-urls":["https://127.0.0.1:2379","https://192.4.121.9:2379"],"listen-metrics-urls":["http://127.0.0.1:2381"]}
{"level":"info","ts":"2023-09-08T03:00:19.389Z","caller":"embed/etcd.go:762","msg":"serving metrics","address":"http://127.0.0.1:2381"}
{"level":"info","ts":"2023-09-08T03:00:21.078Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"5a66c5a502692d6f is starting a new election at term 8"}
{"level":"info","ts":"2023-09-08T03:00:21.078Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"5a66c5a502692d6f became pre-candidate at term 8"}
{"level":"info","ts":"2023-09-08T03:00:21.078Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"5a66c5a502692d6f received MsgPreVoteResp from 5a66c5a502692d6f at term 8"}
{"level":"info","ts":"2023-09-08T03:00:21.078Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"5a66c5a502692d6f became candidate at term 9"}
{"level":"info","ts":"2023-09-08T03:00:21.078Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"5a66c5a502692d6f received MsgVoteResp from 5a66c5a502692d6f at term 9"}
{"level":"info","ts":"2023-09-08T03:00:21.078Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"5a66c5a502692d6f became leader at term 9"}
{"level":"info","ts":"2023-09-08T03:00:21.078Z","logger":"raft","caller":"etcdserver/zap_raft.go:77","msg":"raft.node: 5a66c5a502692d6f elected leader 5a66c5a502692d6f at term 9"}
{"level":"info","ts":"2023-09-08T03:00:21.079Z","caller":"etcdserver/server.go:2062","msg":"published local member to cluster through raft","local-member-id":"5a66c5a502692d6f","local-member-attributes":"{Name:controlplane ClientURLs:[https://192.4.121.9:2379]}","request-path":"/0/members/5a66c5a502692d6f/attributes","cluster-id":"ddf05ee95628ace","publish-timeout":"7s"}
{"level":"info","ts":"2023-09-08T03:00:21.079Z","caller":"embed/serve.go:100","msg":"ready to serve client requests"}
{"level":"info","ts":"2023-09-08T03:00:21.079Z","caller":"embed/serve.go:100","msg":"ready to serve client requests"}
{"level":"info","ts":"2023-09-08T03:00:21.079Z","caller":"etcdmain/main.go:44","msg":"notifying init daemon"}
{"level":"info","ts":"2023-09-08T03:00:21.079Z","caller":"etcdmain/main.go:50","msg":"successfully notified init daemon"}
{"level":"fatal","ts":"2023-09-08T03:00:21.079Z","caller":"etcdmain/etcd.go:219","msg":"listener failed","error":"open /etc/kubernetes/pki/etcd/server-certificate.crt: no such file or directory","stacktrace":"go.etcd.io/etcd/server/v3/etcdmain.startEtcdOrProxyV2\n\tgo.etcd.io/etcd/server/v3/etcdmain/etcd.go:219\ngo.etcd.io/etcd/server/v3/etcdmain.Main\n\tgo.etcd.io/etcd/server/v3/etcdmain/main.go:40\nmain.main\n\tgo.etcd.io/etcd/server/v3/main.go:32\nruntime.main\n\truntime/proc.go:255"}

controlplane ~ ➜  









{"level":"warn","ts":"2023-09-08T03:00:19.379Z","caller":"auth/store.go:1234","msg":"simple token is not cryptographically signed"}


{"level":"fatal","ts":"2023-09-08T03:00:21.079Z","caller":"etcdmain/etcd.go:219","msg":"listener failed","error":"open /etc/kubernetes/pki/etcd/server-certificate.crt: no such file or directory","stacktrace":"go.etcd.io/etcd/server/v3/etcdmain.startEtcdOrProxyV2\n\tgo.etcd.io/etcd/server/v3/etcdmain/etcd.go:219\ngo.etcd.io/etcd/server/v3/etcdmain.Main\n\tgo.etcd.io/etcd/server/v3/etcdmain/main.go:40\nmain.main\n\tgo.etcd.io/etcd/server/v3/main.go:32\nruntime.main\n\truntime/proc.go:255"}



"msg":"listener failed","error":"open /etc/kubernetes/pki/etcd/server-certificate.crt: no such file or directory"




- O manifesto tá com esta configuração errada, que deve estar gerando o problema:
    - --cert-file=/etc/kubernetes/pki/etcd/server-certificate.crt


- Via ps-ef, antes estava assim:
--cert-file=/etc/kubernetes/pki/etcd/server.crt



- Ajustando:
vi /etc/kubernetes/manifests/etcd.yaml 


cat /etc/kubernetes/manifests/etcd.yaml 



controlplane ~ ➜  cat /etc/kubernetes/manifests/etcd.yaml 
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/etcd.advertise-client-urls: https://192.4.121.9:2379
  creationTimestamp: null
  labels:
    component: etcd
    tier: control-plane
  name: etcd
  namespace: kube-system
spec:
  containers:
  - command:
    - etcd
    - --advertise-client-urls=https://192.4.121.9:2379
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt
    - --client-cert-auth=true
    - --data-dir=/var/lib/etcd
    - --experimental-initial-corrupt-check=true
    - --experimental-watch-progress-notify-interval=5s
    - --initial-advertise-peer-urls=https://192.4.121.9:2380
    - --initial-cluster=controlplane=https://192.4.121.9:2380
    - --key-file=/etc/kubernetes/pki/etcd/server.key
    - --listen-client-urls=https://127.0.0.1:2379,https://192.4.121.9:2379
    - --listen-metrics-urls=http://127.0.0.1:2381
    - --listen-peer-urls=https://192.4.121.9:2380
    - --name=controlplane
    - --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
    - --peer-client-cert-auth=true
    - --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
    - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    - --snapshot-count=10000
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    image: registry.k8s.io/etcd:3.5.7-0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /health?exclude=NOSPACE&serializable=true
        port: 2381
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: etcd
    resources:
      requests:
        cpu: 100m
        memory: 100Mi
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /health?serializable=false
        port: 2381
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /var/lib/etcd
      name: etcd-data
    - mountPath: /etc/kubernetes/pki/etcd
      name: etcd-certs
  hostNetwork: true
  priority: 2000001000
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/kubernetes/pki/etcd
      type: DirectoryOrCreate
    name: etcd-certs
  - hostPath:
      path: /var/lib/etcd
      type: DirectoryOrCreate
    name: etcd-data
status: {}

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods
The connection to the server controlplane:6443 was refused - did you specify the right host or port?

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ kubectl get pods
The connection to the server controlplane:6443 was refused - did you specify the right host or port?

controlplane ~ ✖ crictl ps -a
CONTAINER           IMAGE               CREATED             STATE               NAME                      ATTEMPT             POD ID              POD
9d11b273e09a3       86b6af7dd652c       13 seconds ago      Running             etcd                      0                   c6c15ac3eba16       etcd-controlplane
77f5299cdc439       6f707f569b572       4 minutes ago       Exited              kube-apiserver            7                   6b5c6018d8b95       kube-apiserver-controlplane
0e65cc7d63b5f       f73f1b39c3fe8       14 minutes ago      Running             kube-scheduler            1                   38f8e2ecafcc5       kube-scheduler-controlplane
eee8ec45c0b50       95fe52ed44570       14 minutes ago      Running             kube-controller-manager   1                   c482bafd666a9       kube-controller-manager-controlplane
08b4b523818b7       ead0a4a53df89       42 minutes ago      Running             coredns                   0                   49d5002026258       coredns-5d78c9869d-jzvdm
30442ee048708       ead0a4a53df89       42 minutes ago      Running             coredns                   0                   06e4287a9b47a       coredns-5d78c9869d-9cs6z
c5706cff92963       8b675dda11bb1       42 minutes ago      Running             kube-flannel              0                   89bcdc505fcd5       kube-flannel-ds-842v9
d1deb07ceaa4d       8b675dda11bb1       42 minutes ago      Exited              install-cni               0                   89bcdc505fcd5       kube-flannel-ds-842v9
45fce4591ad72       fcecffc7ad4af       42 minutes ago      Exited              install-cni-plugin        0                   89bcdc505fcd5       kube-flannel-ds-842v9
29c0dbf756976       5f82fc39fa816       43 minutes ago      Running             kube-proxy                0                   9eb04025e0e11       kube-proxy-bq69z
3d8480d72e91c       f73f1b39c3fe8       43 minutes ago      Exited              kube-scheduler            0                   38f8e2ecafcc5       kube-scheduler-controlplane
e13196ea86605       95fe52ed44570       43 minutes ago      Exited              kube-controller-manager   0                   c482bafd666a9       kube-controller-manager-controlplane

controlplane ~ ➜  date
Thu 07 Sep 2023 11:07:11 PM EDT

controlplane ~ ➜  kubectl get pods
The connection to the server controlplane:6443 was refused - did you specify the right host or port?

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ crictl ps -a
CONTAINER           IMAGE               CREATED             STATE               NAME                      ATTEMPT             POD ID              POD
9d11b273e09a3       86b6af7dd652c       37 seconds ago      Running             etcd                      0                   c6c15ac3eba16       etcd-controlplane
77f5299cdc439       6f707f569b572       5 minutes ago       Exited              kube-apiserver            7                   6b5c6018d8b95       kube-apiserver-controlplane
0e65cc7d63b5f       f73f1b39c3fe8       14 minutes ago      Running             kube-scheduler            1                   38f8e2ecafcc5       kube-scheduler-controlplane
eee8ec45c0b50       95fe52ed44570       14 minutes ago      Running             kube-controller-manager   1                   c482bafd666a9       kube-controller-manager-controlplane
08b4b523818b7       ead0a4a53df89       43 minutes ago      Running             coredns                   0                   49d5002026258       coredns-5d78c9869d-jzvdm
30442ee048708       ead0a4a53df89       43 minutes ago      Running             coredns                   0                   06e4287a9b47a       coredns-5d78c9869d-9cs6z
c5706cff92963       8b675dda11bb1       43 minutes ago      Running             kube-flannel              0                   89bcdc505fcd5       kube-flannel-ds-842v9
d1deb07ceaa4d       8b675dda11bb1       43 minutes ago      Exited              install-cni               0                   89bcdc505fcd5       kube-flannel-ds-842v9
45fce4591ad72       fcecffc7ad4af       43 minutes ago      Exited              install-cni-plugin        0                   89bcdc505fcd5       kube-flannel-ds-842v9
29c0dbf756976       5f82fc39fa816       43 minutes ago      Running             kube-proxy                0                   9eb04025e0e11       kube-proxy-bq69z
3d8480d72e91c       f73f1b39c3fe8       43 minutes ago      Exited              kube-scheduler            0                   38f8e2ecafcc5       kube-scheduler-controlplane
e13196ea86605       95fe52ed44570       43 minutes ago      Exited              kube-controller-manager   0                   c482bafd666a9       kube-controller-manager-controlplane

controlplane ~ ➜  



- Ainda não está OK o kubectl
- Verificando






controlplane ~ ➜  crictl ps -a
CONTAINER           IMAGE               CREATED              STATE               NAME                      ATTEMPT             POD ID              POD
fd3566e37f157       6f707f569b572       About a minute ago   Running             kube-apiserver            8                   6b5c6018d8b95       kube-apiserver-controlplane
9d11b273e09a3       86b6af7dd652c       2 minutes ago        Running             etcd                      0                   c6c15ac3eba16       etcd-controlplane
77f5299cdc439       6f707f569b572       6 minutes ago        Exited              kube-apiserver            7                   6b5c6018d8b95       kube-apiserver-controlplane
0e65cc7d63b5f       f73f1b39c3fe8       16 minutes ago       Running             kube-scheduler            1                   38f8e2ecafcc5       kube-scheduler-controlplane
eee8ec45c0b50       95fe52ed44570       16 minutes ago       Running             kube-controller-manager   1                   c482bafd666a9       kube-controller-manager-controlplane
08b4b523818b7       ead0a4a53df89       44 minutes ago       Running             coredns                   0                   49d5002026258       coredns-5d78c9869d-jzvdm
30442ee048708       ead0a4a53df89       44 minutes ago       Running             coredns                   0                   06e4287a9b47a       coredns-5d78c9869d-9cs6z
c5706cff92963       8b675dda11bb1       44 minutes ago       Running             kube-flannel              0                   89bcdc505fcd5       kube-flannel-ds-842v9
d1deb07ceaa4d       8b675dda11bb1       44 minutes ago       Exited              install-cni               0                   89bcdc505fcd5       kube-flannel-ds-842v9
45fce4591ad72       fcecffc7ad4af       44 minutes ago       Exited              install-cni-plugin        0                   89bcdc505fcd5       kube-flannel-ds-842v9
29c0dbf756976       5f82fc39fa816       44 minutes ago       Running             kube-proxy                0                   9eb04025e0e11       kube-proxy-bq69z
3d8480d72e91c       f73f1b39c3fe8       45 minutes ago       Exited              kube-scheduler            0                   38f8e2ecafcc5       kube-scheduler-controlplane
e13196ea86605       95fe52ed44570       45 minutes ago       Exited              kube-controller-manager   0                   c482bafd666a9       kube-controller-manager-controlplane

controlplane ~ ➜  date
Thu 07 Sep 2023 11:09:09 PM EDT

controlplane ~ ➜  




- Agora normalizou


controlplane ~ ➜  kubectl get pods
No resources found in default namespace.

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS        AGE
kube-flannel   kube-flannel-ds-842v9                  1/1     Running   0               45m
kube-system    coredns-5d78c9869d-9cs6z               1/1     Running   0               45m
kube-system    coredns-5d78c9869d-jzvdm               1/1     Running   0               45m
kube-system    etcd-controlplane                      1/1     Running   0               45m
kube-system    kube-apiserver-controlplane            1/1     Running   8 (6m57s ago)   45m
kube-system    kube-controller-manager-controlplane   1/1     Running   1 (16m ago)     45m
kube-system    kube-proxy-bq69z                       1/1     Running   0               45m
kube-system    kube-scheduler-controlplane            1/1     Running   1 (16m ago)     45m

controlplane ~ ➜  date
Thu 07 Sep 2023 11:09:28 PM EDT

controlplane ~ ➜  
















 
The kube-api server stopped again! Check it out. Inspect the kube-api server logs and identify the root cause and fix the issue.

Run crictl ps -a command to identify the kube-api server container. Run crictl logs container-id command to view the logs.

    Fix the kube-api server




controlplane ~ ➜  kubectl get pods -A
The connection to the server controlplane:6443 was refused - did you specify the right host or port?

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ crictl ps -a
CONTAINER           IMAGE               CREATED             STATE               NAME                      ATTEMPT             POD ID              POD
89c225087057b       f73f1b39c3fe8       27 seconds ago      Running             kube-scheduler            2                   38f8e2ecafcc5       kube-scheduler-controlplane
eb7725fb4113f       95fe52ed44570       27 seconds ago      Running             kube-controller-manager   2                   c482bafd666a9       kube-controller-manager-controlplane
9d11b273e09a3       86b6af7dd652c       3 minutes ago       Running             etcd                      0                   c6c15ac3eba16       etcd-controlplane
0e65cc7d63b5f       f73f1b39c3fe8       17 minutes ago      Exited              kube-scheduler            1                   38f8e2ecafcc5       kube-scheduler-controlplane
eee8ec45c0b50       95fe52ed44570       17 minutes ago      Exited              kube-controller-manager   1                   c482bafd666a9       kube-controller-manager-controlplane
08b4b523818b7       ead0a4a53df89       46 minutes ago      Running             coredns                   0                   49d5002026258       coredns-5d78c9869d-jzvdm
30442ee048708       ead0a4a53df89       46 minutes ago      Running             coredns                   0                   06e4287a9b47a       coredns-5d78c9869d-9cs6z
c5706cff92963       8b675dda11bb1       46 minutes ago      Running             kube-flannel              0                   89bcdc505fcd5       kube-flannel-ds-842v9
d1deb07ceaa4d       8b675dda11bb1       46 minutes ago      Exited              install-cni               0                   89bcdc505fcd5       kube-flannel-ds-842v9
45fce4591ad72       fcecffc7ad4af       46 minutes ago      Exited              install-cni-plugin        0                   89bcdc505fcd5       kube-flannel-ds-842v9
29c0dbf756976       5f82fc39fa816       46 minutes ago      Running             kube-proxy                0                   9eb04025e0e11       kube-proxy-bq69z

controlplane ~ ➜  


controlplane ~ ✖ crictl pods
POD ID              CREATED             STATE               NAME                                   NAMESPACE           ATTEMPT             RUNTIME
80f868001db71       38 seconds ago      Ready               kube-apiserver-controlplane            kube-system         0                   (default)
c6c15ac3eba16       4 minutes ago       Ready               etcd-controlplane                      kube-system         0                   (default)
49d5002026258       46 minutes ago      Ready               coredns-5d78c9869d-jzvdm               kube-system         0                   (default)
06e4287a9b47a       46 minutes ago      Ready               coredns-5d78c9869d-9cs6z               kube-system         0                   (default)
9eb04025e0e11       47 minutes ago      Ready               kube-proxy-bq69z                       kube-system         0                   (default)
89bcdc505fcd5       47 minutes ago      Ready               kube-flannel-ds-842v9                  kube-flannel        0                   (default)
38f8e2ecafcc5       47 minutes ago      Ready               kube-scheduler-controlplane            kube-system         0                   (default)
c482bafd666a9       47 minutes ago      Ready               kube-controller-manager-controlplane   kube-system         0                   (default)

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  crictl ps -a
CONTAINER           IMAGE               CREATED              STATE               NAME                      ATTEMPT             POD ID              POD
91626737ddcbd       6f707f569b572       23 seconds ago       Exited              kube-apiserver            1                   80f868001db71       kube-apiserver-controlplane
89c225087057b       f73f1b39c3fe8       About a minute ago   Running             kube-scheduler            2                   38f8e2ecafcc5       kube-scheduler-controlplane
eb7725fb4113f       95fe52ed44570       About a minute ago   Running             kube-controller-manager   2                   c482bafd666a9       kube-controller-manager-controlplane
9d11b273e09a3       86b6af7dd652c       4 minutes ago        Running             etcd                      0                   c6c15ac3eba16       etcd-controlplane
0e65cc7d63b5f       f73f1b39c3fe8       18 minutes ago       Exited              kube-scheduler            1                   38f8e2ecafcc5       kube-scheduler-controlplane
eee8ec45c0b50       95fe52ed44570       18 minutes ago       Exited              kube-controller-manager   1                   c482bafd666a9       kube-controller-manager-controlplane
08b4b523818b7       ead0a4a53df89       46 minutes ago       Running             coredns                   0                   49d5002026258       coredns-5d78c9869d-jzvdm
30442ee048708       ead0a4a53df89       46 minutes ago       Running             coredns                   0                   06e4287a9b47a       coredns-5d78c9869d-9cs6z
c5706cff92963       8b675dda11bb1       47 minutes ago       Running             kube-flannel              0                   89bcdc505fcd5       kube-flannel-ds-842v9
d1deb07ceaa4d       8b675dda11bb1       47 minutes ago       Exited              install-cni               0                   89bcdc505fcd5       kube-flannel-ds-842v9
45fce4591ad72       fcecffc7ad4af       47 minutes ago       Exited              install-cni-plugin        0                   89bcdc505fcd5       kube-flannel-ds-842v9
29c0dbf756976       5f82fc39fa816       47 minutes ago       Running             kube-proxy                0                   9eb04025e0e11       kube-proxy-bq69z

controlplane ~ ➜  



crictl logs 91626737ddcbd

controlplane ~ ➜  crictl logs 91626737ddcbd
I0908 03:10:49.180369       1 server.go:551] external host was not specified, using 192.4.121.9
I0908 03:10:49.181645       1 server.go:165] Version: v1.27.0
I0908 03:10:49.181674       1 server.go:167] "Golang settings" GOGC="" GOMAXPROCS="" GOTRACEBACK=""
I0908 03:10:49.565023       1 shared_informer.go:311] Waiting for caches to sync for node_authorizer
I0908 03:10:49.581740       1 plugins.go:158] Loaded 12 mutating admission controller(s) successfully in the following order: NamespaceLifecycle,LimitRanger,ServiceAccount,NodeRestriction,TaintNodesByCondition,Priority,DefaultTolerationSeconds,DefaultStorageClass,StorageObjectInUseProtection,RuntimeClass,DefaultIngressClass,MutatingAdmissionWebhook.
I0908 03:10:49.581774       1 plugins.go:161] Loaded 13 validating admission controller(s) successfully in the following order: LimitRanger,ServiceAccount,PodSecurity,Priority,PersistentVolumeClaimResize,RuntimeClass,CertificateApproval,CertificateSigning,ClusterTrustBundleAttest,CertificateSubjectRestriction,ValidatingAdmissionPolicy,ValidatingAdmissionWebhook,ResourceQuota.
W0908 03:10:49.630649       1 logging.go:59] [core] [Channel #1 SubChannel #2] grpc: addrConn.createTransport failed to connect to {
  "Addr": "127.0.0.1:2379",
  "ServerName": "127.0.0.1",
  "Attributes": null,
  "BalancerAttributes": null,
  "Type": 0,
  "Metadata": null
}. Err: connection error: desc = "transport: authentication handshake failed: tls: failed to verify certificate: x509: certificate signed by unknown authority"
W0908 03:11:00.054672       1 logging.go:59] [core] [Channel #4 SubChannel #5] grpc: addrConn.createTransport failed to connect to {
  "Addr": "127.0.0.1:2379",
  "ServerName": "127.0.0.1",
  "Attributes": null,
  "BalancerAttributes": null,
  "Type": 0,
  "Metadata": null
}. Err: connection error: desc = "transport: authentication handshake failed: tls: failed to verify certificate: x509: certificate signed by unknown authority"
W0908 03:11:00.658950       1 logging.go:59] [core] [Channel #3 SubChannel #6] grpc: addrConn.createTransport failed to connect to {
  "Addr": "127.0.0.1:2379",
  "ServerName": "127.0.0.1",
  "Attributes": null,
  "BalancerAttributes": null,
  "Type": 0,
  "Metadata": null
}. Err: connection error: desc = "transport: authentication handshake failed: tls: failed to verify certificate: x509: certificate signed by unknown authority"
W0908 03:11:06.511710       1 logging.go:59] [core] [Channel #4 SubChannel #5] grpc: addrConn.createTransport failed to connect to {
  "Addr": "127.0.0.1:2379",
  "ServerName": "127.0.0.1",
  "Attributes": null,
  "BalancerAttributes": null,
  "Type": 0,
  "Metadata": null
}. Err: connection error: desc = "transport: authentication handshake failed: tls: failed to verify certificate: x509: certificate signed by unknown authority"
W0908 03:11:06.765546       1 logging.go:59] [core] [Channel #1 SubChannel #2] grpc: addrConn.createTransport failed to connect to {
  "Addr": "127.0.0.1:2379",
  "ServerName": "127.0.0.1",
  "Attributes": null,
  "BalancerAttributes": null,
  "Type": 0,
  "Metadata": null
}. Err: connection error: desc = "transport: authentication handshake failed: tls: failed to verify certificate: x509: certificate signed by unknown authority"
W0908 03:11:07.476000       1 logging.go:59] [core] [Channel #3 SubChannel #6] grpc: addrConn.createTransport failed to connect to {
  "Addr": "127.0.0.1:2379",
  "ServerName": "127.0.0.1",
  "Attributes": null,
  "BalancerAttributes": null,
  "Type": 0,
  "Metadata": null
}. Err: connection error: desc = "transport: authentication handshake failed: tls: failed to verify certificate: x509: certificate signed by unknown authority"
E0908 03:11:09.628092       1 run.go:74] "command failed" err="context deadline exceeded"

controlplane ~ ➜  






authentication handshake failed: tls: failed to verify certificate: x509: certificate signed by unknown authority




controlplane ~ ➜  cd /etc/kubernetes/manifests/

controlplane /etc/kubernetes/manifests ➜  ls
etcd.yaml  kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml

controlplane /etc/kubernetes/manifests ➜  cat kube-apiserver.yaml 
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 192.4.121.9:6443
  creationTimestamp: null
  labels:
    component: kube-apiserver
    tier: control-plane
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
    - --advertise-address=192.4.121.9
    - --allow-privileged=true
    - --authorization-mode=Node,RBAC
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --enable-admission-plugins=NodeRestriction
    - --enable-bootstrap-token-auth=true
    - --etcd-cafile=/etc/kubernetes/pki/ca.crt
    - --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
    - --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key
    - --etcd-servers=https://127.0.0.1:2379
    - --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt
    - --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key
    - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
    - --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt
    - --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key
    - --requestheader-allowed-names=front-proxy-client
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --requestheader-extra-headers-prefix=X-Remote-Extra-
    - --requestheader-group-headers=X-Remote-Group
    - --requestheader-username-headers=X-Remote-User
    - --secure-port=6443
    - --service-account-issuer=https://kubernetes.default.svc.cluster.local
    - --service-account-key-file=/etc/kubernetes/pki/sa.pub
    - --service-account-signing-key-file=/etc/kubernetes/pki/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --tls-cert-file=/etc/kubernetes/pki/apiserver.crt
    - --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
    image: registry.k8s.io/kube-apiserver:v1.27.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 192.4.121.9
        path: /livez
        port: 6443
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-apiserver
    readinessProbe:
      failureThreshold: 3
      httpGet:
        host: 192.4.121.9
        path: /readyz
        port: 6443
        scheme: HTTPS
      periodSeconds: 1
      timeoutSeconds: 15
    resources:
      requests:
        cpu: 250m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 192.4.121.9
        path: /livez
        port: 6443
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /etc/ssl/certs
      name: ca-certs
      readOnly: true
    - mountPath: /etc/ca-certificates
      name: etc-ca-certificates
      readOnly: true
    - mountPath: /etc/kubernetes/pki
      name: k8s-certs
      readOnly: true
    - mountPath: /usr/local/share/ca-certificates
      name: usr-local-share-ca-certificates
      readOnly: true
    - mountPath: /usr/share/ca-certificates
      name: usr-share-ca-certificates
      readOnly: true
  hostNetwork: true
  priority: 2000001000
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/ssl/certs
      type: DirectoryOrCreate
    name: ca-certs
  - hostPath:
      path: /etc/ca-certificates
      type: DirectoryOrCreate
    name: etc-ca-certificates
  - hostPath:
      path: /etc/kubernetes/pki
      type: DirectoryOrCreate
    name: k8s-certs
  - hostPath:
      path: /usr/local/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-local-share-ca-certificates
  - hostPath:
      path: /usr/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-share-ca-certificates
status: {}

controlplane /etc/kubernetes/manifests ➜  






openssl x509 -in /etc/kubernetes/pki/ca.crt -text -noout


controlplane /etc/kubernetes/manifests ➜  openssl x509 -in /etc/kubernetes/pki/ca.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 0 (0x0)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = kubernetes
        Validity
            Not Before: Sep  8 02:23:32 2023 GMT
            Not After : Sep  5 02:23:32 2033 GMT
        Subject: CN = kubernetes
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:b5:79:9a:33:d9:8f:7e:cf:73:b5:2f:16:80:63:
                    c0:8d:a3:1b:bd:0e:d9:a1:55:35:f8:02:45:6b:17:
                    91:66:13:60:ba:2d:73:33:ec:f8:e3:d5:00:96:d5:
                    c9:52:6a:42:24:9b:e6:66:7b:49:e4:ed:63:95:5f:
                    16:a2:4b:92:d9:51:f5:96:e9:05:f8:7c:47:41:16:
                    e2:0a:29:2f:fc:52:18:43:60:70:2c:f3:67:54:67:
                    31:0f:32:53:85:4f:c4:d4:32:9c:a1:58:19:ca:f1:
                    68:69:f8:17:4f:47:7c:85:3c:c9:91:59:d2:af:e7:
                    9c:e2:45:a6:36:28:3f:d9:8d:37:ea:b7:b1:39:34:
                    9b:39:7d:33:4a:34:3b:c1:f1:71:32:53:b0:68:6c:
                    d3:76:1f:08:fa:d4:50:a4:dd:f6:1f:53:c6:07:2f:
                    93:07:b8:f9:08:05:fa:b7:fd:a4:7b:00:9d:d6:e9:
                    7b:f1:18:ba:fd:61:f4:1d:90:74:ab:86:7c:92:7c:
                    33:d2:0c:c9:e5:2a:92:c1:a8:ca:2b:4c:45:b9:1c:
                    16:28:31:ba:96:b8:2e:85:0a:05:39:4a:46:40:79:
                    70:26:ba:8c:24:08:1a:f4:8a:9b:63:30:26:cd:00:
                    15:89:e6:fc:0f:19:98:1a:79:ce:60:93:bb:8a:75:
                    9f:85
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment, Certificate Sign
            X509v3 Basic Constraints: critical
                CA:TRUE
            X509v3 Subject Key Identifier: 
                8F:7E:00:F0:0F:BD:E3:1F:9E:C6:10:69:23:69:FE:48:09:6E:3C:02
            X509v3 Subject Alternative Name: 
                DNS:kubernetes
    Signature Algorithm: sha256WithRSAEncryption
         20:31:ba:51:5b:4e:67:83:6c:47:02:a4:67:46:cb:c4:7b:90:
         c5:a2:f1:24:5b:cb:a0:fe:58:4c:49:ce:81:42:7a:d1:f5:04:
         c7:6c:b2:db:cc:b0:85:2f:64:b0:17:ad:76:47:db:5d:e9:5d:
         ea:13:d0:c0:1b:04:98:fe:07:6b:61:95:43:cf:fc:50:95:d0:
         89:e8:b3:46:f6:68:eb:18:6f:bf:3a:cb:78:7d:ee:35:08:83:
         3b:6e:b1:53:e0:6d:46:82:63:74:45:9d:50:88:32:b4:54:c7:
         db:87:26:47:54:d4:53:b3:fa:38:a4:d7:d4:82:f3:97:ba:15:
         b4:e3:aa:15:51:27:5c:38:37:a7:76:dc:a9:15:f3:a7:ba:ea:
         00:73:05:17:77:ba:ec:b1:fe:79:c2:e7:ff:32:bb:e4:49:28:
         01:09:29:cb:8a:5c:d4:e6:40:5c:a1:4e:54:ce:12:23:ae:0d:
         0d:0d:b5:b5:a9:f1:7f:23:08:12:14:4c:df:08:56:fb:c9:18:
         17:55:d1:1b:3c:fc:03:2b:53:38:c6:b4:90:31:06:6f:fc:ce:
         04:3f:a2:bd:12:86:7f:2e:bf:d7:ee:b6:60:e7:30:89:ae:83:
         2d:9a:fe:0c:3e:a5:1f:16:d4:ed:29:31:1e:ca:99:59:35:90:
         ca:39:e8:06

controlplane /etc/kubernetes/manifests ➜  




https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/
<https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/>



- Antes, via ps-ef estava assim o kube-apiserver:

controlplane ~ ➜  ps -ef | grep api
root        3515    3047  0 22:23 ?        00:00:35 kube-apiserver --advertise-address=192.4.121.9 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root        8435    8194  0 22:35 pts/0    00:00:00 grep --color=auto api

controlplane ~ ➜  


- Ajustar a etcd-cafile

- ANTES: 
    - --etcd-cafile=/etc/kubernetes/pki/ca.crt
- DEPOIS:
      --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt 



controlplane /etc/kubernetes/manifests ➜  vi kube-apiserver.yaml 

controlplane /etc/kubernetes/manifests ➜  

controlplane /etc/kubernetes/manifests ➜  

controlplane /etc/kubernetes/manifests ➜  

controlplane /etc/kubernetes/manifests ➜  date
Thu 07 Sep 2023 11:21:03 PM EDT

controlplane /etc/kubernetes/manifests ➜  


controlplane /etc/kubernetes/manifests ➜  crictl ps -a
CONTAINER           IMAGE               CREATED             STATE               NAME                      ATTEMPT             POD ID              POD
906cccd65e7ab       6f707f569b572       8 seconds ago       Running             kube-apiserver            0                   241a85e0c8d5c       kube-apiserver-controlplane
fb1690b1b5d5c       6f707f569b572       3 minutes ago       Exited              kube-apiserver            6                   80f868001db71       kube-apiserver-controlplane
89c225087057b       f73f1b39c3fe8       11 minutes ago      Running             kube-scheduler            2                   38f8e2ecafcc5       kube-scheduler-controlplane
eb7725fb4113f       95fe52ed44570       11 minutes ago      Running             kube-controller-manager   2                   c482bafd666a9       kube-controller-manager-controlplane
9d11b273e09a3       86b6af7dd652c       14 minutes ago      Running             etcd                      0                   c6c15ac3eba16       etcd-controlplane
0e65cc7d63b5f       f73f1b39c3fe8       28 minutes ago      Exited              kube-scheduler            1                   38f8e2ecafcc5       kube-scheduler-controlplane
eee8ec45c0b50       95fe52ed44570       28 minutes ago      Exited              kube-controller-manager   1                   c482bafd666a9       kube-controller-manager-controlplane
08b4b523818b7       ead0a4a53df89       56 minutes ago      Running             coredns                   0                   49d5002026258       coredns-5d78c9869d-jzvdm
30442ee048708       ead0a4a53df89       56 minutes ago      Running             coredns                   0                   06e4287a9b47a       coredns-5d78c9869d-9cs6z
c5706cff92963       8b675dda11bb1       57 minutes ago      Running             kube-flannel              0                   89bcdc505fcd5       kube-flannel-ds-842v9
d1deb07ceaa4d       8b675dda11bb1       57 minutes ago      Exited              install-cni               0                   89bcdc505fcd5       kube-flannel-ds-842v9
45fce4591ad72       fcecffc7ad4af       57 minutes ago      Exited              install-cni-plugin        0                   89bcdc505fcd5       kube-flannel-ds-842v9
29c0dbf756976       5f82fc39fa816       57 minutes ago      Running             kube-proxy                0                   9eb04025e0e11       kube-proxy-bq69z

controlplane /etc/kubernetes/manifests ➜  date
Thu 07 Sep 2023 11:21:21 PM EDT

controlplane /etc/kubernetes/manifests ➜  

controlplane /etc/kubernetes/manifests ➜  kubectl get pods
No resources found in default namespace.

controlplane /etc/kubernetes/manifests ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS      AGE
kube-flannel   kube-flannel-ds-842v9                  1/1     Running   0             57m
kube-system    coredns-5d78c9869d-9cs6z               1/1     Running   0             57m
kube-system    coredns-5d78c9869d-jzvdm               1/1     Running   0             57m
kube-system    etcd-controlplane                      1/1     Running   0             57m
kube-system    kube-apiserver-controlplane            1/1     Running   0             57m
kube-system    kube-controller-manager-controlplane   1/1     Running   2 (11m ago)   57m
kube-system    kube-proxy-bq69z                       1/1     Running   0             57m
kube-system    kube-scheduler-controlplane            1/1     Running   2 (11m ago)   57m

controlplane /etc/kubernetes/manifests ➜  