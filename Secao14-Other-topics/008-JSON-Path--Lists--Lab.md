
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


cat input.json | jpath '$[0:5]'



alpine-host ~ ➜  vi answer3.sh

alpine-host ~ ➜  ./answer3.sh
[
  "Apple",
  "Google",
  "Microsoft",
  "Amazon",
  "Facebook"
]
alpine-host ~ ➜  date
Thu Sep 26 00:11:29 UTC 2024

alpine-host ~ ➜  







### 4

Develop a JSON path query to extract the expected output from the Source Data.
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  "Microsoft",
  "Amazon",
  "Facebook",
  "Coca-Cola",
  "Samsung"
]

Save the query to filename answer4.sh under root directory.

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

touch answer4.sh
chmod +x answer4.sh
echo "cat input.json | jpath '$[2:7]'" > answer4.sh






### 5

Develop a JSON path query to extract the expected output from the Source Data.
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  "McDonald's"
]

Save the query to filename answer5.sh under root directory.

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

touch answer5.sh
chmod +x answer5.sh
echo "cat input.json | jpath '$[-1:0]'" > answer5.sh

cat input.json | jpath '$[-1:0]'

cat input.json | jpath '$[9]'


alpine-host ~ ➜  cat input.json | jpath '$[9]'
[
  "McDonald's"
]
alpine-host ~ ➜  date
Thu Sep 26 00:31:57 UTC 2024

alpine-host ~ ➜  





### 6
Develop a JSON path query to extract the expected output from the Source Data.
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  "Samsung",
  "Disney",
  "Toyota",
  "McDonald's"
]

Save the query to filename answer6.sh under root directory.

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


touch answer6.sh
chmod +x answer6.sh
echo "cat input.json | jpath '$[6:10]'" > answer6.sh

alpine-host ~ ➜  cat input.json | jpath '$[6:10]'
[
  "Samsung",
  "Disney",
  "Toyota",
  "McDonald's"
]
alpine-host ~ ➜  date
Thu Sep 26 00:34:54 UTC 2024

alpine-host ~ ➜  

vi answer6.sh
cat input.json | jpath '$[6:10]'


alpine-host ~ ➜  ./answer6.sh
-bash: ./answer6.sh: Permission denied

alpine-host ~ ✖ chmod +x answer6.sh

alpine-host ~ ➜  

alpine-host ~ ➜  

alpine-host ~ ➜  ./answer6.sh
[
  "Samsung",
  "Disney",
  "Toyota",
  "McDonald's"
]
alpine-host ~ ➜  date
Thu Sep 26 00:35:42 UTC 2024

alpine-host ~ ➜  






### 7

evelop a JSON path query to extract the expected output from the Source Data.
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  "Amazon",
  "Facebook",
  "Coca-Cola",
  "Samsung",
  "Disney",
  "Toyota"
]

Save the query to filename answer7.sh under root directory.

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

vi answer7.sh
cat input.json | jpath '$[3:9]'







### 8
Develop a JSON path query to extract the expected output from the Source Data.
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  "In Ltd"
]

Save the query to filename answer8.sh under root directory.

Query worked as expected?


alpine-host ~ ✖ 

