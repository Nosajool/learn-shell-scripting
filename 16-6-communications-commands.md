# 16.6 Communications Commands

## Information and Statistics

`host`: Searches for information about an Internet host by name or IP address, using DNS.

`ipcalc`: Displays IP information for a host. With the -h option, **ipcalc** does a reverse DNS lookup, finding the name of the host (server) from the IP address.

`nslookup`: Do an Internet "name server lookup" on a host by IP address. This is essentially equivalent to ipcalc -h or dig -x . The command may be run either interactively or noninteractively, i.e., from within a script.

The nslookup command has allegedly been "deprecated," but it is still useful.

`dig`: Domain Information Groper. Similar to nslookup, dig does an Internet name server lookup on a host. May be run from the command-line or from within a script.

Some interesting options to dig are +time=N for setting a query timeout to N seconds, +nofail for continuing to query servers until a reply is received, and -x for doing a reverse address lookup.

`traceroute`: Trace the route taken by packets sent to a remote host. This command works within a LAN, WAN, or over the Internet. The remote host may be specified by an IP address. The output of this command may be filtered by grep or sed in a pipe.

`ping`: Broadcast an ICMP ECHO_REQUEST packet to another machine, either on a local or remote network. This is a diagnostic tool for testing network connections, and it should be used with caution.

`whois`: Perform a DNS (Domain Name System) lookup. The -h option permits specifying which particular whois server to query. 

`finger`: Retrieve information about users on a network. Optionally, this command can display a user's ~/.plan, ~/.project, and ~/.forward files, if present.

`chfn`: Change information disclosed by the finger command.

`vrfy`: Verify an Internet e-mail address.

## Remote Host Access

`sx, rx`: The sx and rx command set serves to transfer files to and from a remote host using the xmodem protocol. These are generally part of a communications package, such as minicom.

`sz, rz`: The sz and rz command set serves to transfer files to and from a remote host using the zmodem protocol. Zmodem has certain advantages over xmodem, such as faster transmission rate and resumption of interrupted file transfers. Like sx and rx, these are generally part of a communications package.

`ftp`: Utility and protocol for uploading / downloading files to or from a remote host. 

`uucp`: uucp: UNIX to UNIX copy. This is a communications package for transferring files between UNIX servers. A shell script is an effective way to handle a uucp command sequence.

Since the advent of the Internet and e-mail, uucp seems to have faded into obscurity, but it still exists and remains perfectly workable in situations where an Internet connection is not available or appropriate. The advantage of uucp is that it is fault-tolerant, so even if there is a service interruption the copy operation will resume where it left off when the connection is restored.

`uux`:  UNIX to UNIX execute. Execute a command on a remote system. This command is part of the uucp package.

`cu`: Call Up a remote system and connect as a simple terminal. It is a sort of dumbed-down version of telnet. This command is part of the uucp package.

`telnet`: Utility and protocol for connecting to a remote host.

The telnet protocol contains security holes and should therefore probably be avoided. Its use within a shell script is not recommended.

`wget`: The wget utility noninteractively retrieves or downloads files from a Web or ftp site. It works well in a script.

`lynx`: The lynx Web and file browser can be used inside a script (with the -dump option) to retrieve a file from a Web or ftp site noninteractively.

With the -traversal option, lynx starts at the HTTP URL specified as an argument, then "crawls" through all links located on that particular server. Used together with the -crawl option, outputs page text to a log file.

`rlogin`: Remote login, initates a session on a remote host. This command has security issues, so use ssh instead.

`rsh`: Remote shell, executes command(s) on a remote host. This has security issues, so use ssh instead.

`rcp`: Remote copy, copies files between two different networked machines.

`rsync`: Remote synchronize, updates (synchronizes) files between two different networked machines.

`ssh`: Secure shell, logs onto a remote host and executes commands there. This secure replacement for telnet, rlogin, rcp, and rsh uses identity authentication and encryption.

`scp`: Secure copy, similar in function to rcp, copies files between two different networked machines, but does so using authentication, and with a security level similar to ssh.

## Local Network

`write`: This is a utility for terminal-to-terminal communication. It allows sending lines from your terminal (console or xterm) to that of another user. The mesg command may, of course, be used to disable write access to a terminal

Since write is interactive, it would not normally find use in a script.

`netconfig`: A command-line utility for configuring a network adapter (using DHCP). This command is native to Red Hat centric Linux distros.

## Mail

`mail`: Send or read e-mail messages.

This stripped-down command-line mail client works fine as a command embedded in a script.

`mailto`: Similar to the mail command, mailto sends e-mail messages from the command-line or in a script. However, mailto also permits sending MIME (multimedia) messages.

`mailstats`: Show mail statistics. This command may be invoked only by root.

`vacation`: This utility automatically replies to e-mails that the intended recipient is on vacation and temporarily unavailable. It runs on a network, in conjunction with sendmail, and is not applicable to a dial-up POPmail account.
