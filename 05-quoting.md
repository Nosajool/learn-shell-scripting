# 5 Quoting

The idea of quoting is to protect special characters in the string from reinterpretation or expansion by the shell or shell script.

A character is special if it has an interpretation other than its literal meaning.

# 5.1 Quoting Variables

When referencing a variable, it is generally advisable to enclose its name in double quotes.

This prevents reinterpretation of all special characters within the quoted string -- except `$`, `\`` (backquote) and `\\` (escape).

Using double quotes prevents word splitting. An argument enclosed in double quotes presents itself as a single word, even if it contains whitespace separators.

Single quotes operate similarly to double quotes but do not permit referencing variables since the special meaning of $ is turned off.

Within single quotes, every special character except ' gets interepreted literally.

Consider single quotes to be a stricter method of quoting than double quotes ("partial quoting")

# 5.2 Escaping

Escaping is a method of quoting single characters.

The escape (\) preceding a character tells the shell to interpret that character literally.

`\n`: new line

`\r`: return

`\t`: tab

`\v`: vertical tab

`\b`: backspace

`\a`: alert (beep or flash)

`\0xx`: translate to octal ASCII equivalent of 0nn, where nn is a string of digits


`\"` gives the quote its lieterall meaning

`\$` gives the dollar sign its literal meaning.

`\\` gives the backslash its literall meaning
