# Chapter 9 Another Look at Variables

# 9.1 Internal Variables

## *Builtin* variables are variables that affect the bash script behavior

`$BASH`: The path to the Bash binary itself.

`$BASH_ENV`: An environment variable pointing to a Bash startup file to be read when a script is invoked.

`$BASH_SUBSHELL`: A variable indicating *subshell* level.

`$BASHPID`: Process ID of the current instance of Bash. Not the same as `$$` necessarily

`$BASH_VERSINFO[n]`: 6-element array containing information about installed release of Bash. More detailed than `$BASH_VERSION`.

`$BASH_VERSION`: The version of Bash installed on the system

`$CDPATH`: Colon separated list of search paths available to the cd command, similar in function tothe `$PATH` variable for binaries. Can set this path in `~/.bashrc`.

`$DIRSTACK`: The top value in the directory stack. Affected by `pushd` and `popd`.

`$EDITOR`: The default editor invoked by a script. Usually vi or emacs.

`$EUID`: "Effective" user ID number.

`$FUNCNAME`: Name of the current function

`$GLOBIGNORE`: A list of filename patterns to be excluded from matching in globbing

`$GROUPS`: Groups current user belongs to. This is a listing (array) of the group id numbers for current user, as recorded in `/etc/passwd` and `/etc/group`.

`$HOME`: Home directory of the user

`$HOSTNAME`: Hostname command assigns the system host name at bootup in an init script. However, the `gethostname()` function sets the Bash internal variable `$HOSTNAME`.

`$HOSTTYPE`: Host type (identifies system hardware)

`$IFS`: Internal field separator. This variable determines how Bash recognizes fields or word boundaries when it interprets character strings. `$IFS` defaults to whitespace but can be changed for example, to parse a csv.

`$IGNOREEOF`: Ignore EOF: How many end-of-files (control-D) the shell will ignore before logging out

`$LC_COLLATE`: Often set in the `.bashrc` or `/etc/profile` files, this variable controls collation order in filename expansion and pattern matching..

`$LC_CTYPE`: This internal variable controls character interpretation in globbing and pattern matching

`$LINENO`: This variable is the line number of the shell script in which this variable appears. It has significance only within the script in which it appears, and is chiefly useful for debugging purposes.

`$MACHTYPE`: machine type. Identifies system hardware

`$OLDPWD`: Old working directory. (OLD-print-working-directory). Previous directory you were in

`$OSTYPE`: Operating system type

`$PATH`: Path to binaries. Normally, the system stores the `$PATH` definition in `/etc/profile` and/or `~/.bashrc`

`$PIPESTATUS`: Array variable holding *exit status(es)* of last executed foreground pipe.

`$PPID`: The `$PPID` of a process is the process ID (pid) of its parent process

`$PROMT_COMMAND`: Variable holding a command to be executed just before the primary prompt, `$PS1` is to be displayed

`$PS1`: This is the main prompt, seen at the command-line

`$PS2`: The secondary prompt, seen when additional input is expected. It displays as ">".

`$PS3`: The tertiary prompt, displayed in a *select* loop.

`$PS4`: The quarternary prompt, shown at the beginning of each line of output when invoking a script with the -x (verbose trace) option. It displays as "+"

`$PWD`: Working directory

`$REPLY`: The default value when a variable is not supplied to *read*. Also applicable to *select* menus but only supplies the item number of the variable chosen, not the value of the variable itself.

`$SECONDS`: The number of seconds the script has been running.

`$SHELLOPTS`: The list of enabled shell options. Readonly variable

`$SHLVL`: Shell level, how deeply Bash is nested. If, at the command-line, `$SHLVL` is 1, then in a script, it will increment to 2.

`$TMOUT`: If the `$TMOUT` environment variable is set to a non-zero value `time`, then the shell prompt will time out after `$time` seconds. This will cause a logout.

`$UID`: User ID number. Current user identification number, as recorded in `/etc/passwd`.

## Positional Parameters

`$0, $1, $2, etc`: Positional parameters passed from command line to script, passed to a function or set to a variable

`$#`: Number of command-line arguments or positional parameters

`$*`: All of the positional parameters, seen as a single word

`$@`: Same as `$*` but each parameter is a quoted string, that is, the parameters are passed on intact, without interpretation or expansion.

## Other Special Parameters

`$-`: Flags passed to script

`$!`: PID of last job run in background

`$_`: Special variable set to final argument of previous command executed

`$?`: Exit status of a command, function or the script itself

`$$`: Process ID of the script itself.

# 9.2 Typing variables: declare or typeset

The *declare* or *typeset* builtins, which are exact synonyms, permit modifying the properties of variables.

It is a very weak form of *typing*.

## declare/typeset options

`-r readonly`: Rough equivalent of the C *const* type qualifier. An attempt to change the value of a readonly variable fails with an error message.

`-i integer`: Declared integer

`-a array`: 

`-f function(s)`

`-x export`: Declares variable as available for exporting outside the environment of the script itself.

`-x var=$value`: The declare command permits assigning a value to a variable in the same statement as setting its properties.

The *declare* command can be helpful in identifying variables, environmental or otherwise. This can be especially useful with arrays.

# 9.3 $RANDOMm: generate random integer

`$RANDOM` is an internal Bash function that returns a pseudorandom integer in the rage 0-32767. It should not be used to generate an encryption key


It is best to *reseed* the RANDOM generator each time it is invoked. Setting `RANDOM` seeds the number generator

Note that `/dev/urandom` pseudo-device file provides a method of generating much more "random" pseudorandom numbers than the `$RANDOM` variable.
