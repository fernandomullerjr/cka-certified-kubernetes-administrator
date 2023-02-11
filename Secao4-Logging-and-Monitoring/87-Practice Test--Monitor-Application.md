
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 87. Practice Test - Monitor Application Logs"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status





# ##############################################################################################################################################################
#  87. Practice Test - Monitor Application Logs







We have deployed a POD hosting an application. Inspect it. Wait for it to start.

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-5c6b6c5476-tmbqr                  1/1     Running     0          17m
kube-system   local-path-provisioner-5d56847996-s9vpl   1/1     Running     0          17m
kube-system   helm-install-traefik-crd-7hg9w            0/1     Completed   0          17m
kube-system   helm-install-traefik-8cffl                0/1     Completed   1          17m
kube-system   metrics-server-7b67f64457-jlfs8           1/1     Running     0          17m
kube-system   svclb-traefik-e40fd97e-tn6bc              2/2     Running     0          17m
kube-system   traefik-56b8c5fb5c-2mctp                  1/1     Running     0          17m
default       webapp-1                                  1/1     Running     0          20s

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-5c6b6c5476-tmbqr                  1/1     Running     0          18m
kube-system   local-path-provisioner-5d56847996-s9vpl   1/1     Running     0          18m
kube-system   helm-install-traefik-crd-7hg9w            0/1     Completed   0          18m
kube-system   helm-install-traefik-8cffl                0/1     Completed   1          18m
kube-system   metrics-server-7b67f64457-jlfs8           1/1     Running     0          18m
kube-system   svclb-traefik-e40fd97e-tn6bc              2/2     Running     0          17m
kube-system   traefik-56b8c5fb5c-2mctp                  1/1     Running     0          17m
default       webapp-1                                  1/1     Running     0          48s

controlplane ~ ➜  














A user - USER5 - has expressed concerns accessing the application. Identify the cause of the issue.

Inspect the logs of the POD



