#!/bin/bash

variable1=23
echo variable1  # variable1
echo $variable1 # 23
hello=$variable1
echo $hello # 23
echo ${hello} # 23

var_with_spaces="A B  C    D"
echo $var_with_spaces # A B C D

# Quoting a variable preserves whitespace
echo "$var_with_spaces" # A B  C    D"

# Variable referencing disabled using full quoting
echo '$var_with_spaces' # $var_with_spaces

blah= # Set to null value
echo "\$blah (null value) = $blah" # $blah (null value) =

# Note that setting a variable to a null value is no the same as unsetting it.

# Unset variable
var4=23
unset var4
echo $var4 # null value

# let keyword
let a=16+5
echo $a


