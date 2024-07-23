# Reads data from on/off.txt's and calculates time since last blackout and time since electricity turned on.
#

# dont-require-permissons=yes

:global FuncBlackoutRead do={
 :local currentTimestamp [:timestamp]
 :local currentTime [:pick $currentTimestamp 0 [:find $currentTimestamp "."]]
 :local blackoutTimeOff [/file get <pathtofile>/off.txt contents]
 :local blackoutTimeOn [/file get <pathtofile>/on.txt contents]
 :local blackoutTimeSinceLast ($currentTime - $blackoutTimeOff)
 :local blackoutTimePowerOn ($currentTime - $blackoutTimeOn)
 :return "$blackoutTimeSinceLast $blackoutTimePowerOn"
}
:put [$FuncBlackoutRead]