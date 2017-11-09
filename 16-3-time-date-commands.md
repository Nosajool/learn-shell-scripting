## 16.3 Time / Date Commands

### Time/date and timing

`date`: Simply invoked, *date* prints the date and time to *stdout*. Where this command gets interesting is in its formatting and parsing options.

```sh
echo "The number of days since the year's beginning is `date +%j`."
# Needs a leading '+' to invoke formatting.
# %j gives day of year.

echo "The number of seconds elapsed since 01/01/1970 is `date +%s`."
#  %s yields number of seconds since "UNIX epoch" began,
#+ but how is this useful?

prefix=temp
suffix=$(date +%s)  # The "+%s" option to 'date' is GNU-specific.
filename=$prefix.$suffix
echo "Temporary filename = $filename"
#  It's great for creating "unique and random" temp filenames,
#+ even better than using $$.
```

The -u option gives the UTC (Universal Coordinated Time).

The date command has quite a number of output options. For example %N gives the nanosecond portion of the current time. One interesting use for this is to generate random integers.

`zdump`: Time zone dump: echoes the time in a specified time zone

```
bash$ zdump EST
EST  Tue Sep 18 22:09:22 2001 EST
```

`time`: Outputs verbose timing statistics for executing a command

`touch`: Utility for updating access/modification times of a file to current system time or other specified time, but also useful for creating a new file. The command touch zzz will create a new file of zero length, named zzz, assuming that zzz did not previously exist. Time-stamping empty files in this way is useful for storing date information, for example in keeping track of modification times on a project.

The touch command is equivalent to : >> newfile or >> newfile (for ordinary files).

`at`: The *at* job control command executes a given set of commands at a specified time. Superficially, it resembles *cron*, however *at* is chiefly used for one-time execution of a command set.

`at 2pm January 15` prompts for a set of commands to execute at that time. These commands should be shell-script compatible, since, for all practical purposes, the user is typing in an executable shell script a line at a time.Input terminate s with a Ctl-D.

Using either the -f option or input redirection (<), at reads a command list from a file. This file is an executable shell script, though it should, of course, be non-interactive. Particularly clever is including the run-parts command in the file to execute a different set of scripts.

```
bash$ at 2:30 am Friday < at-jobs.list
job 2 at 2000-10-27 02:30
```

`batch`: The batch job control command is similar to at, but it runs a command list when the system load drops below .8. Like at, it can read commands from a file with the -f option.

The concept of batch processing dates back to the era of mainframe computers. It means running a set of commands without user intervention.

`cal`: Prints a neatly formatted monthly calendar to stdout. Will do current year or a large range of past and future years.

`sleep`: This is the shell equivalent of a wait loop. It pauses for a specified number of seconds, doing nothing. It can be useful for timing or in processes running in the background, checking for a specific event every so often (polling).

`usleep`: Microsleep (the u may be read as the Greek mu, or micro- prefix). This is the same as sleep, above, but "sleeps" in microsecond intervals. It can be used for fine-grained timing, or for polling an ongoing process at very frequent intervals.

`hwclock, clock`: The hwclock command accesses or adjusts the machine's hardware clock. Some options require root privileges. The /etc/rc.d/rc.sysinit startup file uses hwclock to set the system time from the hardware clock at bootup.

The clock command is a synonym for hwclock.

