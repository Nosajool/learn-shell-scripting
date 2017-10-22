# 02 - Starting off with a Sha-Bang

## 2.1 Invoking the script

Can place normal shell commands in a script so that you don't have to retype them again. - A program

Use the `#!/bin/bash` header to tell your system that this file is a set of commands to be fed to the command interpreter indicated.

`#!` is a 2-byte magic number (designating file type / executable shell script)

- See `man magic` for more details

Can remove the sha-bang if script only uses system commands and no internal shell directives.

