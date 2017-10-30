# Chapter 15 Internal Commands and Builtins

A *builtin* is a command contained within the Bash tool set, literally *built in*.

This is either for performance reasons: builtins execute faster than external commands which usually require forking off a separate process

or because a particular builtin needs direct access to the shell internals.

When a command or the shell itself initiates (or *spawns*) a new subprocess to carry out a task, this is called *forking*.

This new process is the *child* and the process that *forked* it off is the *parent*.

While the *child process* is doing its work ,the *parent process* is still executing.

Note that while a *parent process* gets the process ID of the *child process*, and can thus pass arguments to it, the reverse is not true.

```sh
#!/bin/bash
# spawn.sh


PIDS=$(pidof sh $0)  # Process IDs of the various instances of this script.
P_array=( $PIDS )    # Put them in an array (why?).
echo $PIDS           # Show process IDs of parent and child processes.
let "instances = ${#P_array[*]} - 1"  # Count elements, less 1.
                                      # Why subtract 1?
echo "$instances instance(s) of this script running."
echo "[Hit Ctl-C to exit.]"; echo


sleep 1              # Wait.
sh $0                # Play it again, Sam.

exit 0               # Not necessary; script will never get to here.
                     # Why not?
```

Generally, a Bash builtin does not fork a subprocess when it executes within a script.

An external system command or filter in a script usually *will* fork a subprocess.

A builtin may be a synonym to a system command of the same name, but Bash reimplements it internally. For example, the Bash echo command is not the same as /bin/echo, although their behavior is almost identical.

```sh
echo "This line uses the \"echo\" builtin."
/bin/echo "This line uses the /bin/echo system command."
```

A keyword is a reserved word, token or operator. Keywords have a special meaning to the shell, and indeed are the building blocks of the shell's syntax. As examples, for, while, do, and ! are keywords. Similar to a builtin, a keyword is hard-coded into Bash, but unlike a builtin, a keyword is not in itself a command, but a subunit of a command construct.

## I/O

`echo` prints to stdout an expression or variable

An echo requires the -e option to print escaped characters. 

Normally, each echo command prints a terminal newline, but the -n option suppresses this.


`printf` The printf, formatted print, command is an enhanced echo. It is a limited variant of the C language printf() library function, and its syntax is somewhat different.

`read` "Reads" the value of a variable from stdin, that is, interactively fetches input from the keyboard. The -a option lets read get array variables

Normally, inputting a \ suppresses a newline during input to a read. The -r option causes an inputted \ to be interpreted literally.

The read command has some interesting options that permit echoing a prompt and even reading keystrokes without hitting ENTER.

The -n option to read also allows detection of the arrow keys and certain of the other unusual keys.

The -t option to read permits timed input

The -u option takes the file descriptor of the target file.

The read command may also "read" its variable value from a file redirected to stdin. If the file contains more than one line, only the first line is assigned to the variable. If read has more than one parameter, then each of these variables gets assigned a successive whitespace-delineated string. Caution!

## Filesystem

`cd` The familiar cd change directory command finds use in scripts where execution of a command requires being in a specified directory.

`pwd` Print Working Directory. This gives the user's (or script's) current directory. The effect is identical to reading the value of the builtin variable $PWD.

`pushd` `popd`, `dirs` This command set is a mechanism for bookmarking working directories, a means of moving back and forth through directories in an orderly manner. A pushdown stack is used to keep track of directory names. Options allow various manipulations of the directory stack.

`pushd dir-name` pushes the path dir-name onto the directory stack (to the top of the stack) and simultaneously changes the current working directory to dir-name

`popd` removes (pops) the top directory path name off the directory stack and simultaneously changes the current working directory to the directory now at the top of the stack.

`dirs` lists the contents of the directory stack (compare this with the $DIRSTACK variable). A successful pushd or popd will automatically invoke dirs.

Scripts that require various changes to the current working directory without hard-coding the directory name changes can make good use of these commands. Note that the implicit $DIRSTACK array variable, accessible from within a script, holds the contents of the directory stack.

