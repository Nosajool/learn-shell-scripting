## 16.4 Text Processing Commands

### Commands affecting text and text files

`sort`: File sort utility, often used as a filter in a pipe. This command sorts a text stream or file forwards or backwards, or according to various keys or character positions. Using the -m option, it merges presorted input files.The info page lists its many capabilities and options.

`tsort`: Topological sort, reading in pairs of whitespace-separated strings and sorting according to input patterns. The original purpose of tsort was to sort a list of dependencies for an obsolete version of the ld linker in an "ancient" version of UNIX.

The results of a tsort will usually differ markedly from those of the standard sort command, above.

`uniq`: This filter removes duplicate lines from a sorted file. It is often seen in a pipe coupled with sort.

```
cat list-1 list-2 list-3 | sort | uniq > final.list
# Concatenates the list files,
# sorts them,
# removes duplicate lines,
# and finally writes the result to an output file.
```

The useful -c option prefixes each line of the input file with its number of occurrences.

```
bash$ cat testfile
This line occurs only once.
 This line occurs twice.
 This line occurs twice.
 This line occurs three times.
 This line occurs three times.
 This line occurs three times.


bash$ uniq -c testfile
      1 This line occurs only once.
       2 This line occurs twice.
       3 This line occurs three times.


bash$ sort testfile | uniq -c | sort -nr
      3 This line occurs three times.
       2 This line occurs twice.
       1 This line occurs only once.
```

The sort INPUTFILE | uniq -c | sort -nr command string produces a frequency of occurrence listing on the INPUTFILE file (the -nr options to sort cause a reverse numerical sort). This template finds use in analysis of log files and dictionary lists, and wherever the lexical structure of a document needs to be examined.

`expand, unexpand`: The expand filter converts tabs to spaces. It is often used in a pipe.

The unexpand filter converts spaces to tabs. This reverses the effect of expand.

`cut`: A tool for extracting fields from files. It is similar to the print $N command set in awk, but more limited. It may be simpler to use cut in a script than awk. Particularly important are the -d (delimiter) and -f (field specifier) options.

Using cut to obtain a listing of the mounted filesystems: `cut -d ' ' -f1,2 /etc/mtab`

Using cut to list the OS and kernel version: `uname -a | cut -d" " -f1,3,11,12`

Using cut to extract message headers from an e-mail folder:

```
bash$ grep '^Subject:' read-messages | cut -c10-80
Re: Linux suitable for mission-critical apps?
 MAKE MILLIONS WORKING AT HOME!!!
 Spam complaint
 Re: Spam complaint
```

Using cut to parse a file:

```sh
# List all the users in /etc/passwd.

FILENAME=/etc/passwd

for user in $(cut -d: -f1 $FILENAME)
do
  echo $user
  done
```
cut -d ' ' -f2,3 filename is equivalent to awk -F'[ ]' '{ print $2, $3 }' filename

`paste`: Tool for merging together different files into a single, multi-column file. In combination with cut, useful for creating system log files.

```
bash$ cat items
alphabet blocks
 building blocks
 cables

bash$ cat prices
$1.00/dozen
 $2.50 ea.
 $3.75

bash$ paste items prices
alphabet blocks $1.00/dozen
 building blocks $2.50 ea.
 cables  $3.75
```

`join`: Consider this a special-purpose cousin of paste. This powerful utility allows merging two files in a meaningful fashion, which essentially creates a simple version of a relational database.

The join command operates on exactly two files, but pastes together only those lines with a common tagged field (usually a numerical label), and writes the result to stdout. The files to be joined should be sorted according to the tagged field for the matchups to work properly.

```
File: 1.data

100 Shoes
200 Laces
300 Socks

File: 2.data

100 $40.00
200 $1.00
300 $2.00
```

```
bash$ join 1.data 2.data
File: 1.data 2.data

 100 Shoes $40.00
 200 Laces $1.00
 300 Socks $2.00
```

`head`: lists the beginning of a file to stdout. The default is 10 lines, but a different number can be specified. The command has a number of interesting options.

