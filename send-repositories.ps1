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
            git add * 2>&1 $null
            Write-Host ("Commit repository "+$i) -ForegroundColor Yellow -BackgroundColor Black
            $message = Read-Host "Push with message"
            git commit -m $message 2>&1 $null
            git push origin master -q
            if($?){Write-Host ("Committed "+$i) -ForegroundColor Green -BackgroundColor Black}
            else{Write-Host ("Failed to commit "+$i)}
        }
    }
    Pop-Location
}
Pop-Location