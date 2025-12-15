param(
    [Parameter(Mandatory=$true)][string]$LogisimJar,
    [string]$TestsDir = "tests",
    [string]$Circuit = "s-mips.circ",
    [string]$OutDir = "test_out",
    [string]$Template = "s-mips-template.circ",
    [int]$Verbose = 4
)

# Ensure python launcher available
if (-not (Get-Command py -ErrorAction SilentlyContinue)) {
    Write-Host "Warning: 'py' launcher not found. Will try 'python' instead."
    $pyCmd = "python"
} else { $pyCmd = "py -3" }

# Set LOGISIM_JAR for local `logisim.cmd` shim
$env:LOGISIM_JAR = $LogisimJar

Write-Host "Using LOGISIM_JAR = $LogisimJar"

# ensure output dir exists
if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir | Out-Null }

# Run test.py with verbose
& $pyCmd test.py $TestsDir $Circuit -o $OutDir -t $Template -v $Verbose
