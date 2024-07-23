# Writes timestamp without append into on/off.txt files when electricity turns off/on.
#

# 

:global powerOnOff
:local filename
:if ($powerOnOff = "on") do={
 :set filename "<pathtofile>/on.txt"
} else={
 :set filename "<pathtofile>/off.txt"
}
:local blackoutTimestamp [:timestamp]
:local blackoutTime [:pick $blackoutTimestamp 0 [:find $blackoutTimestamp "."]]
:if ([:len [/file find name=$filename]] = 0) do={
 /file print file=$filename
 delay 1
}
/file set $filename contents=$blackoutTime