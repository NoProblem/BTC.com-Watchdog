;=================================== BTC.com Watchdog By NoProblem ==============================================
#include lib\JSON.ahk
;================================== Main ===========================================
Menu, Tray, add
Menu, Tray, add, Run BTC.com Watchdog, RunWD
Menu, Tray, add, Show Log BTC.com Watchdog, ShowLogWD
Menu, Tray, add, Stop/Reload BTC.com Watchdog, StopWD
Menu, Tray, add, Settings BTC.com Watchdog v0.1.01a, SettingsWD 
Menu, Tray, Tip, BTC.com Watchdog Paused
Menu, Tray, Icon, Images\pause_wd.bmp
Menu, Tray, Disable, Stop/Reload BTC.com Watchdog

IniRead, User , BTC.com_watchdog.ini, BTC.comSettings, User
IniRead, AccessKey, BTC.com_watchdog.ini, BTC.comSettings, AccessKey
IniRead, puid, BTC.com_watchdog.ini, BTC.comSettings, puid
IniRead, APIURL, BTC.com_watchdog.ini, BTC.comSettings, APIURL
IniRead, WorkerWarnSpeed, BTC.com_watchdog.ini, BTC.comSettings, WorkerWarnSpeed
IniRead, WorkerErrorSpeed, BTC.com_watchdog.ini, BTC.comSettings, WorkerErrorSpeed
IniRead, WorkerTotal, BTC.com_watchdog.ini, BTC.comSettings, WorkerTotal
IniRead, SkipWorkers, BTC.com_watchdog.ini, BTC.comSettings, SkipWorkers
IniRead, SleepTime, BTC.com_watchdog.ini, BTC.comSettings, SleepTime
IniRead, SleepAfterError, BTC.com_watchdog.ini, BTC.comSettings, SleepAfterError
IniRead, MustSendSMS, BTC.com_watchdog.ini, BTC.comSettings, MustSendSMS
IniRead, SMS_RU_api_id, BTC.com_watchdog.ini, BTC.comSettings, SMS_RU_api_id
IniRead, Phones, BTC.com_watchdog.ini, BTC.comSettings, Phones
IniRead, MustSendTelegram, BTC.com_watchdog.ini, BTC.comSettings, MustSendTelegram
IniRead, Telegram_token, BTC.com_watchdog.ini, BTC.comSettings, Telegram_token
IniRead, Telegram_chat_id, BTC.com_watchdog.ini, BTC.comSettings, Telegram_chat_id

startTime := " " . A_DD . " " . A_MMM . " " . A_Hour . ":" . A_Min . ":" . A_Sec
textLog := "Started:" . startTime . chr(10) . chr(13)
textErrorLog := "Started: " . startTime . chr(10) . chr(13)
checkCounter := 0
totalWarn := 0
totalErr := 0
SetFormat, float, 0.1

Gui, Add, Tab3, vTab, Settings|Log|ReadmeRU|ReadmeEN
Gui, Tab, 1
Gui, Add, Edit, w600 r37 -wrap vEditSettings
Gui, Add, Button, gSaveSettings, Save and Reload
Gui, Tab, 2
Gui, Add, text,, Log:
Gui, Add, Edit, w600 r20 vEditLog
Gui, Add, text,, Error Log:
Gui, Add, Edit, w600 r15 vEditErrorLog
Gui, Tab, 3
Gui, Add, Edit, w600 r39 vEditReadme
Gui, Tab, 4
Gui, Add, Edit, w600 r39 vEditReadmeEN
return

fillGui(textLog, textErrorLog)
{
	GuiControl,, EditLog, %textLog%
	GuiControl,, EditErrorLog, %textErrorLog%
	FileRead, FileContents, BTC.com_watchdog.ini
	GuiControl, , EditSettings, %FileContents%
	FileRead, FileContents, readme_ru.txt
	GuiControl, , EditReadme, %FileContents%
	FileRead, FileContents, readme.txt
	GuiControl, , EditReadmeEN, %FileContents%
	return
}

; Settings =============================================================================
SettingsWD:
Menu, Tray, Tip, BTC.com Watchdog Paused
Menu, Tray, Icon, Images\pause_wd.bmp
Menu, Tray, Disable, Stop/Reload BTC.com Watchdog
Menu, Tray, Enable, Run BTC.com Watchdog
fillGui(textLog, textErrorLog)
Gui, -AlwaysOnTop 
GuiControl, Choose, Tab, 1
Gui, Show

