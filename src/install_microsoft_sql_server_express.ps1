# Powershell 2.0

if($env:RS_REBOOT){exit 0}

# Stop and fail script when a command fails.
$errorActionPreference = "Stop"

# load library functions
$rsLibDstDirPath = "$env:rs_sandbox_home\RightScript\lib"
. "$rsLibDstDirPath\tools\ResolveError.ps1"
. "$rsLibDstDirPath\sqls\SqlServer.ps1"

try {
	switch ($env:SQL_EXPRESS_VERSION) {
		'2008R2' {	
			if ( (GetSQLServerVersion) -eq '2008R2'  )	{
			write-host "MS SQL Server 2008R2 Express already installed."
			}else	{
				write-host "Silent install sqlserver 2008R2 express..."
				& 'cmd.exe'+" /c copy /y /b $env:RS_ATTACH_DIR\SQLEXPR_x64_ENU_2008R2.00001.exe.tmp + $env:RS_ATTACH_DIR\SQLEXPR_x64_ENU_2008R2.00002.exe.tmp $env:RS_ATTACH_DIR\SQLEXPR_x64_ENU.exe"`
				Move-Item -Force $env:RS_ATTACH_DIR\SQLEXPR_x64_ENU.exe c:\windows\temp\
				Set-Location c:\windows\temp
				& 'cmd.exe'+" /c SQLEXPR_x64_ENU.exe /Q /IACCEPTSQLSERVERLICENSETERMS /ACTION=install /FEATURES=SQL,Conn,ADV_SSMS /INSTANCENAME=NEURONDB /AGTSVCACCOUNT=`"NT AUTHORITY\NETWORK SERVICE`" /SQLSVCACCOUNT=`"NT AUTHORITY\NETWORK SERVICE`" /SQLSYSADMINACCOUNTS=`"Administrator"
				write-host "removing temporary files..."
				write-host "removing temporary files..."
				Remove-Item -Force "$env:RS_ATTACH_DIR\SQLEXPR_x64_ENU_2008R2.00001.exe.tmp", "$env:RS_ATTACH_DIR\SQLEXPR_x64_ENU_2008R2.00002.exe.tmp"
				write-host "MS SQL Server 2008R2 Express install completed."
			}
		}
		'2012' {
			if ( (GetSQLServerVersion) -eq '2012' )	{
			write-host "MS SQL Server 2012 Express already installed."
			}else	{
				write-host "Silent install sqlserver 2012 express..."
				& 'cmd.exe'+" /c copy /y /b $env:RS_ATTACH_DIR\SQLEXPR_x64_ENU_2012.00001.exe.tmp + $env:RS_ATTACH_DIR\SQLEXPR_x64_ENU_2012.00002.exe.tmp $env:RS_ATTACH_DIR\SQLEXPR_x64_ENU.exe"
				Move-Item -Force $env:RS_ATTACH_DIR\SQLEXPR_x64_ENU.exe c:\windows\temp\
				Set-Location c:\windows\temp
				& 'cmd.exe'+" /c SQLEXPR_x64_ENU.exe /Q /IACCEPTSQLSERVERLICENSETERMS /ACTION=install /FEATURES=SQL,Conn,ADV_SSMS /INSTANCENAME=NEURONDB /AGTSVCACCOUNT=`"NT AUTHORITY\NETWORK SERVICE`" /SQLSVCACCOUNT=`"NT AUTHORITY\NETWORK SERVICE`" /SQLSYSADMINACCOUNTS=`"Administrator"
				write-host "removing temporary files..."
				write-host "removing temporary files..."
				#Remove-Item -Force "$env:RS_ATTACH_DIR\SQLEXPR_x64_ENU_2012.00001.exe.tmp", "$env:RS_ATTACH_DIR\SQLEXPR_x64_ENU_2012.00002.exe.tmp"
				write-host "MS SQL Server 2012 Express install completed."
			}
		}	
	}
} catch {
	ResolveError
    exit 1
}