alpine-host ~ ✖ cat input.json 
[
  "Curabitur Vel Lectus Limited",
  "Libero Morbi Accumsan Industries",
  "Faucibus Ltd",
  "Eu Corp.",
  "Neque Sed Corporation",
  "Nunc Commodo Incorporated",
  "Taciti Sociosqu Industries",
  "Rutrum Lorem Corp.",
  "Proin Corp.",
  "Dolor Fusce Corporation",
  "Malesuada Ut Sem LLC",
  "Mattis Ornare PC",
  "Pede Nonummy Ut LLP",
  "Aliquam PC",
  "Eu Consulting",
  "Leo Morbi Neque Incorporated",
  "Suspendisse Institute",
  "In Tincidunt Congue Consulting",
  "Ipsum Inc.",
  "Nulla Aliquet Proin Consulting",
  "Lorem Luctus Ut Consulting",
  "Sed Sapien Nunc Associates",
  "Feugiat Tellus Industries",
  "Sem LLP",
  "Aliquam Enim Nec Inc.",
  "Feugiat Tellus PC",
  "Dis Parturient Limited",
  "Sed Dictum Corporation",
  "Eu PC",
  "Tellus Faucibus Leo Corp.",
  "Velit Company",
  "Mauris Aliquam Eu Corp.",
  "Rutrum Justo Praesent Industries",
  "Malesuada Fames Associates",
  "Vitae Sodales Foundation",
  "Amet Company",
  "Dignissim Tempor Limited",
  "Morbi Tristique Corp.",
  "Nisi Cum Sociis Foundation",
  "Donec Vitae Erat Incorporated",
  "Fringilla Industries",
  "Elit Incorporated",
  "Velit In Institute",
  "Odio A Purus Incorporated",
  "Hendrerit Id Institute",
  "Aliquet Magna Associates",
  "Dictum Eu Corporation",
  "Integer Mollis Integer Corp.",
  "Libero Proin Mi Foundation",
  "Purus Sapien Associates",
  "Fringilla Associates",
  "Ante Company",
  "Bibendum Company",
  "Convallis Ligula Donec Industries",
  "Elit Inc.",
  "Scelerisque Foundation",
  "Curae; Corp.",
  "Ornare PC",
  "Ut Ipsum Consulting",
  "Tortor Ltd",
  "Convallis Dolor Quisque Foundation",
  "Feugiat Metus Sit Corp.",
  "Nec Orci Incorporated",
  "Arcu Vel Institute",
  "Diam Duis Corp.",
  "Ut Cursus Luctus Incorporated",
  "Vitae LLP",
  "Sed Sem Company",
  "Pede Cum Ltd",
  "Laoreet Lectus Foundation",
  "Semper Dui Foundation",
  "Odio A Purus Inc.",
  "Rutrum Magna Cras PC",
  "A Felis Company",
  "Libero Et Tristique Incorporated",
  "Odio Etiam Associates",
  "Cum Sociis Natoque Industries",
  "Nulla Dignissim Maecenas Inc.",
  "Malesuada Incorporated",
  "Lorem Eu Metus Foundation",
  "In Company",
  "Class Aptent Incorporated",
  "Ac Arcu Nunc Institute",
  "Aliquet Molestie LLP",
  "Sed LLC",
  "Pede LLP",
  "Ante Ipsum Primis Corporation",
  "Eu Dolor Ltd",
  "A Aliquet Consulting",
  "Lacinia Limited",
  "Pretium Aliquet Limited",
  "Magna Nec Corp.",
  "Egestas Corporation",
  "Est Congue Associates",
  "Non Cursus Inc.",
  "Elit Fermentum Associates",
  "Consectetuer Adipiscing Elit Limited",
  "Accumsan Convallis PC",
  "In Ltd"
]

alpine-host ~ ➜  



vi answer8.sh
cat input.json | jpath '$[-1]'


at process.processTicksAndRejections (node:internal/process/task_queues:95:5)

alpine-host ~ ➜  cat input.json | jpath $[-1]
[]
alpine-host ~ ➜  cat input.json | jpath $[-1:0]
-bash: -1:0: syntax error in expression (error token is ":0")
cat: write error: Broken pipe

alpine-host ~ ✖ cat input.json | jpath .$[-1:0]
-bash: -1:0: syntax error in expression (error token is ":0")
cat: write error: Broken pipe

alpine-host ~ ✖ 

- Verificando a solução:
cat filename | jpath '$[query]'
Filename - input.json, It is an input for jpath query.
It is the query to get the required output '$[xx]'

So the final command would be like this to get output try it yourself.

cat input.json | jpath '$[-1:]'

save the command used for the query to filename answer8.sh under root directory.



alpine-host ~ ✖ cat input.json | jpath '$[-1:]'
[
  "In Ltd"
]
alpine-host ~ ➜  date
Thu Sep 26 00:46:04 UTC 2024

