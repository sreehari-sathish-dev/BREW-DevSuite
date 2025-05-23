param([string]$Mode)

# Install required module if missing
if (-not (Get-Module -ListAvailable -Name CredentialManager)) {
    Install-Module -Name CredentialManager -Force -Scope CurrentUser
}

Import-Module CredentialManager

if ($Mode -eq "Auth") {
    $cred = Get-StoredCredential -Target "BREW-Auth" -ErrorAction SilentlyContinue
    if (-not $cred) {
        $pass = Read-Host "Set New Password" -AsSecureString
        New-StoredCredential -Target "BREW-Auth" -UserName "brew-user" -Password $pass | Out-Null
    }
    
    $attempt = Read-Host "Enter Password" -AsSecureString
    $stored = Get-StoredCredential -Target "BREW-Auth"
    
    # Convert both secure strings to plain text for comparison
    $attemptText = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [Runtime.InteropServices.Marshal]::SecureStringToBSTR($attempt)
    )
    
    $storedText = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [Runtime.InteropServices.Marshal]::SecureStringToBSTR($stored.Password)
    )

    if ($attemptText -eq $storedText) {
        exit 0
    }
    else {
        exit 1
    }
}