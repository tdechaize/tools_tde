# Here are another two formatting examples:
#
# date "+DATE: %D%nTIME: %T"
#
# Another date format example
#
# date +"Week number: %V Year: %y"
#
# These are the most common formatting characters for the date command:
#
#        %D – Display date as mm/dd/yy
#        %Y – Year (e.g., 2020)
#        %m – Month (01-12)
#        %B – Long month name (e.g., November)
#        %b – Short month name (e.g., Nov)
#        %d – Day of month (e.g., 01)
#        %j – Day of year (001-366)
#        %u – Day of week (1-7)
#        %A – Full weekday name (e.g., Friday)
#        %a – Short weekday name (e.g., Fri)
#        %H – Hour (00-23)
#        %I – Hour (01-12)
#        %M – Minute (00-59)
#        %S – Second (00-60)
#
#
#
#! /bin/bash
export datecurr=`date +"%d-%m-%Y"`
export DAY=`echo $datecurr | cut -c 1-2`
export MONTH=`echo $datecurr | cut -c 4-5`
export YEAR=`echo $datecurr | cut -c 7-10`
echo "Jour : $DAY"
echo "Mois : $MONTH"
echo "Ann?e : $YEAR"