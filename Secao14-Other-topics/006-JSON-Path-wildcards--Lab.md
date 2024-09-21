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


touch answer1.sh
chmod +x answer1.sh
vi answer1.sh
cat q1.json | jpath $.*



alpine-host ~ ➜  ./answer1.sh
[
  "value1",
  "value2"
]
alpine-host ~ ➜  
~~~~




### 2
Develop a JSON PATH query to extract the kind of object. A file named q2.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "blue",
  "white"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q2.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer2.sh in /root directory.

Is the answer2.sh contains the correct command?

~~~~BASH

alpine-host ~ ➜  cat q2.json 
{
    "car": {
        "color": "blue",
        "price": "$20,000"
    },
    "bus": {
        "color": "white",
        "price": "$120,000"
    }
}
alpine-host ~ ➜  cat q2.json | jpath $.*.color
[
  "blue",
  "white"
]
alpine-host ~ ➜  

touch answer2.sh
chmod +x answer2.sh
vi answer2.sh
cat q2.json | jpath $.*.color
~~~~





### 3
Develop a JSON PATH query to extract the kind of object. A file named q3.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "$20,000",
  "$120,000"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q3.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer3.sh in /root directory.

Is the answer3.sh contains the correct command?

~~~~BASH



touch answer3.sh
chmod +x answer3.sh
vi answer3.sh
cat q3.json | jpath $.*.color
~~~~
