cd $home\Desktop
$string="bruh moment `#"
$index=0

function desktop(){
    $code = @'
        [System.Runtime.InteropServices.DllImport("Shell32.dll")]
        private static extern int SHChangeNotify(int eventId, int flags, IntPtr item1, IntPtr item2);
        public static void Refresh(){
            SHChangeNotify(0x8000000, 0x1000, IntPtr.Zero, IntPtr.Zero);
        }
'@
    Add-Type -MemberDefinition $code -Namespace WinAPI -Name Explorer
    new-item ($string+$index)
    $filename=($string+$index)
    while($true){
        $index++
        rename-item $filename ($string+$index)
        $filename = $string+$index
        [WinAPI.Explorer]::Refresh()
        start-sleep 1
    }
}
function file(){
    while($true){
        $index++
        echo ($string+$index) > bruh.txt
        start-sleep 1
    }
}
function terminal(){
    while($true){
        $index++
        write-host ($string+$index)
        start-sleep 1
    }
}

$title = "Bruh moment:"
$message = "How do you want to print?"
$a = New-Object System.Management.Automation.Host.ChoiceDescription `
    "&Desktop", "Uses file name on Desktop. (Intensive)"
$b = New-Object System.Management.Automation.Host.ChoiceDescription `
    "&File", "Prints to file"
$c = New-Object System.Management.Automation.Host.ChoiceDescription `
    "&Terminal", "Prints on terminal"
$options = [System.Management.Automation.Host.ChoiceDescription[]]($a, $b, $c)
$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

switch ($result)
{
    0 {desktop}
    1 {file}
    2 {terminal}
}