`tail`: lists the (tail) end of a file to stdout. The default is 10 lines, but this can be changed with the -n option. Commonly used to keep track of changes to a system logfile, using the -f option, which outputs lines appended to the file.

To list a specific line of a text file, pipe the output of head to tail -n 1. For example head -n 8 database.txt | tail -n 1 lists the 8th line of the file database.txt.

To set a variable to a given block of a text file:

```sh
var=$(head -n $m $filename | tail -n $n)
# filename = name of file
# m = from beginning of file, number of lines to end of block
# n = number of lines to set variable to (trim from end of block)
```

`grep`: A multi-purpose file search tool that uses Regular Expressions. It was originally a command/filter in the venerable ed line editor: g/re/p -- global - regular expression - print.

`grep pattern [file...]`

Search the target file(s) for occurrences of pattern, where pattern may be literal text or a Regular Expression.

```
bash$ grep '[rst]ystem.$' osinfo.txt
The GPL governs the distribution of the Linux operating system.
```

If no target file(s) specified, grep works as a filter on stdout, as in a pipe.

```
bash$ ps ax | grep clock
765 tty1     S      0:00 xclock
 901 pts/1    S      0:00 grep clock
```

The -i option causes a case-insensitive search.

The -w option matches only whole words.

The -l option lists only the files in which matches were found, but not the matching lines.

The -r (recursive) option searches files in the current working directory and all subdirectories below it.

The -n option lists the matching lines, together with line numbers.

```
bash$ grep -n Linux osinfo.txt
2:This is a file containing information about Linux.
 6:The GPL governs the distribution of the Linux operating system.
```

The -v (or --invert-match) option filters out matches.

```
grep pattern1 *.txt | grep -v pattern2

# Matches all lines in "*.txt" files containing "pattern1",
# but ***not*** "pattern2".	      
```

The -c (--count) option gives a numerical count of matches, rather than actually listing the matches.

```
grep -c txt *.sgml   # (number of occurrences of "txt" in "*.sgml" files)


#   grep -cz .
#            ^ dot
# means count (-c) zero-separated (-z) items matching "."
# that is, non-empty ones (containing at least 1 character).
# 
printf 'a b\nc  d\n\n\n\n\n\000\n\000e\000\000\nf' | grep -cz .     # 3
printf 'a b\nc  d\n\n\n\n\n\000\n\000e\000\000\nf' | grep -cz '$'   # 5
printf 'a b\nc  d\n\n\n\n\n\000\n\000e\000\000\nf' | grep -cz '^'   # 5
#
printf 'a b\nc  d\n\n\n\n\n\000\n\000e\000\000\nf' | grep -c '$'    # 9
# By default, newline chars (\n) separate items to match. 

# Note that the -z option is GNU "grep" specific.
```

The --color (or --colour) option marks the matching string in color (on the console or in an xterm window). Since grep prints out each entire line containing the matching pattern, this lets you see exactly what is being matched. See also the -o option, which shows only the matching portion of the line(s).

When invoked with more than one target file given, grep specifies which file contains matches.

```
bash$ grep Linux osinfo.txt misc.txt
osinfo.txt:This is a file containing information about Linux.
 osinfo.txt:The GPL governs the distribution of the Linux operating system.
 misc.txt:The Linux operating system is steadily gaining in popularity.
```

To force grep to show the filename when searching only one target file, simply give /dev/null as the second file.

If there is a successful match, grep returns an exit status of 0, which makes it useful in a condition test in a script, especially in combination with the -q option to suppress output.

```sh
SUCCESS=0                      # if grep lookup succeeds
word=Linux
filename=data.file

grep -q "$word" "$filename"    #  The "-q" option
                               #+ causes nothing to echo to stdout.
if [ $? -eq $SUCCESS ]
# if grep -q "$word" "$filename"   can replace lines 5 - 7.
then
  echo "$word found in $filename"
else
  echo "$word not found in $filename"
fi
```

How can grep search for two (or more) separate patterns? What if you want grep to display all lines in a file or files that contain both "pattern1" and "pattern2"?

