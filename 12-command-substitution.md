# Chapter 12 Command Substitution

*Command Substitution* reassigns the output of a command or even multiple commands; it literally plugs the command output into another context.

The classic form of command substitution uses *backquotes*.

```sh
script_name=`basename $0`
echo "The name of this script is $script_name."
```

```sh
rm `cat filename`   # "filename" contains a list of files to delete.
```

Command substitution invokes a *subshell*.

Command substitution may result in *word splitting*

```sh
COMMAND `echo a b`     # 2 args: a and b

COMMAND "`echo a b`"   # 1 arg: "a b"

COMMAND `echo`         # no arg

COMMAND "`echo`"       # one empty arg
```

Command substitution even permits setting a variable to the contents of a file, using either redirection or the *cat* command.

```sh

variable1=`<file1`      #  Set "variable1" to contents of "file1".
variable2=`cat file2`   #  Set "variable2" to contents of "file2".
                        #  This, however, forks a new process,
                        #+ so the line of code executes slower than the above version.

#  Note that the variables may contain embedded whitespace,
#+ or even (horrors), control characters.

#  It is not necessary to explicitly assign a variable.
echo "` <$0`"           # Echoes the script itself to stdout.
```

Command substitution permits setting a variable to the output of a loop. The key to this is grabbing the output of an *echo* command within the loop.

```sh

variable1=`for i in 1 2 3 4 5
do
  echo -n "$i"                 #  The 'echo' command is critical
done`                          #+ to command substitution here.

echo "variable1 = $variable1"  # variable1 = 12345

```

Command substitution makes it possible to extend the toolset available to Bash. It is simply a matter of writing a program or script that outputs to stdout (like a well-behaved UNIX tool should) and assigning that output to a variable.

```c

#include <stdio.h>

/*  "Hello, world." C program  */		

int main()
{
  printf( "Hello, world.\n" );
  return (0);
}
```

```bash
gcc -o hello hello.c
```

```sh
greeting=`./hello`
echo $greeting
```

The `$(...)` form has superseded backticks for command substitution

```sh
output=$(sed -n /"$1"/p $file)   # From "grp.sh"	example.
	      
# Setting a variable to the contents of a text file.
File_contents1=$(cat $file1)      
File_contents2=$(<$file2)        # Bash permits this also.
```

The `$(...)` form of command substitution permits nesting.

```sh
word_count=$( wc -w $(echo * | awk '{print $8}') )
```
