# ===========================================================
# FILE BUILD GAME PARNY ESCAPE - MADE BY THE PASCAL CORNER
# ===========================================================

$ErrorActionPreference = "Stop"
$currentPath = Get-Location

# --- 1. CAU HINH DUONG DAN ---
$ppsxDefault = "..\ParnyEscape.ppsx"
$iconPath = "..\materials\images\Parny.ico"
$evbConsole = ".\enigmavbconsole.exe" 
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$evbProjectFile = ".\ParnyEscape_config_enigma.evb"

Write-Host "========== CONG XUONG DONG GOI PORTABLE ==========" -ForegroundColor Magenta

# --- 2. NHAP TEN FILE GAME ---
$inputName = Read-Host "Nhap ten file Slide (Mac dinh: ParnyEscape.ppsx)"
$fullPathPPSX = if ([string]::IsNullOrWhiteSpace($inputName)) { $ppsxDefault } else { "..\$inputName" }

if (-not (Test-Path $fullPathPPSX)) { Write-Host "Loi: Khong tim thay PPSX!" -ForegroundColor Red; pause; exit }

$baseName = [System.IO.Path]::GetFileNameWithoutExtension($fullPathPPSX)
$ppsxFileNameOnly = [System.IO.Path]::GetFileName($fullPathPPSX)

$moiExe    = "$($baseName)_ps1.exe"
$enigmaExe = "$($baseName)_ps1_enigma.exe"
$finalExe  = "$($baseName).exe"

# --- 3. TAO FILE MOI ---
Write-Host "`n[1/3] Dang tao file moi..." -ForegroundColor Cyan
$launcherScript = "try { Start-Process '$ppsxFileNameOnly' -ErrorAction Stop } catch { Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Loi file game!', 'Potani') }"
$launcherScript | Out-File -FilePath "temp_launcher.ps1" -Encoding utf8

Invoke-ps2exe -InputFile "temp_launcher.ps1" -OutputFile "$moiExe" -noConsole -x64 -icon "$iconPath" -title "$baseName"
Remove-Item "temp_launcher.ps1"

# --- 4. DONG GOI ---
Write-Host "`n[2/3] Dang dong goi bang Enigma Console tai cho..." -ForegroundColor Green
if (Test-Path $evbConsole) {
    # Chay lenh Enigma
    & $evbConsole "$evbProjectFile"
} else {
    Write-Host "LOI: Khong tim thay enigmavbconsole.exe!" -ForegroundColor Red; pause; exit
}

# --- 5. TAO CHU KY CHINH THUC ---
Write-Host "`n[3/3] Dang ky ten (SigThief)..." -ForegroundColor Yellow
if (Test-Path "sigthief.py") {
    # Kiem tra xem file Enigma co thuc su ton tai truoc khi ky khong
    if (Test-Path $enigmaExe) {
        Start-Sleep -Seconds 2
        python sigthief.py -i "$chromePath" -t "$enigmaExe" -o "$finalExe"
        Write-Host "`n>>> THANH CONG: $finalExe" -ForegroundColor Green
    } else {
        Write-Host "LOI: SigThief khong tim thay file $enigmaExe de ky!" -ForegroundColor Red
    }
}

# --- 6. DON DEP FILE TRUNG GIAN ---
Write-Host "`n[Clean] Dang don dep file tam..." -ForegroundColor Gray
$filesToDelete = @($moiExe, $enigmaExe)

foreach ($file in $filesToDelete) {
    if (Test-Path $file) {
        Remove-Item -Path $file -Force
        Write-Host "-> Da xoa: $file" -ForegroundColor Gray
    }
}

Write-Host "================================================" -ForegroundColor Magenta
Read-Host "Da build xong! Nhan Enter de thoat..."