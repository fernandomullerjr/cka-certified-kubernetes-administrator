#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "Practice Test - JSON PATH."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
## Practice Test - JSON PATH



### 1

Develop a JSON PATH query to extract the kind of object. A file named q1.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "value1"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q1.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer1.sh in the /root directory.

Is the answer1.sh contains the correct command?




alpine-host ~ ➜  ls
input.json  q1.json     q10.json    q11.json    q12.json    q13.json    q2.json     q3.json     q4.json     q5.json     q6.json     q7.json     q8.json     q9.json

alpine-host ~ ➜  cat q1
q1.json   q10.json  q11.json  q12.json  q13.json  

alpine-host ~ ➜  cat q1.json 
{
    "property1": "value1",
    "property2": "value2"
}
alpine-host ~ ➜  


alpine-host ~ ➜  cat q1.json | jpath $.property1
[
  "value1"
]
alpine-host ~ ➜  



vi answer1.sh
cat q1.json | jpath $.property1








### 2
Develop a JSON PATH query to extract the kind of object. A file named q2.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  {
    "color": "white",
    "price": "$120,000"
  }
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q2.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer2.sh in the /root directory.

Is the answer2.sh contains the correct command?

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
alpine-host ~ ➜  

vi answer2.sh
cat q2.json | jpath $.bus





### 3

Develop a JSON PATH query to extract the kind of object. A file named q3.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "$120,000"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q3.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer3.sh in the /root directory.

Is the answer3.sh contains the correct command?



alpine-host ~ ➜  cat q3.json
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
alpine-host ~ ➜  


vi answer3.sh
cat q3.json | jpath $.bus.price


alpine-host ~ ➜  cat q3.json | jpath $.bus.price
[
  "$120,000"
]
alpine-host ~ ➜  







### 4

Develop a JSON PATH query to extract the kind of object. A file named q4.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "$20,000"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q4.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer4.sh in the /root directory.

Is the answer4.sh contains the correct command?


alpine-host ~ ➜  cat q4.json
{
    "vehicles": {
        "car": {
            "color": "blue",
            "price": "$20,000"
        },
        "bus": {
            "color": "white",
            "price": "$120,000"
        }
    }
}
alpine-host ~ ➜  


vi answer4.sh
cat q4.json | jpath $.vehicles.car.price

alpine-host ~ ➜  vi answer4.sh

alpine-host ~ ➜  ./answer4.sh
-bash: ./answer4.sh: Permission denied

alpine-host ~ ✖ chmod +x answer4.sh

alpine-host ~ ➜  ./answer4.sh
[
  "$20,000"
]
alpine-host ~ ➜  








### 5

Develop a JSON PATH query to extract the kind of object. A file named q5.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
    [
        {
            "model": "KDJ39848T",
            "location": "front-right"
        },
        {
            "model": "MDJ39485DK",
            "location": "front-left"
        },
        {
            "model": "KCMDD3435K",
            "location": "rear-right"
        },
        {
            "model": "JJDH34234KK",
            "location": "rear-left"
        }
    ]
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q5.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer5.sh in the /root directory.

Is the answer5.sh contains the correct command?



alpine-host ~ ➜  cat q5.json 
{
    "car": {
        "color": "blue",
        "price": "$20,000",
        "wheels": [
            {
                "model": "KDJ39848T",
                "location": "front-right"
            },
            {
                "model": "MDJ39485DK",
                "location": "front-left"
            },
            {
                "model": "KCMDD3435K",
                "location": "rear-right"
            },
            {
                "model": "JJDH34234KK",
                "location": "rear-left"
            }
        ]
    }
}
alpine-host ~ ➜  




vi answer5.sh
cat q5.json | jpath $.car.wheels[*]
chmod +x answer5.sh


alpine-host ~ ➜  cat q5.json | jpath $.car.wheels[*]
[
  {
    "model": "KDJ39848T",
    "location": "front-right"
  },
  {
    "model": "MDJ39485DK",
    "location": "front-left"
  },
  {
    "model": "KCMDD3435K",
    "location": "rear-right"
  },
  {
    "model": "JJDH34234KK",
    "location": "rear-left"
  }
]
alpine-host ~ ➜  


alpine-host ~ ➜  ./answer5.sh
[
  {
    "model": "KDJ39848T",
    "location": "front-right"
  },
  {
    "model": "MDJ39485DK",
    "location": "front-left"
  },
  {
    "model": "KCMDD3435K",
    "location": "rear-right"
  },
  {
    "model": "JJDH34234KK",
    "location": "rear-left"
  }
]
alpine-host ~ ➜  date
Sun Sep  8 21:17:14 UTC 2024

