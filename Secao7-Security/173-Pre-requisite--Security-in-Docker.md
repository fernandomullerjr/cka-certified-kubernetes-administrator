
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

no host local, na VM

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

- Acessando o Container

podemos ver o processo com o pid 1

~~~~bash

fernando@debian10x64:~$
fernando@debian10x64:~$ docker ps
CONTAINER ID   IMAGE     COMMAND        CREATED         STATUS         PORTS     NAMES
68b4f64625aa   alpine    "sleep 1111"   6 minutes ago   Up 6 minutes             confident_rubin
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$
fernando@debian10x64:~$ docker exec -ti 68b4f64625aa sh
/ #
/ #
/ #
/ #
/ # ps -ef
PID   USER     TIME  COMMAND
    1 root      0:00 sleep 1111
    8 root      0:00 sh
   14 root      0:00 ps -ef
/ #

~~~~


- Estes pid diferentes, é porque o processo pode ter diferentes pid em diferentes Namespaces.
- Este é o isolamento de processos que o Docker faz.

- Podemos ver que o container está utilizando o usuário root.
- Por padrão o Docker utiliza o usuário root dentro dos Containers.









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











## USUARIO

To run our asset build, we could use a command something like this:

~~~~BASH
docker container run --rm -it \
  -v $(app):/app \                          # Mount the source code
  --workdir /app \                          # Set the working dir
  --user 1000:1000 \                        # Run as the given user
  my-docker/my-build-environment:latest \   # Our build env image
  make assets                               # ... and the command!
~~~~

This will tell Docker to run its processes with user ID 1000 and group ID 1000. That will mean that any files created by that process also belong to the user with ID 1000.



Um Dockerfile é um script que contém uma série de instruções para a construção de uma imagem Docker. Para definir um usuário específico no Dockerfile, você pode usar a instrução USER. Aqui está um exemplo de um Dockerfile que define o usuário 1000:

~~~~Dockerfile

# Use uma imagem base, como o Alpine Linux
FROM alpine:latest

# Define o usuário para o ID 1000
USER 1000

# Adicione outras instruções do Dockerfile abaixo
# ...

# Especifica o comando padrão a ser executado quando o contêiner é iniciado
CMD ["echo", "Hello, Docker!"]
~~~~

A instrução USER é usada para definir o usuário ou UID (User ID) que será utilizado quando o contêiner estiver sendo executado. No exemplo acima, o usuário é definido como 1000.

A razão para definir um usuário específico está relacionada à segurança. Por padrão, ao executar um contêiner Docker, ele é executado como o usuário root (UID 0). Isso pode representar um risco de segurança, pois um contêiner comprometido como root pode ter acesso irrestrito ao sistema hospedeiro.

Ao definir um usuário não privilegiado, como o usuário 1000, você limita os danos que um contêiner comprometido pode causar. Isso ajuda a seguir o princípio do "privilégio mínimo necessário", onde você restringe os privilégios do contêiner para reduzir o impacto de possíveis violações de segurança.

Lembre-se de que o UID 1000 é apenas um exemplo e pode variar dependendo do contexto do seu sistema. Ao usar imagens base, como Alpine Linux ou outras, o UID 1000 geralmente é um UID não privilegiado padrão. Certifique-se de ajustar conforme necessário para atender aos requisitos específicos do seu aplicativo e ambiente.












https://cloudyuga.guru/hands_on_lab/docker-as-non-root-user
<https://cloudyuga.guru/hands_on_lab/docker-as-non-root-user>

## Running Programs as non-root user, inside the Container

Generally, if you run a container and check the user id or group id, it is set to 0; which means that we are running the program as the admin user, in the context of the container. 

docker run --rm alpine id

    uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),11(floppy),20(dialout),26(tape),27(video)

This is not a good practice.  One way is to fix it by providing the uid/gid, while running the containers like following :-

docker run --rm -u 1001:1001 alpine id

    uid=1001 gid=1001 groups=1001

But this may cause problems to the programs which we are not configured to run as non-root users, inside the containers; unless we do so. So a better approach is to configure the default user/group and the program accordingly inside the Dockerfile. Let's see an example of the same. 

### Step 1: Create a Dockerfile.

    To write a Dockerfile

vim Dockerfile


~~~~DOCKERFILE
FROM centos:7

RUN useradd -u 1001 testuser

USER testuser

CMD ["/bin/sleep", "200"]
~~~~
​

### Step 2: Build an Image.

    To build an image from the Dockerfile

docker build -t cloudyuga/test:learn .

