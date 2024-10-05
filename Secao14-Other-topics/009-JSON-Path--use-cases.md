
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "JSON PATH IN KUBERNETES - Use cases."
git push
git status


eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github


# ###################################################################################################################### 
# ###################################################################################################################### 
## JSON PATH IN KUBERNETES

Objectives
• JSON PATH in KubeCtl
• Why JSON PATH?
• View and interpret KubeCtl output in JSON Format
• How to use JSON PATH with KubeCtl
• JSON PATH Examples
• Loops – Range
• Custom Columns
• Sort
• Practice Tests and Exercises