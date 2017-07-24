#!/bin/sh

# Check we got a database name (at least)
if [ $# -lt 1 ]
then
        echo "Usage:"
        echo "   pg_backup database [path]"
        exit 1
fi


# Get the supplied database name
database_name=$1

# Get the path, if supplied
backup_path="."

if [ $# -gt 1 ]
then
        backup_path=$2
fi

# Set some date and time variables
current_date=`date +%Y%m%d`
current_utc_date=`TZ='UTC' date +%Y%m%d`
current_time=`date +%H%M%S`
current_utc_time=`TZ='UTC' date +%H%M%S`

# Generate the destination file
destination_path="$backup_path""/""$database_name""_""$current_utc_date""_""$current_utc_time"".bak"

echo "Current UTC date: $current_utc_date"
echo "Current UTC time: $current_utc_time"
echo "Destination path: $destination_path"

pg_dump -Fc $database_name -f $destination_path