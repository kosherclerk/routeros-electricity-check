# Collects data about date, time and uptime
# 

# policy=read

:global FuncStatus do={
 /system clock
 :local deviceDate [get date]
 :local deviceTime [get time]
 /system resource
 :local deviceUptime [get uptime]
 :return "$deviceDate  $deviceTime  uptime: $deviceUptime"
}
:put [$FuncStatus]