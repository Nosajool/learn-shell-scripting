# Chapter 11 Loops and Branches

# 11.1 Loops

A *loop* is a block of code that *iterates* a list of commands as long as the *loop control condition* is true.

## for loops

`for arg in [list]`:  During each pass through the loop *arg* takes on the value of each successive variable in the *list*

The argument *list* may contain wild cards. If *do* is on the same line as *for*, there needs to be a semicolon after list.

`for arg in [list] ; do`

Each *[list]* element may contain multiple parameters. This is useful when processing parameters in groups. In such cases, use the *set* command to force parsing of each *[list]* element and assignment of each component to the positional parameters.

A variable may supply the *[list]* in a for loop.

The *[list]* in a *for loop* may be parametereized.

If the *[list]* in a for loop contains wild cards (\* and ?) used in filename expansion, then globbing takes place.


Omitting the *in [list]* part of a *for loop* causes the loop to operate on *$@* the positional parameters.

It is possible to use *command substitution* to generate the *[list]* in a *for loop*.

*command* can be a function.

The output of a *for loop* may be *piped* to a command or commands.

just use something like `done | sort` at the end of the loop

There is an alternative syntax for a *for loop* that looks familar to C programmers using double parenthesis.

The keywords *do* and *done* delineate the for-loop command block. However, these may in certain contexts, be omitted by framing the command block *within curly brackets*

## while

This construct tests for a condition at the top of a loop and keeps looping as long as that condition is true. (0 as exit status).

In contrast to a *for loop*, a *while loop* finds use in situations where the number of loop repetitions is not known beforehand.

```sh
while [condition ]
do
  command(s)...
done
```

The bracket construct in a while loops is the *test brackets* used in an *if/then* test. A while loop can legally use the more versatile double-brackets construct `while [[ condition ]]`


As in the case with *for loops*, placing the *do* on the same line as the condition test requires a semicolon.

`while [ condition ] ; do`

A while loop may have multiple conditions. Only the final condition determines when the loop terminates. This necessitates a slightly different loop syntax, however.

```sh
var1=unset
previous=$var1

while echo "previous-variable = $previous"
      echo
      previous=$var1
      [ "$var1" != end ] # Keeps track of what $var1 was previously.
      # Four conditions on *while*, but only the final one controls loop.
      # The *last* exit status is the one that counts.
do
echo "Input variable #1 (end to exit) "
  read var1
  echo "variable #1 = $var1"
done
```

As with a for loop, a while loop may employ C-style syntax by using the double-parentheses construct.

```sh
LIMIT=10                 # 10 iterations.
a=1

while [ "$a" -le $LIMIT ]
do
  echo -n "$a "
  let "a+=1"
done                     # No surprises, so far.

echo; echo

# +=================================================================+

# Now, we'll repeat with C-like syntax.

((a = 1))      # a=1
# Double parentheses permit space when setting a variable, as in C.

while (( a <= LIMIT ))   #  Double parentheses,
do                       #+ and no "$" preceding variables.
  echo -n "$a "
  ((a += 1))             # let "a+=1"
  # Yes, indeed.
  # Double parentheses permit incrementing a variable with C-like syntax.
done

echo
```

Inside its test brackets, a while loop can call a function.

```sh
t=0

condition ()
{
  ((t++))

  if [ $t -lt 5 ]
  then
    return 0  # true
  else
    return 1  # false
  fi
}

while condition
#     ^^^^^^^^^
#     Function call -- four loop iterations.
do
  echo "Still going: t = $t"
done

# Still going: t = 1
# Still going: t = 2
# Still going: t = 3
# Still going: t = 4
```

By coupling the power of the read command with a while loop, we get the handy while read construct, useful for reading and parsing files.

```sh
cat $filename |   # Supply input from a file.
while read line   # As long as there is another line to read ...
do
  ...
done

# =========== Snippet from "sd.sh" example script ========== #

  while read value   # Read one data point at a time.
  do
    rt=$(echo "scale=$SC; $rt + $value" | bc)
    (( ct++ ))
  done

  am=$(echo "scale=$SC; $rt / $ct" | bc)

  echo $am; return $ct   # This function "returns" TWO values!
  #  Caution: This little trick will not work if $ct > 255!
  #  To handle a larger number of data points,
  #+ simply comment out the "return $ct" above.
} <"$datafile"   # Feed in data file.
```

## until

This construct tests for a condition at the top of a loop, and keeps looping as long as that condition is false (opposite of while loop).

```sh
until [ condition-is-true ]
do 
 command(s)... 
done
```

Note that an until loop tests for the terminating condition at the top of the loop, differing from a similar construct in some programming languages.

As is the case with for loops, placing the do on the same line as the condition test requires a semicolon.

`until [ condition-is-true ] ; do`

```sh
END_CONDITION=end

until [ "$var1" = "$END_CONDITION" ]
# Tests condition here, at top of loop.
do
  echo "Input variable #1 "
  echo "($END_CONDITION to exit)"
  read var1
  echo "variable #1 = $var1"
  echo
done  

#                     ---                        #

#  As with "for" and "while" loops,
#+ an "until" loop permits C-like test constructs.

LIMIT=10
var=0

until (( var > LIMIT ))
do  # ^^ ^     ^     ^^   No brackets, no $ prefixing variables.
  echo -n "$var "
  (( var++ ))
done    # 0 1 2 3 4 5 6 7 8 9 10
```


# 11.2 Nested Loops

A *nested* loop is a loop within a loop, an inner loop within the body of an outer one. How this works is that the first pass of the outer loop triggers the inner loop, which executes to completion. Then the second pass of the outer loop triggers the inner loop again. This repeats until the outer loop finishes. Of course, a break within either the inner or outer loop would interrupt this process.

# 11.3 Loop Control

`break, continue`: The *break* and *continue* loop control commands correspond exactly to their counterparts in other programming languages. The *break* command terminates the loop, while *continue* causes a jump to the next iteration of the loop, skipping remaining commands in that particular loop cycle.

The *break* command may optionally take a parameter. A plain *break* terminates only the innermost loop in which it is embedded but a *break N* breaks out of N levels of loop.

The *continue* command, similar to *break*, optionally takes a parameter. A plain continue cuts short the current iteration within its loop and begins the next. A *continue N* terminates all remaining iterations at its loop level and continues with the next iteration at the loop, N levels above.

# 11.4 Testing and Branching

The *case* and *select* constructs are technically not loops, since they do not iterate the execution of a code block. Like loops, however, they direct program flow according to conditions at the top or bottom of the block.


## Controlling program flow in a code block

`case (in) / esac`

The *case* construct is the shell scripting analog to *switch* in C/C++. It permits branching to one of a number of code blocks, depending on condition tests. It serves as a kind of shorthand for multiple if/then/else statements and is an appropriate tool for creating menus.

Note that *esac* is *case* backwards

```sh
case "$variable" in 

 "$condition1" ) 
 command... 
 ;; 

 "$condition2" ) 
 command... 
 ;; 

```

`select`: The select construct, adopted from the Korn Shell, is yet another tool for building menus.


```sh
select variable [in list]
do 
 command... 
 break 
done
```

This prompts the user to enter one of the choices presented in the variable list. Note that select uses the $PS3 prompt (#? ) by default, but this may be changed.



