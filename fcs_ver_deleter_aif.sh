#! /bin/bash

PATH_TO_PRODUCTIONBUNDLE="/Volumes/PPwork/FCSvr_Data/Devices/Version.bundle/" 
ARCHIVE_DESTINATION="/Volumes/PPwork/Archive/Versions/" 
LOG_PATH="/Library/Logs/Archive_Versions_Aif.log" 
DATE=$(date) 

echo $DATE >> "$LOG_PATH" 
find  "$PATH_TO_PRODUCTIONBUNDLE" -name '*.aif*' -mtime +30 -exec mv -v {} "$ARCHIVE_DESTINATION" \; >> "$LOG_PATH"
