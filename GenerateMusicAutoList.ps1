#requires -Version 5.1
<#
GenerateMusicAutoList.ps1
- Scans Music/custom for .mp3 files
- Optional auto-guess for "Artist - Title" based on filename
- Supports music_overrides.csv (KEY,Label) and artist_map.csv (CODE,Artist Full Name)
- Writes MusicAutoList.lua (UTF-8 without BOM)
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Header {
    param([string]$AddonTitle = 'DeadlyBossMods - Epic Music Pack by', [string]$Author = 'ZelionGG')
    Write-Host ''
    $lines = @($AddonTitle, $Author)
    $minWidth = 50
    $contentMax = ($lines | ForEach-Object { $_.Length } | Measure-Object -Maximum).Maximum

    # Determine console width safely (use the smaller of window and buffer width)
    $winWidth = 80
    try {
        $ui = $Host.UI.RawUI
        $w = $ui.WindowSize.Width
        $b = $ui.BufferSize.Width
        $winWidth = [Math]::Min($w, $b)
    } catch { }
    if (-not $winWidth -or $winWidth -lt 30) { $winWidth = 80 }

    # Desired inner width vs max allowed (window width - 2 borders)
    $desiredInner = [Math]::Max($minWidth - 2, $contentMax + 4)
    # Keep larger margin to avoid line-wrapping in some hosts
    $maxInner = [Math]::Max(20, $winWidth - 10)
    $innerWidth = [Math]::Min($desiredInner, $maxInner)
    $boxWidth = $innerWidth + 2
    # Final clamp: ensure box width stays strictly below window width
    if ($boxWidth -ge $winWidth) {
        $innerWidth = [Math]::Max(20, $winWidth - 4)
        $boxWidth = $innerWidth + 2
    }

    # Helper: truncate with ellipsis if text doesn't fit
    function _Trunc([string]$s, [int]$avail) {
        if ($null -eq $s) { return '' }
        if ($avail -le 0) { return '' }
        if ($s.Length -le $avail) { return $s }
        $cut = [Math]::Max(0, $avail - 3)
        return ($s.Substring(0, $cut) + '...')
    }

    $contentAvail = $innerWidth
    $titleShown  = _Trunc $AddonTitle $contentAvail
    $authorShown = _Trunc $Author $contentAvail

    # Top border
    Write-Host ('#' * $boxWidth) -ForegroundColor Cyan
    # Empty spacer
    Write-Host ('#' + (' ' * $innerWidth) + '#') -ForegroundColor Cyan

    # Title line (cyan, centered)
    $titleLeft = [Math]::Floor(($innerWidth - $titleShown.Length) / 2)
    $titleRight = $innerWidth - $titleShown.Length - $titleLeft
    Write-Host ('#' + (' ' * $titleLeft)) -ForegroundColor Cyan -NoNewline
    Write-Host $titleShown -ForegroundColor Cyan -NoNewline
    Write-Host ((' ' * $titleRight) + '#') -ForegroundColor Cyan

    # Author line (author in yellow, centered)
    $authorLeft = [Math]::Floor(($innerWidth - $authorShown.Length) / 2)
    $authorRight = $innerWidth - $authorShown.Length - $authorLeft
    Write-Host ('#' + (' ' * $authorLeft)) -ForegroundColor Cyan -NoNewline
    Write-Host $authorShown -ForegroundColor Yellow -NoNewline
    Write-Host ((' ' * $authorRight) + '#') -ForegroundColor Cyan

    # Empty spacer and bottom border
    Write-Host ('#' + (' ' * $innerWidth) + '#') -ForegroundColor Cyan
    Write-Host ('#' * $boxWidth) -ForegroundColor Cyan
    Write-Host ''
}

function Read-YesNo([string]$Message, [bool]$DefaultYes = $true) {
    $suffix = if ($DefaultYes) { ' [Y/n]' } else { ' [y/N]' }
    while ($true) {
        Write-Host -ForegroundColor White -NoNewline ("$Message${suffix}: ")
        $resp = Read-Host
        if ([string]::IsNullOrWhiteSpace($resp)) { return $DefaultYes }
        switch ($resp.ToLower()) {
            'y' { return $true }
            'yes' { return $true }
            'n' { return $false }
            'no' { return $false }
            default { Write-Host 'Please answer Y or N.' -ForegroundColor Yellow }
        }
    }
}

function Get-Root {
    if ($PSScriptRoot) { return $PSScriptRoot }
    $cmd = $MyInvocation.MyCommand
    if ($cmd -and ($cmd.PSObject.Properties.Match('Path').Count -gt 0) -and $cmd.Path) {
        return (Split-Path -Parent $cmd.Path)
    }
    return (Get-Location).Path
}

function Ensure-Dir([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
        Write-Host "[INFO] Creating custom music directory: '$Path'" -ForegroundColor DarkCyan
    }
}