## Variables

`let` The let command carries out arithmetic operations on variables.

`eval` Combines the arguments in an expression or list of expressions and evaluates them. Any variables within the expression are expanded. **The net result is to convert a string into a command.**

`set` The set command changes the value of internal script variables/options. One use for this is to toggle option flags which help determine the behavior of the script. Another application for it is to reset the positional parameters that a script sees as the result of a command (set `command`). The script can then parse the fields of the command output.

Invoking set without any options or arguments simply lists all the environmental and other variables that have been initialized.

Using set with the -- option explicitly assigns the contents of a variable to the positional parameters. If no variable follows the -- it unsets the positional parameters.

`unset`: The unset command deletes a shell variable, effectively setting it to null. Note that this command does not affect positional parameters.

`export`: The export command makes available variables to all child processes of the running script or shell. One important use of the export command is in startup files, to initialize and make accessible environmental variables to subsequent user processes.

Unfortunately, there is no way to export variables back to the parent process, to the process that called or invoked the script or shell.

`declare`, `typeset`: The declare and typeset commands specify and/or restrict properties of variables.

`readonly`: Same as declare -r, sets a variable as read-only, or, in effect, as a constant. Attempts to change the variable fail with an error message. This is the shell analog of the C language const type qualifier.

`getopts`: This powerful tool parses command-line arguments passed to the script. This is the Bash analog of the getopt external command and the getopt library function familiar to C programmers. It permits passing and concatenating multiple options and associated arguments to a script (for example scriptname -abc -e /usr/local).

The getopts construct uses two implicit variables. $OPTIND is the argument pointer (OPTion INDex) and $OPTARG (OPTion ARGument) the (optional) argument attached to an option. A colon following the option name in the declaration tags that option as having an associated argument.

A getopts construct usually comes packaged in a while loop, which processes the options and arguments one at a time, then increments the implicit $OPTIND variable to point to the next.

```sh
while getopts ":abcde:fg" Option
# Initial declaration.
# a, b, c, d, e, f, and g are the options (flags) expected.
# The : after option 'e' shows it will have an argument passed with it.
do
  case $Option in
    a ) # Do something with variable 'a'.
    b ) # Do something with variable 'b'.
    ...
    e)  # Do something with 'e', and also with $OPTARG,
        # which is the associated argument passed with option 'e'.
    ...
    g ) # Do something with variable 'g'.
  esac
done
shift $(($OPTIND - 1))
# Move argument pointer to next.
```

## Script behavior

`source` (dot command)