alpine-host ~ ➜  


acusou incorreta

ajustando

vi answer5.sh
cat q5.json | jpath $.car.wheels

agora foi!
ok!







### 6

Develop a JSON PATH query to extract the kind of object. A file named q6.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  {
    "model": "KCMDD3435K",
    "location": "rear-right"
  }
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q6.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer6.sh in the /root directory.

Is the answer6.sh contains the correct command?



alpine-host ~ ➜  cat q6.json
{
    "car": {
        "color": "blue",
        "price": "$20,000",
        "wheels": [
            {
                "model": "KDJ39848T",
                "location": "front-right"
            },
            {
                "model": "MDJ39485DK",
                "location": "front-left"
            },
            {
                "model": "KCMDD3435K",
                "location": "rear-right"
            },
            {
                "model": "JJDH34234KK",
                "location": "rear-left"
            }
        ]
    }
}
alpine-host ~ ➜  


touch answer6.sh
chmod +x answer6.sh
vi answer6.sh
cat q6.json | jpath $.car.wheels[?(@.model == 'KCMDD3435K')]

alpine-host ~ ➜  cat q6.json | jpath $.car.wheels[?(@.model == 'KCMDD3435K')]
[]
alpine-host ~ ➜  


incorreto

revisando

cat q6.json | jpath $.car.wheels[?(@.model == 'KCMDD3435K')]


cat q6.json | jpath $.car.wheels[?(@.location == 'rear-right')]


alpine-host ~ ➜  cat q6.json | jpath $.car.wheels[?(@.location == 'rear-right')]
[]
alpine-host ~ ➜  




$.car.wheels[?(@.location == 'rear-right')]

cat q6.json | jpath $.car.wheels[?(@.location == 'rear-right')]



Alternativa 1

jsonpath

$..wheels[?(@.location=='rear-right')]

cat q6.json | jpath $..wheels[?(@.location=='rear-right')]

alpine-host ~ ➜  cat q6.json | jpath $..wheels[?(@.location=='rear-right')]
[]
alpine-host ~ ➜  


Alternativa 2: Simplificação

Se o seu interpretador JSONPath tem dificuldades com comparações, você pode tentar abordar o problema em dois passos:

    Extraia todos os objetos da lista wheels.
    Realize o filtro manualmente (fora do JSONPath) ou use ferramentas alternativas como jq para manipular o JSON.

Por exemplo, usando jq no terminal:

bash

cat q6.json | jq '.car.wheels[] | select(.location == "rear-right")'

alpine-host ~ ➜  vi answer6.sh 

alpine-host ~ ➜  

alpine-host ~ ➜  

alpine-host ~ ➜  

alpine-host ~ ➜  ./answer6.sh 
{
  "model": "KCMDD3435K",
  "location": "rear-right"
}

alpine-host ~ ➜  date
Sun Sep  8 21:29:34 UTC 2024

alpine-host ~ ➜  


acusou incorreta, mesmo assim


- Verificando a solução

cat q6.json | jpath $.car.wheels[2]
[
  {
    "model": "KCMDD3435K",
    "location": "rear-right"
  }
]

So you need to write the cat q6.json | jpath $.car.wheels[2] into file answer6.sh.


- Na solução não é usada a condicional
é acessado via posição, index, etc





# ###################################################################################################################### 
# ###################################################################################################################### 
## Practice Test - JSON PATH


### 1
Develop a JSON PATH query to extract the kind of object. A file named q1.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "value1"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q1.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer1.sh in the /root directory.

Is the answer1.sh contains the correct command?

vi answer1.sh
cat q1.json | jpath $.property1


alpine-host ~ ➜  ./answer1.sh
-bash: ./answer1.sh: Permission denied

alpine-host ~ ✖ chmod +x answer1.sh

alpine-host ~ ➜  ./answer1.sh
[
  "value1"
]
alpine-host ~ ➜  date
Fri Sep 13 00:34:55 UTC 2024

alpine-host ~ ➜  






### 2
Develop a JSON PATH query to extract the kind of object. A file named q2.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  {
    "color": "white",
    "price": "$120,000"
  }
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q2.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer2.sh in the /root directory.

Is the answer2.sh contains the correct command?


vi answer2.sh
chmod +x answer2.sh
cat q2.json | jpath $.bus


alpine-host ~ ➜  chmod +x answer2.sh

