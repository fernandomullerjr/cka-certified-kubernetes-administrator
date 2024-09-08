



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

