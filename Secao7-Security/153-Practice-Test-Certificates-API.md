

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "153. Practice Test - Certificates API."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
#  153. Practice Test - Certificates API

A new member akshay joined our team. He requires access to our cluster. The Certificate Signing Request is at the /root location.

Inspect it


controlplane ~ ➜  ls
akshay.csr  akshay.key

controlplane ~ ➜  pwd
/root

controlplane ~ ➜  




controlplane ~ ➜  cat akshay.csr
-----BEGIN CERTIFICATE REQUEST-----
MIICVjCCAT4CAQAwETEPMA0GA1UEAwwGYWtzaGF5MIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAu3HzimPV+5KyOqygzEXrUG/crTan/Hi9IneUVja4ZAB2
nlGC2mHm4BorKMmgmR9bfyGX1Ssmzg6UjGncURa0aJwhn5Pp7SkuVg0bT91nofvv
fIep1WdTvHQ03QhSL4YKvfIXqkKEdVeAj4PCCXIgJPLoWOIz/wAtdMBRBfNNkWc6
sTPdLKKCie/6svH5MHE+TjVcDfSMDqj3cuf7Ng2Ly4rS311nBUTaYobK3+sFy8YR
RXyCX7ZnRqA4twBRxjG+f6GfqaEnTAj0IDvBISSprEamTnNuZ7lX3bmL9GVdDuo/
MHZ4EOnGH5enPTAP2NR8I7JRvK4aK5/dpH6U5ped6QIDAQABoAAwDQYJKoZIhvcN
AQELBQADggEBAEBsKBt3x14XjJpMRSgdrYgK4WLR6Z0VUS/rr3GJAhnWiyckWg/9
d3xoDSbqzvtOnO3LtkryaiD3U4blQgU9sz5vqBffTJkOFhxNpc81ezGlp76Y2lTa
KbIusSYMFBSacL6grDucOSewI4XS5qMZfsm0L/cs/EEsKl4J0grnWZojuzqaa580
tjVH2Y5FXT8ssNs2OJ7VehohOJ5VuwFJG0HzJ88S6HnLEE2q6eRyI/1qdpy6G84p
FrFPrDLLwvpS+DweTttcz8Cyd8aITFoEBQPZpwFD0ViCgK8VxqdsL7IRRmXdDUn1
r7oHLee7v8MuGhXTmq44OMbD0dQT4JWibZo=
-----END CERTIFICATE REQUEST-----

controlplane ~ ➜  

