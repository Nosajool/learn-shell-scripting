# 16.9 Miscellaneous Commands

`jot, seq`: These utilities emit a sequence of integers, with a user-selectable increment.

The default separator character between each integer is a newline, but this can be changed with the -s option.


```sh
bash$ seq 5
1
 2
 3
 4
 5



bash$ seq -s : 5
1:2:3:4:5
```

`getopt`: The getopt command parses command-line options preceded by a dash. This external command corresponds to the getopts Bash builtin. Using getopt permits handling long options by means of the -l flag, and this also allows parameter reshuffling.

```sh
#!/bin/bash
# Using getopt

# Try the following when invoking this script:
#   sh ex33a.sh -a
#   sh ex33a.sh -abc
#   sh ex33a.sh -a -b -c
#   sh ex33a.sh -d
#   sh ex33a.sh -dXYZ
#   sh ex33a.sh -d XYZ
#   sh ex33a.sh -abcd
#   sh ex33a.sh -abcdZ
#   sh ex33a.sh -z
#   sh ex33a.sh a
# Explain the results of each of the above.

E_OPTERR=65

if [ "$#" -eq 0 ]
then   # Script needs at least one command-line argument.
  echo "Usage $0 -[options a,b,c]"
  exit $E_OPTERR
fi  

set -- `getopt "abcd:" "$@"`
# Sets positional parameters to command-line arguments.
# What happens if you use "$*" instead of "$@"?

while [ ! -z "$1" ]
do
  case "$1" in
    -a) echo "Option \"a\"";;
    -b) echo "Option \"b\"";;
    -c) echo "Option \"c\"";;
    -d) echo "Option \"d\" $2";;
     *) break;;
  esac

  shift
done

#  It is usually better to use the 'getopts' builtin in a script.

exit 0
```

`run-parts`: The run-parts command executes all the scripts in a target directory, sequentially in ASCII-sorted filename order. Of course, the scripts need to have execute permission.

The cron daemon invokes run-parts to run the scripts in the /etc/cron.* directories.

`yes`: In its default behavior the yes command feeds a continuous string of the character y followed by a line feed to stdout. A control-C terminates the run. A different output string may be specified, as in yes different string, which would continually output different string to stdout.

One might well ask the purpose of this. From the command-line or in a script, the output of yes can be redirected or piped into a program expecting user input. In effect, this becomes a sort of poor man's version of expect.

`yes | fsck /dev/hdal` runs `fsck` non-iteractively

`yes | rm -r dirname` has the same effect as `rm -rf dirname`

`banner`: Prints arguments as a large vertical banner to stdout, using an ASCII character (default '#'). This may be redirected to a printer for hardcopy.

Note that banner has been dropped from many Linux distros, presumably because it is no longer considered useful.

`printenv`: Show all the environmental variables set for a particular user.

`lp`: The lp and lpr commands send file(s) to the print queue, to be printed as hard copy. These commands trace the origin of their names to the line printers of another era.

`tee`: This is a redirection operator, but with a difference. Like the plumber's tee, it permits "siphoning off" to a file the output of a command or commands within a pipe, but without affecting the result. This is useful for printing an ongoing process to a file or paper, perhaps to keep track of it for debugging purposes.

`mkfifo`: This obscure command creates a named pipe, a temporary first-in-first-out buffer for transferring data between processes. [4] Typically, one process writes to the FIFO, and the other reads from it.

`pathchk`: This command checks the validity of a filename. If the filename exceeds the maximum allowable length (255 characters) or one or more of the directories in its path is not searchable, then an error message results.

Unfortunately, pathchk does not return a recognizable error code, and it is therefore pretty much useless in a script. Consider instead the file test operators.

`dd`: Though this somewhat obscure and much feared data duplicator command originated as a utility for exchanging data on magnetic tapes between UNIX minicomputers and IBM mainframes, it still has its uses. The dd command simply copies a file (or stdin/stdout), but with conversions. Possible conversions include ASCII/EBCDIC, upper/lower case, swapping of byte pairs between input and output, and skipping and/or truncating the head or tail of the input file.

`od`: The od, or octal dump filter converts input (or files) to octal (base-8) or other bases. This is useful for viewing or processing binary data files or otherwise unreadable system device files, such as /dev/urandom, and as a filter for binary data.

`hexdump`: Performs a hexadecimal, octal, decimal, or ASCII dump of a binary file. This command is the rough equivalent of od, above, but not nearly as useful. May be used to view the contents of a binary file, in combination with dd and less.

`objdump`: Displays information about an object file or binary executable in either hexadecimal form or as a disassembled listing (with the -d option).

`mcookie`: This command generates a "magic cookie," a 128-bit (32-character) pseudorandom hexadecimal number, normally used as an authorization "signature" by the X server. This also available for use in a script as a "quick 'n dirty" random number.

`units`: This utility converts between different units of measure. While normally invoked in interactive mode, units may find use in a script.

`m4`: A hidden treasure, m4 is a powerful macro processing filter, virtually a complete language. Although originally written as a pre-processor for RatFor, m4 turned out to be useful as a stand-alone utility. In fact, m4 combines some of the functionality of eval, tr, and awk, in addition to its extensive macro expansion facilities.

`xmessage`: This X-based variant of echo pops upa  message/query window on the desktop

`zenity`: The zenity utility is adept at displaying GTK+dialog widgets.

`doexec`: The doexec command enables passing an arbitrary list of arguments to a binary executable. In particular, passing argv[0] (which corresponds to $0 in a script) lets the executable be invoked by various names, and it can then carry out different sets of actions, according to the name by which it was called. What this amounts to is roundabout way of passing options to an executable.

For example, the /usr/local/bin directory might contain a binary called "aaa". Invoking doexec /usr/local/bin/aaa list would list all those files in the current working directory beginning with an "a", while invoking (the same executable with) doexec /usr/local/bin/aaa delete would delete those files.

`dialog`: The dialog family of tools provide a method of calling interactive "dialog" boxes from a script. The more elaborate variations of dialog -- gdialog, Xdialog, and kdialog -- actually invoke X-Windows widgets.

`sox`: The sox, or "sound exchange" command plays and performs transformations on sound files. In fact, the /usr/bin/play executable (now deprecated) is nothing but a shell wrapper for sox.

For example, sox soundfile.wav soundfile.au changes a WAV sound file into a (Sun audio format) AU sound file.
