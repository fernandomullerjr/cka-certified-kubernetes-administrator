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

alpine-host ~ ➜  cat q3.json | jpath $[*].*.price
-bash: *: syntax error: operand expected (error token is "*")
cat: write error: Broken pipe

alpine-host ~ ✖ cat q3.json | jpath $*.*.price
Error: Parse error on line 1:
.*.price
^
Expecting 'DOLLAR', 'STAR', 'IDENTIFIER', 'SCRIPT_EXPRESSION', 'INTEGER', 'END', got 'DOT'
    at Parser.parseError (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/generated/parser.js:166:15)
    at Parser.parser.yy.parseError (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/parser.js:13:17)
    at Parser.parse (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/generated/parser.js:224:22)
    at JSONPath.nodes (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/index.js:118:26)
    at JSONPath.query (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/index.js:94:22)
    at query (/usr/local/lib/node_modules/jsonpath-cli/bin/index.js:16:29)
    at process.processTicksAndRejections (node:internal/process/task_queues:95:5)

alpine-host ~ ➜  cat q3.json | jpath $.*.*.price
[
  "$20,000",
  "$120,000"
]
alpine-host ~ ➜  

touch answer3.sh
chmod +x answer3.sh
vi answer3.sh
cat q3.json | jpath $.*.*.price
~~~~






### 4 
Develop a JSON PATH query to extract the kind of object. A file named q4.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "KDJ39848T",
  "MDJ39485DK",
  "KCMDD3435K",
  "JJDH34234KK"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q4.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer4.sh in /root directory.

Is the answer4.sh contains the correct command?

~~~~BASH
alpine-host ~ ➜  cat q4.json 
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

alpine-host ~ ➜  cat q4.json | jpath $.*.*.model
[]
alpine-host ~ ➜  cat q4.json | jpath $.*.model
[
  "KDJ39848T",
  "MDJ39485DK",
  "KCMDD3435K",
  "JJDH34234KK"
]
alpine-host ~ ➜  


touch answer4.sh
chmod +x answer4.sh
vi answer4.sh
cat q4.json | jpath $.*.model
~~~~






### 5
Develop a JSON PATH query to extract the kind of object. A file named q5.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "KDJ39848T",
  "MDJ39485DK",
  "KCMDD3435K",
  "JJDH34234KK"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q5.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer5.sh in /root directory.

Is the answer5.sh contains the correct command?

~~~~BASH


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
alpine-host ~ ➜  cat q5.json | jpath $.*.wheels.model
[]
alpine-host ~ ➜  cat q5.json | jpath $.*.wheels.model.*
[]
alpine-host ~ ➜  cat q5.json | jpath $.*.wheels
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
alpine-host ~ ➜  cat q5.json | jpath $.*.wheels.*.model
[
  "KDJ39848T",
  "MDJ39485DK",
  "KCMDD3435K",
  "JJDH34234KK"
]
alpine-host ~ ➜  

touch answer5.sh
chmod +x answer5.sh
vi answer5.sh
cat q5.json | jpath $.*.wheels.*.model
~~~~





### 6

Develop a JSON PATH query to extract the kind of object. A file named q6.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "KDJ39848T",
  "MDJ39485DK",
  "KCMDD3435K",
  "JJDH34234KK",
  "BBBB39848T",
  "BBBB9485DK",
  "BBBB3435K",
  "BBBB4234KK"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q6.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer6.sh in /root directory.

Is the answer6.sh contains the correct command?


~~~~BASH

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
    },
    "bus": {
        "color": "white",
        "price": "$120,000",
        "wheels": [
            {
                "model": "BBBB39848T",
                "location": "front-right"
            },
            {
                "model": "BBBB9485DK",
                "location": "front-left"
            },
            {
                "model": "BBBB3435K",
                "location": "rear-right"
            },
            {
                "model": "BBBB4234KK",
                "location": "rear-left"
            }
        ]
    }
}
alpine-host ~ ➜  
alpine-host ~ ➜  cat q6.json | jpath $.*.wheels.*.model
[
  "KDJ39848T",
  "MDJ39485DK",
  "KCMDD3435K",
  "JJDH34234KK",
  "BBBB39848T",
  "BBBB9485DK",
  "BBBB3435K",
  "BBBB4234KK"
]
alpine-host ~ ➜  