controlplane ~ ➜  cat akshay.key
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAu3HzimPV+5KyOqygzEXrUG/crTan/Hi9IneUVja4ZAB2nlGC
2mHm4BorKMmgmR9bfyGX1Ssmzg6UjGncURa0aJwhn5Pp7SkuVg0bT91nofvvfIep
1WdTvHQ03QhSL4YKvfIXqkKEdVeAj4PCCXIgJPLoWOIz/wAtdMBRBfNNkWc6sTPd
LKKCie/6svH5MHE+TjVcDfSMDqj3cuf7Ng2Ly4rS311nBUTaYobK3+sFy8YRRXyC
X7ZnRqA4twBRxjG+f6GfqaEnTAj0IDvBISSprEamTnNuZ7lX3bmL9GVdDuo/MHZ4
EOnGH5enPTAP2NR8I7JRvK4aK5/dpH6U5ped6QIDAQABAoIBADzDgtyA4rQr6OUG
YxX1MIQhzxrDlg9NIJrUwtxz3rBkSg+mgtHCXPKW6RjOy+X3eVSsEilDVNAFf/hI
tOgAgTlMK8YsT+/WorO4ifsI3fhv0EHBRLfuSAHWdfCVKvdG76KFoVBLQd88H2vm
nXcsbOktaU6u/YYTi6jGUz2nkqSokSLW3TZe9uhr/xuQRUXprfQ1/ocWl7SO1ba+
FaHKsdbYpmyIgH77M25iz5HsxdguUuPOgM3YuuwNT7T/JR+6w9Ej+lu6/oLiCMvH
iZ1jGaJDV+9PHaeh8azzYM0Zkq5uelN79LcbQXzfAktIcXu/ZhFynKj3N1UYyDRP
9MnwXVECgYEA2170v9sYMWa8v1SPZSaCST5oA8m/uviUnioHXakV7aiqSeDk0A4p
6XY4Rx5v+/RtNQ645sHUspLLWwp6ceJkffBf1UbT+bxBMc6wrqh8fsW5lD34xfuW
fx7N6cclQqiR3UKHGkreF7EBgZmAlYd/VJMfJBMYqqWVrgeW2qa9Ik0CgYEA2r5S
cSJ+0WdqbRRuKQJqNIejkipJGWVWUZPtM/unVW7GApNDmAs+iBHjLLwQ6vU3fkJj
M4y0QacXinc3S7a8i2DnTUmWvuWa6ci/s4sMaQ/GJgXvU04Tk2NK2tFLDAxd5GsO
xylG4BaLQ5RyDN3AYHEtPzx8SK7Z9Ww+61qgYA0CgYBtz5yopV347Lqy8/tL4Pj6
/RhIPSeSynhqrBM/2TI242VK0h733v8v9JO7VgssjnBUTOhV6tU0BrNxAU/FzlQL
jtYKBwh5TLk9238qDwEy3HtHL7ZmNMhjHeJpkdye/470uSa0DKIcLejZHSP2tfsR
NQwznLOOSJEiqn3jOfAXSQKBgDhwzzjd27cQZgeLM/lk5B51uSDnxEDHQwR9lMDK
+Bw1HuZfNRuwGwxlASbzx7G4X/82Bf6xGXmvMYXKyPvCRNf5wvTQPhM3j0cvQzeC
c0tQhKIe+eeWx7pJ7nCTfDe5oShk70U4Q09iwcBINz1WomLAERq18qOWairHKVz0
bc1qzk3kxhdxnzkpdgdn9ueg34y08smxgfv0hxvcu3/ULJr/c4/xAJt9ZY9j6zCv
HQRUznYc83zUzwES5iPJ9jyMcxyJY+DAvMlXq7VFTvu/bfoNVGudIE+BTX16c67V
P6pZqQPRxGPy6h3P9Hn5DwZL5esn5ZkaYNcqMvpmlyGnj8+1+x4=
-----END RSA PRIVATE KEY-----

controlplane ~ ➜  
















Create a CertificateSigningRequest object with the name akshay with the contents of the akshay.csr file

As of kubernetes 1.19, the API to use for CSR is certificates.k8s.io/v1.

Please note that an additional field called signerName should also be added when creating CSR. For client authentication to the API server we will use the built-in signer kubernetes.io/kube-apiserver-client.

    CSR akshay created

    Right CSR is used





Create a CertificateSigningRequest