alpine-host ~ ➜  ./answer2.sh 
[
  {
    "color": "white",
    "price": "$120,000"
  }
]
alpine-host ~ ➜  







### 3
Develop a JSON PATH query to extract the kind of object. A file named q3.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "$120,000"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q3.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer3.sh in the /root directory.

Is the answer3.sh contains the correct command?



### 3


Develop a JSON PATH query to extract the kind of object. A file named q3.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "$120,000"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q3.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer3.sh in the /root directory.

Is the answer3.sh contains the correct command?



vi answer3.sh
chmod +x answer3.sh
cat q3.json | jpath $.bus.price







### 4
Develop a JSON PATH query to extract the kind of object. A file named q4.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "$20,000"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q4.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer4.sh in the /root directory.

Is the answer4.sh contains the correct command?


vi answer4.sh
chmod +x answer4.sh
cat q4.json | jpath $.vehicles.car.price






### 5

Develop a JSON PATH query to extract the kind of object. A file named q5.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
    [
        {
            "model": "KDJ39848T",
            "location": "front-right"
        },
        {
            "model": "MDJ39485DK",
            "location": "front-left"
        },
        {
            "model": "KCMDD3435K",
            "location": "rear-right"
        },
        {
            "model": "JJDH34234KK",
            "location": "rear-left"
        }
    ]
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q5.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer5.sh in the /root directory.

Is the answer5.sh contains the correct command?

alpine-host ~ ➜  cat q5.json 
{
    "car": {
        "color": "blue",
        "price": "$20,000",
        "wheels": [
            {
                "model": "KDJ39848T",
                "location": "front-right"
            },
            {
                "model": "MDJ39485DK",
                "location": "front-left"
            },
            {
                "model": "KCMDD3435K",
                "location": "rear-right"
            },
            {
                "model": "JJDH34234KK",
                "location": "rear-left"
            }
        ]
    }
}
alpine-host ~ ➜  

vi answer5.sh
chmod +x answer5.sh
cat q5.json | jpath $.car.wheels







### 6
Develop a JSON PATH query to extract the kind of object. A file named q6.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  {
    "model": "KCMDD3435K",
    "location": "rear-right"
  }
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q6.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer6.sh in the /root directory.

Is the answer6.sh contains the correct command?

alpine-host ~ ➜  cat q6.json 
{
    "car": {
        "color": "blue",
        "price": "$20,000",
        "wheels": [
            {
                "model": "KDJ39848T",
                "location": "front-right"
            },
            {
                "model": "MDJ39485DK",
                "location": "front-left"
            },
            {
                "model": "KCMDD3435K",
                "location": "rear-right"
            },
            {
                "model": "JJDH34234KK",
                "location": "rear-left"
            }
        ]
    }
}
alpine-host ~ ➜  


touch answer6.sh
chmod +x answer6.sh
vi answer6.sh
cat q6.json | jpath $.car.wheels[2]






### 7

Develop a JSON PATH query to extract the kind of object. A file named q7.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "KCMDD3435K"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q7.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer7.sh in the /root directory.

Is the answer7.sh contains the correct command?


alpine-host ~ ➜  

alpine-host ~ ➜  cat q7.json 
{
    "car": {
        "color": "blue",
        "price": "$20,000",
        "wheels": [
            {
                "model": "KDJ39848T",
                "location": "front-right"
            },
            {
                "model": "MDJ39485DK",
                "location": "front-left"
            },
            {
                "model": "KCMDD3435K",
                "location": "rear-right"
            },
            {
                "model": "JJDH3434KK",
                "location": "rear-left"
            }
        ]
    }
}
alpine-host ~ ➜  


touch answer7.sh
chmod +x answer7.sh
vi answer7.sh
cat q7.json | jpath $.car.wheels[2].model


alpine-host ~ ➜  cat q7.json | jpath $.car.wheels[2].model
[
  "KCMDD3435K"
]
alpine-host ~ ➜  








### 8

Develop a JSON PATH query to extract the kind of object. A file named q8.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  [
    {
      "month": "june",
      "amount": 1400
    },
    {
      "month": "july",
      "amount": 2400
    },
    {
      "month": "august",
      "amount": 3400
    }
  ]
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q8.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer8.sh in the /root directory.

Is the answer8.sh contains the correct command?

alpine-host ~ ➜  cat q8.json 
{
    "employee": {
        "name": "john",
        "gender": "male",
        "age": 24,
        "address": {
            "city": "edison",
            "state": "new jersey",
            "country": "united states"
        },
        "payslips": [
            {
                "month": "june",
                "amount": 1400
            },
            {
                "month": "july",
                "amount": 2400
            },
            {
                "month": "august",
                "amount": 3400
            }
        ]
    }
}
alpine-host ~ ➜  

