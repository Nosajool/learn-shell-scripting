## 16.5 File and Archiving Commands

`tar`: The standard UNIX archiving utility. Originally a Tape ARchiving program, it has developed into a general purpose package that can handle all manner of archiving with all types of destination devices, ranging from tape drives to regular files to even stdout. GNU tar has been patched to accept various compression filters, for example: `tar czvf archive_name.tar.gz *`, which recursively archives and gzips all files in a directory tree except dotfiles in the current working directory ($PWD).

Some useful tar options:

-c create (a new archive)

-x extract (files from existing archive)

--delete delete (files from existing archive)

Caution	
This option will not work on magnetic tape devices.

-r append (files to existing archive)

-A append (tar files to existing archive)

-t list (contents of existing archive)

-u update archive

-d compare archive with specified filesystem

--after-date only process files with a date stamp after specified date

-z gzip the archive

(compress or uncompress, depending on whether combined with the -c or -x) option

-j bzip2 the archive

`shar`: Shell archiving utility. The text and/or binary files in a shell archive are concatenated without compression, and the resultant archive is essentially a shell script, complete with #!/bin/sh header, containing all the necessary unarchiving commands, as well as the files themselves. Unprintable binary characters in the target file(s) are converted to printable ASCII characters in the output shar file. Shar archives still show up in Usenet newsgroups, but otherwise shar has been replaced by tar/gzip. The unshar command unpacks shar archives.

`ar`: Creation and manipulation utility for archives, mainly used for binary object file libraries.

`rpm`: The Red Hat Package Manager, or rpm utility provides a wrapper for source or binary archives. It includes commands for installing and checking the integrity of packages, among other things.

`cpio`: This specialized archiving copy command (**c**o**p**y **i**nput and **o**utput) is rarely seen any more, having been supplanted by tar/gzip. It still has its uses, such as moving a directory tree. With an appropriate block size (for copying) specified, it can be appreciably faster than tar.

`rpm2cpio`: This command extracts a cpio archive from an rpm one.

`pax`: The pax **p**ortable **a**rchive e**x**change toolkit facilitates periodic file backups and is designed to be cross-compatible between various flavors of UNIX. It was designed to replace tar and cpio.

## Compression

`gzip`: The standard GNU/UNIX compression utility, replacing the inferior and proprietary compress. The corresponding decompression command is gunzip, which is the equivalent of gzip -d.

The zcat filter decompresses a gzipped file to stdout, as possible input to a pipe or redirection. This is, in effect, a cat command that works on compressed files (including files processed with the older compress utility). The zcat command is equivalent to gzip -dc.

`bzip2`: An alternate compression utility, usually more efficient (but slower) than gzip, especially on large files. The corresponding decompression command is bunzip2.

Similar to the zcat command, bzcat decompresses a bzipped2-ed file to stdout.

`compress, uncompress`: This is an older, proprietary compression utility found in commercial UNIX distributions. The more efficient gzip has largely replaced it. Linux distributions generally include a compress workalike for compatibility, although gunzip can unarchive files treated with compress.

`sq`: Yet another compression (squeeze) utility, a filter that works only on sorted ASCII word lists. It uses the standard invocation syntax for a filter, sq < input-file > output-file. Fast, but not nearly as efficient as gzip. The corresponding uncompression filter is unsq, invoked like sq.

`zip, unzip`: Cross-platform file archiving and compression utility compatible with DOS pkzip.exe. "Zipped" archives seem to be a more common medium of file exchange on the Internet than "tarballs."

`unarc, unarj, unrar`: These Linux utilities permit unpacking archives compressed with the DOS arc.exe, arj.exe, and rar.exe programs.

`lzma, unlzma, lzcat`: Highly efficient Lempel-Ziv-Markov compression. The syntax of lzma is similar to that of gzip.

`xz, unxz, xzcat`: A new high-efficiency compression tool, backward compatible with lzma, and with an invocation syntax similar to gzip. 

## File Informationo