Create a CertificateSigningRequest and submit it to a Kubernetes Cluster via kubectl. Below is a script to generate the CertificateSigningRequest.

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: myuser
spec:
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZVzVuWld4aE1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQTByczhJTHRHdTYxakx2dHhWTTJSVlRWMDNHWlJTWWw0dWluVWo4RElaWjBOCnR2MUZtRVFSd3VoaUZsOFEzcWl0Qm0wMUFSMkNJVXBGd2ZzSjZ4MXF3ckJzVkhZbGlBNVhwRVpZM3ExcGswSDQKM3Z3aGJlK1o2MVNrVHF5SVBYUUwrTWM5T1Nsbm0xb0R2N0NtSkZNMUlMRVI3QTVGZnZKOEdFRjJ6dHBoaUlFMwpub1dtdHNZb3JuT2wzc2lHQ2ZGZzR4Zmd4eW8ybmlneFNVekl1bXNnVm9PM2ttT0x1RVF6cXpkakJ3TFJXbWlECklmMXBMWnoyalVnald4UkhCM1gyWnVVV1d1T09PZnpXM01LaE8ybHEvZi9DdS8wYk83c0x0MCt3U2ZMSU91TFcKcW90blZtRmxMMytqTy82WDNDKzBERHk5aUtwbXJjVDBnWGZLemE1dHJRSURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBR05WdmVIOGR4ZzNvK21VeVRkbmFjVmQ1N24zSkExdnZEU1JWREkyQTZ1eXN3ZFp1L1BVCkkwZXpZWFV0RVNnSk1IRmQycVVNMjNuNVJsSXJ3R0xuUXFISUh5VStWWHhsdnZsRnpNOVpEWllSTmU3QlJvYXgKQVlEdUI5STZXT3FYbkFvczFqRmxNUG5NbFpqdU5kSGxpT1BjTU1oNndLaTZzZFhpVStHYTJ2RUVLY01jSVUyRgpvU2djUWdMYTk0aEpacGk3ZnNMdm1OQUxoT045UHdNMGM1dVJVejV4T0dGMUtCbWRSeEgvbUNOS2JKYjFRQm1HCkkwYitEUEdaTktXTU0xMzhIQXdoV0tkNjVoVHdYOWl4V3ZHMkh4TG1WQzg0L1BHT0tWQW9FNkpsYWFHdTlQVmkKdjlOSjVaZlZrcXdCd0hKbzZXdk9xVlA3SVFjZmg3d0drWm89Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
EOF



- Editado

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: akshay
spec:
  request: MIICVjCCAT4CAQAwETEPMA0GA1UEAwwGYWtzaGF5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu3HzimPV+5KyOqygzEXrUG/crTan/Hi9IneUVja4ZAB2nlGC2mHm4BorKMmgmR9bfyGX1Ssmzg6UjGncURa0aJwhn5Pp7SkuVg0bT91nofvvfIep1WdTvHQ03QhSL4YKvfIXqkKEdVeAj4PCCXIgJPLoWOIz/wAtdMBRBfNNkWc6sTPdLKKCie/6svH5MHE+TjVcDfSMDqj3cuf7Ng2Ly4rS311nBUTaYobK3+sFy8YRRXyCX7ZnRqA4twBRxjG+f6GfqaEnTAj0IDvBISSprEamTnNuZ7lX3bmL9GVdDuo/MHZ4EOnGH5enPTAP2NR8I7JRvK4aK5/pH6U5ped6QIDAQABoAAwDQYJKoZIhvcNAQELBQADggEBAEBsKBt3x14XjJpMRSgdrYgK4WLR6Z0VUS/rr3GJAhnWiyckWg/9d3xoDSbqzvtOnO3LtkryaiD3U4blQgU9sz5vqBffTJkOFhxNpc81ezGlp76Y2lTaKbIusSYMFBSacL6grDucOSewI4XS5qMZfsm0L/cs/EEsKl4J0grnWZojuzqaa580tjVH2Y5FXT8ssNs2OJ7VehohOJ5VuwFJG0HzJ88S6HnLEE2q6eRyI/1qdpy6G84pFrFPrDLLwvpS+DweTttcz8Cyd8aITFoEBQPZpwFD0ViCgK8VxqdsL7IRRmXdDUn1r7oHLee7v8MuGhXTmq44OMbD0dQT4JWibZo=
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
EOF




- ERRO

