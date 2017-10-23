# 6 Exit and Exit Status

The exit command terminates a script. It can also return a value, which is available to the script's parent process.

Every command returns an *exit status*.

A successful command returns a 0, while an unsuccessful one returns a non-zero value that usually can be interpreted as an *error code*.

Likewise, functions within a script and the script itself return an exit status.

The last command executed in the function or script determines the exit status.

When a script ends with an exit that has no parameter, the exit status of the script is the exit status of the last command executed in the script (previous to the exit)

`$?` reads the exit status of the last command executed.

After a function returns, `$?` gives the exit status of the last command executed in the function. This is Bash's way of giving functions a "return value"
