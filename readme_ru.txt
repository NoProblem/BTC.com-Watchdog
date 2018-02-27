������ ��� ����������� ��������� ������ �� ���� BTC.com (����� ����: https://pool.btc.com) ������ ���������� � ������� ����� ����������� �� �������� :)

�� ����� ������ ������� ������������ ������ � ���� ���������� � ����. ������ ��� � 2 ������ ��������� ������� �� ����, ���� ���� ��������� ��� ������� ���������� �� �� �������� ������ � ���� � ������ ���������� ��� �/��� ��������� � ���������.

��� ������ ������� ����������: 
1. ���������� ��������� ���������� https://www.autohotkey.com/
2. ������� � ����������� ������ https://github.com/NoProblem/BTC.com-Watchdog/raw/master/BTC.com-Watchdog.zip
3. (���������� ��� ���� �� ������ ����� ���) ������������������ �� ����� sms.ru, ���� ��������� ��������� ��������� 5 ��� � ����� �� ���� �����, ����� ������ ����������.
4. (���������� ��� ���� �� ������ ����� ��������� � Telegram) ����� BotFather � Telegram �������� ������ ���� https://core.telegram.org/bots, ��������� ��� token �, ������� ���, ��������� chat_id ����.
5. ��������� � ����� BTC.com_watchdog.ini ���� ���������:

[BTC.comSettings]
User=SubAccount ------------------------------------ ��� ��� ������� �� ����. https://pool.btc.com/manage-account
AccessKey=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - "AccessKey" �� �������� �� ����: https://pool.btc.com/dashboard -> "Settings" -> "Get AccessKey and puid" 
puid=XXXXX ----------------------------------------- "puid" �� �������� �� ����: https://pool.btc.com/dashboard -> "Settings" -> "Get AccessKey and puid" 
APIURL=https://eu-pool.api.btc.com/v1/ ------------- API Call the path as follows: https://${Endpoint}/${Version}/ Endpoint: China cn-pool.api.btc.com, America us-pool.api.btc.com; Version: v1 https://github.com/btccom/BTCPoolAPIDocs/blob/master/en.md)
WorkerWarnSpeed=100.00 ----------------------------- �������� (��������������) ���� �������� ���� �� �������� �������������� � ���� � ����.
WorkerErrorSpeed=90.00 ----------------------------- �������� (������) ���� �������� ���� �� �������� ������ � ���� � ���������� SMS �/��� ��������� � ���������.
WorkerTotal=8 -------------------------------------- ����� ���������� ��������, ���� ���������� �������� ������ ��� ������ ���������� ������ � ���� � ������������ SMS �/��� ��������� � ���������.
SleepTime=120000 ----------------------------------- �������� � ������������� ����� ���������� (120000 = 2 ������)
SleepAfterError=1800000 ---------------------------- �������� � ������������� ����� ��������� ��������� � ������ ���� ��������� ������ (1800000 = 30 �����). ������� ����� � ������ ������ �� ������� SMS. 
MustSendSMS=0 -------------------------------------- ���������� SMS ���� ��������� ������ (�����:1 �� �����:0)
SMS_RU_api_id=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX - ��� api_id � ����� sms.ru https://sms.ru/?panel=api
Phones=79001234567,79001234568 --------------------- ������ ��������� �� ������� ����� ���������� SMS.
MustSendTelegram=0 --------------------------------- ���������� ��������� � Telegram ���� ��������� ������ (�����:1 �� �����:0)
Telegram_token=XXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXX - ����� ���������� �� BotFather � Telegram. 
Telegram_chat_id=XXXXXXXXX ------------------------- chat_id ������ � ����� ���� � ��������, ��� ����� ���������� �������� ��� ������ (https://web.telegram.org/) � ������ ����� �������� ���������� ����, ����� � �������� ������� ������ ���� https://api.telegram.org/botXXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXX/getUpdates?offset=0 (��� XXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXX - token ������ ����) � ������� �������� ���� id ��� � ���� ������� chat_id. 

6. ��������� ������ (������� ���� �� ����� BTC.com_watchdog.ahk), � ���� �������� ������ "�����" �������� �� ��� ������ ������� � ������� � ������ "Run BTC.com Watchdog"
7. ������!

������ ����� ������������� � ����� ��������� ���������, �������� � ���������� � �������� � notepad++, ���������� � ������ �� ���������, ���������� ������� � ���� "Reload This Script" ��� "Exit" � ��������� ������ ������.
� ������ ����� ����� �������� �������� ������ ��� ��������� � ������/�����/������/������/� �.�. �� ��������������� ������ ���� �������� api ������ ����������� �������� ��� ��� ��������� � ���������. 
���� ����������� ������ ����� ���� ���� :) Bitcoin: 17cQT8GjQyYg9QKt2b42PFXRTifxENdMHT

������:
������ ���: https://github.com/NoProblem/BTC.com-Watchdog/raw/master/BTC.com-Watchdog.zip
�������� �������: https://github.com/NoProblem/BTC.com-watchdog
� ������� ������������ �������� ����������:
AutoHotkey-JSON https://github.com/cocobelgica/AutoHotkey-JSON

������ �������� 3�� ���������� � 0.0% ������������� �������, ����� ��������� ��������� �������� � ������� ����������� �� ������ �����.  