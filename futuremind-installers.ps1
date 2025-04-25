# -------------------------------
# Install Dev Tools using winget
# -------------------------------

# Install VS Code
winget install --id Microsoft.VisualStudioCode -e --silent

# Install Oracle Java JRE
winget install --id Oracle.JavaRuntimeEnvironment -e --silent

# Install Python 3.11.9
winget install --id Python.Python.3 --version 3.11.9 -e --silent --accept-package-agreements --accept-source-agreements

# Install Node.js
winget install --id OpenJS.NodeJS -e --silent

# Install Git
winget install --id Git.Git -e --silent

# Install Wireshark 4.4.6
winget install --id=WiresharkFoundation.Wireshark --version 4.4.6 -e --silent --accept-package-agreements --accept-source-agreements

# Install MinGW-w64 for C/C++ development
winget install --id=GnuWin.Mingw-w64 -e --silent --accept-package-agreements --accept-source-agreements

# -------------------------------
# Set Environment Variables
# -------------------------------

# Set JAVA_HOME (searching for Java path dynamically)
$javaPath = Get-ChildItem "C:\Program Files\Java\" | Where-Object { $_.Name -like "jre*" -or $_.Name -like "jdk*" } | Sort-Object LastWriteTime -Descending | Select-Object -First 1
if ($javaPath) {
    $fullJavaPath = $javaPath.FullName
    [Environment]::SetEnvironmentVariable("JAVA_HOME", $fullJavaPath, "Machine")

    # Add Java bin to PATH if not already present
    $javaBin = "$fullJavaPath\bin"
    $path = [Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($path -notlike "*$javaBin*") {
        [Environment]::SetEnvironmentVariable("Path", "$path;$javaBin", "Machine")
    }
}

# Add VS Code to PATH
$vsCodePath = "C:\Program Files\Microsoft VS Code\bin"
$path = [Environment]::GetEnvironmentVariable("Path", "Machine")
if ($path -notlike "*$vsCodePath*") {
    [Environment]::SetEnvironmentVariable("Path", "$path;$vsCodePath", "Machine")
}

# Add MinGW bin to PATH
$mingwPath = "C:\Program Files\mingw-w64\bin"
if (Test-Path $mingwPath) {
    $path = [Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($path -notlike "*$mingwPath*") {
        [Environment]::SetEnvironmentVariable("Path", "$path;$mingwPath", "Machine")
    }
}

# -------------------------------
# Reminder
# -------------------------------
Write-Output "`All tools installed and environment variables set."
Write-Output "You may need to restart the computer or log off and log in again to apply PATH changes."
