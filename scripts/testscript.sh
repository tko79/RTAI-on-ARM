#!/bin/sh

# testscript - Tool to run rtai boardtests.
#              This file is part of RTAI-on-ARM project.
# Copyright (C) 2017 Torsten Koschorrek
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.

license=$(cat <<EOF
testscript  Copyright (C) 2017  Torsten Koschorrek

This program comes with ABSOLUTELY NO WARRANTY. This is free software, and you
are welcome to redistribute it under the terms of the GNU General Public License
as published by the Free Software Foundation, either version 2 of the License,
or (at your option) any later version.
EOF
)

PREFIX_KMOD="/install/modules/"
PREFIX_TESTSUITE="/install/testsuite/"
PREFIX_LIBS="/install/lib/"
LATENCY_PERIOD=1000000
TEST_DURATION=10

function _create_device_files() {
    if [ ! -e /dev/rtf0 ]; then
	mknod /dev/rtf0 c 150 0
    fi
    if [ ! -e /dev/rtf3 ]; then
	mknod /dev/rtf3 c 150 3
    fi
}

function _load_modules() {
    sched_lxrt=$1

    insmod ${PREFIX_KMOD}/rtai_hal.ko
    insmod ${PREFIX_KMOD}/rtai_${sched_lxrt}.ko
    insmod ${PREFIX_KMOD}/rtai_msg.ko
    insmod ${PREFIX_KMOD}/rtai_sem.ko
    insmod ${PREFIX_KMOD}/rtai_mbx.ko
    insmod ${PREFIX_KMOD}/rtai_fifos.ko
    insmod ${PREFIX_KMOD}/rtai_shm.ko
}

function _unload_modules() {
    rmmod latency_rt &> /dev/null
    rmmod preempt_rt &> /dev/null
    rmmod switches_rt &> /dev/null
    rmmod rtai_shm rtai_fifos rtai_mbx rtai_sem rtai_msg &> /dev/null
    rmmod rtai_sched rtai_hal &> /dev/null
    rmmod rtai_lxrt rtai_hal &> /dev/null
}

function load_unload_kernel_modules() {
    echo "3.1: load/unload kernel modules"

    _create_device_files
    _unload_modules

    echo "3.1.1: load/unload kernel modules (sched)"
    _load_modules sched; lsmod; _unload_modules; lsmod
    echo "3.1.2: load/unload kernel modules (sched)"
    _load_modules sched; lsmod; _unload_modules; lsmod
    echo "3.1.3: load/unload kernel modules (lxrt)"
    _load_modules lxrt;  lsmod; _unload_modules; lsmod
    echo "3.1.4: load/unload kernel modules (lxrt)"
    _load_modules lxrt;  lsmod; _unload_modules; lsmod
}

function _latency_kernel() {
    periodic_oneshot=$1

    insmod ${PREFIX_KMOD}/latency_rt.ko timer_mode=$periodic_oneshot period=$LATENCY_PERIOD

    ( sleep $TEST_DURATION; killall display ) &
    $PREFIX_TESTSUITE/kern/latency/display
}

function _latency_user() {
    periodic_oneshot=$1

    # periodic/oneshot mode in userspace is defined by TIMER_MODE in latency.c
    # oneshot=0 is default -> latency ; periodic=1 is manually modified -> latency-p
    if [ $periodic_oneshot -eq 0 ]; then
	latencyprg=latency
    else
	latencyprg=latency-p
    fi
    LD_LIBRARY_PATH=$PREFIX_LIBS $PREFIX_TESTSUITE/user/latency/$latencyprg &
    sleep 1

    ( sleep $TEST_DURATION; killall display ) &
    LD_LIBRARY_PATH=$PREFIX_LIBS $PREFIX_TESTSUITE/user/latency/display
}

function latency_test_idle() {
    echo "3.2: latency tests (idle system)"

    _create_device_files
    _unload_modules

    echo "3.2.1: latency, idle, kernelspace, oneshot"
    _load_modules sched; _latency_kernel 0; _unload_modules
    echo "3.2.2: latency, idle, kernelspace, periodic"
    _load_modules sched; _latency_kernel 1; _unload_modules
    echo "3.2.3: latency, idle, userspace, oneshot"
    _load_modules sched; _latency_user 0; _unload_modules
    echo "3.2.4: latency, idle, userspace, periodic"
    _load_modules sched; _latency_user 1; _unload_modules
}