controlplane ~ ➜  cat <<EOF | kubectl apply -f -
> apiVersion: certificates.k8s.io/v1
> kind: CertificateSigningRequest
> metadata:
>   name: akshay
> spec:
>   request: MIICVjCCAT4CAQAwETEPMA0GA1UEAwwGYWtzaGF5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu3HzimPV+5KyOqygzEXrUG/crTan/Hi9IneUVja4ZAB2nlGC2mHm4BorKMmgmR9bfyGX1Ssmzg6UjGncURa0aJwhn5Pp7SkuVg0bT91nofvvfIep1WdTvHQ03QhSL4YKvfIXqkKEdVeAj4PCCXIgJPLoWOIz/wAtdMBRBfNNkWc6sTPdLKKCie/6svH5MHE+TjVcDfSMDqj3cuf7Ng2Ly4rS311nBUTaYobK3+sFy8YRRXyCX7ZnRqA4twBRxjG+f6GfqaEnTAj0IDvBISSprEamTnNuZ7lX3bmL9GVdDuo/MHZ4EOnGH5enPTAP2NR8I7JRvK4aK5/pH6U5ped6QIDAQABoAAwDQYJKoZIhvcNAQELBQADggEBAEBsKBt3x14XjJpMRSgdrYgK4WLR6Z0VUS/rr3GJAhnWiyckWg/9d3xoDSbqzvtOnO3LtkryaiD3U4blQgU9sz5vqBffTJkOFhxNpc81ezGlp76Y2lTaKbIusSYMFBSacL6grDucOSewI4XS5qMZfsm0L/cs/EEsKl4J0grnWZojuzqaa580tjVH2Y5FXT8ssNs2OJ7VehohOJ5VuwFJG0HzJ88S6HnLEE2q6eRyI/1qdpy6G84pFrFPrDLLwvpS+DweTttcz8Cyd8aITFoEBQPZpwFD0ViCgK8VxqdsL7IRRmXdDUn1r7oHLee7v8MuGhXTmq44OMbD0dQT4JWibZo=
>   signerName: kubernetes.io/kube-apiserver-client
>   expirationSeconds: 86400  # one day
>   usages:
>   - client auth
> EOF
Error from server (BadRequest): error when creating "STDIN": CertificateSigningRequest in version "v1" cannot be handled as a CertificateSigningRequest: illegal base64 data at input byte 803

controlplane ~ ✖ 






cat akshay.csr |base64 


controlplane ~ ✖ 

controlplane ~ ✖ cat akshay.csr |base64 
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBN
QTBHQTFVRUF3d0dZV3R6YUdGNU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJD
Z0tDQVFFQXUzSHppbVBWKzVLeU9xeWd6RVhyVUcvY3JUYW4vSGk5SW5lVVZqYTRaQUIyCm5sR0My
bUhtNEJvcktNbWdtUjliZnlHWDFTc216ZzZVakduY1VSYTBhSndobjVQcDdTa3VWZzBiVDkxbm9m
dnYKZkllcDFXZFR2SFEwM1FoU0w0WUt2ZklYcWtLRWRWZUFqNFBDQ1hJZ0pQTG9XT0l6L3dBdGRN
QlJCZk5Oa1djNgpzVFBkTEtLQ2llLzZzdkg1TUhFK1RqVmNEZlNNRHFqM2N1ZjdOZzJMeTRyUzMx
MW5CVVRhWW9iSzMrc0Z5OFlSClJYeUNYN1puUnFBNHR3QlJ4akcrZjZHZnFhRW5UQWowSUR2QklT
U3ByRWFtVG5OdVo3bFgzYm1MOUdWZER1by8KTUhaNEVPbkdINWVuUFRBUDJOUjhJN0pSdks0YUs1
L2RwSDZVNXBlZDZRSURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBRUJzS0J0M3gx
NFhqSnBNUlNnZHJZZ0s0V0xSNlowVlVTL3JyM0dKQWhuV2l5Y2tXZy85CmQzeG9EU2JxenZ0T25P
M0x0a3J5YWlEM1U0YmxRZ1U5c3o1dnFCZmZUSmtPRmh4TnBjODFlekdscDc2WTJsVGEKS2JJdXNT
WU1GQlNhY0w2Z3JEdWNPU2V3STRYUzVxTVpmc20wTC9jcy9FRXNLbDRKMGdybldab2p1enFhYTU4
MAp0alZIMlk1RlhUOHNzTnMyT0o3VmVob2hPSjVWdXdGSkcwSHpKODhTNkhuTEVFMnE2ZVJ5SS8x
cWRweTZHODRwCkZyRlByRExMd3ZwUytEd2VUdHRjejhDeWQ4YUlURm9FQlFQWnB3RkQwVmlDZ0s4
VnhxZHNMN0lSUm1YZERVbjEKcjdvSExlZTd2OE11R2hYVG1xNDRPTWJEMGRRVDRKV2liWm89Ci0t
LS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=

