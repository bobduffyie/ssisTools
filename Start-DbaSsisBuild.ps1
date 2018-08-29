function Start-DbaSsisBuild
{
 <# 
.SYNOPSIS 
Build/Compile SSIS Project from source code in VS to create ispac

.DESCRIPTION 
During deployment this cmdlet creates a "ISPAC" whichc can be used for deployment

Requires devenv to be installed (ssdt with BI features)

.PARAMETER Version
Visual Studio Version. 14=2015, 15=2017

.PARAMETER Path
Solution FilePath. Eg C:\agent\_work\6\s\EDW\EDW_SSIS\EDW_SSIS.sln or project file

.EXAMPLE 
Start-DbaSsisBuild -Version 14 -Project "C:\Projects\EDW - Integration\EDW\EDW_SSIS\EDW_SSIS.dtproj"

#>
Param(
[parameter(Mandatory=$false)] [string]$Version=14,
[parameter(Mandatory=$true)] [string]$Project
)
    Write-Host ("devenv version: {0}" -f $Version)
    Write-Host ("Project: {0}" -f $project)
    &"C:\Program Files (x86)\Microsoft Visual Studio $version.0\Common7\IDE\devenv.com" "$project"  /Rebuild
}