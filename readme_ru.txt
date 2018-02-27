Скрипт для мониторинга состояния асиков на пуле BTC.com (Адрес пула: https://pool.btc.com) Скрипт бесплатный с откртым кодом пользуйтесь на здоровье :)

Во время работы скрипта отображается иконка и мини статистика в трее. Скрипт раз в 2 минуты проверяет хэшрэйт на пуле, если асик отвалился или хэшрэйт уменьшился то то появится ошибка в трее и скрипт отправляет смс и/или сообщение в телеграмм.

Для работы скрипта необходимо: 
1. Установить программу автохоткей https://www.autohotkey.com/
2. Скачать и распаковать скрипт https://github.com/NoProblem/BTC.com-Watchdog/raw/master/BTC.com-Watchdog.zip
3. (Пропустить шаг если не хотите слать смс) Зарегистрироваться на сайте sms.ru, сайт позволяет бесплатно отправить 5 смс в сутки на свой номер, этого обычно достаточно.
4. (Пропустить шаг если не хотите слать сообщения в Telegram) Через BotFather в Telegram создаете своего бота https://core.telegram.org/bots, получаете его token и, написав ему, получаете chat_id чата.
5. Прописать в файле BTC.com_watchdog.ini ваши настройки:

[BTC.comSettings]
User=SubAccount ------------------------------------ Ваш суб аккаунт на пуле. https://pool.btc.com/manage-account
AccessKey=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - "AccessKey" из настроек на пуле: https://pool.btc.com/dashboard -> "Settings" -> "Get AccessKey and puid" 
puid=XXXXX ----------------------------------------- "puid" из настроек на пуле: https://pool.btc.com/dashboard -> "Settings" -> "Get AccessKey and puid" 
APIURL=https://eu-pool.api.btc.com/v1/ ------------- API Call the path as follows: https://${Endpoint}/${Version}/ Endpoint: China cn-pool.api.btc.com, America us-pool.api.btc.com; Version: v1 https://github.com/btccom/BTCPoolAPIDocs/blob/master/en.md)
WorkerWarnSpeed=100.00 ----------------------------- Скорость (предупреждение) если скорость ниже то появится предупреждение в трее и логе.
WorkerErrorSpeed=90.00 ----------------------------- Скорость (ошибка) если скорость ниже то появится ошибка в трее и отправится SMS и/или сообщение в телеграмм.
WorkerTotal=8 -------------------------------------- Общее количество воркеров, если работающих воркеров меньше или больше появляется ошибка в трее и отправляется SMS и/или сообщение в телеграмм.
SleepTime=120000 ----------------------------------- Задержка в миллисекундах между проверками (120000 = 2 минуты)
SleepAfterError=1800000 ---------------------------- Задержка в миллисекундах перед следующей проверкой в случае если произошла ошибка (1800000 = 30 минут). Сделано чтобы в случае ошибки не спамить SMS. 
MustSendSMS=0 -------------------------------------- Отправлять SMS если произошла ошибка (слать:1 не слать:0)
SMS_RU_api_id=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX - Ваш api_id с сайта sms.ru https://sms.ru/?panel=api
Phones=79001234567,79001234568 --------------------- Номера телефонов на которые будет отправлено SMS.
MustSendTelegram=0 --------------------------------- Отправлять сообщение в Telegram если произошла ошибка (слать:1 не слать:0)
Telegram_token=XXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXX - токен полученный от BotFather в Telegram. 
Telegram_chat_id=XXXXXXXXX ------------------------- chat_id вашего с ботом чата в телеграм, для этого открываете например веб клиент (https://web.telegram.org/) и пишете любое собщение созданному боту, далее в браузере делаете запрос вида https://api.telegram.org/botXXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXX/getUpdates?offset=0 (где XXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXX - token вашего бота) и узнаете значение поля id это и есть искомый chat_id. 

6. Запустить скрипт (двойной клик на файле BTC.com_watchdog.ahk), в трее появится иконка "пауза" кликнуть по ней правой кнопкой и выбрать в списке "Run BTC.com Watchdog"
7. Профит!

Скрипт можно редактировать в любом текстовом редакторе, например я редактирую в блокноте и notepad++, компиляция и прочее не требуются, достаточно выбрать в трее "Reload This Script" или "Exit" и запустить скрипт заново.
В скрипт можно легко добавить отправку емэйла или сообщения в вайбер/скайп/ватсап/твитер/и т.д. на соответствующих сайтах есть описание api обычно аналогичное отправке смс или сообщений в телеграмм. 
Кому понравилось коньяк можно лить сюда :) Bitcoin: 17cQT8GjQyYg9QKt2b42PFXRTifxENdMHT

Ссылки:
качаем тут: https://github.com/NoProblem/BTC.com-Watchdog/raw/master/BTC.com-Watchdog.zip
страница проекта: https://github.com/NoProblem/BTC.com-watchdog
В скрипте использована опенсорс библиотека:
AutoHotkey-JSON https://github.com/cocobelgica/AutoHotkey-JSON

Скрипт занимает 3МБ оперативки и 0.0% процессорного времени, можно запускать несколько скриптов с разными настройками из разных папок.  