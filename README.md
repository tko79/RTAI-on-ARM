# RTAI-on-ARM

Beside the x86 and x86-64 architecture and others [RTAI](https://www.rtai.org)
also supports ARM architecture.

Key task of this repository is to track the development of RTAI on ARM and with
this to improve the support of the ARM architecture in RTAI.

To achieve that goal this repository intends to be the home of several ARM
related patches, including development patches as well as patches which are
already integrated into RTAI. Documentation (mainly via the
[Wiki](https://github.com/tko79/RTAI-on-ARM/wiki)), test scripts and test
results are also part of this repository.

Latest supported RTAI version is 3.9.1 and Linux version is 2.6.37.6. Issues
[#5](https://github.com/tko79/RTAI-on-ARM/issues/5) and
[#6](https://github.com/tko79/RTAI-on-ARM/issues/6) are created to track the
porting to RTAI 3.9.2 and Linux 2.6.38.8. The
[SupportedBoards](https://github.com/tko79/RTAI-on-ARM/wiki/SupportedBoards#overview)
list provides an overview of the status of currently available ARM boards. But
there is more this project wants to achieve! Please have a closer look to the
[VISION](https://github.com/tko79/RTAI-on-ARM/blob/master/VISION.md) document
for RTAI-on-ARM project for some more words on this.

***

# Getting Started

Change into the RTAI-on-ARM repository. First you should try to create a pdf
from the _plain.log. The pdf is created in directory boardtests/ and overwrites
the version which is already tracked with git.

    cd ~/rtai-on-arm/
    ./scripts/log2pdf.sh boardtests/_plain.log

To add a new test simply copy the _plain.log and fill the form with the test
data and results. Finally you should create a pdf version of your test.

    cp boardtests/_plain.log boardtests/omapl138_v1_rtai3.9.1_linux2.6.37.6.log
    vi boardtests/omapl138_v1_rtai3.9.1_linux2.6.37.6.log
    ./scripts/log2pdf.sh boardtests/omapl138_v1_rtai3.9.1_linux2.6.37.6.log

Please use the following syntax for the log file, with processor e.g. omapl138,
version or test number with this processor and rtai and linux versions:

    <processor>_v<test_version>_rtai<rtai_version>_linux<linux_version>.log

***

# License

RTAI-on-ARM is licensed under the GNU General Public License, version 2. See
[COPYING](https://github.com/tko79/RTAI-on-ARM/blob/master/COPYING) for
details.
