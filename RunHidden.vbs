Set objShell = WScript.CreateObject("WScript.Shell")
objShell.Run "" & "python " & CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) & "\presence.py bkgrnd", 0, True
