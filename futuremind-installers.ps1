# -------------------------------
# Check if winget is installed
# -------------------------------

$wingetInstalled = Get-Command "winget" -ErrorAction SilentlyContinue

if (-not $wingetInstalled) {
    Write-Output "winget not found. Install winget first"
    exit
} else {
    Write-Output "winget is already installed."
}

# -------------------------------
# Install Dev Tools using winget
# -------------------------------

# Function to install and check version of tools
function Install-Tool {
    param (
        [string]$toolId,
        [string]$toolName
    )

    Write-Host "Installing $toolName..." -ForegroundColor Cyan
    try {
        winget install --id $toolId -e --silent
        # Check version of the installed tool
        $toolVersion = winget show --id $toolId -e | Select-String "Version"
        Write-Host "$toolName installed with version: $($toolVersion.Line)" -ForegroundColor Green
    } catch {
        Write-Host "Failed to install $toolName. Error: $_" -ForegroundColor Red
    }

    # Visual separator
    Write-Host "`n------------------------------`n" -ForegroundColor DarkGray
}



# Install VS Code
Install-Tool -toolId "Microsoft.VisualStudioCode" -toolName "VS Code"

# Install Oracle Java JRE
Install-Tool -toolId "Oracle.JavaRuntimeEnvironment" -toolName "Oracle Java JRE"

# Install Node.js
Install-Tool -toolId "OpenJS.NodeJS" -toolName "Node.js"

# Install Git
Install-Tool -toolId "Git.Git" -toolName "Git"

# Install Wireshark 4.4.6
Install-Tool -toolId "WiresharkFoundation.Wireshark" -toolName "Wireshark 4.4.6"

# # Install MinGW-w64 for C/C++ development
# Install-Tool -toolId "GnuWin.Mingw-w64" -toolName "MinGW-w64"

# # Install Dev-C++ (Orwell)
# Install-Tool -toolId "Orwell.Dev-C++" -toolName "Dev-C++ (for C language)"

# -------------------------------
# Set Environment Variables
# -------------------------------

# # Set JAVA_HOME (searching for Java path dynamically)
# $javaPath = Get-ChildItem "C:\Program Files\Java\" | Where-Object { $_.Name -like "jre*" -or $_.Name -like "jdk*" } | Sort-Object LastWriteTime -Descending | Select-Object -First 1
# if ($javaPath) {
#     $fullJavaPath = $javaPath.FullName
#     [Environment]::SetEnvironmentVariable("JAVA_HOME", $fullJavaPath, "Machine")

#     # Add Java bin to PATH if not already present
#     $javaBin = "$fullJavaPath\bin"
#     $path = [Environment]::GetEnvironmentVariable("Path", "Machine")
#     if ($path -notlike "*$javaBin*") {
#         [Environment]::SetEnvironmentVariable("Path", "$path;$javaBin", "Machine")
#     }
# }

# # Add VS Code to PATH
# $vsCodePath = "C:\Program Files\Microsoft VS Code\bin"
# $path = [Environment]::GetEnvironmentVariable("Path", "Machine")
# if ($path -notlike "*$vsCodePath*") {
#     [Environment]::SetEnvironmentVariable("Path", "$path;$vsCodePath", "Machine")
# }

# # Add MinGW bin to PATH
# $mingwPath = "C:\Program Files\mingw-w64\bin"
# if (Test-Path $mingwPath) {
#     $path = [Environment]::GetEnvironmentVariable("Path", "Machine")
#     if ($path -notlike "*$mingwPath*") {
#         [Environment]::SetEnvironmentVariable("Path", "$path;$mingwPath", "Machine")
#     }
# }

# # Add Dev-C++'s MinGW bin to PATH if it exists
# $devCppMingwPath = "C:\Program Files (x86)\Dev-Cpp\MinGW64\bin"
# if (Test-Path $devCppMingwPath) {
#     $path = [Environment]::GetEnvironmentVariable("Path", "Machine")
#     if ($path -notlike "*$devCppMingwPath*") {
#         [Environment]::SetEnvironmentVariable("Path", "$path;$devCppMingwPath", "Machine")
#     }
# }

Write-Output "All installations attempted. Please check the output for any failures."