controlplane ~ ➜  



- Editado

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: akshay
spec:
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZV3R6YUdGNU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQXUzSHppbVBWKzVLeU9xeWd6RVhyVUcvY3JUYW4vSGk5SW5lVVZqYTRaQUIyCm5sR0MybUhtNEJvcktNbWdtUjliZnlHWDFTc216ZzZVakduY1VSYTBhSndobjVQcDdTa3VWZzBiVDkxbm9mdnYKZkllcDFXZFR2SFEwM1FoU0w0WUt2ZklYcWtLRWRWZUFqNFBDQ1hJZ0pQTG9XT0l6L3dBdGRNQlJCZk5Oa1djNgpzVFBkTEtLQ2llLzZzdkg1TUhFK1RqVmNEZlNNRHFqM2N1ZjdOZzJMeTRyUzMxMW5CVVRhWW9iSzMrc0Z5OFlSClJYeUNYN1puUnFBNHR3QlJ4akcrZjZHZnFhRW5UQWowSUR2QklTU3ByRWFtVG5OdVo3bFgzYm1MOUdWZER1by8KTUhaNEVPbkdINWVuUFRBUDJOUjhJN0pSdks0YUs1L2RwSDZVNXBlZDZRSURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnUJBRUJzS0J0M3gxNFhqSnBNUlNnZHJZZ0s0V0xSNlowVlVTL3JyM0dKQWhuV2l5Y2tXZy85CmQzeG9EU2JxenZ0T25PM0x0a3J5YWlEM1U0YmxRZ1U5c3o1dnFCZmZUSmtPRmh4TnBjODFlekdscDc2WTJsVGEKS2JJdXNTWU1GQlNhY0w2Z3JEdWNPU2V3STRYUzVxTVpmc20wTC9jcy9FRXNLbDRKMGdybldab2p1enFhYTU4MAp0alZIMlk1RlhUOHNzTnMyT0o3VmVob2hPSjVWdXdGSkcwSHpKODhTNkhuTEVFMnE2ZVJ5SS8xcWRweTZHODRwCkZRlByRExMd3ZwUytEd2VUdHRjejhDeWQ4YUlURm9FQlFQWnB3RkQwVmlDZ0s4VnhxZHNMN0lSUm1YZERVbjEKcjdvSExlZTd2OE11R2hYVG1xNDRPTWJEMGRRVDRKV2liWm89Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVU1QtLS0tLQo=
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
EOF


- erro