One method is to pipe the result of grep pattern1 to grep pattern2.

```
bash$ grep file tstfile
# Filename: tstfile
 This is a sample file.
 This is an ordinary text file.
 This file does not contain any unusual text.
 This file is not unusual.

bash$ grep file tstfile | grep text
This is an ordinary text file.
 This file does not contain any unusual text.
```

`egrep`: extended grep -- is the same as grep -E. This uses a somewhat different, extended set of Regular Expressions, which can make the search a bit more flexible. It also allows the boolean | (or) operator.

```
bash $ egrep 'matches|Matches' file.txt
Line 1 matches.
 Line 3 Matches.
 Line 4 contains matches, but also Matches
```

`fgrep`: -- fast grep -- is the same as grep -F. It does a literal string search (no Regular Expressions), which generally speeds things up a bit.

On some Linux distros, egrep and fgrep are symbolic links to, or aliases for grep, but invoked with the -E and -F options, respectively.

`agrep`: (approximate grep) extends the capabilities of grep to approximate matching. The search string may differ by a specified number of characters from the resulting matches. This utility is not part of the core Linux distribution.

To search compressed files, use zgrep, zegrep, or zfgrep. These also work on non-compressed files, though slower than plain grep, egrep, fgrep. They are handy for searching through a mixed set of files, some compressed, some not.


To search bzipped files, use bzgrep.

`look`: The command look works like grep, but does a lookup on a "dictionary," a sorted word list. By default, look searches for a match in /usr/dict/words, but a different dictionary file may be specified.

```sh
#!/bin/bash
# lookup: Does a dictionary lookup on each word in a data file.

file=words.data  # Data file from which to read words to test.

echo
echo "Testing file $file"
echo

while [ "$word" != end ]  # Last word in data file.
do               # ^^^
  read word      # From data file, because of redirection at end of loop.
  look $word > /dev/null  # Don't want to display lines in dictionary file.
  #  Searches for words in the file /usr/share/dict/words
  #+ (usually a link to linux.words).
  lookup=$?      # Exit status of 'look' command.

  if [ "$lookup" -eq 0 ]
  then
    echo "\"$word\" is valid."
  else
    echo "\"$word\" is invalid."
  fi  

done <"$file"    # Redirects stdin to $file, so "reads" come from there.

echo
```

`sed, awk`: Scripting languages especially suited for parsing text files and command output. May be embedded singly or in combination in pipes and shell scripts.

`sed`: Non-interactive "stream editor", permits using many ex commands in batch mode. It finds many uses in shell scripts.

`awk`: Programmable file extractor and formatter, good for manipulating and/or extracting fields (columns) in structured text files. Its syntax is similar to C.

`wc`: wc gives a "word count" on a file or I/O stream:

```
bash $ wc /usr/share/doc/sed-4.1.2/README
13  70  447 README
[13 lines  70 words  447 characters]
```

wc -w gives only the word count.

wc -l gives only the line count.

wc -c gives only the byte count.

wc -m gives only the character count.

wc -L gives only the length of the longest line.

Using wc to total up the size of all the files whose names begin with letters in the range d - h

```
bash$ wc [d-h]* | grep total | awk '{print $3}'
71832
```

`tr`: character translation filter.

Either `tr "A-Z" "*" <filename or tr A-Z \* <filename` changes all the uppercase letters in filename to asterisks (writes to stdout). On some systems this may not work, but `tr A-Z '[**]'` will.

The -d option deletes a range of characters.

```
echo "abcdef"                 # abcdef
echo "abcdef" | tr -d b-d     # aef


tr -d 0-9 <filename
# Deletes all digits from the file "filename".
```

The --squeeze-repeats (or -s) option deletes all but the first instance of a string of consecutive characters. This option is useful for removing excess whitespace.

```
bash$ echo "XXXXX" | tr --squeeze-repeats 'X'
X
```

The -c "complement" option inverts the character set to match. With this option, tr acts only upon those characters not matching the specified set.

```
bash$ echo "acfdeb123" | tr -c b-d +
+c+d+b++++
```

