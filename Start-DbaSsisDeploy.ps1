function Start-DbaSsisDeploy
{
    <# 
    .SYNOPSIS 
    Deploy SSIS ISPAC File 

    .DESCRIPTION 
    Once  Start-DbaSsisDeploy has build IPAC use this cmdLet to Deploy

    .PARAMETER Path
    PAth to ISPAC FIle

    .PARAMETER Folder
    Folder for SSIS Project inside SSIS Catalog

    .PARAMETER SqlInstance
    SQL Server instance to deploy to (default localhost) 

    .PARAMETER Catalog
    SSISDB Catalog (Default of SSISDB)

    .EXAMPLE 
    Start-SsisIpacDeploy 
    #>
    Param(
    [parameter(Mandatory=$true)] [string]$Path,
    [parameter(Mandatory=$false)] [string]$SqlInstance="localhost",
    [parameter(Mandatory=$false)] [string]$Catalog="SSISDB",
    [parameter(Mandatory=$true)] [string]$Folder,
    [parameter(Mandatory=$false)] [string]$Environment
    
    )
    [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Management.IntegrationServices") | Out-Null;
    $SSISNamespace = "Microsoft.SqlServer.Management.IntegrationServices"
    Write-Host ("Connecting to SqlInstance {0}" -f $SqlInstance)
    $sqlConnection = New-Object System.Data.SqlClient.SqlConnection "Data Source=$sqlInstance;Initial Catalog=master;Integrated Security=SSPI"
    $ssisServer = New-Object $SSISNamespace".IntegrationServices"  $sqlConnection
    if(!$ssisServer)  {
        Write-Host ("Cannot connect to SqlInstance {0}." -f $SqlInstance) -ForegroundColor Yellow
        return
    }

    Write-Host ("Connecting to SSIS Catalog {0}" -f $Catalog)
    if(!$ssisServer.Catalogs[$Catalog])
    {
        Write-Host ("SSIS Catalog {0} does not exist." -f $Catalog) -ForegroundColor Yellow
        return
    }
    $ssisCatalog = $ssisServer.Catalogs[$Catalog]
    Write-Host ("Connecting to Folder {0}" -f $Folder)
    $ssisFolder = $ssisCatalog.Folders[$Folder]
    if (!$ssisFolder)
    {
        Write-Host "Creating Folder ..."
        $folder = New-Object "$SSISNamespace.CatalogFolder" ($ssisCatalog, $Folder, $Folder)            
        $folder.Create()  
    }

    # Read the project file, and deploy it to the folder
    $file = Get-Item $Path 
    if (!$file)
    {
        Write-Host ("SSIS ISPAC Not found {0}" -f $Path ) -ForegroundColor Yellow 
        return
    }
    $ProjectName= $file.BaseName 
    Write-Host "Deploying SSIS Project ..."
    [byte[]] $projectFile = [System.IO.File]::ReadAllBytes($Path)
    $ssisFolder.DeployProject($ProjectName, $projectFile) | Out-Null;
    Write-Host "SSIS Deployment Complete  ..."
        
}