controlplane ~ ➜  kubectl logs webapp-1
[2023-02-11 03:18:19,008] INFO in event-simulator: USER1 logged out
[2023-02-11 03:18:20,009] INFO in event-simulator: USER2 logged out
[2023-02-11 03:18:21,010] INFO in event-simulator: USER4 logged out
[2023-02-11 03:18:22,012] INFO in event-simulator: USER3 is viewing page3
[2023-02-11 03:18:23,013] INFO in event-simulator: USER4 is viewing page1
[2023-02-11 03:18:24,014] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:24,015] INFO in event-simulator: USER3 is viewing page1
[2023-02-11 03:18:25,016] INFO in event-simulator: USER1 logged out
[2023-02-11 03:18:26,017] INFO in event-simulator: USER1 logged in
[2023-02-11 03:18:27,019] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:18:27,019] INFO in event-simulator: USER4 is viewing page2
[2023-02-11 03:18:28,020] INFO in event-simulator: USER3 is viewing page2
[2023-02-11 03:18:29,021] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:29,021] INFO in event-simulator: USER3 logged in
[2023-02-11 03:18:30,022] INFO in event-simulator: USER2 logged out
[2023-02-11 03:18:31,024] INFO in event-simulator: USER4 is viewing page2
[2023-02-11 03:18:32,025] INFO in event-simulator: USER2 logged out
[2023-02-11 03:18:33,025] INFO in event-simulator: USER4 logged out
[2023-02-11 03:18:34,027] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:34,027] INFO in event-simulator: USER4 is viewing page1
[2023-02-11 03:18:35,029] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:18:35,029] INFO in event-simulator: USER3 logged out
[2023-02-11 03:18:36,030] INFO in event-simulator: USER1 is viewing page2
[2023-02-11 03:18:37,031] INFO in event-simulator: USER3 logged out
[2023-02-11 03:18:38,033] INFO in event-simulator: USER2 is viewing page2
[2023-02-11 03:18:39,034] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:39,035] INFO in event-simulator: USER1 is viewing page1
[2023-02-11 03:18:40,036] INFO in event-simulator: USER1 is viewing page3
[2023-02-11 03:18:41,037] INFO in event-simulator: USER1 is viewing page2
[2023-02-11 03:18:42,038] INFO in event-simulator: USER4 is viewing page3
[2023-02-11 03:18:43,040] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:18:43,040] INFO in event-simulator: USER1 logged in
[2023-02-11 03:18:44,041] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:44,042] INFO in event-simulator: USER1 logged out
[2023-02-11 03:18:45,043] INFO in event-simulator: USER3 is viewing page1
[2023-02-11 03:18:46,045] INFO in event-simulator: USER3 is viewing page3
[2023-02-11 03:18:47,047] INFO in event-simulator: USER1 logged in
[2023-02-11 03:18:48,048] INFO in event-simulator: USER2 is viewing page3
[2023-02-11 03:18:49,049] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:49,049] INFO in event-simulator: USER4 logged in
[2023-02-11 03:18:50,050] INFO in event-simulator: USER3 is viewing page3
[2023-02-11 03:18:51,052] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:18:51,052] INFO in event-simulator: USER3 logged in
[2023-02-11 03:18:52,053] INFO in event-simulator: USER4 is viewing page1
[2023-02-11 03:18:53,054] INFO in event-simulator: USER2 is viewing page2
[2023-02-11 03:18:54,056] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:54,056] INFO in event-simulator: USER4 logged out
[2023-02-11 03:18:55,058] INFO in event-simulator: USER3 is viewing page3
[2023-02-11 03:18:56,059] INFO in event-simulator: USER2 logged out
[2023-02-11 03:18:57,061] INFO in event-simulator: USER3 is viewing page2
[2023-02-11 03:18:58,062] INFO in event-simulator: USER4 is viewing page1
[2023-02-11 03:18:59,063] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:59,064] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:18:59,064] INFO in event-simulator: USER3 is viewing page2
[2023-02-11 03:19:00,065] INFO in event-simulator: USER1 is viewing page3
[2023-02-11 03:19:01,067] INFO in event-simulator: USER4 logged out
[2023-02-11 03:19:02,068] INFO in event-simulator: USER1 is viewing page2
[2023-02-11 03:19:03,070] INFO in event-simulator: USER3 logged in
[2023-02-11 03:19:04,071] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:19:04,072] INFO in event-simulator: USER2 logged in
[2023-02-11 03:19:05,073] INFO in event-simulator: USER4 is viewing page1
[2023-02-11 03:19:06,075] INFO in event-simulator: USER2 is viewing page1
[2023-02-11 03:19:07,076] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:19:07,077] INFO in event-simulator: USER4 logged out
[2023-02-11 03:19:08,078] INFO in event-simulator: USER2 is viewing page2
[2023-02-11 03:19:09,079] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:19:09,079] INFO in event-simulator: USER1 logged in
[2023-02-11 03:19:10,081] INFO in event-simulator: USER4 logged out
[2023-02-11 03:19:11,083] INFO in event-simulator: USER2 logged in
[2023-02-11 03:19:12,084] INFO in event-simulator: USER2 is viewing page3
[2023-02-11 03:19:13,085] INFO in event-simulator: USER3 logged out
[2023-02-11 03:19:14,087] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:19:14,087] INFO in event-simulator: USER3 logged in
[2023-02-11 03:19:15,088] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:19:15,089] INFO in event-simulator: USER4 is viewing page2
[2023-02-11 03:19:16,090] INFO in event-simulator: USER4 is viewing page2
[2023-02-11 03:19:17,091] INFO in event-simulator: USER3 is viewing page1
[2023-02-11 03:19:18,093] INFO in event-simulator: USER3 is viewing page1
[2023-02-11 03:19:19,094] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:19:19,094] INFO in event-simulator: USER4 is viewing page2
[2023-02-11 03:19:20,096] INFO in event-simulator: USER1 logged out
[2023-02-11 03:19:21,097] INFO in event-simulator: USER3 is viewing page1
[2023-02-11 03:19:22,098] INFO in event-simulator: USER3 logged out

controlplane ~ ➜  