This command, when invoked from the command-line, executes a script. Within a script, a source file-name loads the file file-name. Sourcing a file (dot-command) imports code into the script, appending to the script (same effect as the #include directive in a C program). The net result is the same as if the "sourced" lines of code were physically present in the body of the script. This is useful in situations when multiple scripts use a common data file or function library.

If the sourced file is itself an executable script, then it will run, then return control to the script that called it. A sourced executable script may use a return for this purpose.

Arguments may be (optionally) passed to the sourced file as positional parameters.

`source $filename $arg1 arg2`

`exit` Unconditionally terminates a script. The exit command may optionally take an integer argument, which is returned to the shell as the exit status of the script. It is good practice to end all but the simplest scripts with an exit 0, indicating a successful run.

If a script terminates with an exit lacking an argument, the exit status of the script is the exit status of the last command executed in the script, not counting the exit. This is equivalent to an exit $?.

An exit command may also be used to terminate a subshell.

`exec` This shell builtin replaces the current process with a specified command. Normally, when the shell encounters a command, it forks off a child process to actually execute the command. Using the exec builtin, the shell does not fork, and the command exec'ed replaces the shell. When used in a script, therefore, it forces an exit from the script when the exec'ed command terminates. 

`shopt`: This command permits changing shell options on the fly

`caller`: Putting a caller command inside a function echoes to stdout information about the caller of that function.

 caller command can also return caller information from a script sourced within another script. Analogous to a function, this is a "subroutine call."

 ## Commands

 `true`: A command that returns a successful (zero) exit status, but does nothing else.

 `false`: A command that returns an unsuccessful exit status, but does nothing else.

`type [cmd]`: Similar to the which external command, type cmd identifies "cmd." Unlike which, type is a Bash builtin. The useful -a option to type identifies keywords and builtins, and also locates system commands with identical names.

`hash[cmds]`: Records the path name of specified commands -- in the shell hash table -- so the shell or script will not need to search the $PATH on subsequent calls to those commands. When hash is called with no arguments, it simply lists the commands that have been hashed. The -r option resets the hash table.

`bind`: The bind builtin displays or modifies readline key bindings.

`help`: Gets a short usage summary of a shell builtin. This is the counterpart to whatis, but for builtins. 

# 15.1 Job Control Commands

Certain of the following job control commands take a *job identifier* as an argument

`jobs`: List the jobs running in the background, giving the job number.It is all too easy to confuse jobs and processes. Certain builtins, such as kill, disown, and wait accept either a job number or a process number as an argument. The fg, bg and jobs commands accept only a job number.

```
bash$ sleep 100 &
[1] 1384

bash $ jobs
[1]+  Running                 sleep 100 &
```

`disown`: Remove job(s) from the shell's table of active jobs

`fg, bg`: The fg command switches a job running in the background into the foreground. The bg command restarts a suspended job, and runs it in the background. If no job number is specified, then the fg or bg command acts upon the currently running job.

`wait`: Suspend script execution until all jobs running in background have terminated, or until the job number or process ID specified as an option terminates. Returns the exit status of waited-for command.

You may use the wait command to prevent a script from exiting before a background job finishes executing (this would create a dreaded orphan process).


```sh

#!/bin/bash

ROOT_UID=0   # Only users with $UID 0 have root privileges.
E_NOTROOT=65
E_NOPARAMS=66

if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  # "Run along kid, it's past your bedtime."
  exit $E_NOTROOT
fi  

if [ -z "$1" ]
then
  echo "Usage: `basename $0` find-string"
  exit $E_NOPARAMS
fi


echo "Updating 'locate' database..."
echo "This may take a while."
updatedb /usr &     # Must be run as root.

wait
# Don't run the rest of the script until 'updatedb' finished.
# You want the the database updated before looking up the file name.

locate $1

#  Without the 'wait' command, in the worse case scenario,
#+ the script would exit while 'updatedb' was still running,
#+ leaving it as an orphan process.

exit 0
```

`suspend`: This has a similar effect to Control-Z, but it suspends the shell (the shell's parent process should resume it at an appropriate time).

`logout`: Exit a login shell, optionally specifying an exit status.

`times`: Gives statistics on the system time elapsed when executing commands, in the following form:
0m0.020s 0m0.020s

This capability is of relatively limited value, since it is not common to profile and benchmark shell scripts.

`kill`: Forcibly terminate a process by sending it an appropriate terminate signal

```sh
kill $$  # Script kills its own process here.
         # Recall that "$$" is the script's PID.

echo "This line will not echo."
# Instead, the shell sends a "Terminated" message to stdout.

exit 0   # Normal exit? No!
```

`killall`: The killall command kills a running process by name, rather than by process ID. If there are multiple instances of a particular command running, then doing a killall on that command will terminate them all.

`command`: The command directive disables aliases and functions for the command immediately following it.

`bash$ command ls`

`builtin`: Invoking builtin BUILTIN_COMMAND runs the command BUILTIN_COMMAND as a shell builtin, temporarily disabling both functions and external system commands with the same name.

`enable`: This either enables or disables a shell builtin command. As an example, enable -n kill disables the shell builtin kill, so that when Bash subsequently encounters kill, it invokes the external command /bin/kill.

`autoload`: This is a port to Bash of the ksh autoloader. With autoload in place, a function with an autoload declaration will load from an external file at its first invocation. This saves system resources.
