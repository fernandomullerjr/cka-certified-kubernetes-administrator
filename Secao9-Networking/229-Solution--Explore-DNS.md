
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "229. Solution - Explore DNS."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  229. Solution - Explore DNS

cluster apenas não rola
é necessário utilizar cluster.local ou sacar fora

exemplo:
[OK] mysql.payroll.svc.cluster.local
[OK] mysql.payroll.svc
[OK] mysql.payroll
[OK] mysql
[NÃO-OK] mysql.payroll.svc.cluster