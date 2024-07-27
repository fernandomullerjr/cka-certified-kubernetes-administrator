#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "Pre-Requisites - JSON PATH."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
## Pre-Requisites - JSON PATH

In the upcoming lecture we will explore some advanced commands with kubectl utility. But that requires JSON PATH. If you are new to JSON PATH queries get introduced to it first by going through the lectures and practice tests available here.

https://kodekloud.com/p/json-path-quiz


Once you are comfortable head back here:


I also have some JSON PATH exercises with Kubernetes Data Objects. Make sure you go through these:

https://mmumshad.github.io/json-path-quiz/index.html#!/?questions=questionskub1

https://mmumshad.github.io/json-path-quiz/index.html#!/?questions=questionskub2


