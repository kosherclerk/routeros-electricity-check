# Since 7.21 text must be converted using :convert to work properly.
#
# Sends any message stored in textSent variable to users via telegram bot.
# keep-result=no is required to not store any files locally on the RouterOS device.
# parse_mode=HTML allows us to use text formatting.
#

# dont-require-permissons=yes

:global textSent
:local convertedText [:convert $textSent to=url]
:local telegramUsers {<user1>;<user2>}
:local botID "<botid1>"
:foreach chatID in $telegramUsers do={
 /tool fetch url="https://api.telegram.org/bot$botID/sendMessage\3Fchat_id=$chatID&parse_mode=$parseMode&text=$convertedText" keep-result=no
}