docker image ls

Step 3: Create and run a container from the previous step image 

    To create and run container and retrive user detail

docker run --rm -d --name testc cloudyuga/test:learn

Step 4: Verify the user and ownership of the program running inside the container

docker exec testc id 

docker exec testc ps aux 

We can see the uid and gid are set to 1001 and the sleep program runs with the user testuser.  Also if we inspect the container we'll see the user is set to testuser. 

docker inspect testc --format '{{.Config.User}} {{.Name}}'

Note: container name is added with username.






## Capabilities in Docker Containers

By default Docker assigns a few capabilities to the containers. It's very easy to check which capabilities are these by running:
docker run --rm -it  r.j3ss.co/amicontained 

~~~~BASH
Capabilities:
	BOUNDING -> chown dac_override fowner fsetid kill setgid setuid setpcap net_bind_service net_raw sys_chroot mknod audit_write setfcap
​
# Add a capabilities
docker run --rm -it --cap-add=SYS_ADMIN r.j3ss.co/amicontained bash
​
# Add all capabilities
docker run --rm -it --cap-add=ALL r.j3ss.co/amicontained bash
​
# Remove all and add only one
docker run --rm -it  --cap-drop=ALL --cap-add=SYS_PTRACE r.j3ss.co/amicontained bash
​~~~~
~~~~



- Arquivo onde podem ser ajustados os

~~~~bash

fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ cat /usr/include/linux/capability.h  | head
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/*
 * This is <linux/capability.h>
 *
 * Andrew G. Morgan <morgan@kernel.org>
 * Alexander Kjeldaas <astor@guardian.no>
 * with help from Aleph1, Roland Buresund and Andrew Main.
 *
 * See here for the libcap library ("POSIX draft" compliance):
 *
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ cat /usr/include/linux/capability.h  | tail

/*
 * Bit location of each capability (used by user-space library and kernel)
 */

#define CAP_TO_INDEX(x)     ((x) >> 5)        /* 1 << 5 == bits in __u32 */
#define CAP_TO_MASK(x)      (1U << ((x) & 31)) /* mask for indexed __u32 */


#endif /* _LINUX_CAPABILITY_H */
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$

~~~~






## Excessive Capabilities
Running a Docker container with --privileged or dangerous capabilities allows privileged operations.
The --privileged flag gives all  to the container, and it also lifts all the limitations enforced by the device cgroup controller. In other words, the container can then do almost everything that the host can do.



## Abusing exposed host directories

Assusme, the /home directory is exposed by /dev/sdb1 within a privileged container. In such case, you can generate a device node for that block device, mount it into the container, and gain access to host's /home directory.
$ docker run --privileged -it --rm alpine:latest
/ $ apk update && apk add util-linux
# ...
/ $ lsblk
NAME      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda         8:0    0   45G  0 disk
├─sda1      8:1    0 40.9G  0 part /etc/hosts
├─sda2      8:2    0   16M  0 part
├─sda3      8:3    0    2G  0 part
│ └─vroot 253:0    0  1.2G  1 dm
├─sda4      8:4    0   16M  0 part
├─sda5      8:5    0    2G  0 part
├─sda6      8:6    0  512B  0 part
├─sda7      8:7    0  512B  0 part
├─sda8      8:8    0   16M  0 part
├─sda9      8:9    0  512B  0 part
├─sda10     8:10   0  512B  0 part
├─sda11     8:11   0    8M  0 part
└─sda12     8:12   0   32M  0 part
sdb         8:16   0    5G  0 disk
└─sdb1      8:17   0    5G  0 part
zram0     252:0    0  768M  0 disk [SWAP]
/ $ mknod /dev/sdb1 block 8 17
/ $ mkdir /mnt/host_home
/ $ mount /dev/sdb1 /mnt/host_home
/ $ echo 'echo "Hello from container land!" 2>&1' >> /mnt/host_home/eric_chiang_m/.bashrc





# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# RESUMO

- Por padrão, o root é usuario 0 num container.
- O usuário root tem acesso a varios "Linux Capabilities".

- Adicionando uma Linux Capability:
    docker run --rm -it --cap-add=SYS_ADMIN r.j3ss.co/amicontained bash

- Removendo todas Capabilities e adicionado apenas uma:
    docker run --rm -it  --cap-drop=ALL --cap-add=SYS_PTRACE r.j3ss.co/amicontained bash

- A flag --privileged garante todas permissões possíveis ao Container, inclusive aquelas que afetam o host:
    docker run --privileged -it --rm alpine:latest