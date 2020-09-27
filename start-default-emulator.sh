#!/bin/bash

echo "Starting emuf emulator"
$ANDROID_HOME/emulator/emulator @emuf -no-window -no-audio 2>&1 &

EMU_BOOTED="no"
while [[ ${EMU_BOOTED} != *"stopped"* ]]; do
    echo "Wating for emulator booted..."
    sleep 5
    EMU_BOOTED=$(adb shell getprop init.svc.bootanim || echo "no")
done

echo "Emulator emuf booted"

echo "Starting emus emulator"
$ANDROID_HOME/emulator/emulator @emus -no-window -no-audio 2>&1 &

EMU_BOOTED="no"
while [[ ${EMU_BOOTED} != *"stopped"* ]]; do
    echo "Wating for emulator booted..."
    sleep 5
    EMU_BOOTED=$(adb shell getprop init.svc.bootanim || echo "no")
done

echo "Emulator emus booted"