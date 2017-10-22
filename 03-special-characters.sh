#!/bin/bash

# This line is a comment

echo "A comment will follow." # Comment here

  # Tabbed comment

echo "hi"; echo "bye"

var1="abc"

case "$var1" in
  abc) echo "abc" ;;
  xyz) echo "xyz" ;;
esac

# Comma operator links arithmetic operations but only the last one is returned.
let "t2 = ((a = 9, 15 / 3))"
# Set "a = 9" and "t2 = 15 /3"

# null operator

:
echo $? # 0

# endless loop

# while :
# do
#   echo "endless loop"
# done

# same as while true

# Using : and redirection operation > can truncate a file to zero length without changing permissions.
# : > data.xxx # file data.xxx is now empty
# Same effect as cat /dev/null > data.xxx
# However, it does not fork a new process since ":" is a builtin.

# Brace expansion
echo \"{These,words,are,quoted}\"


# Extended brace expansion
echo {a..z}

# Block of code (inline group). Unlike a standard function, variables inside code block remain visible to the remainder of the script

a=9
{ a=123; }
echo $a # 123


# Integer expansion
c=3
d=7
echo $[$c+$d] # 10
echo $[$c*$d] # 21

# ASCII comparison

veg1=carrots
veg2=tomatoes

if [[ "$veg1" < "$veg2" ]]
then
  echo "Although $veg1 precede $veg2 in the dictionary,"
  echo -n "this does not necessarily imply anything "
  echo "about my culinary preferences."
else
  echo "What kind of dictionary are you using, anyhow?"
fi

# Pipe
echo ls -l | sh

