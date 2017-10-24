# Chapter 10 Manipulating Variables

# 10.1 Manipulating Strings

Bash supports lots of string manipulation operations but there is a lack of focus which results in some being a subset of parameter substitution, some fall under the functinoality of the UNIX `expr` command.

String Length

`${#string}`

`expr length $string`

`expr"$string":'.*'`

Length of Matching Substring at Beginning of String

`expr match "$string" "$substring'`

`expr "$string":'$substring'`

Index

`expr index $string $substring` Numerical position in $string of first character in $substring that matches

Substring Extraction

`${string:position}` Extracts substring from $string at $position. If the $string parameter is `*` or `@`, then this extracts the positional parameters starting at $position

`${string:position:length}`: Extracts $length characters of substring from $string at $position

`expr substr $string $position $length`: Extracts $length characters from $string starting at $position`

`expr match "$string" '\($substring\)'` Extracts $substring at beginning of $string, where $substring is a regular expression.

`expr "$string":'\($substring\)'`: Extracts $substring at beginning of $string, where $substring is a regular expression

`expr match "$string" '.\*\($substring\)' or `expr "$string" : '.*\($substring\)'
`: Extract $substring at end of $string where $substring is a regular expression

Substring Removal

`${string#substring}`: Delete shortest match of $substring from front of $string

`${string##substring}`: Delete longest match of $substring from front of $string

`${string%substring}`: Delete shortest match of $substring from back of $string

`${string%%substring}`: Deletes longest match of $substring from back of $string. Useful for generating filenames

Substring Replacement

`${string/substring/replacement}`: Replace first match of $substring with $replacement

`${string//substring/replacement}`: Replace all matches of $substring with $replacement

`${string/#substring/replacement}`: If $substring matches front end of $string, substitute $replacement for $substring.

`${string/%substring/replacement}`: If $substring matches back end of $string, substitute $replacement for $substring.

You can also invoke `awk` to manipulate strings rather than using built-in operations

```sh

String=23skidoo1
#      012345678    Bash
#      123456789    awk
# Note different string indexing system:
# Bash numbers first character of string as 0.
# Awk  numbers first character of string as 1.

echo ${String:2:4} # position 3 (0-1-2), 4 characters long
                                         # skid

# The awk equivalent of ${string:pos:length} is substr(string,pos,length).
echo | awk '
{ print substr("'"${String}"'",3,4)      # skid
}
'
#  Piping an empty "echo" to awk gives it dummy input,
#+ and thus makes it unnecessary to supply a filename.

echo "----"

# And likewise:

echo | awk '
{ print index("'"${String}"'", "skid")      # 3
}                                           # (skid starts at position 3)
'   # The awk equivalent of "expr index" ...
```

# 10.2 Parameter Substitution

Manipulating and/or expanding variables

`${parameter}`: Same as $parameter. ie. value of parameter

`${parameter-default}, ${parameter:-default}`: If parameter not set, use default. The default parameter construct finds use in providing "missing" command-line arguments in scripts

`${parameter=default}, ${parameter:=default}`: Same as above but the `:` makes a difference only when $parameter has been declared and is null

`${parameter+alt_value}, ${parameter:+alt_value}`: If parameter is set, use `alt_value`, otherwise, use null string.

`${parameter?err_msg}, ${parameter:?err_msg}`: If parameter set, use it, else print `err_msg` and abort the script with exit status of 1

Parameter substitution and/or expansion. The following expressions are the complement to the match in expr string operations. These particular ones are used mostly in parsing file path names.

Variable length / Substring removal

`${#var}`: String length. For an array, `${#array}` is the length of the first element in the array.

`${var#Pattern}`: Remove from $var the shortest part of $Pattern that matches the front end of $var.


`${var##Pattern}`: Remove from $var the longest part of $Pattern that matches the front end of $var.

`${var%Pattern}`: Remove from $var the shortest part of $Pattern that matches the back end of $var.

`${var%%Pattern}`: Remove from $var the longest part of $Pattern that matches the back end of $var.

Variable expansion / Substring replacement

`${var:pos}`: Variable var expanded, starting from offset pos.

`${var:pos:len}`: Expansion to a max of len characters of variable var, from offset pos.

`${var/Pattern/Replacement}`: First match of Pattern, within var replaced with Replacement. If Replacement is omitted, then the first match of Pattern is replaced by nothing, that is, deleted.

`${var//Pattern/Replacement}`: Global replacement. All matches of Pattern, within var replaced with Replacement. As above, if Replacement is omitted, then all occurrences of Pattern are replaced by nothing, that is, deleted.

`${var/#Pattern/Replacement}`: If prefix of var matches Pattern, then substitute Replacement for Pattern.

`${var/%Pattern/Replacement}`: If suffix of var matches Pattern, then substitute Replacement for Pattern.

`${!varprefix*}, ${!varprefix@}`: Matches names of all previously declared variables beginning with varprefix.






