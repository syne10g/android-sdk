#!/bin/bash

echo "Starting emulators"

$ANDROID_HOME/emulator/emulator @emuone -no-boot-anim -no-window -no-audio 2>&1 &
$ANDROID_HOME/emulator/emulator @emutwo -no-boot-anim -no-window -no-audio 2>&1 &
$ANDROID_HOME/emulator/emulator @emuthree -no-boot-anim -no-window -no-audio 2>&1 &
$ANDROID_HOME/emulator/emulator @emufour -no-boot-anim -no-window -no-audio 2>&1 &

set +e

bootcomplete=""
failcounter=0
timeout=600
sleeptime=10
maxfail=$((timeout / sleeptime))

until [[ "${bootcomplete}" =~ "1" ]]; do
    bootcomplete=`adb -s emulator-5560 shell getprop dev.bootcomplete 2>&1 &`
    if [[ "${bootcomplete}" =~ "" ]]; then
        ((failcounter += 1))
        adb devices
        echo "Waiting for emulator to start"
        if [[ ${failcounter} -gt ${maxfail} ]]; then
            echo "Timeout ($timeout seconds) reached; failed to start emulator"
            while pkill -9 "emulator" >/dev/null 2>&1; do
                echo "Killing emulator proces...."
                pgrep "emulator"
            done
            echo "Process terminated"
            pgrep "emulator"
            exit 1
        fi
    fi
    sleep ${sleeptime}
done

adb -s emulator-5556 shell su root setprop marathon.serialno 89991111111
adb -s emulator-5556 shell su root setprop marathon.serialno 89992222222
adb -s emulator-5558 shell su root setprop marathon.serialno 89993333333
adb -s emulator-5560 shell su root setprop marathon.serialno 89994444444

echo "Emulators is ready"