controlplane ~ ➜  cat <<EOF | kubectl apply -f -
> apiVersion: certificates.k8s.io/v1
> kind: CertificateSigningRequest
> metadata:
>   name: akshay
> spec:
>   request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZV3R6YUdGNU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQXUzSHppbVBWKzVLeU9xeWd6RVhyVUcvY3JUYW4vSGk5SW5lVVZqYTRaQUIyCm5sR0MybUhtNEJvcktNbWdtUjliZnlHWDFTc216ZzZVakduY1VSYTBhSndobjVQcDdTa3VWZzBiVDkxbm9mdnYKZkllcDFXZFR2SFEwM1FoU0w0WUt2ZklYcWtLRWRWZUFqNFBDQ1hJZ0pQTG9XT0l6L3dBdGRNQlJCZk5Oa1djNgpzVFBkTEtLQ2llLzZzdkg1TUhFK1RqVmNEZlNNRHFqM2N1ZjdOZzJMeTRyUzMxMW5CVVRhWW9iSzMrc0Z5OFlSClJYeUNYN1puUnFBNHR3QlJ4akcrZjZHZnFhRW5UQWowSUR2QklTU3ByRWFtVG5OdVo3bFgzYm1MOUdWZER1by8KTUhaNEVPbkdINWVuUFRBUDJOUjhJN0pSdks0YUs1L2RwSDZVNXBlZDZRSURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnUJBRUJzS0J0M3gxNFhqSnBNUlNnZHJZZ0s0V0xSNlowVlVTL3JyM0dKQWhuV2l5Y2tXZy85CmQzeG9EU2JxenZ0T25PM0x0a3J5YWlEM1U0YmxRZ1U5c3o1dnFCZmZUSmtPRmh4TnBjODFlekdscDc2WTJsVGEKS2JJdXNTWU1GQlNhY0w2Z3JEdWNPU2V3STRYUzVxTVpmc20wTC9jcy9FRXNLbDRKMGdybldab2p1enFhYTU4MAp0alZIMlk1RlhUOHNzTnMyT0o3VmVob2hPSjVWdXdGSkcwSHpKODhTNkhuTEVFMnE2ZVJ5SS8xcWRweTZHODRwCkZRlByRExMd3ZwUytEd2VUdHRjejhDeWQ4YUlURm9FQlFQWnB3RkQwVmlDZ0s4VnhxZHNMN0lSUm1YZERVbjEKcjdvSExlZTd2OE11R2hYVG1xNDRPTWJEMGRRVDRKV2liWm89Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVU1QtLS0tLQo=
>   signerName: kubernetes.io/kube-apiserver-client
>   expirationSeconds: 86400  # one day
>   usages:
>   - client auth
> EOF
Error from server (BadRequest): error when creating "STDIN": CertificateSigningRequest in version "v1" cannot be handled as a CertificateSigningRequest: illegal base64 data at input byte 1180

controlplane ~ ✖ 





cat myuser.csr | base64 | tr -d "\n"
cat akshay.csr | base64 | tr -d "\n"


controlplane ~ ✖ cat akshay.csr | base64 | tr -d "\n"
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZV3R6YUdGNU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQXUzSHppbVBWKzVLeU9xeWd6RVhyVUcvY3JUYW4vSGk5SW5lVVZqYTRaQUIyCm5sR0MybUhtNEJvcktNbWdtUjliZnlHWDFTc216ZzZVakduY1VSYTBhSndobjVQcDdTa3VWZzBiVDkxbm9mdnYKZkllcDFXZFR2SFEwM1FoU0w0WUt2ZklYcWtLRWRWZUFqNFBDQ1hJZ0pQTG9XT0l6L3dBdGRNQlJCZk5Oa1djNgpzVFBkTEtLQ2llLzZzdkg1TUhFK1RqVmNEZlNNRHFqM2N1ZjdOZzJMeTRyUzMxMW5CVVRhWW9iSzMrc0Z5OFlSClJYeUNYN1puUnFBNHR3QlJ4akcrZjZHZnFhRW5UQWowSUR2QklTU3ByRWFtVG5OdVo3bFgzYm1MOUdWZER1by8KTUhaNEVPbkdINWVuUFRBUDJOUjhJN0pSdks0YUs1L2RwSDZVNXBlZDZRSURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBRUJzS0J0M3gxNFhqSnBNUlNnZHJZZ0s0V0xSNlowVlVTL3JyM0dKQWhuV2l5Y2tXZy85CmQzeG9EU2JxenZ0T25PM0x0a3J5YWlEM1U0YmxRZ1U5c3o1dnFCZmZUSmtPRmh4TnBjODFlekdscDc2WTJsVGEKS2JJdXNTWU1GQlNhY0w2Z3JEdWNPU2V3STRYUzVxTVpmc20wTC9jcy9FRXNLbDRKMGdybldab2p1enFhYTU4MAp0alZIMlk1RlhUOHNzTnMyT0o3VmVob2hPSjVWdXdGSkcwSHpKODhTNkhuTEVFMnE2ZVJ5SS8xcWRweTZHODRwCkZyRlByRExMd3ZwUytEd2VUdHRjejhDeWQ4YUlURm9FQlFQWnB3RkQwVmlDZ0s4VnhxZHNMN0lSUm1YZERVbjEKcjdvSExlZTd2OE11R2hYVG1xNDRPTWJEMGRRVDRKV2liWm89Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
controlplane ~ ➜  



