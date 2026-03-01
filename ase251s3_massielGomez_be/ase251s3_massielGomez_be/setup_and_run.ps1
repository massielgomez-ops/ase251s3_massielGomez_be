$proj = Split-Path -Parent $MyInvocation.MyCommand.Definition
$zip = Join-Path $proj '.jdk.zip'
$jdir = Join-Path $proj '.jdk'
if (-not (Test-Path $jdir)) { New-Item -Path $jdir -ItemType Directory | Out-Null }
Write-Host "Downloading JDK (may take a few minutes)..."
$urls = @(
	'https://corretto.aws/downloads/latest/amazon-corretto-17-x64-windows-jdk.zip',
	'https://github.com/adoptium/temurin17-binaries/releases/latest/download/OpenJDK17U-jdk_x64_windows_hotspot.zip'
)
$downloaded = $false
foreach ($u in $urls) {
	Write-Host "Trying: $u"
	try {
		Invoke-WebRequest -Uri $u -OutFile $zip -UseBasicParsing -ErrorAction Stop
		$downloaded = $true
		break
	} catch {
		Write-Host "Download failed for: $u"
	}
}
if (-not $downloaded) {
	Write-Error 'Unable to download a JDK from known URLs. Aborting.'
	exit 1
}
Write-Host "Extracting JDK..."
Expand-Archive -LiteralPath $zip -DestinationPath $jdir -Force
Remove-Item $zip -Force
$extracted = Get-ChildItem -Directory $jdir | Select-Object -First 1
$javaHome = $extracted.FullName
$env:JAVA_HOME = $javaHome
$env:Path = "$env:JAVA_HOME\bin;$env:Path"
Write-Host "JAVA_HOME set to: $javaHome"
Write-Host "Running mvnw (skipping tests)..."
Set-Location $proj
.\mvnw.cmd -DskipTests spring-boot:run
