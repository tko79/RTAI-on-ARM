Obviously the ARM support for RTAI got caught on old, not to say ancient,
versions. RTAI on ARM and the supported Linux Kernel are some years behind now.
**This needs to be changed**!

The strategy and roadmap is the development in small but steady steps, moving
from one version to the next. The idea is to introduce new features step by
step to keep changes simple and comprehensible. After all you would have to
take care of three parts, RTAI, Linux and the ARM board support. And there is
no need to work on all parts simultaneously.

Finally it should be possible to catch up with the current development of both,
RTAI and Linux Kernel. And with every newly supported Linux version the number
of potentially supported ARM boards would also increase.
