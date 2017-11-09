## 16.2 Complex Commands

`find`: `-exec COMMAND \;`

Carries out COMMAND on each file that *find* matches. The command sequence terminates with ; (the ";" is escaped to make certain the shell passes it to find literally, without interpreting it as a special character).

```
bash$ find ~/ -name '*.txt'
/home/bozo/.kde/share/apps/karm/karmdata.txt
 /home/bozo/misc/irmeyc.txt
 /home/bozo/test-scripts/1.txt
```

If COMMAND contains {}, then find substitutes the full path name of the selected file for "{}".

```
find ~/ -name 'core*' -exec rm {} \;
# Removes all core dump files from user's home directory.
```

`xargs`: A filter for feeding arguments to a command, and also a tool for assembling the commands themselves. It breaks a data stream into small enough chunks for filters and commands to process. Consider it as a powerful replacement for backquotes. In situations where command substitution fails with a too many arguments error, substituting xargs often works. Normally, xargs reads from stdin or from a pipe, but it can also be given the output of a file.

The default command for xargs is echo. This means that input piped to xargs may have linefeeds and other whitespace characters stripped out.

```
bash$ ls -l
total 0
 -rw-rw-r--    1 bozo  bozo         0 Jan 29 23:58 file1
 -rw-rw-r--    1 bozo  bozo         0 Jan 29 23:58 file2



bash$ ls -l | xargs
total 0 -rw-rw-r-- 1 bozo bozo 0 Jan 29 23:58 file1 -rw-rw-r-- 1 bozo bozo 0 Jan...



bash$ find ~/mail -type f | xargs grep "Linux"
./misc:User-Agent: slrn/0.9.8.1 (Linux)
 ./sent-mail-jul-2005: hosted by the Linux Documentation Project.
 ./sent-mail-jul-2005: (Linux Documentation Project Site, rtf version)
 ./sent-mail-jul-2005: Subject: Criticism of Bozo's Windows/Linux article
 ./sent-mail-jul-2005: while mentioning that the Linux ext2/ext3 filesystem
 . . .
 ```

 An interesting xargs option is -n NN, which limits to NN the number of arguments passed.

 `ls | xargs -n 8 echo` lists the files in the current directory in 8 columns.

 Another useful option is -0, in combination with find -print0 or grep -lZ. This allows handling arguments containing whitespace or quotes.

The -P option to xargs permits running processes in parallel. This speeds up execution in a machine with a multicore CPU.

```
$ seq 5 | xargs -n 1 echo "Hello"
Hello 1
Hello 2
Hello 3
Hello 4
Hello 5
```

`expr`: All-purpose expression evaluator: Concatenates and evaluates the arguments according to the operation given (arguments must be separated by spaces). Operations may be arithmetic, comparison, string or logical.

