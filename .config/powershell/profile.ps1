function Test-Administrator {
    if ($PSVersionTable.Platform -eq 'Win32NT') {
        return ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    } else {
        return (id -u) -eq 0
    }
}

function prompt {
    $currentPath = (Get-Location).toString()
    if ($currentPath.startsWith($home)) {
        $currentPath = '~' + $currentPath.subString($home.length)
    }
    Write-Host -NoNewline -ForegroundColor $prompt_colour "[$([Environment]::UserName)@$([Environment]::MachineName) "

    Write-Host -NoNewLine -ForegroundColor $wd_colour $currentPath
    if (Get-Module -ListAvailable -Name posh-git) {
        Write-VcsStatus
    }
    Write-Host -NoNewline -ForegroundColor $prompt_colour "]"
    Write-Host -NoNewline -ForegroundColor $prompt_colour ('>' * ($nestedPromptLevel + 1))
    ' '
}

$administrator = Test-Administrator
if ($administrator) {
    $prompt_colour = [ConsoleColor]::DarkRed
    $command_colour = [ConsoleColor]::Magenta
} elseif ((id -u) -ne (stat -c %u ~)) {
    # if the shell if running as another user
    $prompt_colour = [ConsoleColor]::DarkYellow
    $command_colour = [ConsoleColor]::White
} else {
    # if the shell is running as myself
    $prompt_colour = [ConsoleColor]::DarkGreen
    $command_colour = [ConsoleColor]::Yellow
}
$wd_colour = [ConsoleColor]::Blue
Set-PSReadLineOption -colors @{Command = $command_colour}
Import-Module posh-git
