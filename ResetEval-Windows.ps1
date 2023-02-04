
Add-Type -AssemblyName PresentationFramework

$confirm = [System.Windows.MessageBox]::Show('Are you sure you wish to continue?', 'Confirmation', 'YesNo');
if ($confirm -eq 'Yes')
{
    Write-host "Option 'Yes' was selected. Resetting Evaluation..." -f Cyan;

    cd "$HOME\AppData\Roaming\JetBrains\IntelliJIdea2021.1";

    if (-not (Test-Path -Path "eval")) 
    { 
        Write-host "Operation aborted... Unable to reset Evaluation, Unable to Locate Eval File" -f Red;
        return;
    }

    if (-not (Test-Path -Path "options\other.xml")) 
    { 
        Write-host "Operation aborted... Unable to reset Evaluation, Unable to Locate Options File" -f Red;
        return;
    }
    
    if (-not (Test-Path -Path "HKCU:\Software\JavaSoft\Prefs\jetbrains\idea"))
    { 
        Write-host "Operation aborted... Unable to reset Evaluation, Unable to Locate Registry File" -f Red;
        return;
    }
    
    Remove-Item "eval" -Recurse
    Remove-Item "options\other.xml" -Recurse
    Remove-Item "HKCU:\Software\JavaSoft\Prefs\jetbrains\idea" -Force -Verbose -Recurse

    Write-host "Success" -f green;
}
else
{
    Write-host "Option no was selected. Aborted!" -f Red;
}
pause;