# Check itself as a host. If your UPS battery ran out this netwatch check will be triggered when the power comes back on.
# 


######
# UP #
######

/system script run FuncDeviceStatus
:global FuncStatus
:global textSent "$[$FuncStatus]%0A\E2\9A\A1\F0\9F\94\8C <b>Electricity is back on. UPS battery ran out</b>"
/system script run SendToTelegram