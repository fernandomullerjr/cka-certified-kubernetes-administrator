#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "JSON PATH - Wildcards - LAB."
git push
git status





# ###################################################################################################################### 
# ###################################################################################################################### 
##  JSON PATH - Wildcards - LAB

### 1

Develop a JSON PATH query to extract the kind of object. A file named q1.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "value1",
  "value2"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q1.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer1.sh in /root directory.

Is the answer1.sh contains the correct command?



cat q1.json | jpath $.property1

- RESPOSTA

~~~~BASH

alpine-host ~ ➜  cat q1.json 
{
    "property1": "value1",
    "property2": "value2"
}
alpine-host ~ ➜  cat q1.json | jpath $.property1
[
  "value1"
]
alpine-host ~ ➜  cat q1.json | jpath $.*
[
  "value1",
  "value2"
]
alpine-host ~ ➜  


~~~~