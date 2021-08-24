Set filesys = CreateObject("Scripting.FileSystemObject")
Set objShell = WScript.CreateObject("WScript.Shell")
If filesys.FileExists(CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) & "\config.ini") Then
    objShell.Run "" & "python " & CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) & "\presence.py bkgrnd", 0, True
Else
    WScript.Echo "Please rename config.ini.example to config.ini or create your own config file to run"
End If