alpine-host ~ ➜  









### 9
Develop a JSON path query to extract the expected output from the Source Data.
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  "Consectetuer Adipiscing Elit Limited",
  "Accumsan Convallis PC",
  "In Ltd"
]

Save the query to filename answer9.sh under root directory.

Query worked as expected?


alpine-host ~ ➜  tail input.json 
  "Pretium Aliquet Limited",
  "Magna Nec Corp.",
  "Egestas Corporation",
  "Est Congue Associates",
  "Non Cursus Inc.",
  "Elit Fermentum Associates",
  "Consectetuer Adipiscing Elit Limited",
  "Accumsan Convallis PC",
  "In Ltd"
]

alpine-host ~ ➜  

cat input.json | jpath '$[-1:]'

cat input.json | jpath '$[-3:]'


alpine-host ~ ➜  cat input.json | jpath '$[-3:]'
[
  "Consectetuer Adipiscing Elit Limited",
  "Accumsan Convallis PC",
  "In Ltd"
]
alpine-host ~ ➜  


vi answer9.sh
cat input.json | jpath '$[-3:]'







### 10

Develop a JSON path query to extract the expected output from the Source Data.
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  "Magna Nec Corp.",
  "Egestas Corporation",
  "Est Congue Associates",
  "Non Cursus Inc.",
  "Elit Fermentum Associates",
  "Consectetuer Adipiscing Elit Limited"
]

Save the query to filename answer10.sh under root directory.

Query worked as expected?

alpine-host ~ ➜  tail input.json 
  "Pretium Aliquet Limited",
  "Magna Nec Corp.",
  "Egestas Corporation",
  "Est Congue Associates",
  "Non Cursus Inc.",
  "Elit Fermentum Associates",
  "Consectetuer Adipiscing Elit Limited",
  "Accumsan Convallis PC",
  "In Ltd"
]

alpine-host ~ ➜  

vi answer10.sh
cat input.json | jpath '$[-3:]'

verificando solucao

cat filename | jpath '$[query]'
Filename - input.json, It is an input for jpath query.
It is the query to get the required output '$[xx]'

So the final command would be like this to get output try it yourself.

cat input.json | jpath '$[-8:-2]'

save the command used for the query to filename answer10.sh under root directory.


vi answer10.sh
cat input.json | jpath '$[-8:-2]'




### 11

Develop a JSON path query to extract the phone numbers of first 5 users.
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  "+1 (850) 469-2827",
  "+1 (825) 558-2599",
  "+1 (946) 495-3285",
  "+1 (948) 406-2941",
  "+1 (903) 413-2132"
]

Save the query to filename answer11.sh under root directory.

Query worked as expected?

alpine-host ~ ➜  cat input.json 
[
  {
    "age": 35,
    "name": "Tameka Lane",
    "gender": "female",
    "phone": "+1 (850) 469-2827"
  },
  {
    "age": 26,
    "name": "Kristy Day",
    "gender": "female",
    "phone": "+1 (825) 558-2599"
  },
  {
    "age": 36,
    "name": "Nieves Hill",
    "gender": "male",
    "phone": "+1 (946) 495-3285"
  },
  {
    "age": 30,
    "name": "Dianna Holland",
    "gender": "female",
    "phone": "+1 (948) 406-2941"
  },
  {
    "age": 23,
    "name": "Marsh Robertson",
    "gender": "male",
    "phone": "+1 (903) 413-2132"
  },
  {
    "age": 33,
    "name": "Valenzuela Mcbride",
    "gender": "male",
    "phone": "+1 (998) 499-2074"
  },
  {
    "age": 40,
    "name": "Virginia Michael",
    "gender": "female",
    "phone": "+1 (898) 505-3869"
  },
  {
    "age": 38,
    "name": "Mueller Keller",
    "gender": "male",
    "phone": "+1 (805) 555-3665"
  },
  {
    "age": 37,
    "name": "Madeline Farley",
    "gender": "female",
    "phone": "+1 (954) 446-2747"
  },
  {
    "age": 23,
    "name": "Potter Casey",
    "gender": "male",
    "phone": "+1 (948) 538-3644"
  },
  {
    "age": 24,
    "name": "Melinda Hardy",
    "gender": "female",
    "phone": "+1 (944) 557-2486"
  },
  {
    "age": 34,
    "name": "Monique Carey",
    "gender": "female",
    "phone": "+1 (863) 424-2359"
  },
  {
    "age": 20,
    "name": "Marianne Britt",
    "gender": "female",
    "phone": "+1 (846) 462-2844"
  },
  {
    "age": 37,
    "name": "Guy Langley",
    "gender": "male",
    "phone": "+1 (905) 401-3848"
  },
  {
    "age": 40,
    "name": "Hurst Hogan",
    "gender": "male",
    "phone": "+1 (934) 587-3143"
  }
]

