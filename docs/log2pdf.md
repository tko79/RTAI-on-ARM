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

## Used programs

- awk: 1.3.3-17 (debian)
- sed: 4.2.1-10 (debian)
- enscript: 1.6.5.90-2 (debian)
- ps2pdf: 9.05~dfsg-6.3+ (debian)