`file`: A utility for identifying file types. The command file file-name will return a file specification for file-name, such as ascii text or data. It references the magic numbers found in /usr/share/magic, /etc/magic, or /usr/lib/magic, depending on the Linux/UNIX distribution.

The -f option causes file to run in batch mode, to read from a designated file a list of filenames to analyze. The -z option, when used on a compressed target file, forces an attempt to analyze the uncompressed file type.

```
bash$ file test.tar.gz
test.tar.gz: gzip compressed data, deflated,
 last modified: Sun Sep 16 13:34:51 2001, os: Unix

bash file -z test.tar.gz
test.tar.gz: GNU tar archive (gzip compressed data, deflated,
 last modified: Sun Sep 16 13:34:51 2001, os: Unix)
 ```

 ```
# Find sh and Bash scripts in a given directory:

DIRECTORY=/usr/local/bin
KEYWORD=Bourne
# Bourne and Bourne-Again shell scripts

file $DIRECTORY/* | fgrep $KEYWORD

# Output:

# /usr/local/bin/burn-cd:          Bourne-Again shell script text executable
# /usr/local/bin/burnit:           Bourne-Again shell script text executable
# /usr/local/bin/cassette.sh:      Bourne shell script text executable
# /usr/local/bin/copy-cd:          Bourne-Again shell script text executable
# . . . 
```

`which`: which command gives the full path to "command." This is useful for finding out whether a particular command or utility is installed on the system.

`whereis`: Similar to which, above, whereis command gives the full path to "command," but also to its manpage.

`whatis`: whatis command looks up "command" in the whatis database. This is useful for identifying system commands and important configuration files. Consider it a simplified man command.

`vdir`: Show a detailed directory listing. The effect is similar to ls -lb.

`locate, slocate`: The locate command searches for files using a database stored for just that purpose. The slocate command is the secure version of locate (which may be aliased to slocate).

`getfacl, setfacl`: These commands retrieve or set the **f**ile **a**ccess **c**ontrol **l**ist -- the owner, group, and file permissions.

`readlink`: Disclose the file that a symbolic link points to.

`strings`: Use the strings command to find printable strings in a binary or data file. It will list sequences of printable characters found in the target file. This might be handy for a quick 'n dirty examination of a core dump or for looking at an unknown graphic image file (strings image-file | more might show something like JFIF, which would identify the file as a jpeg graphic). In a script, you would probably parse the output of strings with grep or sed.

## Compression

`diff`: flexible file comparison utility. It compares the target files line-by-line sequentially. In some applications, such as comparing word dictionaries, it may be helpful to filter the files through sort and uniq before piping them to diff. diff file-1 file-2 outputs the lines in the files that differ, with carets showing which file each particular line belongs to.

The --side-by-side option to diff outputs each compared file, line by line, in separate columns, with non-matching lines marked. The -c and -u options likewise make the output of the command easier to interpret.

There are available various fancy frontends for diff, such as sdiff, wdiff, xdiff, and mgdiff.

Tip
T he diff command returns an exit status of 0 if the compared files are identical, and 1 if they differ (or 2 when binary files are being compared). This permits use of diff in a test construct within a shell script (see below).

A common use for diff is generating difference files to be used with patch The -e option outputs files suitable for ed or ex scripts.

`patch`: flexible versioning utility. Given a difference file generated by diff, patch can upgrade a previous version of a package to a newer version. It is much more convenient to distribute a relatively small "diff" file than the entire body of a newly revised package. Kernel "patches" have become the preferred method of distributing the frequent releases of the Linux kernel.

`zdiff`: compare gzipped files

`diffstat`: create histogram of output from diff

`diff3`: An extended version of diff that compares three files at a time. This command returns an exit value of 0 upon successful execution, but unfortunately this gives no information about the results of the comparison.

`merge`: The merge (3-way file merge) command is an interesting adjunct to diff3. Its syntax is merge Mergefile file1 file2. The result is to output to Mergefile the changes that lead from file1 to file2. Consider this command a stripped-down version of patch.

`sdiff`: Compare and/or edit two files in order to merge them into an output file. Because of its interactive nature, this command would find little use in a script.