- Editado
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/153-cert-request.yaml

- ERRO

controlplane ~ ➜  vi cert-request.yaml

controlplane ~ ➜  kubectl apply -f cert-request.yaml
error: resource mapping not found for name: "akshay" namespace: "" from "cert-request.yaml": no matches for kind "CertificateSigningRequest" in version "certificates.k8s.io/v1beta1"
ensure CRDs are installed first

controlplane ~ ✖ 


- Editado
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/153-cert-request_v2.yaml



controlplane ~ ✖ vi cert-request.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f cert-request.yaml
error: resource mapping not found for name: "akshay" namespace: "" from "cert-request.yaml": no matches for kind "CertificateSigningRequest" in version "certificates.k8s.io/v1beta1"
ensure CRDs are installed first

controlplane ~ ✖ 



- Ajustado apiversion

DE:
apiVersion: certificates.k8s.io/v1beta1

PARA:
apiVersion: certificates.k8s.io/v1


- OK, agora aplicou:

controlplane ~ ✖ vi cert-request.yaml

controlplane ~ ➜  kubectl apply -f cert-request.yaml
certificatesigningrequest.certificates.k8s.io/akshay created

controlplane ~ ➜  


controlplane ~ ➜  kubectl get csr
NAME        AGE   SIGNERNAME                                    REQUESTOR                  REQUESTEDDURATION   CONDITION
akshay      46s   kubernetes.io/kube-apiserver-client           kubernetes-admin           24h                 Pending
csr-x6xhh   37m   kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   <none>              Approved,Issued

controlplane ~ ➜  










What is the Condition of the newly created Certificate Signing Request object?

-RESPOSTA
Pending











https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#approval-rejection-kubectl
To approve a CSR with kubectl:

kubectl certificate approve <certificate-signing-request-name>


kubectl certificate approve akshay


controlplane ~ ➜  kubectl certificate approve akshay
certificatesigningrequest.certificates.k8s.io/akshay approved

controlplane ~ ➜  
controlplane ~ ➜  kubectl get csr
NAME        AGE     SIGNERNAME                                    REQUESTOR                  REQUESTEDDURATION   CONDITION
akshay      8m12s   kubernetes.io/kube-apiserver-client           kubernetes-admin           24h                 Approved,Issued
csr-x6xhh   44m     kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   <none>              Approved,Issued

controlplane ~ ➜  








How many CSR requests are available on the cluster?

Including approved and pending

- RESPOSTA
2










During a routine check you realized that there is a new CSR request in place. What is the name of this request?



controlplane ~ ➜  kubectl get csr
NAME          AGE   SIGNERNAME                                    REQUESTOR                  REQUESTEDDURATION   CONDITION
agent-smith   20s   kubernetes.io/kube-apiserver-client           agent-x                    <none>              Pending
akshay        9m    kubernetes.io/kube-apiserver-client           kubernetes-admin           24h                 Approved,Issued
csr-x6xhh     45m   kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   <none>              Approved,Issued

controlplane ~ ➜  

- RESPOSTA
agent-smith






Hmmm.. You are not aware of a request coming in. What groups is this CSR requesting access to?

