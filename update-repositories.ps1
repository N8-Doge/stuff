<#
.SYNOPSIS
  Name: update-repositories.ps1
  Updates all repositories in specified directory.
  
.DESCRIPTION
  Runs git pull/fetch in every dectected repository.

.PARAMETER location
  Location to update. Defaults to working directory.

.PARAMETER recurse
    Recursively checks directories in location.

.PARAMETER fetch
    Fetches from remote without pulling.

.PARAMETER reset
    Resets repository to origin/master. Overrides fetch.

.NOTES
    Author - Nathan Chen 
    Created/used for personal purposes
    Feel free to use/copy with credit

.INPUTS
    Allowed to pipe a string into -location at position 1

.OUTPUTS
    Does not generate direct output

.EXAMPLE
  ./update-repositories.ps1
  Runs script in working directory

.EXAMPLE
  ./update-repositories.ps1 $home
  Runs script in userprofile

.EXAMPLE
  ./update-repositories.ps1 -fetch
  Fetches all repositories in working directory
#>

#-----Parameters-----
param(
    [string]$location=$(Get-Location),
    [switch]$recurse=$false,
    [switch]$fetch=$false,
    [switch]$reset=$false
)
Write-Verbose ("Location - "+$location)
Write-Verbose ("Fetch - "+[boolean]$fetch)
Write-Verbose ("Reset - "+[boolean]$reset)
Write-Debug "Parsed Parameters"

#-----Prereqs-----
Get-Command git -ErrorAction SilentlyContinue > $null
if(-not $?){
    Write-Host "Error: Git is not installed" -ForegroundColor Red -BackgroundColor Black
    Write-Host "You can install Git at git-scm.org/downloads" -ForegroundColor Green -BackgroundColor Black
    Write-Host "Press any key to terminate"
    cmd /c pause > $null
    exit
}
Write-Debug "Executed Prereqs"


#-----Functions-----
function fetch{
    git fetch
}
function pull{
    git pull
}
function reset{
    git fetch --all
    git reset --hard origin/master
}
function normal{
    Get-ChildItem -Directory -Name
}
function recurse{
    Get-ChildItem -Directory -Name -Recurse
}
Write-Debug "Executed Functions"

#-----Aliases-----
if($recurse){
    Set-Alias list recurse
}
else{
    Set-Alias list normal
}
if($fetch){
    $message="Fetching"
    Set-Alias update fetch
}
else{
    $message="Pulling"
    Set-Alias update pull
}
if($reset){
    $message="Resetting"
    Set-Alias update reset
}
$message+=" "
Write-Debug "Executed Aliases"

#------Main------
Push-Location $location
ForEach ($i in list){
    Write-Verbose ("Checking "+$i)
    Push-Location $i
    $child=([string](Get-Location)).replace("/","\")
    $parent=((git rev-parse --show-toplevel)) 2>$null
    if($parent){
        Write-Verbose ($i+" is a valid repository")
        $parent=$parent.replace("/","\")
        if($child -eq $parent){
            Write-Verbose ($i+" is a parent repository")
            Write-Host ($message+$i) -ForegroundColor Green -BackgroundColor Black
            update
        }
        else{
            Write-Verbose ($i+" is not a parent repository")
        }
    }
    Pop-Location
}
Pop-Location
Write-Debug "Executed Main"