`cmp`: The cmp command is a simpler version of diff, above. Whereas diff reports the differences between two files, cmp merely shows at what point they differ.

Like diff, cmp returns an exit status of 0 if the compared files are identical, and 1 if they differ. This permits use in a test construct within a shell script.

`zcmp`: cmp for gzipped files

`comm`: Versatile file comparison utility. The files must be sorted for this to be useful.

## Utilities

`basename`: Strips the path information from a file name, printing only the file name. The construction basename $0 lets the script know its name, that is, the name it was invoked by. This can be used for "usage" messages if, for example a script is called with missing arguments:

`dirname`: Strips the basename from a filename, printing only the path information.

basename and dirname can operate on any arbitrary string. The argument does not need to refer to an existing file, or even be a filename for that matter

`split, csplit`: These are utilities for splitting a file into smaller chunks. Their usual use is for splitting up large files in order to back them up on floppies or preparatory to e-mailing or uploading them.

The csplit command splits a file according to context, the split occuring where patterns are matched.

## Encoding and Encryption

`sum, cksum, md5sum, sha1sum`: These are utilities for generating checksums. A checksum is a number mathematically calculated from the contents of a file, for the purpose of checking its integrity. A script might refer to a list of checksums for security purposes, such as ensuring that the contents of key system files have not been altered or corrupted. For security applications, use the md5sum (message digest 5 checksum) command, or better yet, the newer sha1sum (Secure Hash Algorithm).

`uuencode`: This utility encodes binary files (images, sound files, compressed files, etc.) into ASCII characters, making them suitable for transmission in the body of an e-mail message or in a newsgroup posting. This is especially useful where MIME (multimedia) encoding is not available.

`uudecode`: This reverses the encoding, decoding uuencoded files back into the original binaries.

`mimencode, mmencode`: The mimencode and mmencode commands process multimedia-encoded e-mail attachments. Although mail user agents (such as pine or kmail) normally handle this automatically, these particular utilities permit manipulating such attachments manually from the command-line or in batch processing mode by means of a shell script.

`crypt`: At one time, this was the standard UNIX file encryption utility. Politically-motivated government regulations prohibiting the export of encryption software resulted in the disappearance of crypt from much of the UNIX world, and it is still missing from most Linux distributions. Fortunately, programmers have come up with a number of decent alternatives to it, among them the author's very own cruft (see Example A-4).

`openssl`: This is an Open Source implementation of Secure Sockets Layer encryption.

Piping openssl to/from tar makes it possible to encrypt an entire directory tree.

`shred`: Securely erase a file by overwriting it multiple times with random bit patterns before deleting it.

This is one of the GNU fileutils.

Advanced forensic technology may still be able to recover the contents of a file, even after application of shred.

## Miscellaneous

`mktemp`: Create a temporary file with a "unique" filename. When invoked from the command-line without additional arguments, it creates a zero-length file in the /tmp directory.

`make`: Utility for building and compiling binary packages. This can also be used for any set of operations triggered by incremental changes in source files.

The make command checks a Makefile, a list of file dependencies and operations to be carried out.

The make utility is, in effect, a powerful scripting language similar in many ways to Bash, but with the capability of recognizing dependencies.

`install`: Special purpose file copying command, similar to cp, but capable of setting permissions and attributes of the copied files. This command seems tailormade for installing software packages, and as such it shows up frequently in Makefiles (in the make install : section). It could likewise prove useful in installation scripts.

`dos2unix`: This utility, written by Benjamin Lin and collaborators, converts DOS-formatted text files (lines terminated by CR-LF) to UNIX format (lines terminated by LF only), and vice-versa.

`ptx`: The ptx [targetfile] command outputs a permuted index (cross-reference list) of the targetfile. This may be further filtered and formatted in a pipe, if necessary.

`more, less`: Pagers that display a text file or stream to stdout, one screenful at a time. These may be used to filter the output of stdout . . . or of a script.

An interesting application of more is to "test drive" a command sequence, to forestall potentially unpleasant consequences.


