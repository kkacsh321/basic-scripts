#/bin/bash
#ENVIRONMENT=STAGE

TENANTS_CFG=all-prodtenants-stage-env.cfg



# user may have chosen to run this only for selected tenants
# make sure the tenant(s) exist in the config file before going further
if [ "$SELECTED_TENANTS" != "" ] ;  then

  for tenant in $SELECTED_TENANTS ; do
      # check to see that the tenant exists as the first parameter of an entry in the tenant configs
      # file
      EXISTS_IN_CONFIG=`grep ^${tenant}\; ${TENANTS_CFG}`
      if [ "$EXISTS_IN_CONFIG" == "" ] ; then
        echo "WARNING: $tenant does not exist in $TENANTS_CFG! "
        exit 1
      fi
  done
  TENANTS=`bash bin/list_tenants.sh  "${TENANTS_CFG}"|grep $SELECTED_TENANTS|gshuf`
else
  TENANTS=`bash bin/list_tenants.sh  "${TENANTS_CFG}"|gshuf`
  
fi

echo ${TENANTS}

for tenant in $TENANTS; 

do cat  >> test.txt <<End-of-message

[/home/tribe/.pm2/logs/$tenant-out.log]
datetime_format = %Y-%m-%d %H:%M:%S
file = /home/tribe/.pm2/logs/$tenant-out.log
buffer_duration = 5000
log_stream_name = stageapi1-$tenant-out
initial_position = end_of_file
log_group_name = Stage-3.0
[/home/tribe/.pm2/logs/$tenant-error.log]
datetime_format = %Y-%m-%d %H:%M:%S
file = /home/tribe/.pm2/logs/$tenant-error.log
buffer_duration = 5000
log_stream_name = stageapi1-$tenant-error
initial_position = end_of_file
log_group_name = Stage-3.0
End-of-message


done

