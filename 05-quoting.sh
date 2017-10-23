#!/bin/bash

List="one two three"

for a in $List # Splits the variable in parts at whitespace
do
  echo "$a"
done

# one
# two
# three

echo "---"

for a in "$List" # Preserve whitespace in a single variable
do
  echo "$a"
done

# one two three
