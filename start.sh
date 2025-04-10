#!/bin/bash

JAR_FILE="paper.jar"
MIN_RAM="2G"
MAX_RAM="6G"
THREADS=$(nproc)

FLAGS_OPTIMIZE="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs"

java -Xms${MIN_RAM} -Xmx${MAX_RAM} ${FLAGS_OPTIMIZE} \
    -XX:ActiveProcessorCount=${THREADS} \
    -Dpaper.maxChunkThreads=${THREADS} \
    -Dpaper.maxTickThreads=${THREADS} \
    -Dpaper.disableChannelLimit=true \
    -Dpaper.globalMaxConcurrentChunkLoads=1000 \
    -jar ${JAR_FILE} --nogui