MsgBox, Script Paused
return

SaveSettings:
Gui, Submit
FileDelete, BTC.com_watchdog.ini
FileAppend, %EditSettings%, BTC.com_watchdog.ini
reload
return

;SHOW LOG ===============================================================================
ShowLogWD:
fillGui(textLog, textErrorLog)
Gui, +AlwaysOnTop 
GuiControl, Choose, Tab, 2
Gui, Show
Goto, RunWD
return

;RUN function ===========================================================================
RunWD:

Menu, Tray, Disable, Run BTC.com Watchdog
Menu, Tray, Enable, Stop/Reload BTC.com Watchdog
Menu, Tray, Tip, BTC.com Watchdog Starting...
Menu, Tray, Icon, Images\play_wd_start.bmp

;main loop ==============================================================================
Loop 
{
checkCounter++

POSTData := "?access_key=" . AccessKey
          . "&puid=" .      puid 
	  
URL := APIURL . "realtime/hashrate" . POSTData
URL_stats := APIURL . "worker/stats" . POSTData

try 
{
	WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	WebRequest.Open("GET", URL, false)
	WebRequest.SetRequestHeader("Content-Type", "application/json")
	WebRequest.Send("")

	WebRequest_stats := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	WebRequest_stats.Open("GET", URL_stats, false)
	WebRequest_stats.SetRequestHeader("Content-Type", "application/json")
	WebRequest_stats.Send("")
}
catch e 
{
	tipStr := "BTC.com Watchdog Connection Error! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(13) . URL
	Menu, Tray, Tip, %tipStr%
	Menu, Tray, Icon, Images\play_wd_err.bmp	

	textLog .= "BTC.com Connection Error! " .  A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . URL . chr(10) . chr(13)
	textErrorLog .= "BTC.com Connection Error! " .  A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . URL . chr(10) . chr(13)
 	totalWarn++
	Sleep, %SleepTime% 
	continue
}

if (WebRequest.StatusText = "OK")
{
	html := WebRequest.responseText
	html_stats := WebRequest_stats.responseText

	parsed := JSON.Load(html)
	parsed_stats := JSON.Load(html_stats)

	textLog .= "" . A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13)	
	warningText := ""
	errorText := ""

	Warn := 0
	Err := 0

	shares_15m := parsed.data.shares_15m
	shares_15m_unit := parsed.data.shares_15m_unit
	shares_1d := parsed.data.shares_1d
	shares_1d_unit := parsed.data.shares_1d_unit

	workers_active := parsed_stats.data.workers_active
	workers_inactive := parsed_stats.data.workers_inactive
	workers_dead := parsed_stats.data.workers_dead
	shares_1m := parsed_stats.data.shares_1m
	shares_5m := parsed_stats.data.shares_5m
	shares_15m_ := parsed_stats.data.shares_15m
	workers_total := parsed_stats.data.workers_total
	shares_unit := parsed_stats.data.shares_unit
	
	if (workers_active != WorkerTotal)
	{
		errorText .= "Worker count error. Found: " . workers_active . " (expected: " . WorkerTotal . ") "
		err++
	}	
		
	rateStr := "RT 1d: " . shares_1d . " RT 15m: " . shares_15m .  " 1m: " . shares_1m . " 5m: " . shares_5m . " 15m: " . shares_15m_
	textLog .= rateStr . chr(10) . chr(13)	 

	if (shares_1m < WorkerWarnSpeed) and (shares_5m < WorkerWarnSpeed) and (shares_15m_ < WorkerWarnSpeed)
	{
		warningText .= rateStr . "; "
		Warn++
	}

	if (shares_1m < WorkerErrorSpeed) and (shares_5m < WorkerErrorSpeed) and (shares_15m_ < WorkerErrorSpeed)
	{
		errorText .= rateStr . "; "
		err++
	}

	if (totalRecord != WorkerCount)
		errorText .= worker . " "	
	
		
	if (warn > 0)
	{
		textLog .= "Warning! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . warningText . chr(10) . chr(13)
		textErrorLog .= "Warning! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . warningText . chr(10) . chr(13)
	}
	if (err > 0)
	{
		textLog .= "Error! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . errorText . chr(10) . chr(13)
		textErrorLog .= "Error! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . errorText . chr(10) . chr(13)

		; ================= SMS ===========================================================
		try 
		{
			URL := "SMS disabled"
			if (MustSendSMS != 0)
			{
				URL := "https://sms.ru/sms/send?api_id=" . SMS_RU_api_id
					. "&to=" . Phones . "&msg=" . errorText . "&json=1"  
	
				WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
				WebRequest.Open("POST", URL, false)
				WebRequest.SetRequestHeader("Content-Type", "application/json")
				WebRequest.Send("")
			}

			textErrorLog .= "SMS send " . A_Hour . ":" . A_Min . ":" . A_Sec . " " . URL . chr(10) . chr(13)
		}
		catch e 
		{
			textLog .= "SMS send Error! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . URL . chr(10) . chr(13)
			textErrorLog .= "SMS send Error! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . URL . chr(10) . chr(13)
			totalWarn++
		}	

		; ================= Telegram BOT ===========================================================
		try 
		{
			URL := "Telegram disabled"
			if (MustSendTelegram != 0)
			{
				URL := "https://api.telegram.org/bot" . Telegram_token 	
					. "/sendMessage?chat_id=" . Telegram_chat_id . "&text=" . errorText 
	
				WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
				WebRequest.Open("POST", URL, false)
				WebRequest.SetRequestHeader("Content-Type", "application/json")
				WebRequest.Send("")
			}

			textErrorLog .= "Telegram send " . A_Hour . ":" . A_Min . ":" . A_Sec . " " . URL . chr(10) . chr(13)
		}
		catch e 
		{
			textLog .= "Telegram send Error! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . URL . chr(10) . chr(13)
			textErrorLog .= "Telegram send Error! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . URL . chr(10) . chr(13)
			totalWarn++
		}	
	}

	totalWarn += Warn
	totalErr += Err
	
	;totalRateStr := "1d: " . shares_1d . " 15m: " . shares_15m . " 1m: " . shares_1m . " 5m: " . shares_5m . " 15m: " . shares_15m_
	totalRateStr := "1d: " . shares_1d . " 15m: " . shares_15m . " 5m: " . shares_5m
	
	tipStr := chr(34) . User . chr(34) . " BTC.com WD Running" . startTime . chr(13) 
		. "Err: " . totalErr . " " . errorText . " Warn: " . totalWarn . " " . warningText . chr(13)
		. A_Hour . ":" . A_Min . ":" . A_Sec . " (" . checkCounter . ")" .  chr(13) 
		. totalRateStr 

	textLog .= totalRateStr . chr(10) . chr(13)	 
	Menu, Tray, Tip, %tipStr%

	if (err > 0) and (warn > 0)
		Menu, Tray, Icon, Images\play_wd_err_warn.bmp	
	else if (err > 0)
		Menu, Tray, Icon, Images\play_wd_err.bmp	
	else if (warn > 0)
		Menu, Tray, Icon, Images\play_wd_warn.bmp	
	else
		Menu, Tray, Icon, Images\play_wd.bmp	
}
else 
{
	tipStr := "BTC.com Watchdog Request Status Error! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(13) . WebRequest.StatusText
	Menu, Tray, Tip, %tipStr%
	Menu, Tray, Icon, Images\play_wd_err.bmp	

	textLog .= "BTC.com Watchdog BTC.com Request Status Error! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . WebRequest.StatusText . chr(10) . chr(13) 
	textErrorLog .= "BTC.com Watchdog BTC.com Request Status Error! " . A_Hour . ":" . A_Min . ":" . A_Sec . chr(10) . chr(13) . WebRequest.StatusText . chr(10) . chr(13) 
}
;end web request ==========================================================

	if (err > 0)
		Sleep, %SleepAfterError%

	Sleep, %SleepTime%

	; BTC.com Request limits (copyed from AntPool): Do not make more than 600 request per 10 minutes or we will ban your IP address. 
	if (SleepTime < 1000)
		Sleep, 1000 
}
; end main loop =======================================================
return

Done:
gui,submit,nohide
gui,destroy
return

StopWD:
Reload
