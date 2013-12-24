#!/bin/sh

USED_BYTES_REGEX="(?<=\"usedBytes\":)[^,]*"
MAX_BYTES_REGEX="(?<=\"maxBytes\":)[^,]*"
PLAN_NAMES_REGEX="(?<=\"planName\":\")[^\"]*"

TOTAL_USED_BYTES=0
TOTAL_ALLOTED_BYTES=0

echo "Fetching usage from verizon..."
RAW_DATA=$(curl -s "https://mobile.vzw.com/vzam/servlet/vzam?client=chrome&serviceName=accountInfo&subServiceName=poundData")

USED_BYTES=$(echo "$RAW_DATA" | grep -Po $USED_BYTES_REGEX)
MAX_BYTES=$(echo "$RAW_DATA" | grep -Po $MAX_BYTES_REGEX)
PLAN_NAMES=$(echo "$RAW_DATA" | grep -Po $PLAN_NAMES_REGEX)

for used in $USED_BYTES
do
  TOTAL_USED_BYTES=$(expr $TOTAL_USED_BYTES + $used)
done

for alloted in $MAX_BYTES
do
  TOTAL_ALLOTED_BYTES=$(expr $TOTAL_ALLOTED_BYTES + $alloted)
done

PERCENT=$(echo "scale=4;$TOTAL_USED_BYTES / $TOTAL_ALLOTED_BYTES * 100" | bc -q 2>/dev/null)

echo "Total Bytes:  $TOTAL_ALLOTED_BYTES"
echo "Used Bytes:   $TOTAL_USED_BYTES"
echo "Used Percent: $PERCENT%"
