# ssisTools
PowerShell Tools to Automate SSIS Build and Deploy

# Installation

Copy the ssisTools.psm1 folder to 
C:\Program Files\WindowsPowerShell\Modules\ssisTools\ssisTools.psm1

#Building SSIS Packages
Start-DbaSsisBuild -Version 14 -Project "C:\Projects\AdventureWorks\SSIS\AdventureWorks.SSIS.sln"

#Deploying SSIS Packages
Start-DbaSsisDeploy  -Path C:\Projects\AdventureWorks\SSIS\bin\Development\AdventureWorks.ispac  -SqlInstance localhost -Folder AW -Environment AW
