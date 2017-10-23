# 7.1 Test Constructs


An `if/then` construct tests whether the *exit status* of a list of commands is 0 (success), and if so, executes one or more commands.

There exists a dedicated command called `[`. It is a synonym for *test* and a builtin for efficiency reasons. This command considers its arguments as comparison expressions or file tests and returns an exit status corresponding to the result of the comparison (0 for true, 1 for false).

There is also `[[...]]` which is the *extended test command* that performs comparisons in a manner more familiar to programmers from other languages.

The `((...))` and `let ...` constructs return an *exit status* according to whether the arithmetic expressions they evaluate expand to a non-zero value.

An *if* can test any command, not just conditions enclosed within brackets.

```sh
if cmp a b &> /dev/null
then echo "Files a and b are identical."
else echo "Files a and b differ."
fi
```

```sh
if grep -q Bash file
then echo "File contains at least one occurrence of Bash."
fi
```


When *if* and *then* are on the same line in a condition test, a semicolon must terminate the if statement.

Else if and elif.

elif is a contraction for else if.

The effect is to nest an inner if/then construct within an outer one.


The `test` command is a Bash builtin which tests file types and compares strings. Therefore, in a Bash script, *test* does NOT call the external `/usr/bin/test` binary which is part of the `sh-utils` package.

Likewise, `[` does not call `/usr/bin/[` which is linked to `/usr/bin/test`

# 7.2 File test operators

Returns true if:

`-e`:  file exists

`-a`: file exists (deprecated)

`-f`: file is a *regular file* (not a directory or a device file)

`-s`: file is NOT zero size

`-d`: file is a directory

`-b`: file is a block device: A block device reads and/or writes data in chunks or blocks. ie.e hard drives, CDROM drives, flash drives

`-c`: file is a character device: Accesses data in character units. ie keyboards, modems, sound cards

`-p`: file is a pipe

`-h`: file is a symlink

`-L`: file is a symlink

`-S`: file is a socket

`-t`: file descriptor is associated with a terminal device. This test option may be used to check whether the stdin [ -t 0 ] or stdout [ -t 1 ] in a given script is a terminal.

`-r`: file has read permission for the user running the test

`-w`: file has write permission (for the user running the test)

`-x`: file has execute permission (for the user running the test)

`-g`: set group-id (sgid) flag set on file or directory. If a directory has the *sgid* flag set, then a file created within that directory belongs to the group that owns the directory, not necessarily to the group of the user who created the file.

`-u`: set-user-id (suid) flag set on file. A binary owned by root with set-user-id flag set runs with root privilleges, even when an ordinary user invokes it.

`-k`: sticky bit set. Commonly known as the sticky bit, the save-text-mode flag is a special type of file permission. If a file has this flag set, that file will be kept in cache memory for quicker access. If set on a directory, it restricts write permission. Setting the sticky bit adds a t to the permissions on the file or directory listing. This restricts altering or deleting specific files in that directory to the owner of those files.

`-O`: You are the owner of file

`-G`: group-id of file same as yours

`-N`: file modified since it was last read

`f1 -nt f2`: file f1 is newer than f2

`f1 -ot f2`: file f1 is older than f2

`f1 -ef f2`: files f1 and f2 are hard links to the same file

`!`: "not" -- reverses the sense of the tests above

# 7.3 Other Comparison Operators

integer comparison:

`-eq`: is equal to

`-ne`: is not equal to

`-gt`: is greater than

`-ge`: is greater than or equal to

`-lt`: is less than

`-le`: is less than or equal to

`<`: is less than (within double parentheses)

`<=`: is less than or equal to (within double parenthesis)

`>`: is greater than (within double parentheses)

`>=`: is greater than or equal to (within double parentheses)

string comparison:

`=`: is equal to 

`==`: is equal to (synonym to =)

`!=`: not equal to

`<`: less than in ASCII alphabetical order

`>`: is greater than, in ASCII alphabetical order

`-z`: string is null (zero length)

`-n`: string is NOT null

compound comparison

`-a`: logical and

`-o`: logical or

# 7.4 Nested if/then Condition Tests

Condition tests using the if/then construct may be nested.

The net result is equivalent to using the `&&` compound comparison operator.