alpine-host ~ ➜  cat q8.json | jpath $.employee.payslips
[
  [
    {
      "month": "june",
      "amount": 1400
    },
    {
      "month": "july",
      "amount": 2400
    },
    {
      "month": "august",
      "amount": 3400
    }
  ]
]
alpine-host ~ ➜  date
Fri Sep 13 00:54:57 UTC 2024

alpine-host ~ ➜  

touch answer8.sh
chmod +x answer8.sh
vi answer8.sh
cat q8.json | jpath $.employee.payslips







### 9

Develop a JSON PATH query to extract the kind of object. A file named q9.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  {
    "month": "august",
    "amount": 3400
  }
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q9.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer9.sh in the /root directory.

Is the answer9.sh contains the correct command?

alpine-host ~ ➜  cat q9.json 
{
    "employee": {
        "name": "john",
        "gender": "male",
        "age": 24,
        "address": {
            "city": "edison",
            "state": "new jersey",
            "country": "united states"
        },
        "payslips": [
            {
                "month": "june",
                "amount": 1400
            },
            {
                "month": "july",
                "amount": 2400
            },
            {
                "month": "august",
                "amount": 3400
            }
        ]
    }
}
alpine-host ~ ➜  



alpine-host ~ ➜  cat q9.json | jpath $.employee.payslips[2]
[
  {
    "month": "august",
    "amount": 3400
  }
]
alpine-host ~ ➜  

touch answer9.sh
chmod +x answer9.sh
vi answer9.sh
cat q9.json | jpath $.employee.payslips[2]

alpine-host ~ ➜  

alpine-host ~ ➜  ./answer9.sh
[
  {
    "month": "august",
    "amount": 3400
  }
]
alpine-host ~ ➜  









### 10
Develop a JSON PATH query to extract the kind of object. A file named q10.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  3400
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q10.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer10.sh in the /root directory.

Is the answer10.sh contains the correct command?

alpine-host ~ ➜  cat q10.json 
{
    "employee": {
        "name": "john",
        "gender": "male",
        "age": 24,
        "address": {
            "city": "edison",
            "state": "new jersey",
            "country": "united states"
        },
        "payslips": [
            {
                "month": "june",
                "amount": 1400
            },
            {
                "month": "july",
                "amount": 2400
            },
            {
                "month": "august",
                "amount": 3400
            }
        ]
    }
}
alpine-host ~ ➜  

alpine-host ~ ➜  cat q10.json | jpath $.employee.payslips[2].amount
[
  3400
]
alpine-host ~ ➜  


touch answer10.sh
chmod +x answer10.sh
vi answer10.sh
cat q10.json | jpath $.employee.payslips[2].amount

alpine-host ~ ➜  ./answer10.sh
[
  3400
]
alpine-host ~ ➜  












### 11

Develop a JSON PATH query to extract the kind of object. A file named q11.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  {
    "id": "914",
    "firstname": "Malala",
    "surname": "Yousafzai",
    "motivation": "\"for their struggle against the suppression of children and young people and for the right of all children to education\"",
    "share": "2"
  }
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q11.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer11.sh in the /root directory.

Is the answer11.sh contains the correct command?

