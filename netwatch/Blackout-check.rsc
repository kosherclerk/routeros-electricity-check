# This netwatch script can be fine-tuned to launch faster, but I use type=simple - works for me.
# Checks host for ping availability (you can set the host IP of any devices that run 24/7 without UPS power - IOT devices, APs, etc.)
# UP status - electricity is turned on, DOWN status - electricity turned off. 
# Correspondibly to an event it runs other scripts, writes and sends messages to Telegram, turns off/on the wireless interface on itself
# (I use another APs for wireless while there is no blackout).
#


######
# UP #
######

/system script run FuncDeviceStatus
:global FuncStatus
:global powerOnOff "on"
/system script run FuncBlackoutWriteTimeOnOff
/system script run FuncBlackoutReadTime
:global FuncBlackoutRead
:global blackoutStatus
:local blackoutDuration [:pick [$FuncBlackoutRead] 0 [:find [$FuncBlackoutRead] " "]]
:if ($blackoutStatus = $powerOnOff) do={
 :global textSent "$[$FuncStatus]%0A\E2\9A\A1\F0\9F\94\8B <b>Status has not changed. Probable reboot</b>"
} else={
 :global textSent "$[$FuncStatus]%0A\E2\9A\A1\F0\9F\94\8B <b>Electricity is back on. UPS is working%0A%0ABlackout duration:  $blackoutDuration</b>"
}
:log warning "[ELECTRICITY] Blackout-hotspot disabled. Exiting power saving mode"
# old capsman
# /interface wireless cap set enabled=no
# new capsman
# /interface wifi set [find name~"wifi"] disabled=yes
/interface wifi set [find name~"wifi"] disabled=yes
/system routerboard settings set cpu-frequency=auto
/system script run SendToTelegram

########
# DOWN #
########

/system script run FuncDeviceStatus
:global FuncStatus
:global powerOnOff "off"
/system script run FuncBlackoutWriteTimeOnOff
/system script run FuncBlackoutReadTime
:global FuncBlackoutRead
:global blackoutStatus
:local powerOnDuration [:pick [$FuncBlackoutRead] ([:find [$FuncBlackoutRead] " "]+1) [:len [$FuncBlackoutRead]]]
:if ($blackoutStatus = $powerOnOff) do={
 :global textSent "$[$FuncStatus]%0A\E2\9D\8C\F0\9F\94\8B <b>Status has not changed. Probable reboot</b>"
} else={
 :global textSent "$[$FuncStatus]%0A\E2\9D\8C\F0\9F\94\8B <b>Electricity is down. UPS is working%0A%0APower on duration:  $powerOnDuration</b>"
}
:log warning "[ELECTRICITY] Blackout-hotspot enabled. Entering power saving mode"
# old capsman
# /interface wireless cap set enabled=yes
# new capsman
# /interface wifi set [find name~"wifi"] disabled=no
/interface wifi set [find name~"wifi"] disabled=no
/system routerboard settings set cpu-frequency=448MHz
/system script run SendToTelegram