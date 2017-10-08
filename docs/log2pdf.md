[//]: # (header info to convert markdown to man pages with md2man.sh)
[//]: # (title:LOG2PDF.SH)
[//]: # (section:1)
[//]: # (description:log2pdf.sh)

# Name

log2pdf - Tool to convert plaintext test logs into pdf file format

# Synopsis

`log2pdf.sh <logfile>`

# Description

**log2pdf** converts plaintext test logs into pdf file format. The script is
part of RTAI-on-ARM project.

The `<logfile>` is the log file which should be converted into a pdf document.

# Details

## Files

### Input

- `<logfile>.log`: test logfile to be converted

### Intermediate

- `/tmp/log2pdf.ps`: file is created with enscript as an intermediate step

### Output

- `<logfile>.pdf`: test log in pdf file format

## Used Programs

- echo: coreutils-8.13-3.5 (debian)
- awk: mawk-1.3.3-17 (debian)
- sed: sed-4.2.1-10 (debian)
- enscript: enscript-1.6.5.90-2 (debian)
- ps2pdf: ghostscript-9.05~dfsg-6.3+ (debian)
- grep: grep-2.12-2 (debian)
