#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "Labs YAML."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
## Labs YAML



Which of the following is used to separate the key and value in YAML?

RESPOSTA:
colon = 2 pontos




How many array keys are there in the following yaml snippet?

Fruits:
  - Orange
  - Apple
  - Banana
Vegetables:
  - Carrot
  - CauliFlower
  - Tomato

RESPOSTA:
2



Which of the following statements is true?

A. Dictionary is an unordered collection whereas list is an ordered collection.


B. Dictionary is an ordered collection whereas list is an unordered collection.


C. Dictionary and list, both are an ordered collection.


D. Dictionary and list, both are an unordered collection.


RESPOSTA:
A




There is a yaml file named practice.yaml under /home/bob/playbooks/ directory with a key property1 and value value1.


Add an additional key named property2 and value value2.

Added an additional key named "property2" and value "value2" in "practice.yaml" file?


[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
property1: value1
[bob@student-node ~]$ 


property1: value1
property2: value2

[bob@student-node ~]$ vi /home/bob/playbooks/practice.yaml 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
property1: value1
property2: value2
[bob@student-node ~]$ 




We have updated the /home/bob/playbooks/practice.yaml file with the key name and value apple. Add some additional properties (given below) to the dictionary.


name= apple
color= red
weight= 90g

Added some additional properties to the dictionary in "practice.yaml" file?

[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
name: apple
[bob@student-node ~]$ 

name: apple
name: apple
color: red
weight: 90g


[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
name: apple
name: apple
color: red
weight: 90g
[bob@student-node ~]$ date
Sat Jul 27 03:02:38 UTC 2024
[bob@student-node ~]$ 




We have updated the /home/bob/playbooks/practice.yaml file with a dictionary named employee. Add the remaining properties to it using information from the table below.

Key/Property 	Value
name 	john
gender 	male
age 	24

Added the remaining properties to the "employee" dictionary in "practice.yaml " file, using the information from the given table?


[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employee:
  name: john
[bob@student-node ~]$ 


employee:
  name: john
  gender: male
  age: 24


[bob@student-node ~]$ 
[bob@student-node ~]$ vi /home/bob/playbooks/practice.yaml 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employee:
  name: john
  gender: male
  age: 24
[bob@student-node ~]$ date
Sat Jul 27 03:06:08 UTC 2024
[bob@student-node ~]$ 






Now, update the /home/bob/playbooks/practice.yaml file with a dictionary in dictionary.

Add a dictionary named address to add the address information in this file.

Key/Property 	Value
city 	edison
state 	new jersey
country 	united states

Added a dictionary named "address" to add the address information in "practice.yaml" file?

[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employee:
  name: john
  gender: male
  age: 24
[bob@student-node ~]$ 
[bob@student-node ~]$ 

employee:
  name: john
  gender: male
  age: 24
address:
  city: edison
  state: new jersey
  country: united states



[bob@student-node ~]$ vi /home/bob/playbooks/practice.yaml 
[bob@student-node ~]$ 
[bob@student-node ~]$ 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employee:
  name: john
  gender: male
  age: 24
address:
  city: edison
  state: new jersey
  country: united states
[bob@student-node ~]$ date
Sat Jul 27 03:08:26 UTC 2024
[bob@student-node ~]$ 

- Errado

- Ajustando

employee:
  name: john
  gender: male
  age: 24
  address:
    city: edison
    state: new jersey
    country: united states


[bob@student-node ~]$ vi /home/bob/playbooks/practice.yaml 
[bob@student-node ~]$ 
[bob@student-node ~]$ 
[bob@student-node ~]$ 
[bob@student-node ~]$ date
Sat Jul 27 03:14:58 UTC 2024
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employee:
  name: john
  gender: male
  age: 24
  address:
    city: edison
    state: new jersey
    country: united states
[bob@student-node ~]$ date
Sat Jul 27 03:15:01 UTC 2024
[bob@student-node ~]$ 





We have updated the /home/bob/playbooks/practice.yaml file with an array of apples. Add a new apple to the list to make it a total of 4.

Added a new apple to the list to make it a total of 4 in "practice.yaml"?

[bob@student-node ~]$ 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
- apple
- apple
- apple

[bob@student-node ~]$ 

- apple
- apple
- apple
- apple


[bob@student-node ~]$ 
[bob@student-node ~]$ vi /home/bob/playbooks/practice.yaml 
[bob@student-node ~]$ 
[bob@student-node ~]$ 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
- apple
- apple
- apple
- apple
[bob@student-node ~]$ date
Sat Jul 27 03:17:23 UTC 2024
[bob@student-node ~]$ 





In /home/bob/playbooks/practice.yaml, add two more values to make it 6.

Added two more values to the list to make it a total of 6 in practice.yaml?

[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
- apple
- apple
- apple
- apple
[bob@student-node ~]$ 


- apple
- apple
- apple
- apple
- apple
- apple


[bob@student-node ~]$ vi /home/bob/playbooks/practice.yaml 
[bob@student-node ~]$ 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
- apple
- apple
- apple
- apple
- apple
- apple
[bob@student-node ~]$ date
Sat Jul 27 03:19:05 UTC 2024
[bob@student-node ~]$ 











We have updated the /home/bob/playbooks/practice.yaml file with some data for apple, orange and mango. Just like apple, we would like to add additional details for each item, such as color, weight etc. Modify the remaining items to match the below data.

orange
color 	weight
orange 	90g



mango
color 	weight
yellow 	150g

Verify the details like color, weight etc for Apple.

Verify the details like color, weight etc for Orange.

Verify the details like color, weight etc for Mango.



[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
- name: apple
  color: red
  weight: 100g
- name: orange
- name: mango
[bob@student-node ~]$ 



- name: apple
  color: red
  weight: 100g
- name: orange
  color: orange
  weight: 90g
- name: mango
  color: yellow
  weight: 150g



[bob@student-node ~]$ 
[bob@student-node ~]$ 
[bob@student-node ~]$ vi /home/bob/playbooks/practice.yaml 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
- name: apple
  color: red
  weight: 100g
- name: orange
  color: orange
  weight: 90g
- name: mango
  color: yellow
  weight: 150g
[bob@student-node ~]$ date
Sat Jul 27 03:21:10 UTC 2024
[bob@student-node ~]$ 












We have updated the /home/bob/playbooks/practice.yaml file with a dictionary named employee. We would like to record information about multiple employees. Convert the dictionary named employee to an array named employees.

Converted the dictionary named "employee" to an array named "employees" in "practice.yaml" file?


[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employee:
  name: john
  gender: male
  age: 24
[bob@student-node ~]$ 

employees:
  - name: john
    gender: male
    age: 24


[bob@student-node ~]$ vi /home/bob/playbooks/practice.yaml 
[bob@student-node ~]$ 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employees:
  - name: john
    gender: male
    age: 24
[bob@student-node ~]$ date
Sat Jul 27 03:22:56 UTC 2024
[bob@student-node ~]$ 










Update the /home/bob/playbooks/practice.yaml file to add an additional employee (below the existing entry) to the list using the below information.

Key/Property 	Value
name 	sarah
gender 	female
age 	28

Verify the existing employees in "practice.yaml" file.

Verify the new employees entry in "practice.yaml" file.


[bob@student-node ~]$ 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employees:
  - name: john
    gender: male
    age: 24

[bob@student-node ~]$ 


employees:
  - name: john
    gender: male
    age: 24
  - name: sarah
    gender: female
    age: 28



[bob@student-node ~]$ vi /home/bob/playbooks/practice.yaml 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employees:
  - name: john
    gender: male
    age: 24
  - name: sarah
    gender: female
    age: 28
[bob@student-node ~]$ date
Sat Jul 27 03:24:40 UTC 2024
[bob@student-node ~]$ 









We have updated the /home/bob/playbooks/practice.yaml file to add some more details. Now add the pay information. Remember, while address is a dictionary, payslips is an array of month and amount.

payslips
month 	amount
june 	1400
july 	2400
august 	3400



Verify the "June" month pay in "practice.yaml" file.

Verify the "July" month pay in "practice.yaml" file.

Verify the "August" month pay in "practice.yaml" file.

[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employee:
  name: john
  gender: male
  age: 24
  address:
    city: 'edison'
    state: 'new jersey'
    country: 'united states'
[bob@student-node ~]$ 


employee:
  name: john
  gender: male
  age: 24
  address:
    city: 'edison'
    state: 'new jersey'
    country: 'united states'
  payslips
    - month: june
      amount: 1400
    - month: july
      amount: 2400
    - month: august
      amount: 3400



[bob@student-node ~]$ vi /home/bob/playbooks/practice.yaml 
[bob@student-node ~]$ 
[bob@student-node ~]$ 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employee:
  name: john
  gender: male
  age: 24
  address:
    city: 'edison'
    state: 'new jersey'
    country: 'united states'
  payslips
    - month: june
      amount: 1400
    - month: july
      amount: 2400
    - month: august
      amount: 3400
[bob@student-node ~]$ date
Sat Jul 27 03:36:15 UTC 2024
[bob@student-node ~]$ 

- ERRADO

- Ajustando
adicionando 2 pontos no payslips

employee:
  name: john
  gender: male
  age: 24
  address:
    city: 'edison'
    state: 'new jersey'
    country: 'united states'
  payslips:
    - month: june
      amount: 1400
    - month: july
      amount: 2400
    - month: august
      amount: 3400


[bob@student-node ~]$ 
[bob@student-node ~]$ vi /home/bob/playbooks/practice.yaml 
[bob@student-node ~]$ 
[bob@student-node ~]$ 
[bob@student-node ~]$ 
[bob@student-node ~]$ cat /home/bob/playbooks/practice.yaml 
employee:
  name: john
  gender: male
  age: 24
  address:
    city: 'edison'
    state: 'new jersey'
    country: 'united states'
  payslips:
    - month: june
      amount: 1400
    - month: july
      amount: 2400
    - month: august
      amount: 3400
[bob@student-node ~]$ 