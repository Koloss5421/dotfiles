# dotfiles
This is a collection of my personal dot files as well as a script to backup and restore!

# Usage:
The 'map.txt' file should contain a line separated list of files.
Each line should contain the original file and the backup file.

```bash
<original_file>:<backup_location>
```

There is also an optional flag to prevent from backing up the file after it has already been added:

```bash
<original_file>:<backup_location>:0
```

From there the script can be used to copy the files to/from the files directory with backup/restore respectively:
```bash
Usage: dotfiles.sh <backup|restore>
```
