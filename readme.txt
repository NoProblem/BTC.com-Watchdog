Opensource and free script for ASIC monitoring on BTC.com pool (https://pool.btc.com). Created by NoProblem :)

English is not my native language, sorry for mistakes.

This script running in tray and checking ASIC state every 2 min. If a hashrate less than value "WorkerErrorSpeed" script will send SMS and/or telegram message.
Usage:
1. Download and install Autohotkey https://www.autohotkey.com/
2. Dowload script: https://github.com/NoProblem/BTC.com-Watchdog/raw/master/BTC.com-Watchdog.zip
3. (skip if not need SMS) Register on site sms.ru
4. (skip if not need Telegram) Crete new bot with BotFather https://core.telegram.org/bots, get it token and chat_id.
5. Change values in file BTC.com_watchdog.ini

[BTC.comSettings]
User=SubAccount ------------------------------------ Your sub account. https://pool.btc.com/manage-account
AccessKey=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - "AccessKey" from https://pool.btc.com/dashboard -> "Settings" -> "Get AccessKey and puid" 
puid=XXXXX ----------------------------------------- "puid" from https://pool.btc.com/dashboard -> "Settings" -> "Get AccessKey and puid" 
APIURL=https://eu-pool.api.btc.com/v1/ ------------- API Call the path as follows: https://${Endpoint}/${Version}/ Endpoint: China cn-pool.api.btc.com, America us-pool.api.btc.com; Version: v1 https://github.com/btccom/BTCPoolAPIDocs/blob/master/en.md)
WorkerWarnSpeed=100.00 ----------------------------- Speed (warning) If worker speed less than this value than warning message will apears in tray and log.
WorkerErrorSpeed=900.00 ---------------------------- Speed (error) If worker speed less than this value than error message will apears in tray and log and SMS message or/and Telegram message will be send. 
WorkerTotal=8 -------------------------------------- Your total worker quantity.
SleepTime=120000 ----------------------------------- Time between checks in milliseconds (120000 = 2 min)
SleepAfterError=1800000 ---------------------------- Time after error (1800000 = 30 min). Timout for prevent SMS spamming.
MustSendSMS=0 -------------------------------------- Send SMS when error appears or not (yes:1 no:0)
SMS_RU_api_id=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX - Your api_id from sms.ru https://sms.ru/?panel=api
Phones=79001234567,79001234568 --------------------- Phone numbers for SMS.
MustSendTelegram=0 --------------------------------- Send Telegram message when error appears or not (yes:1 no:0)
Telegram_token=XXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXX - token taken from BotFather.
Telegram_chat_id=XXXXXXXXX ------------------------- chat_id from chat with bot, u can take it from web-client: open https://web.telegram.org and write random message to ur bot, next u must create url like this: https://api.telegram.org/botXXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXX/getUpdates?offset=0 (where XXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXX - bot's token) value from field "id" = chat_id. 

6. Run script (dbl click BTC.com_watchdog.ahk), in tray will appes "pause" icon, right click on it and choose "Run BTC.com Watchdog"
7. Have fun and profit!

You can edit this script with any text editor like notepad, script not need to compile, after update it you must choose "Reload This Script" or "Exit" and run script again.
If you like it you can buy some c2h5oh for me :) Bitcoin: 17cQT8GjQyYg9QKt2b42PFXRTifxENdMHT

links:
Download last version: https://github.com/NoProblem/BTC.com-Watchdog/raw/master/BTC.com-Watchdog.zip
GitHub: https://github.com/NoProblem/BTC.com-Watchdog
Used opensorce libraries:
AutoHotkey-JSON https://github.com/cocobelgica/AutoHotkey-JSON

You can run script multiple times with different settings from different directories.
Script mem usage ~3MB, CPU usage ~0.0%