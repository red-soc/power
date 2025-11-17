Get-WmiObject Win32_Process | Select-Object Name,ProcessId,ParentProcessId,SessionId,path| ft -AutoSize