touch answer6.sh
chmod +x answer6.sh
vi answer6.sh
cat q6.json | jpath $.*.wheels.*.model
~~~~






### 7
Develop a JSON PATH query to extract the kind of object. A file named q7.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  1400,
  2400,
  3400
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q7.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer7.sh in /root directory.

Is the answer7.sh contains the correct command?

~~~~BASH

alpine-host ~ ➜  cat q7.json 
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


alpine-host ~ ➜  cat q7.json | jpath $.*.payslips.*.amount
[
  1400,
  2400,
  3400
]
alpine-host ~ ➜  

touch answer7.sh
chmod +x answer7.sh
vi answer7.sh
cat q7.json | jpath $.*.payslips.*.amount
~~~~





### 8

Develop a JSON PATH query to extract the kind of object. A file named q8.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "Arthur",
  "Gérard",
  "Donna",
  "Frances H.",
  "George P.",
  "Sir Gregory P.",
  "James P.",
  "Tasuku",
  "Denis",
  "Nadia",
  "William D.",
  "Paul M.",
  "Kailash",
  "Malala",
  "Rainer",
  "Barry C.",
  "Kip S.",
  "Jacques",
  "Joachim",
  "Richard",
  "Jeffrey C.",
  "Michael",
  "Michael W."
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q8.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer8.sh in /root directory.

Is the answer8.sh contains the correct command?

~~~~bash

alpine-host ~ ➜  cat q8.json
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


alpine-host ~ ➜  cat q8.json | jpath $.*.*.laureates.*.firstname
[
  "Arthur",
  "Gérard",
  "Donna",
  "Frances H.",
  "George P.",
  "Sir Gregory P.",
  "James P.",
  "Tasuku",
  "Denis",
  "Nadia",
  "William D.",
  "Paul M.",
  "Kailash",
  "Malala",
  "Rainer",
  "Barry C.",
  "Kip S.",
  "Jacques",
  "Joachim",
  "Richard",
  "Jeffrey C.",
  "Michael",
  "Michael W."
]
alpine-host ~ ➜  


touch answer8.sh
chmod +x answer8.sh
vi answer8.sh
cat q8.json | jpath $.*.*.laureates.*.firstname
~~~~





### 9

Develop a JSON PATH query to extract the kind of object. A file named q9.json is provided in the terminal. Your task is to develop a JSON path query to extract the expected output from the Source Data.

Expected output should be like this

[
  "Kailash",
  "Malala"
]

You can test the JSON PATH query as below (noted that the query below is just sample, not a solution).

cat q9.json | jpath $.property1
[
  "value1"
]

If the output matched the expectation then write the whole command into a file named answer9.sh in /root directory.

Is the answer9.sh contains the correct command?

~~~~bash


alpine-host ~ ➜  cat q9.json 
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


erro



alpine-host ~ ➜  cat q9.json | jpath $.*.[4].laureates.*.firstname
Error: Parse error on line 1:
$.*.[4].laureates.*.firs
----^
Expecting 'STAR', 'IDENTIFIER', 'SCRIPT_EXPRESSION', 'INTEGER', 'END', got '['
    at Parser.parseError (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/generated/parser.js:166:15)
    at Parser.parser.yy.parseError (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/parser.js:13:17)
    at Parser.parse (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/generated/parser.js:224:22)
    at JSONPath.nodes (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/index.js:118:26)
    at JSONPath.query (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/index.js:94:22)
    at query (/usr/local/lib/node_modules/jsonpath-cli/bin/index.js:16:29)
    at process.processTicksAndRejections (node:internal/process/task_queues:95:5)

alpine-host ~ ➜  


