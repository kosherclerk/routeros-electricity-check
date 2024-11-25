# Check itself as a host. If your UPS battery ran out this netwatch check will be triggered when the power comes back on.
# 


######
# UP #
######

/system script run FuncDeviceStatus
:global FuncStatus
:global textSent "$[$FuncStatus]%0A\E2\9A\A1\F0\9F\94\8C <b>Mikrotik is back online. The UPS battery has run out of power or a reboot has occurred</b>"
/system script run SendToTelegram