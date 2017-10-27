# Appendix C. A Sed and Awk Micro-Primer

`sed`: a non-interactive text file editor

`awk`: a field-oriented pattern processing language with a C-style syntax

Both utilities share a similar invocation syntax, use *regular expressions*, read input by default from *stdin* and output to *stdout*

These are well-behaved UNIX tools, and they work together well. The output from one can be piped to the other, and their combined capabilities give shell scripts some of the power of perl.

## Sed


*Sed* is a *non-interactive stream editor*.

Stands for "**s**tream **ed**itor"

It receives text input, whether from *stdin* or from a file, performs certain operations on specified lines of the input, one line at a time, then output the result to *stdout* or to a file.

Within a shell script, *sed* is usually one of several tool components in a pipe.

*Sed* determines **which lines** of its input that it will operate on from the **address range** passed to it.

Specify this address range either by **line number** or by a pattern to match.

For example, `3d` signals *sed* to **delete line 3** of the iput and `/Windows/d` tells sed that you want **every line of the input containing a match to "Windows" deleted**

The 3 most commonly used operations of the sed tookit are:

1. **p**rinting
2. **d**eletion
3. **s**ubstitution

Unless the g (global) operator is appended to a substitute command, the substitution operates only on the first instance of a pattern match within each line.

```sh
sed -e '/^$/d' $filename
# The -e option causes the next string to be interpreted as an editing instruction.
#  (If passing only a single instruction to sed, the "-e" is optional.)
#  The "strong" quotes ('') protect the RE characters in the instruction
#+ from reinterpretation as special characters by the body of the script.
# (This reserves RE expansion of the instruction for sed.)
#
# Operates on the text contained in file $filename.
```

Sed uses the -e option to specify that the following string is an instruction or set of instructions. If there is only a single instruction contained in the string, then this may be omitted.

```sh
sed -n '/xzy/p' $filename
# The -n option tells sed to print only those lines matching the pattern.
# Otherwise all input lines would print.
# The -e option not necessary here since there is only a single editing instruction.
```


`$ sed -n /Lorem/p lorem.txt` to print only lines containing "Lorem".

`$ sed s/Lorem/Aquaman/ lorem.txt` to substitute "Aquaman" for the first instance of "Lorem" in each input line.

`$ cat my.csv | sed '2,4d'` don't show lines 2-4 from my.csv
`$ cat my.csv | sed '2,4p'` only show lines 2-4 from my.csv
`$ cat my.csv | sed '/Frank/d'` don't show lines with Frank in the line

## Awk

Awk is a full-featured text processing language with a syntax reminiscent of C.

Awk breaks each line of input passed to it into **fields**.

By default, a field is a **string of consecutive characters** delimited by **whitespace**, though there are options for changing this.

Awk parses and operates on each separate field.

This makes it ideal for *handling structured* text files -- especially tables -- data organized into consistent chunks, such as rows and columns.

*Strong quoting* and *curly brackets* enclose blocks of awk code within a shell script.

```sh

# $1 is field #1, $2 is field #2, etc.

echo one two | awk '{print $1}'
# one

echo one two | awk '{print $2}'
# two

# But what is field #0 ($0)?
echo one two | awk '{print $0}'
# one two
# All the fields!


awk '{print $3}' $filename
# Prints field #3 of file $filename to stdout.

awk '{print $1 $5 $6}' $filename
# Prints fields #1, #5, and #6 of file $filename.

awk '{print $0}' $filename
# Prints the entire file!
# Same effect as:   cat $filename . . . or . . . sed '' $filename
```

Awk handles *variables* similarly to shell scripts, though a bit more flexibly.

`{ total += ${column_number} }`

This adds the value of *column_number* to the running total of *total*.

Finally, to print "total", there is an `END` command block, executed after the script has processed all its input. `END { print total }`

Corresponding to `END`, there is a `BEGIN` for a code block to be performed before awk starts processing its input.

`awk '{ print }' lorem.txt` to print the whole file

`awk '{ print $1 }' lorem.txt` to print the first word in each line

`awk '/Lorem/ { print }' lorem.txt` to print every line with "Lorem" in it

`awk '{ if($1  ~ /Lorem/) print }' lorem.txt` to print lines that have "Ipsum" as the second word

`awk -F "\"*,\"*" '{print $3}' file.csv` to use comma as delimiter and print 3rd field of every line



