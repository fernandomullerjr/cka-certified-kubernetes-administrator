#!/bin/bash

# -z

#    string is null, that is, has zero length

#     String=''   # Zero-length ("null") string variable.

    if [ -z "$String" ]
    then
      echo "\$String is null."
    else
      echo "\$String is NOT null."
    fi     # $String is null.