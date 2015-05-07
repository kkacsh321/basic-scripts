#! /bin/bash

PATH_TO_PRODUCTIONBUNDLE="/Volumes/PPwork/FCSvr_Data/FCSvr_Backups" 
ARCHIVE_DESTINATION="/Volumes/PPwork/Archive/Versions/" 
LOG_PATH="/Library/Logs/clearFCSbackups.log" 
DATE=$(date) 

echo $DATE >> "$LOG_PATH" 
find  "$PATH_TO_PRODUCTIONBUNDLE" -name '*.zip*' -mtime +10 -exec rm -v {} \; >> "$LOG_PATH"