`fold`: A filter that wraps lines of input to a specified width. This is especially useful with the -s option, which breaks lines at word spaces

`fmt`: Simple-minded file formatter, used as a filter in a pipe to "wrap" long lines of text output.

```sh
#!/bin/bash

WIDTH=40                    # 40 columns wide.

b=`ls /usr/local/bin`       # Get a file listing...

echo $b | fmt -w $WIDTH

# Could also have been done by
#    echo $b | fold - -s -w $WIDTH
```

`col`: This deceptively named filter removes reverse line feeds from an input stream. It also attempts to replace whitespace with equivalent tabs. The chief use of col is in filtering the output from certain text processing utilities, such as groff and tbl.

`column`: Column formatter. This filter transforms list-type text output into a "pretty-printed" table by inserting tabs at appropriate places.

```sh

#!/bin/bash
# colms.sh
# A minor modification of the example file in the "column" man page.


(printf "PERMISSIONS LINKS OWNER GROUP SIZE MONTH DAY HH:MM PROG-NAME\n" \
; ls -l | sed 1d) | column -t
#         ^^^^^^           ^^

#  The "sed 1d" in the pipe deletes the first line of output,
#+ which would be "total        N",
#+ where "N" is the total number of files found by "ls -l".

# The -t option to "column" pretty-prints a table.

exit 0
```

`colrm`: Column removal filter. This removes columns (characters) from a file and writes the file, lacking the range of specified columns, back to stdout. `colrm 2 4 <filename` removes the second through fourth characters from each line of the text file filename.

If the file contains tabs or nonprintable characters, this may cause unpredictable behavior. In such cases, consider using expand and unexpand in a pipe preceding colrm.

`nl`: Line numbering filter: nl filename lists filename to stdout, but inserts consecutive numbers at the beginning of each non-blank line. If filename omitted, operates on stdin.

The output of nl is very similar to cat -b, since, by default nl does not list blank lines.


`pr`: Print formatting filter. This will paginate files (or stdout) into sections suitable for hard copy printing or viewing on screen.	Various options permit row and column manipulation, joining lines, setting margins, numbering lines, adding page headers, and merging files, among other things. The pr command combines much of the functionality of nl, paste, fold, column, and expand.

`pr -o 5 --width=65 fileZZZ | more` gives a nice paginated listing to screen of fileZZZ with margins set at 5 and 65

A particularly useful option is -d, forcing double-spacing (same effect as sed -G).

`gettext`: The GNU gettext package is a set of utilities for localizing and translating the text output of programs into foreign languages. While originally intended for C programs, it now supports quite a number of programming and scripting languages.

`msgfmt`: A program for generating binary message catalogs. It is used for localization.

`iconv`: A utility for converting file(s) to a different encoding (character set). Its chief use is for localization.

`recode`: Consider this a fancier version of iconv, above. This very versatile utility for converting a file to a different encoding scheme. Note that recode is not part of the standard Linux installation.

`TeX, gs`: TeX and Postscript are text markup languages used for preparing copy for printing or formatted video display.

TeX is Donald Knuth's elaborate typsetting system. It is often convenient to write a shell script encapsulating all the options and arguments passed to one of these markup languages.

Ghostscript (gs) is a GPL-ed Postscript interpreter.

`texexec`: Utility for processing TeX and pdf files. Found in /usr/bin on many Linux distros, it is actually a shell wrapper that calls Perl to invoke Tex.

`enscript`: Utility for converting plain text file to PostScript

`groff, tbl, eqn`: Yet another text markup and display formatting language is groff. This is the enhanced GNU version of the venerable UNIX roff/troff display and typesetting package. Manpages use groff.

The tbl table processing utility is considered part of groff, as its function is to convert table markup into groff commands.

The eqn equation processing utility is likewise part of groff, and its function is to convert equation markup into groff commands.

`lex, yacc`: The lex lexical analyzer produces programs for pattern matching. This has been replaced by the nonproprietary flex on Linux systems.


The yacc utility creates a parser based on a set of specifications. This has been replaced by the nonproprietary bison on Linux systems.



