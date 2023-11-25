
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# push

git status
git add .
git commit -m "173. Pre-requisite - Security in Docker."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# 173. Pre-requisite - Security in Docker


https://madhuakula.com/content/attacking-and-auditing-docker-containers-using-opensource/attacking-docker-containers/namespaces.html
<https://madhuakula.com/content/attacking-and-auditing-docker-containers-using-opensource/attacking-docker-containers/namespaces.html>

- Testando

~~~~bash

fernando@debian10x64:~$
fernando@debian10x64:~$ docker run --rm -d alpine sleep 1111
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
96526aa774ef: Pull complete
Digest: sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978
Status: Downloaded newer image for alpine:latest
68b4f64625aae6c2ffeacd2260d9088d7de9def3c18441c812244f448a38cea3
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ ps auxx | grep 'sleep 1111'
root      73776  4.0  0.0   1584     4 ?        Ss   15:34   0:00 sleep 1111
fernando  73809  0.0  0.0   6072   816 pts/1    S+   15:35   0:00 grep sleep 1111
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ sudo ls /proc/73776/ns/
[sudo] password for fernando:
cgroup  ipc  mnt  net  pid  pid_for_children  user  uts
fernando@debian10x64:~$

~~~~













<https://www.baeldung.com/linux/docker-container-process-host-pid>

## 5. Docker Example

Now, let’s see how PID namespaces work in Docker. We’ll create and start a new detached Alpine Linux container:

~~~~bash
$ sudo docker run -d alpine:latest sleep 1000
f0901c0b43329f6f997ec946597c3ab159c58a885cd081a8d0f855ae19c8188f
~~~~

Next, let’s run the lsns command again to output the accessible PID namespaces:

~~~~bash
$ sudo lsns -t pid
        NS TYPE NPROCS   PID USER COMMAND
4026531836 pid     115     1 root /sbin/init
4026532153 pid       1  2083 root sleep 1000
~~~~

As expected, Docker created a new PID namespace with the identifier 4026532153. Now, let’s run ps:

~~~~bash
$ ps aux | grep sleep
 2083 root     sleep 1000
~~~~

Indeed, we can see a process that’s running the sleep command with PID 2083 in the parent namespace.

To find out the process ID of this process in its namespace we’ll execute the ps command in the container:

~~~~bash
$ sudo docker container exec f0901 ps ax
PID   USER     TIME  COMMAND
    1 root      0:00 sleep 1000
    6 root      0:00 ps ax
~~~~

As can be seen, the process ID of the process running the sleep command in the child namespace is 1. 