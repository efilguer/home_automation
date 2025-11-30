#!/bin/bash

#import absolute paths so cron can see
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Current date: $(date)"
max_batt="$(acpi -i | grep 'full capacity')"

battery_percent=$(python3 "$DIR/nuffcharge_parse.py" <<< "$max_batt")
echo "testing TEST TEST TEST $battery_percent"
optimum_batt=$(($battery_percent - 10)) #max battery - 10 percent

is_charging="$(acpi -a)"
echo "$is_charging"

#ac uplugged
ac_unplugged="$(acpi -b| grep remaining)" #this only works when ac is unplugged
ac_plugged="$(acpi -b | grep charged)"

current_battery=$(python3 "$DIR/nuffcharge_parse.py" <<< "$ac_plugged")

message_1="Your optimum battery is $optimum_batt Optimum charge achieved at $current_battery. Uplug laptop now."
message_2="Stop charging the laptop and unplug immediately. You will end up frying your battery"
message_3="Good to keep charging"

echo "optimum battery charge at: $optimum_batt %"
#alert user if current batt is greater than max batt

if [ "$current_battery" -eq "$optimum_batt" ]; then
    source "$DIR/notify.sh" $message_1
elif [ "$current_battery" -gt "$optimum_batt" ]; then
    source "$DIR/notify.sh" $message_2
else
   echo $message_3
fi

#check what environment cron is in
env > /tmp/cron_env.txt
