# ssisTools
PowerShell Tools to Automate SSIS Build and Deploy

Installation
Copy the ssisTools.psm1 folder to 
C:\Program Files\WindowsPowerShell\Modules\ssisTools\ssisTools.psm1

Building SSIS Packages
#
# Sample Script to Build SSIS Using Library Function
#

Start-DbaSsisBuild -Version 14 -Project "C:\Projects\AdventureWorks\SSIS\AdventureWorks.SSIS.sln"

Deploying SSIS Packages
#
# Sample Script to Depoy SSIS ispac File to a SSISB repository
#

Start-DbaSsisDeploy  -Path C:\Projects\AdventureWorks\SSIS\bin\Development\AdventureWorks.ispac  -SqlInstance localhost -Folder AW -Environment AW
