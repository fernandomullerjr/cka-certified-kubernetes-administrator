
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 95. Commands."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################

#  95. Commands

# Commands and Arguments in Docker
  - Take me to [Video Tutorial](https://kodekloud.com/topic/commands-and-arguments-in-docker/)
  
In this section, we will take a look at commands and arguments in docker

- To run a docker container
  ```
  $ docker run ubuntu
  ```
- To list running containers
  ```
  $ docker ps 
  ```
- To list all containers including that are stopped
  ```
  $ docker ps -a
  ```
  
  ![dc](../../images/dc.PNG)
  
#### Unlike virtual machines, containers are not meant to host operating system.
- Containers are meant to run a specific task or process such as to host an instance of a webserver or application server or a database server etc.

  ![ex](../../images/ex.PNG)
  
  
#### How do you specify a different command to start the container?
- One Option is to append a command to the docker run command and that way it overrides the default command specified within the image.
  ```
  $ docker run ubuntu sleep 5
  ```
- This way when the container starts it runs the sleep program, waits for 5 seconds and then exists. How do you make that change permanent?
  
  ![sleep](../../images/sleep.PNG)
  
- There are different ways of specifying the command either the command simply as is in a shell form or in a JSON array format.
 
  ![sleep1](../../images/sleep1.PNG)
  
- Now, build the docker image
  ```
  $ docker build -t ubuntu-sleeper .
  ```
- Run docker container
  ```
  $ docker run ubuntu-sleeper
  ```
  
  ![sleep2](../../images/sleep2.PNG)
  
## Entrypoint Instruction
- The entrypoint instruction is like the command instruction as in you can specify the program that will be run when the container starts and whatever you specify on the command line.

#### K8s Reference Docs
- https://docs.docker.com/engine/reference/builder/#cmd










# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################

#  Docker - CMD - Entrypoint - Diferenças e detalhes

CMD

The CMD instruction has three forms:

    CMD ["executable","param1","param2"] (exec form, this is the preferred form)
    CMD ["param1","param2"] (as default parameters to ENTRYPOINT)
    CMD command param1 param2 (shell form)

There can only be one CMD instruction in a Dockerfile. If you list more than one CMD then only the last CMD will take effect.

The main purpose of a CMD is to provide defaults for an executing container. These defaults can include an executable, or they can omit the executable, in which case you must specify an ENTRYPOINT instruction as well.

If CMD is used to provide default arguments for the ENTRYPOINT instruction, both the CMD and ENTRYPOINT instructions should be specified with the JSON array format.

    Note

    The exec form is parsed as a JSON array, which means that you must use double-quotes (“) around words not single-quotes (‘).

Unlike the shell form, the exec form does not invoke a command shell. This means that normal shell processing does not happen. For example, CMD [ "echo", "$HOME" ] will not do variable substitution on $HOME. If you want shell processing then either use the shell form or execute a shell directly, for example: CMD [ "sh", "-c", "echo $HOME" ]. When using the exec form and executing a shell directly, as in the case for the shell form, it is the shell that is doing the environment variable expansion, not docker.

When used in the shell or exec formats, the CMD instruction sets the command to be executed when running the image.

If you use the shell form of the CMD, then the <command> will execute in /bin/sh -c:

FROM ubuntu
CMD echo "This is a test." | wc -

If you want to run your <command> without a shell then you must express the command as a JSON array and give the full path to the executable. This array form is the preferred format of CMD. Any additional parameters must be individually expressed as strings in the array:

FROM ubuntu
CMD ["/usr/bin/wc","--help"]

If you would like your container to run the same executable every time, then you should consider using ENTRYPOINT in combination with CMD. See ENTRYPOINT.

If the user specifies arguments to docker run then they will override the default specified in CMD.

    Note

    Do not confuse RUN with CMD. RUN actually runs a command and commits the result; CMD does not execute anything at build time, but specifies the intended command for the image.






# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################

#  95. Commands


- Ao criar uma imagem do Ubuntu da seguinte maneira, dizemos que ela vai ser executada por 5 segundos ao ser executada e vai morrer:

~~~~Dockerfile
FROM Ubuntu

CMD sleep 5
~~~~



- É possível passar os valores do CMD em texto simples ou num dicionário.
- OBSERVAÇÃO:
ao utilizar um dicionário, o primeiro parametro precisa ser um executável!
ao utilizar um dicionário, o primeiro parametro precisa ser um executável!
ao utilizar um dicionário, o primeiro parametro precisa ser um executável!

    CMD ["executable","param1","param2"] (exec form, this is the preferred form)
    CMD ["param1","param2"] (as default parameters to ENTRYPOINT)
    CMD command param1 param2 (shell form)

docker run ubuntu sleep 5