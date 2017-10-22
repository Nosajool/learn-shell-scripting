# 03 - Special Characters


## Special Characters

`#`: Comments `#`

`;`: Command separator

`;;`: Terminator in a `case`. 

`;;&,;&`: Terminators in a case option

`.`: Source command. Imports code into script appending to the script. Net result is the same as if the "sourced" lines of code were physically present in the body of the script.

`.`: as a component of a filename. Leading dot is the prefix of the "hidden" file.

`.`: for directory names, a single dot represents current working directory. 2 dots denotes parent directory

`.`: In regular expressions, a dot matches a single character

`''` paritial quoting preserves MOST of the special characters within the string

`'` full quoting preserves all special characters within string.

`,` comma operator to link arithmetic operations. Can also concatenate strings

`\`: escape. quoting mechanism for single characters

`/` filename path separator

`\`` command substitution. the command construct makes available the output of command for assignment to a variable.

`:` null command. Shell equivalent of a NOP.

`!` reverse/negate sense of a test or exit status bang.


`\*` wildcard asterix

`\*` arithmetic operator for multiplication

`?` test operator (ternary operator)

`?` wild card single character

`$` variable substitution. A $ prefixing a variable name indicates the value the variable holds

`$` end of line in regular expressions

`${}` parameter substitution

`$'...'` Quoted string expansion - Expands single or multiple escaped octal or hex values into ASCII or Unicode characters

`$\*,$@` positional parameters

`$?` exit status variable

`$$` process id variable

`()` command group - starts a subshell. Separate instnace of the command processor.

`{xxx,yyy,zzz,...}` brace expansion

`{a..z}` extended brace expansion

`{}` Block of code. (inline group). In effect, creates an anonymous function.

`{}` placeholder for text used after xargs -i

`{}\;` pathname

`[]` test expression between []

`[[]]` test expression between [[]]. More flexible than the single-bracket [] test.

`[]` array element

`[]` range of characters in regex

`$[...]` integer expansion

`(())` integer expansion

`>&>&>><<>` redirection. `scriptname > filename` redirects output of scriptname to file filename. `command &> filename` redirects both the stdout and the stderr of command to filename. `command >&2` redirects stdout of command to stderr. `scriptname >> filename` appends the output of scriptname to file filename`. `[i]<>filename` opens filename for reading and writing and assigns file descriptor i to it.

`<<` redirection used in a here document

`<<<` redirection used in a here string

`<, >` ASCII comparison

`\<, \>` word boundary in a regular expression

`|` pipe to pass the output (stdout) of a previous command to the input (stdin) of the next one, or to the shell. This is a method of chaining commands together. Piping sends the stdout of one process to the stdin of another. In a typical case, a command such as cat or echo pipes a stream of data to a filer, a command that transforms its input for processing. cat $filename1 $filename2 | grep $search_word. A pipe runs as a child process and therefore cannot alter script variables.

`>|` force redirection. Overwrites existing file

`||` OR logical operator

`&` run job in background

`&&` AND logical operator

`-` option, prefix. Option flag for a command or filter. ie ls -al

`-` redirection from/to stdin or stdout. cat -  ie ls -al

`-` redirection from/to stdin or stdout. cat -  will echo stdin.

`-` previous working directory. cd -

`-` arithmetic minus

`=` equal assignment operator

`+` plus arithmetic operator

`+` option flag for a command or filter

`%` module arithmetic operation

`~` home directory tilde

`~+` current working directory. Corresponds to $PWD internal variable

`~-` previous working directory $OLDPWD

`=~` regular expression match

`^` beginning of line

`^,^^` Uppercase conversion in parameter substitution

## Control Characters


Control characters can be used to change the behavior of the terminal or text display.

Control characters are CONTROL + key combinations pressed simultaneously.

`Ctl-A`: Move cursor to beginning of line of text

`Ctl-B`: Backspace (nondestructive)

`Ctl-C`: Break. Terminate a foreground job

`Ctl-D`: Log out from a shell / EOF (end of file)

`Ctl-E`: Move cursor to end of line of text ( on the command line)

`Ctl-F`: Moves cursor forward one character posstiion on the command-line

`Ctl-G`: BEL. Bell/beep

`Ctl-H`: Rubout (destructive backspace). Erases characters the cursor backs over while backspacing.

`Ctl-I`: Horizontal tab

`Ctl-J`: Newline (line feed)

`Ctl-K`: Vertical tab

`Ctl-L`: Formfeed (clear terminal screen)

`Ctl-M`: Carriage return

`Ctl-N`: Erase a line of text recalled from history buffer

`Ctl-O`: Issues a newline

`Ctl-P`: Recalls last command from history buffer

`Ctl-Q`: Resume (XON) (Resumes stdin in a terminal)

`Ctl-R`: Backwards search for text in history buffer

`Ctl-S`: Suspend (XOFF). Freeze stdin in a terminal. `Ctl-Q` to restore input

`Ctl-T`: Reverse the position of the character the cursor is on with the previous character (on the command line)

`Ctl-U`: Erase a line of input from cursor backward to beginning of line. In some settings, Ctl-U erases the entire line of input, regardless of cursor position.

`Ctl-V`: When inputting text, Ctl-V permits inserting control characters

`Ctl-W`: When typing text on the console or in an xterm window, Ctl-W erases from the character under the cursor backwards to the first instance of whitespace.

`Ctl-X`: In certain word processing programs, Cuts highlighted text and copies to clipboard

`Ctl-Y`: Pastes back text previously erased with Ctl-U or Ctl-W

`Ctl-z`: Pauses a foreground job


## Whitespace

functions as a separator between commands and/or variables. Whitespace consists of either spaces, tabs, blank lines, or any combination thereof.

In some contexts, such as variable assignment, whitespace is not permitted and results in a syntax error.

Blank lines have no effect on the action of a script and therefore usueful for visually separating functional sections.

