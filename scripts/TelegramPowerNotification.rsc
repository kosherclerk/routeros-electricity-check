# Runned from the scheduler (I use 3-hour intervals). Sends same messages to Telegram.
# I use it to check if UPS is still powering my RouterOS device since I cannot track when UPSs may become dead during blackouts.
#

# dont-require-permissons=yes

/system script run FuncDeviceStatus
/system script run FuncBlackoutReadTime
:global FuncStatus
:global FuncBlackoutRead
:local powerOnDuration [:pick [$FuncBlackoutRead] ([:find [$FuncBlackoutRead] " "]+1) [:len [$FuncBlackoutRead]]]
:local sinceLastBlackout [:pick [$FuncBlackoutRead] 0 [:find [$FuncBlackoutRead] " "]]
:global textSent "$[$FuncStatus]%0A\E2\9C\85 <b>Power is still here%0A%0ASince last blackout:  $sinceLastBlackout%0APower on duration:  $powerOnDuration</b>"
/system script run SendToTelegram