function Load-ArtistMap([string]$FilePath) {
    $map = @{}
    if (Test-Path -LiteralPath $FilePath) {
        try {
            foreach ($line in Get-Content -LiteralPath $FilePath -ErrorAction Stop) {
                if ([string]::IsNullOrWhiteSpace($line)) { continue }
                $parts = $line.Split(',',2)
                if ($parts.Count -ge 1) {
                    $code = $parts[0].Trim()
                    $name = if ($parts.Count -ge 2) { $parts[1].Trim() } else { '' }
                    if ($code) { $map[$code] = $name }
                }
            }
        } catch { Write-Host "[WARN] Failed to read artist_map.csv: $($_.Exception.Message)" -ForegroundColor Yellow }
    }
    return $map
}

function Load-Overrides([string]$FilePath) {
    $ovr = @{}
    if (Test-Path -LiteralPath $FilePath) {
        try {
            foreach ($line in Get-Content -LiteralPath $FilePath -ErrorAction Stop) {
                if ([string]::IsNullOrWhiteSpace($line)) { continue }
                $parts = $line.Split(',',2)
                if ($parts.Count -ge 1) {
                    $key = $parts[0].Trim()
                    $label = if ($parts.Count -ge 2) { $parts[1].Trim() } else { '' }
                    if ($key) { $ovr[$key] = $label }
                }
            }
        } catch { Write-Host "[WARN] Failed to read music_overrides.csv: $($_.Exception.Message)" -ForegroundColor Yellow }
    }
    return $ovr
}

function Guess-Label([string]$Key, [bool]$AutoGuess, $ArtistMap) {
    $rest = $Key
    if ($rest.StartsWith('EMP_')) { $rest = $rest.Substring(4) }
    if (-not $AutoGuess) {
        return ($rest -replace '_',' ')
    }
    $first, $rem = $rest.Split('_',2)
    if (-not $rem) { return ($first -replace '_',' ') }
    $artistCode = $first
    $artist = if ($ArtistMap.ContainsKey($artistCode) -and $ArtistMap[$artistCode]) { $ArtistMap[$artistCode] } else { $artistCode }
    $title = ($rem -replace '_',' ')
    if ($artist) { return "$artist - $title" } else { return $title }
}

function Write-Utf8NoBom([string]$Path, [string[]]$Lines) {
    $encoding = New-Object System.Text.UTF8Encoding($false)
    $dir = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    $stream = [System.IO.StreamWriter]::new($Path, $false, $encoding)
    try {
        foreach ($l in $Lines) { $stream.WriteLine($l) }
    } finally { $stream.Dispose() }
}

try {
    Write-Header
    $root = Get-Root
    $musicDir = Join-Path $root 'Music\custom'
    Ensure-Dir $musicDir

    $autoGuess = Read-YesNo 'Auto guess Artist and Song name?' $true

    $artistMap = Load-ArtistMap (Join-Path $root 'artist_map.csv')
    $overrides = Load-Overrides (Join-Path $root 'music_overrides.csv')

    $mp3s = @(Get-ChildItem -LiteralPath $musicDir -Filter '*.mp3' -File | Sort-Object Name)
    $total = 0
    $totalCount = $mp3s.Count

    $outLines = @()
    $outLines += '-- This file is auto-generated by GenerateMusicAutoList.ps1'
    $outLines += '-- Do not edit manually. Use music_overrides.csv to override labels.'
    $outLines += ''
    $outLines += 'EMP_MUSIC_AUTOLIST = {'

    foreach ($f in $mp3s) {
        $key = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
        $label = if ($overrides.ContainsKey($key)) { $overrides[$key] } else { Guess-Label -Key $key -AutoGuess $autoGuess -ArtistMap $artistMap }
        $safe = $label -replace '"', "'"
        $outLines += ('    ["{0}"] = "{1}",' -f $key, $safe)
        $total++
        Write-Progress -Activity 'Generating MusicAutoList.lua' -Status $f.Name -PercentComplete (($total / [Math]::Max($totalCount,1)) * 100)
    }

    $outLines += '}'

    $outPath = Join-Path $root 'MusicAutoList.lua'
    Write-Utf8NoBom -Path $outPath -Lines $outLines

    Write-Host ''
    Write-Host "[OK] Generated: $outPath" -ForegroundColor Green
    Write-Host ("     Tracks found: {0}" -f $total) -ForegroundColor Gray
    Write-Host ("     Overrides loaded: {0}" -f $overrides.Count) -ForegroundColor Gray
    Write-Host ("     Auto-guess: {0}" -f ($(if($autoGuess){'ENABLED'}else{'DISABLED'}))) -ForegroundColor Gray
    Write-Host ("     Source folder: {0}" -f $musicDir) -ForegroundColor Gray

} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
} finally {
    Write-Host ''
    Write-Host 'Press Enter to exit...' -ForegroundColor White
    [void](Read-Host)
}
