param(
    [string]$pythonCmd = "py -3"
)

$cwd = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Push-Location $cwd

$OutDir = Join-Path $cwd "test_out"
if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir | Out-Null }

# split python command into executable and args (so "py -3" works)
$pythonTokens = $pythonCmd -split ' '
$exe = $pythonTokens[0]
$exeArgs = @()
if ($pythonTokens.Length -gt 1) { $exeArgs += $pythonTokens[1..($pythonTokens.Length - 1)] }

Get-ChildItem -Path (Join-Path $cwd 'tests') -Filter *.asm -Recurse | ForEach-Object {
    $asm = $_
    $name = [System.IO.Path]::GetFileNameWithoutExtension($asm.Name)
    $targetDir = Join-Path $OutDir $name
    if (-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir | Out-Null }
    Write-Host "Assembling $($asm.FullName) -> $targetDir"
    & $exe @exeArgs assembler.py $asm.FullName -o $targetDir
    if ($LASTEXITCODE -ne 0) { Write-Warning "Assembler failed for $($asm.Name) (exit code $LASTEXITCODE)" }
}

Pop-Location