alpine-host ~ ➜  cat q9.json | jpath $.*.*.laureates[4].*.firstname
[]
alpine-host ~ ➜  cat q9.json | jpath $.*.*.laureates
[
  [
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
  ],
  [
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
  ],
  [
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
  ],
  [
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
  ],
  [
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
  ],
  [
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
  ],
  [
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
  ],
  [
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
  ],
  [
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
]
alpine-host ~ ➜  

alpine-host ~ ➜  

alpine-host ~ ➜  cat q9.json | jpath $.*.*.laureates.*.firstname
[
  "Arthur",
  "Gérard",
  "Donna",
  "Frances H.",
  "George P.",
  "Sir Gregory P.",
  "James P.",
  "Tasuku",
  "Denis",
  "Nadia",
  "William D.",
  "Paul M.",
  "Kailash",
  "Malala",
  "Rainer",
  "Barry C.",
  "Kip S.",
  "Jacques",
  "Joachim",
  "Richard",
  "Jeffrey C.",
  "Michael",
  "Michael W."
]
alpine-host ~ ➜  ^[[200~cat q9.json | jpath $.*.*.laureates.[].firstname~^C

alpine-host ~ ✖ cat q9.json | jpath $.*.*.laureates.[].firstname
Error: Parse error on line 1:
$.*.*.laureates.[].firstname
----------------^
Expecting 'STAR', 'IDENTIFIER', 'SCRIPT_EXPRESSION', 'INTEGER', 'END', got '['
    at Parser.parseError (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/generated/parser.js:166:15)
    at Parser.parser.yy.parseError (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/parser.js:13:17)
    at Parser.parse (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/generated/parser.js:224:22)
    at JSONPath.nodes (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/index.js:118:26)
    at JSONPath.query (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/index.js:94:22)
    at query (/usr/local/lib/node_modules/jsonpath-cli/bin/index.js:16:29)
    at process.processTicksAndRejections (node:internal/process/task_queues:95:5)

alpine-host ~ ➜  cat q9.json | jpath $.*.*.laureates[4].*.firstname
[]
alpine-host ~ ➜  


cat q9.json | jpath $.*.*.laureates[4].*.firstname


alpine-host ~ ➜  cat q9.json | jpath $.*.*.laureates[4].*.firstname
[]
alpine-host ~ ➜  


cat q9.json | jpath $.*.*.laureates.*.firstname
cat q9.json | jpath $.*.*.laureates.[].firstname

cat q9.json | jpath $.*.*.laureates[4].firstname
alpine-host ~ ➜  cat q9.json | jpath $.*.*.laureates[4].firstname
[]
alpine-host ~ ➜  

cat q9.json | jpath $.*.*.laureates[4].firstname

alpine-host ~ ➜  cat q9.json | jpath $.*.*.laureates.*.firstname[3]
[]
alpine-host ~ ➜  cat q9.json | jpath $.*.*.laureates.*.firstname.[3]
Error: Parse error on line 1:
...ureates.*.firstname.[3]
-----------------------^
Expecting 'STAR', 'IDENTIFIER', 'SCRIPT_EXPRESSION', 'INTEGER', 'END', got '['
    at Parser.parseError (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/generated/parser.js:166:15)
    at Parser.parser.yy.parseError (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/parser.js:13:17)
    at Parser.parse (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/generated/parser.js:224:22)
    at JSONPath.nodes (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/index.js:118:26)
    at JSONPath.query (/usr/local/lib/node_modules/jsonpath-cli/node_modules/jsonpath/lib/index.js:94:22)
    at query (/usr/local/lib/node_modules/jsonpath-cli/bin/index.js:16:29)
    at process.processTicksAndRejections (node:internal/process/task_queues:95:5)

alpine-host ~ ➜  


consultando a solucao

cat q9.json | jpath '$.prizes[?(@.year == 2014)].laureates[*].firstname'
[
  "Kailash",
  "Malala"
]

So you need to write the cat q9.json | jpath '$.prizes[?(@.year == 2014)].laureates[*].firstname' into file answer9.sh.



alpine-host ~ ➜  cat q9.json | jpath '$.prizes[?(@.year == 2014)].laureates[*].firstname'
[
  "Kailash",
  "Malala"
]
alpine-host ~ ➜  


touch answer9.sh
chmod +x answer9.sh
vi answer9.sh
cat q9.json | jpath '$.prizes[?(@.year == 2014)].laureates[*].firstname'
~~~~


