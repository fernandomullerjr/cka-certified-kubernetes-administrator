
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "116. Solution - Init Containers"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 116. Solution - Init Containers



# How long after the creation of the POD will the application come up and be available to users?

resposta errada:
20minutos

600 segundos também está errado

- RESPOSTA CORRETA:
30minutos


# solução

- Como existem 2 initContainers, é calculado o sleep dos 2.
No caso é:
600
+
1200
=
1800

1800/60 = 30minutos











- Sobre a questão do Pod orange crashando.
- Foi verificado o YAML do Pod e verificado comando sleep incoerente.
- Mas o mais adequado teria sido avaliando os logs do Pod, pegando o erro do comando inexistente.

~~~~YAML
Init Containers:
  init-myservice:
    Container ID:  containerd://2cfe3b099d97ffab21f92016ad69c13bc28bb7f4176075c44221ea6f871c9d41
    Image:         busybox
    Image ID:      docker.io/library/busybox@sha256:b5d6fe0712636ceb7430189de28819e195e8966372edfc2d9409d79402a0dc16
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      sleeeep 2;
    State:          Terminated
      Reason:       Error
~~~~