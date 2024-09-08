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

