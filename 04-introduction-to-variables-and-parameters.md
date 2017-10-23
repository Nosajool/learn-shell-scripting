# 4.1 Variable Substitution

The *name* of a variable is a placeholder for its *value*. Referencing its value is called *variable substitution*.

Enclosing a referenced value in double quotes does not interfere with variable substitution.

This is called *partial quoting*.

Using single quotes causes the variable name to be used literally without substitution. This is called *full quoting* or *strong quoting*

Note that `$variable` is actually the simplified form of `${variable}`.

Uninitialized variable has null value. (no assigned value at all)

Can `unset` variables

# 4.2 Variable Assignment

Can assign using `=`.

Can also assign using `let` keyword.

For loops use a form of disguised assignment without `=` or `let`.


Same as in `read`

`read a`.

# 4.3 Bash Variables are Untyped

Bash does not segregate its variables by "type".

Bash variables are character strings but depending on context.

Bash permits arithmetic operations and comparison on variables.

The determining factor is whether the value of a variable contains only digits.

Untyped variables are both a blessing and a curse. More flexibility in scripting.

Easier to grind out lines of code but can permit subtle errors to creep in and encourage sloppy programming habits.


# 4.4 Special Variable Types

## Local Variables

Variables visible only within  a code block or function

## Environmental variables

Variables that affect the behavior of the shell and user interface.

Each process has an *environment* that is a group of variables that the process may reference.

## Positional Parameters

Arguments passed to the script from the command line: $0, $1, $2, $3, ...

$0 is the name of the script itself.

$1 is the first argument

$2 is second

$3 third and so forth

After $9, must enclose arguments in brackets like ${10}, ${11}, ${12}

Special variables `$*` and `$@` denote all positional parameters

Bracket notation for positional parameters leads to a fairly simple way of referencing hte last argument passed to a script on the command-line.

`args=$# # Number of args passed`
`lastarg=${!args} # Indirect reference to $args`


Can also use `lastarg=${!#}`

If a script expects a command-line parameter but is invoked without one, this may cause a null variable assignment, generally an undesirable result.

One way to prevent this is to append an exstra character to both sides of the assignment statement using the expected positional parameter.

`variable1_=$1_`
This prevents an error even if positional parameter is absent

`critical_argument01=$variable1`

Can strip off the extra character later:

`variable1=${variable1_/_/}`

A more straight forward way is to test whether expected positional parameters have been passed:

```bash
if [ -z $1 ]
then
  exit $E_MISSING_POS_PARAM
fi
```

You can use the `shift` command to reassign positional parameters, left one notch.