Check the details about the request. Preferebly in YAML.

kubectl get csr/agent-smith -o yaml



controlplane ~ ✖ kubectl get csr/agent-smith -o yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  creationTimestamp: "2023-09-20T00:40:50Z"
  name: agent-smith
  resourceVersion: "3969"
  uid: 2e02df90-4410-4049-866a-e6d3e00bdaa5
spec:
  groups:
  - system:masters
  - system:authenticated
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1dEQ0NBVUFDQVFBd0V6RVJNQThHQTFVRUF3d0libVYzTFhWelpYSXdnZ0VpTUEwR0NTcUdTSWIzRFFFQgpBUVVBQTRJQkR3QXdnZ0VLQW9JQkFRRE8wV0pXK0RYc0FKU0lyanBObzV2UklCcGxuemcrNnhjOStVVndrS2kwCkxmQzI3dCsxZUVuT041TXVxOTlOZXZtTUVPbnJEVU8vdGh5VnFQMncyWE5JRFJYall5RjQwRmJtRCs1eld5Q0sKeTNCaWhoQjkzTUo3T3FsM1VUdlo4VEVMcXlhRGtuUmwvanYvU3hnWGtvazBBQlVUcFdNeDRCcFNpS2IwVSt0RQpJRjVueEF0dE1Wa0RQUTdOYmVaUkc0M2IrUVdsVkdSL3o2RFdPZkpuYmZlek90YUF5ZEdMVFpGQy93VHB6NTJrCkVjQ1hBd3FDaGpCTGt6MkJIUFI0Sjg5RDZYYjhrMzlwdTZqcHluZ1Y2dVAwdEliT3pwcU52MFkwcWRFWnB3bXcKajJxRUwraFpFV2trRno4MGxOTnR5VDVMeE1xRU5EQ25JZ3dDNEdaaVJHYnJBZ01CQUFHZ0FEQU5CZ2txaGtpRwo5dzBCQVFzRkFBT0NBUUVBUzlpUzZDMXV4VHVmNUJCWVNVN1FGUUhVemFsTnhBZFlzYU9SUlFOd0had0hxR2k0CmhPSzRhMnp5TnlpNDRPT2lqeWFENnRVVzhEU3hrcjhCTEs4S2czc3JSRXRKcWw1ckxaeTlMUlZyc0pnaEQ0Z1kKUDlOTCthRFJTeFJPVlNxQmFCMm5XZVlwTTVjSjVURjUzbGVzTlNOTUxRMisrUk1uakRRSjdqdVBFaWM4L2RoawpXcjJFVU02VWF3enlrcmRISW13VHYybWxNWTBSK0ROdFYxWWllKzBIOS9ZRWx0K0ZTR2poNUw1WVV2STFEcWl5CjRsM0UveTNxTDcxV2ZBY3VIM09zVnBVVW5RSVNNZFFzMHFXQ3NiRTU2Q0M1RGhQR1pJcFVibktVcEF3a2ErOEUKdndRMDdqRytocGtueG11RkFlWHhnVXdvZEFMYUo3anUvVERJY3c9PQotLS0tLUVORCBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0K
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - digital signature
  - key encipherment
  - server auth
  username: agent-x
status: {}

controlplane ~ ➜ 












That doesn't look very right. Reject that request.

    Request Denied

to deny a CSR:

kubectl certificate deny <certificate-signing-request-name>
kubectl certificate deny agent-smith
controlplane ~ ➜  kubectl certificate deny agent-smith
certificatesigningrequest.certificates.k8s.io/agent-smith denied

controlplane ~ ➜  







Let's get rid of it. Delete the new CSR object

    CSR agent-smith deleted

kubectl delete csr agent-smith


controlplane ~ ➜  kubectl delete csr agent-smith
certificatesigningrequest.certificates.k8s.io "agent-smith" deleted

controlplane ~ ➜  