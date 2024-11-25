# Writes timestamp without append into on/off.txt files when electricity turns off/on.
#

# 

:global powerOnOff
:local powerFile
:local statusFile "<pathtofile>/status.txt"
:if ([:len [/file find name=$statusFile]] = 0) do={
 /file print file=$statusFile
 delay 1
}
:global blackoutStatus [/file get $statusFile contents]
:if ($blackoutStatus != $powerOnOff) do {
 :if ($powerOnOff = "on") do={
  :set powerFile "<pathtofile>/on.txt"
 } else={
  :set powerFile "<pathtofile>/off.txt"
 }
 :local blackoutTime [:totime [:tonum [:timestamp]]]
 :if ([:len [/file find name=$powerFile]] = 0) do={
  /file print file=$powerFile
  delay 1
 }
 /file set $powerFile contents=$blackoutTime
 /file set $statusFile contents=$powerOnOff 
}