# drist

*_NOTE_*: This is a fork of the origional drsit. See the [HISTORY](#history) section below.

## BRIEF
drist is a tool to configure and synchronize configurations to, and/or run scrips on remote host(s) via scp(1) and ssh(1).

## SYNOPSIS
    drist [-p] [-d] [-e [sudo|doas]] [-S script] [-f files-directory] [-F file-to-copy] destination [...]

## DESCRIPTION
Remote host configuration preformed with files and scripts without any special configuration syntaxes/languages, daemons, or agents. drist relies on base tools like sed(1), and ssh(1) and aims at being a simple to use and a pluggable automation tool.

When executed without optional "-F", "-f", "-S" flags, drist will execute the following steps from the current working directory:

1. If folder 'files' or 'files-HOSTNAME'  exists, its content is copied to server.
2. If file 'script' or 'script-HOSTNAME' exists, executed on remote server via ssh(1).

In the previous list, files are copied to or scripts executed on remote server if it's hostname matches 'HOSTNAME' (e.g. a directory called: "files-server.local" would only copy files to a host whos hostname is: "server.local").

If the 'folder' or the 'script' file does not exist, drist will skip it.

drist also supports execution from a different working directory via the use of optional command flags to specify the script or files to be uploaded. See the options and examples sections below.

## OPTIONS
-p      Use persistent ssh connection, allowing ssh only once for the different steps.  This uses ControlMaster feature from ssh(1).

-d      Truncate reported hostname.  Tells drist to truncate the reported remote hostname to the left-most component.

-e      [sudo|doas] execute as priviliged command (as root) on the remote server via binary.  Default is `doas`.

-S      (script) Use a specified script instead of a file called `script` found in local directory.

-f      (directory) Use a specified directory to upload instead of a local directory of `files` directory.

-F      (file) A single file to upload instead of one found in a `files` directory.

destination     Specify the remote servers you want drist to work on. The destination can be a file containing a list of hosts, one per line or it can be addresses passed in the command line. If you specify multiples servers, drist will loop over the list respecting the list order.  Note that only one file can be used in the command line.

## BUILD
default install location: /usr/local/bin
default man path location: /usr/local/share/man/man1
```sh
    # make install
```

To change the default install locations the included "configure"
script can be used.

```sh
    # ./configure --preflix=/location/to/instal/to
    # ./configure --mandi=/location/for/man/pages
 ```

## EXAMPLES
The following examples demonstrate usage with the optional file and directory specifier flags for clarity.

Upload and execute a script ("setup.sh") on the ACME host.
```
   # drist -S /place/where/scripts/reside/setup.sh ACME
```

Upload and execute a script ("setup.sh") on the ACME host using elevated permissions with `doas`.
```
   # drist -e -S /place/where/scripts/reside/setup.sh ACME
```

Upload and execute a script ("setup.sh") on the ACME host using elevated permissions with `sudo`.
```
   # drist -e sudo -S /place/where/scripts/reside/setup.sh ACME
```

Upload a file ("upload.file") to the ACME host.
```
    # drist -F /place/where/files/reside/upload.file ACME
```

Upload all files in a directory to the ACME host.
```
    # drist -f /place/where/files/reside/ ACME
```

## HISTORY
- Originally created by Solène Rapenne <solene@perso.pw>
The original drist is located: 
https://dataswamp.org/~solene/page-drist-official-website.html

- Updated by John Kaul. Please see the [CHANGELOG](CHANGELOG) for updates.
