param(
    [string]$location=$(Get-Location),
    [switch]$recurse=$false
)

function normal(){
    Get-ChildItem -Directory -Name
}
function recurse(){
    Get-ChildItem -Directory -Name -Recurse
}
function parent(){
    $child=([string](Get-Location)).replace("/","\")
    $parent=((git rev-parse --show-toplevel)) 2>$null
    if($parent){
        Write-Verbose ($i+" is a valid repository")
        $parent=$parent.replace("/","\")
        ($child -eq $parent)
    }
}


if($recurse){
    Set-Alias list recurse
}
else{
    Set-Alias list normal
}

Push-Location $location
ForEach ($i in list){
    Push-Location $i
    $a = git status 2> $null
    if(($a) -and (parent)){
        if(-not $a.contains("nothing to commit, working tree clean")){
            git add *
            Write-Host ("Commit repository "+$i) -ForegroundColor Green -BackgroundColor Black
            git status
            $message = Read-Host "Push with message: "
            git commit -m $message
            git push origin master
        }
    }
    Pop-Location
}
Pop-Location