alpine-host ~ ➜  

vi answer11.sh
cat input.json | jpath '$[*].phone[-2]'


cat filename | jpath '$[query]'
Filename - input.json, It is an input for jpath query.
It is the query to get the required output '$[xx]'

So the final command would be like this to get output try it yourself.

cat input.json | jpath '$[0:5].phone'

save the command used for the query to filename answer11.sh under root directory.


vi answer11.sh
cat input.json | jpath '$[0:5].phone'





### 12
Develop a JSON path query to extract the age of last 5 users
A file named input.json is provided in the terminal. Provide the file as input by the cat command.
for example, the command should be like this cat filename | jpath $query

The expected output should be like this.

[
  24,
  34,
  20,
  37,
  40
]

Save the query to filename answer12.sh under root directory.

Query worked as expected?

alpine-host ~ ➜  cat input.json 
[
  {
    "age": 35,
    "name": "Tameka Lane",
    "gender": "female",
    "phone": "+1 (850) 469-2827"
  },
  {
    "age": 26,
    "name": "Kristy Day",
    "gender": "female",
    "phone": "+1 (825) 558-2599"
  },
  {
    "age": 36,
    "name": "Nieves Hill",
    "gender": "male",
    "phone": "+1 (946) 495-3285"
  },
  {
    "age": 30,
    "name": "Dianna Holland",
    "gender": "female",
    "phone": "+1 (948) 406-2941"
  },
  {
    "age": 23,
    "name": "Marsh Robertson",
    "gender": "male",
    "phone": "+1 (903) 413-2132"
  },
  {
    "age": 33,
    "name": "Valenzuela Mcbride",
    "gender": "male",
    "phone": "+1 (998) 499-2074"
  },
  {
    "age": 40,
    "name": "Virginia Michael",
    "gender": "female",
    "phone": "+1 (898) 505-3869"
  },
  {
    "age": 38,
    "name": "Mueller Keller",
    "gender": "male",
    "phone": "+1 (805) 555-3665"
  },
  {
    "age": 37,
    "name": "Madeline Farley",
    "gender": "female",
    "phone": "+1 (954) 446-2747"
  },
  {
    "age": 23,
    "name": "Potter Casey",
    "gender": "male",
    "phone": "+1 (948) 538-3644"
  },
  {
    "age": 24,
    "name": "Melinda Hardy",
    "gender": "female",
    "phone": "+1 (944) 557-2486"
  },
  {
    "age": 34,
    "name": "Monique Carey",
    "gender": "female",
    "phone": "+1 (863) 424-2359"
  },
  {
    "age": 20,
    "name": "Marianne Britt",
    "gender": "female",
    "phone": "+1 (846) 462-2844"
  },
  {
    "age": 37,
    "name": "Guy Langley",
    "gender": "male",
    "phone": "+1 (905) 401-3848"
  },
  {
    "age": 40,
    "name": "Hurst Hogan",
    "gender": "male",
    "phone": "+1 (934) 587-3143"
  }
]

alpine-host ~ ➜  

vi answer12.sh
cat input.json | jpath '$[0:5].phone'