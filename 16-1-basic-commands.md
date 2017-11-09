## 16.1 Basic Commands

`ls`: The basic file "list" command

`cat,tac`: *cat*, an acronym for *concatenate*, lists a file to *stdout*. When combined with redirection (> or >>), it is commonly used to concatenate files.

*tac* is inverse of *cat*, listing a file backwards from its end.

`rev`: reverses each line of a file and outputs to *stdout*. This does not have the same effect as *tac* as it preserves the order of the lines, but flips each one around.

`cp`: This is the file copy command

`mv`: This is the file *move* command. It is the equivalent to a combination of *cp* and *rm*. It may be used to move multiple files to a directory, or even to rename a directory.

`rm`: Delete (remove) a file or files. The -f option forces removal of even readonly files, and is useful for bypassing user input in a script.

The rm command will, by itself, fail to remove filenames beginning with a dash. Why? Because rm sees a dash-prefixed filename as an option.

One clever workaround is to precede the filename with a " -- " (the end-of-options flag).

`bash$ rm -- -badname`

Another method to is to preface the filename to be removed with a dot-slash .

`bash$ rm ./-badname`

`rmdir`: Remove directory. The directory must be empty of all files -- including "invisible" dotfiles -- for this command to succeed.

`mkdir`: Make directory, creates a new directory. For example, mkdir -p project/programs/December creates the named directory. The -p option automatically creates any necessary parent directories.

`chmod`: Changes the attributes of an existing file or directory

`chattr`: **Ch**ange file **attr**ibutes. This is analogous to *chmod* above, but with different options and a different invocation syntax, and it works only on ext2/ext3 filesystems.

One particularly interesting chattr option is i. A chattr +i filename marks the file as immutable. The file cannot be modified, linked to, or deleted, not even by root. This file attribute can be set or removed only by root. In a similar fashion, the *a* option marks the file as append only.

```
root# chattr +i file1.txt


root# rm file1.txt

rm: remove write-protected regular file `file1.txt'? y
 rm: cannot remove `file1.txt': Operation not permitted
```

If a file has the s (secure) attribute set, then when it is deleted its block is overwritten with binary zeroes. 

If a file has the u (undelete) attribute set, then when it is deleted, its contents can still be retrieved (undeleted).

If a file has the c (compress) attribute set, then it will automatically be compressed on writes to disk, and uncompressed on reads.

The file attributes set with chattr do not show in a file listing (ls -l).

`ln`: Creates links to pre-existings files. A "link" is a reference to a file, an alternate name for it. The ln command permits referencing the linked file by more than one name and is a superior alternative to aliasing

The ln creates only a reference, a pointer to the file only a few bytes in size.

The ln command is most often used with the -s, symbolic or "soft" link flag. Advantages of using the -s flag are that it permits linking across file systems or to directories.

The syntax of the command is a bit tricky. For example: ln -s oldfile newfile links the previously existing oldfile to the newly created link, newfile.

Which type of link to use?

Both of these [types of links] provide a certain measure of dual reference -- if you edit the contents of the file using any name, your changes will affect both the original name and either a hard or soft new name. The differences between them occurs when you work at a higher level. The advantage of a hard link is that the new name is totally independent of the old name -- if you remove or rename the old name, that does not affect the hard link, which continues to point to the data while it would leave a soft link hanging pointing to the old name which is no longer there. The advantage of a soft link is that it can refer to a different file system (since it is just a reference to a file name, not to actual data). And, unlike a hard link, a symbolic link can refer to a directory.

`man, info`: These commands access the manual and information pages on system commands and installed utilities. When available, the info pages usually contain more detailed descriptions than do the man pages.


