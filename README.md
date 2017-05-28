# RTAI-on-ARM

Beside the X86 and X86/64 architecture and others [RTAI](https://www.rtai.org)
also supports ARM architecture.

Key task of this repository is to track the development of RTAI on ARM and with
this to improve the support of the ARM architecture in RTAI.

To achieve that goal this repository intends to be the home of several ARM
related patches, including development patches as well as patches which are
already integrated into RTAI. Documentation (mainly via the
[Wiki](https://github.com/tko79/RTAI-on-ARM/wiki)), test scripts and test
results are also part of this repository.

Strategy and roadmap is the development in small but steady steps. Latest
supported RTAI version is 3.9.1 and Linux version is 2.6.37.6. Issues #5 and #6
are created to track the porting to RTAI 3.9.2 and Linux 2.6.38.8.

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