alpine-host ~ ➜  cat q11.json 
{
    "prizes": [
        {
            "year": "2018",
            "category": "physics",
            "overallMotivation": "\"for groundbreaking inventions in the field of laser physics\"",
            "laureates": [
                {
                    "id": "960",
                    "firstname": "Arthur",
                    "surname": "Ashkin",
                    "motivation": "\"for the optical tweezers and their application to biological systems\"",
                    "share": "2"
                },
                {
                    "id": "961",
                    "firstname": "Gérard",
                    "surname": "Mourou",
                    "motivation": "\"for their method of generating high-intensity, ultra-short optical pulses\"",
                    "share": "4"
                },
                {
                    "id": "962",
                    "firstname": "Donna",
                    "surname": "Strickland",
                    "motivation": "\"for their method of generating high-intensity, ultra-short optical pulses\"",
                    "share": "4"
                }
            ]
        },
        {
            "year": "2018",
            "category": "chemistry",
            "laureates": [
                {
                    "id": "963",
                    "firstname": "Frances H.",
                    "surname": "Arnold",
                    "motivation": "\"for the directed evolution of enzymes\"",
                    "share": "2"
                },
                {
                    "id": "964",
                    "firstname": "George P.",
                    "surname": "Smith",
                    "motivation": "\"for the phage display of peptides and antibodies\"",
                    "share": "4"
                },
                {
                    "id": "965",
                    "firstname": "Sir Gregory P.",
                    "surname": "Winter",
                    "motivation": "\"for the phage display of peptides and antibodies\"",
                    "share": "4"
                }
            ]
        },
        {
            "year": "2018",
            "category": "medicine",
            "laureates": [
                {
                    "id": "958",
                    "firstname": "James P.",
                    "surname": "Allison",
                    "motivation": "\"for their discovery of cancer therapy by inhibition of negative immune regulation\"",
                    "share": "2"
                },
                {
                    "id": "959",
                    "firstname": "Tasuku",
                    "surname": "Honjo",
                    "motivation": "\"for their discovery of cancer therapy by inhibition of negative immune regulation\"",
                    "share": "2"
                }
            ]
        },
        {
            "year": "2018",
            "category": "peace",
            "laureates": [
                {
                    "id": "966",
                    "firstname": "Denis",
                    "surname": "Mukwege",
                    "motivation": "\"for their efforts to end the use of sexual violence as a weapon of war and armed conflict\"",
                    "share": "2"
                },
                {
                    "id": "967",
                    "firstname": "Nadia",
                    "surname": "Murad",
                    "motivation": "\"for their efforts to end the use of sexual violence as a weapon of war and armed conflict\"",
                    "share": "2"
                }
            ]
        },
        {
            "year": "2018",
            "category": "economics",
            "laureates": [
                {
                    "id": "968",
                    "firstname": "William D.",
                    "surname": "Nordhaus",
                    "motivation": "\"for integrating climate change into long-run macroeconomic analysis\"",
                    "share": "2"
                },
                {
                    "id": "969",
                    "firstname": "Paul M.",
                    "surname": "Romer",
                    "motivation": "\"for integrating technological innovations into long-run macroeconomic analysis\"",
                    "share": "2"
                }
            ]
        },
        {
            "year": "2014",
            "category": "peace",
            "laureates": [
                {
                    "id": "913",
                    "firstname": "Kailash",
                    "surname": "Satyarthi",
                    "motivation": "\"for their struggle against the suppression of children and young people and for the right of all children to education\"",
                    "share": "2"
                },
                {
                    "id": "914",
                    "firstname": "Malala",
                    "surname": "Yousafzai",
                    "motivation": "\"for their struggle against the suppression of children and young people and for the right of all children to education\"",
                    "share": "2"
                }
            ]
        },
        {
            "year": "2017",
            "category": "physics",
            "laureates": [
                {
                    "id": "941",
                    "firstname": "Rainer",
                    "surname": "Weiss",
                    "motivation": "\"for decisive contributions to the LIGO detector and the observation of gravitational waves\"",
                    "share": "2"
                },
                {
                    "id": "942",
                    "firstname": "Barry C.",
                    "surname": "Barish",
                    "motivation": "\"for decisive contributions to the LIGO detector and the observation of gravitational waves\"",
                    "share": "4"
                },
                {
                    "id": "943",
                    "firstname": "Kip S.",
                    "surname": "Thorne",
                    "motivation": "\"for decisive contributions to the LIGO detector and the observation of gravitational waves\"",
                    "share": "4"
                }
            ]
        },
        {
            "year": "2017",
            "category": "chemistry",
            "laureates": [
                {
                    "id": "944",
                    "firstname": "Jacques",
                    "surname": "Dubochet",
                    "motivation": "\"for developing cryo-electron microscopy for the high-resolution structure determination of biomolecules in solution\"",
                    "share": "3"
                },
                {
                    "id": "945",
                    "firstname": "Joachim",
                    "surname": "Frank",
                    "motivation": "\"for developing cryo-electron microscopy for the high-resolution structure determination of biomolecules in solution\"",
                    "share": "3"
                },
                {
                    "id": "946",
                    "firstname": "Richard",
                    "surname": "Henderson",
                    "motivation": "\"for developing cryo-electron microscopy for the high-resolution structure determination of biomolecules in solution\"",
                    "share": "3"
                }
            ]
        },
        {
            "year": "2017",
            "category": "medicine",
            "laureates": [
                {
                    "id": "938",
                    "firstname": "Jeffrey C.",
                    "surname": "Hall",
                    "motivation": "\"for their discoveries of molecular mechanisms controlling the circadian rhythm\"",
                    "share": "3"
                },
                {
                    "id": "939",
                    "firstname": "Michael",
                    "surname": "Rosbash",
                    "motivation": "\"for their discoveries of molecular mechanisms controlling the circadian rhythm\"",
                    "share": "3"
                },
                {
                    "id": "940",
                    "firstname": "Michael W.",
                    "surname": "Young",
                    "motivation": "\"for their discoveries of molecular mechanisms controlling the circadian rhythm\"",
                    "share": "3"
                }
            ]
        }
    ]
}
alpine-host ~ ➜  





