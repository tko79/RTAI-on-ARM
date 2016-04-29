#!/bin/bash

# Copyright 2016 Torsten Koschorrek
#
# This file is part of RTAI-on-ARM.
#
# RTAI-on-ARM is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# RTAI-on-ARM is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

# setup variables

FONT_CB="\x00font{Courier_Bold10}"
FONT_DF="\x00font{default}"
COLOR_GN="\x00color{0.0 0.5 0.0}"
COLOR_YE="\x00color{1.0 0.8 0.0}"
COLOR_RD="\x00color{1.0 0.0 0.0}"
COLOR_BL="\x00color{0.0 0.0 0.0}"

STYLE_PASSED=${FONT_CB}${COLOR_GN}
STYLE_BLOCKD=${FONT_CB}${COLOR_YE}
STYLE_FAILED=${FONT_CB}${COLOR_RD}
STYLE_NORMAL=${FONT_DF}${COLOR_BL}

BIN_AWK="/usr/bin/awk"
BIN_SED="/bin/sed"
BIN_ENSCRIPT="/usr/bin/enscript"
BIN_PS2PDF="/usr/bin/ps2pdf"

TMPFILE="/tmp/log2pdf.ps"

# check binaries

if [ ! -e "${BIN_AWK}" ]; then
    echo ${BIN_AWK}" is missing. Please install "${BIN_AWK}"!"
    exit 1
fi
if [ ! -e "${BIN_SED}" ]; then
    echo ${BIN_SED}" is missing. Please install "${BIN_SED}"!"
    exit 1
fi
if [ ! -e "${BIN_ENSCRIPT}" ]; then
    echo ${BIN_ENSCRIPT}" is missing. Please install "${BIN_ENSCRIPT}"!"
    exit 1
fi
if [ ! -e "${BIN_PS2PDF}" ]; then
    echo ${BIN_PS2PDF}" is missing. Please install "${BIN_PS2PDF}"!"
    exit 1
fi

# check logfile

LOGFILE=`echo $1 | ${BIN_AWK} -F. '{ print $1 }'`
if [ "${LOGFILE}" == "" ]; then
    LOGFILE="."`echo $1 | ${BIN_AWK} -F. '{ print $2 }'`
    if [ "${LOGFILE}" == "" ]; then
	echo "No logfile given! Please add the logfile as the first parameter!"
	exit 1
    fi
fi

# let's enscript

${BIN_SED} \
    -e "s/PASSED/${STYLE_PASSED}PASSED${STYLE_NORMAL}/g" \
    -e "s/BLOCKED/${STYLE_BLOCKD}BLOCKED${STYLE_NORMAL}/g" \
    -e "s/FAILED/${STYLE_FAILED}FAILED${STYLE_NORMAL}/g" \
    ${LOGFILE}.log | \
    ${BIN_ENSCRIPT} --no-header --escapes --font=Courier10 --output=${TMPFILE} &> /dev/null
${BIN_PS2PDF} ${TMPFILE} ${LOGFILE}.pdf