# Sends any message stored in textSent variable to users via telegram bot.
# keep-result=no is required to not store any files locally on the RouterOS device
# parse_mode=HTML allows us to use text formatting
#

# dont-require-permissons=yes

:global textSent
:local telegramUsers {<user1>;<user2>}
:local botID "<botid1>"
:foreach chatID in $telegramUsers do={
 /tool fetch url="https://api.telegram.org/bot$botID/sendmessage?chat_id=$chatID&text=$textSent&parse_mode=HTML" keep-result=no
}