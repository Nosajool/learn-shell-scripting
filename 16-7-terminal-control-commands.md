# 16.7 Terminal Control Commands

## Command affecting the console or terminal

`tput`: Initialize terminal and/or fetch information about it from terminfo data. Various options permit certain terminal operations: tput clear is the equivalent of clear; tput reset is the equivalent of reset.

Issuing a tput cup X Y moves the cursor to the (X,Y) coordinates in the current terminal. A clear to erase the terminal screen would normally precede this.


  Some interesting options to tput are:

  bold, for high-intensity text

  smul, to underline text in the terminal

  smso, to render text in reverse

  sgr0, to reset the terminal parameters (to normal), without clearing the screen

`infocmp`: This command prints out extensive information about the current terminal. It references the terminfo database.

`reset`: Reset terminal parameters and clear text screen. As with clear, the cursor and prompt reappear in the upper lefthand corner of the terminal.

`clear`: The clear command simply clears the text screen at the console or in an xterm. The prompt and cursor reappear at the upper lefthand corner of the screen or xterm window. This command may be used either at the command line or in a script. 

`resize`: Echoes commands necessary to set $TERM and $TERMCAP to duplicate the size (dimensions) of the current terminal.

`script`: This utility records (saves to a file) all the user keystrokes at the command-line in a console or an xterm window. This, in effect, creates a record of a session.