alpine-host ~ ➜  cat q11.json | jpath $.prizes[5]
[
  {
    "year": "2014",
    "category": "peace",
    "laureates": [
      {
        "id": "913",
        "firstname": "Kailash",
        "surname": "Satyarthi",
        "motivation": "\"for their struggle against the suppression of children and young people and for the right of all children to education\"",
        "share": "2"
      },
      {
        "id": "914",
        "firstname": "Malala",
        "surname": "Yousafzai",
        "motivation": "\"for their struggle against the suppression of children and young people and for the right of all children to education\"",
        "share": "2"
      }
    ]
  }
]
alpine-host ~ ➜  


alpine-host ~ ➜  cat q11.json | jpath $.prizes[5].laureates[1]
[
  {
    "id": "914",
    "firstname": "Malala",
    "surname": "Yousafzai",
    "motivation": "\"for their struggle against the suppression of children and young people and for the right of all children to education\"",
    "share": "2"
  }
]
alpine-host ~ ➜  

touch answer11.sh
chmod +x answer11.sh
vi answer11.sh
cat q11.json | jpath $.prizes[5].laureates[1]












### 12

Develop a JSON PATH query to extract the kind of object. A file named q12.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "car"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q12.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer12.sh in the /root directory.

Is the answer12.sh contains the correct command?


alpine-host ~ ➜  cat q12.json 
[
    "car",
    "bus",
    "truck",
    "bike"
]
alpine-host ~ ➜  


alpine-host ~ ➜  cat q12.json | jpath $[0]
[
  "car"
]
alpine-host ~ ➜  

touch answer12.sh
chmod +x answer12.sh
vi answer12.sh
cat q12.json | jpath $[0]











### 13
Develop a JSON PATH query to extract the kind of object. A file named q13.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "car",
  "bike"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q13.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer13.sh in the /root directory.

Is the answer13.sh contains the correct command?


alpine-host ~ ➜  cat q13.json 
[
    "car",
    "bus",
    "truck",
    "bike"
]
alpine-host ~ ➜  




touch answer13.sh
chmod +x answer13.sh
vi answer13.sh
cat q13.json | jpath $[0,3]

cat q13.json | jpath $[-1:]



O comportamento que você está observando ao tentar acessar os índices específicos no JSON é peculiar ao comando que você está utilizando, como o `jpath`. Parece que o comando está retornando apenas o último valor no array ao usar múltiplos índices.

Para obter o comportamento desejado e retornar tanto `"car"` quanto `"bike"`, você pode tentar ajustar sua consulta para garantir que ela capture ambos os índices de maneira apropriada.

Com base na estrutura JSON que você forneceu, para acessar o primeiro (`0`) e o último (`3`) elementos do array, você pode tentar com uma das seguintes abordagens:

1. **Verifique a sintaxe e suporte do `jpath`:** Certifique-se de que ele suporte a seleção de múltiplos índices, pois o comportamento que você descreve sugere que pode haver uma limitação nesse comando. Tente usar outra ferramenta como `jq`, que é amplamente utilizado para manipulação de JSON no terminal.

2. **Usar `jq`:**
   Se o `jq` estiver disponível, ele permitirá o comportamento desejado. Veja como fazer isso:

   ### Exemplo usando `jq`:
   ```bash
   cat q13.json | jq '.[0, 3]'
   ```

   Isso retornará:

   ```json
   [
     "car",
     "bike"
   ]
   ```

3. **Usar slicing de arrays com `jq`:**
   Para acessar uma fatia do array, como os primeiros e últimos elementos, você também pode usar `jq` assim:

   ```bash
   cat q13.json | jq '.[0, -1]'
   ```

   Isso também retornaria:

   ```json
   [
     "car",
     "bike"
   ]
   ```

Se você estiver restrito a usar `jpath`, recomendo verificar a documentação ou suporte da ferramenta para múltiplos índices, mas se possível, `jq` pode resolver seu problema de forma eficaz.