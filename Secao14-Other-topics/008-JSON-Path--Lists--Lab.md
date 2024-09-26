
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "JSONPath - Lists - LAB."
git push
git status


eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github


# ###################################################################################################################### 
# ###################################################################################################################### 
## JSONPath - Lists - LAB


### 1

Develop a JSON path query to extract the expected output from the Source Data.
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  "Apple"
]

Save the the query to filename answer1.sh under root directory.

Query worked as expected?



alpine-host ~ ➜  cat input.json 
[
  "Apple",
  "Google",
  "Microsoft",
  "Amazon",
  "Facebook",
  "Coca-Cola",
  "Samsung",
  "Disney",
  "Toyota",
  "McDonald's"
]

alpine-host ~ ➜  date
Wed Sep 25 23:58:19 UTC 2024

alpine-host ~ ➜  

alpine-host ~ ➜  cat input.json | jpath $[0]
[
  "Apple"
]
alpine-host ~ ➜  


touch answer1.sh
chmod +x answer1.sh
echo "cat input.json | jpath '$[0]'" > answer1.sh









### 2

Develop a JSON path query to extract the expected output from the Source Data.
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  "Apple"
  "Facebook"
]

Save the query to filename answer2.sh under the root directory.

Query worked as expected?

alpine-host ~ ➜  cat input.json 
[
  "Apple",
  "Google",
  "Microsoft",
  "Amazon",
  "Facebook",
  "Coca-Cola",
  "Samsung",
  "Disney",
  "Toyota",
  "McDonald's"
]

alpine-host ~ ➜  

touch answer2.sh
chmod +x answer2.sh
echo "cat input.json | jpath '$[0,4]'" > answer2.sh


alpine-host ~ ➜  
touch answer2.sh
chmod +x answer2.sh
echo "cat input.json | jpath '$[0,4]'" > answer2.sh

alpine-host ~ ➜  ./answer2.sh 
[
  "Facebook"
]
alpine-host ~ ➜  


touch answer2.sh
chmod +x answer2.sh
echo "cat input.json | jpath '$[0,4]'" > answer2.sh

cat input.json | jpath '$[0,4]'

alpine-host ~ ➜  cat input.json | jpath '$[0,4]'
[
  "Apple",
  "Facebook"
]
alpine-host ~ ➜  cat answer2.sh
cat input.json | jpath '4'

alpine-host ~ ➜  

alpine-host ~ ➜  vi answer2.sh

alpine-host ~ ➜  

alpine-host ~ ➜  

alpine-host ~ ➜  cat answer2.sh
cat input.json | jpath '$[0,4]'

alpine-host ~ ➜  ./answer2.sh 
[
  "Apple",
  "Facebook"
]
alpine-host ~ ➜  date
Thu Sep 26 00:08:47 UTC 2024

alpine-host ~ ➜  















### 3

Develop a JSON path query to extract the expected output from the Source Data.
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  "Apple",
  "Google",
  "Microsoft",
  "Amazon",
  "Facebook"
]

Save the query to filename answer3.sh under root directory.

Query worked as expected?

touch answer3.sh
chmod +x answer3.sh
echo "cat input.json | jpath '$[0:4]'" > answer3.sh

alpine-host ~ ➜  touch answer3.sh
chmod +x answer3.sh
echo "cat input.json | jpath '$[0:4]'" > answer3.sh
-bash: 0:4: syntax error in expression (error token is ":4")

alpine-host ~ ✖ vi answer3.sh

alpine-host ~ ➜  ./answer3.sh
[
  "Apple",
  "Google",
  "Microsoft",
  "Amazon"
]
alpine-host ~ ➜  date
Thu Sep 26 00:10:30 UTC 2024

alpine-host ~ ➜  