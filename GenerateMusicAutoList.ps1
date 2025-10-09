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

function Split-LabelDefaults([string]$Label) {
    $artist = ''
    $title = $Label
    if ($null -ne $Label) {
        $idx = $Label.IndexOf(' - ')
        if ($idx -ge 0) {
            $artist = $Label.Substring(0, $idx)
            $title = $Label.Substring($idx + 3)
        }
    }
    [pscustomobject]@{ Artist = $artist; Title = $title }
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

function Read-TextWithDefault([string]$Message, [string]$Default = '') {
    $suffix = if ([string]::IsNullOrWhiteSpace($Default)) { '' } else { " [$Default]" }
    Write-Host -ForegroundColor White -NoNewline ("{0}{1}: " -f $Message, $suffix)
    $resp = Read-Host
    if ([string]::IsNullOrWhiteSpace($resp)) { return $Default }
    return $resp
}

function Get-ManualDefaults([string]$Key, $ArtistMap) {
    $rest = $Key
    if ($rest.StartsWith('EMP_')) { $rest = $rest.Substring(4) }
    $first, $rem = $rest.Split('_',2)
    $artist = ''
    $title  = ''
    if ($rem) {
        $artistCode = $first
        if ($ArtistMap.ContainsKey($artistCode) -and $ArtistMap[$artistCode]) { $artist = $ArtistMap[$artistCode] } else { $artist = $artistCode }
        $title = ($rem -replace '_',' ')
    } else {
        $title = ($first -replace '_',' ')
    }
    [pscustomobject]@{ Artist = $artist; Title = $title }
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

function Restore-Backup {
    param(
        [Parameter(Mandatory=$true)][string]$Root,
        [Parameter(Mandatory=$true)][string]$SourcePath
    )
    if (-not (Test-Path -LiteralPath $SourcePath)) { throw "Backup path not found: $SourcePath" }
    $working = $SourcePath
    $temp = $null
    try {
        # If a directory was provided but doesn't contain backup payload, try to autodetect the latest child backup
        if ((Get-Item -LiteralPath $SourcePath).PSIsContainer) {
            $hasPayload = (Test-Path -LiteralPath (Join-Path $working 'Music_custom')) -or
                          (Test-Path -LiteralPath (Join-Path $working 'music_overrides.csv')) -or
                          (Test-Path -LiteralPath (Join-Path $working 'MusicAutoList.lua'))
            if (-not $hasPayload) {
                $candidates = Get-ChildItem -LiteralPath $working | Sort-Object LastWriteTime -Descending
                foreach ($c in $candidates) {
                    if ($c.PSIsContainer) {
                        $maybeDir = $c.FullName
                        if (Test-Path -LiteralPath (Join-Path $maybeDir 'Music_custom')) { $working = $maybeDir; break }
                        if ((Test-Path -LiteralPath (Join-Path $maybeDir 'music_overrides.csv')) -or (Test-Path -LiteralPath (Join-Path $maybeDir 'MusicAutoList.lua'))) { $working = $maybeDir; break }
                    } elseif ([System.IO.Path]::GetExtension($c.FullName).ToLower() -eq '.zip') {
                        $temp = Join-Path ([System.IO.Path]::GetTempPath()) ("DBMEpicBackup_" + [System.Guid]::NewGuid().ToString('N'))
                        New-Item -ItemType Directory -Path $temp | Out-Null
                        Expand-Archive -Path $c.FullName -DestinationPath $temp -Force
                        $working = $temp
                        break
                    }
                }
            }
        }
        if ((Get-Item -LiteralPath $SourcePath).PSIsContainer -eq $false -and [System.IO.Path]::GetExtension($SourcePath).ToLower() -eq '.zip') {
            $temp = Join-Path ([System.IO.Path]::GetTempPath()) ("DBMEpicBackup_" + [System.Guid]::NewGuid().ToString('N'))
            New-Item -ItemType Directory -Path $temp | Out-Null
            Expand-Archive -Path $SourcePath -DestinationPath $temp -Force
            $working = $temp
        }
        $srcCustom = Join-Path $working 'Music_custom'
        if (Test-Path -LiteralPath $srcCustom) {
            Ensure-Dir (Join-Path $Root 'Music\\custom')
            # Use -Path with wildcard to copy contents, not -LiteralPath
            Copy-Item -Path (Join-Path $srcCustom '*') -Destination (Join-Path $Root 'Music\\custom') -Recurse -Force -ErrorAction SilentlyContinue
        }
        foreach ($name in @('music_overrides.csv','artist_map.csv','MusicAutoList.lua')) {
            $p = Join-Path $working $name
            if (Test-Path -LiteralPath $p) {
                Copy-Item -LiteralPath $p -Destination (Join-Path $Root $name) -Force -ErrorAction SilentlyContinue
            }
        }
        return $working
    } finally {
        if ($temp -and (Test-Path -LiteralPath $temp)) { Remove-Item -LiteralPath $temp -Recurse -Force -ErrorAction SilentlyContinue }
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

function New-Backup {
    param(
        [Parameter(Mandatory=$true)][string]$Root,
        [string]$DestinationRoot,
        [bool]$Compress = $false
    )
    try {
        $docs = [Environment]::GetFolderPath('MyDocuments')
        if ([string]::IsNullOrWhiteSpace($docs)) { $docs = (Join-Path $env:USERPROFILE 'Documents') }
        if ([string]::IsNullOrWhiteSpace($DestinationRoot)) {
            $DestinationRoot = Join-Path $docs 'DBM-EpicMusicPack_Backups'
        }
        $backupRoot = $DestinationRoot
        Ensure-Dir $backupRoot

        $stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
        $backupDir = Join-Path $backupRoot $stamp
        Ensure-Dir $backupDir

        # Copy user content and config files
        $srcCustom = Join-Path $Root 'Music\custom'
        if (Test-Path -LiteralPath $srcCustom) {
            Copy-Item -LiteralPath $srcCustom -Destination (Join-Path $backupDir 'Music_custom') -Recurse -Force -ErrorAction SilentlyContinue
        }
        foreach ($name in @('music_overrides.csv','artist_map.csv','MusicAutoList.lua')) {
            $p = Join-Path $Root $name
            if (Test-Path -LiteralPath $p) {
                Copy-Item -LiteralPath $p -Destination (Join-Path $backupDir $name) -Force -ErrorAction SilentlyContinue
            }
        }

        $zipPath = $null
        if ($Compress) {
            $zipPath = Join-Path $backupRoot ("Backup_{0}.zip" -f $stamp)
            Compress-Archive -Path (Join-Path $backupDir '*') -DestinationPath $zipPath -Force
        }

        return [pscustomobject]@{ BackupDir = $backupDir; ZipPath = $zipPath }
    } catch {
        throw $_
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

    # Optional restore from an existing backup (folder or ZIP)
    $restorePath = $null
    if (Read-YesNo 'Restore from an existing backup?' $false) {
        $docs = [Environment]::GetFolderPath('MyDocuments'); if ([string]::IsNullOrWhiteSpace($docs)) { $docs = (Join-Path $env:USERPROFILE 'Documents') }
        $defaultBackupRoot = Join-Path $docs 'DBM-EpicMusicPack_Backups'
        $restorePath = Read-TextWithDefault -Message 'Enter backup path (folder or ZIP)' -Default $defaultBackupRoot
        try {
            [void](Restore-Backup -Root $root -SourcePath $restorePath)
            Write-Host ("[OK] Restored from: {0}" -f $restorePath) -ForegroundColor DarkGreen
        } catch {
            Write-Host ("[WARN] Restore failed: {0}" -f $_.Exception.Message) -ForegroundColor Yellow
        }
    }

    $autoGuess = Read-YesNo 'Auto guess Artist and Song name?' $true
    $manualEach = $false
    if (-not $autoGuess) {
        $manualEach = Read-YesNo 'Manually declare each song?' $true
    }
    $overwriteExisting = $false
    if (-not $autoGuess -and $manualEach) {
        $overwriteExisting = Read-YesNo 'Overwrite existing overrides?' $false
    }

    $artistMap = Load-ArtistMap (Join-Path $root 'artist_map.csv')
    $overrides = Load-Overrides (Join-Path $root 'music_overrides.csv')

    $mp3s = @(Get-ChildItem -LiteralPath $musicDir -Filter '*.mp3' -File | Sort-Object Name)
    $total = 0
    $manualCount = 0
    $manualSavedCount = 0
    $totalCount = $mp3s.Count

    $outLines = @()
    $outLines += '-- This file is auto-generated by GenerateMusicAutoList.ps1'
    $outLines += '-- Do not edit manually. Use music_overrides.csv to override labels.'
    $outLines += ''
    $outLines += 'EMP_MUSIC_AUTOLIST = {'

    foreach ($f in $mp3s) {
        $key = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
        if ($overrides.ContainsKey($key)) {
            if ($manualEach -and $overwriteExisting) {
                $curr = $overrides[$key]
                $defOv = Split-LabelDefaults -Label $curr
                $artist = Read-TextWithDefault -Message ("Artist for '" + $key + "'") -Default $defOv.Artist
                $title  = Read-TextWithDefault -Message ("Title for '" + $key + "'") -Default $defOv.Title
                if (-not [string]::IsNullOrWhiteSpace($artist) -and -not [string]::IsNullOrWhiteSpace($title)) {
                    $label = "$artist - $title"
                } elseif (-not [string]::IsNullOrWhiteSpace($artist)) {
                    $label = $artist
                } else {
                    $label = if (-not [string]::IsNullOrWhiteSpace($title)) { $title } else { ($key -replace '_',' ') }
                }
                $manualCount++
                if ($overrides[$key] -ne $label) { $manualSavedCount++ }
                $overrides[$key] = $label
            } else {
                $label = $overrides[$key]
            }
        } elseif ($autoGuess) {
            $label = Guess-Label -Key $key -AutoGuess $autoGuess -ArtistMap $artistMap
        } elseif ($manualEach) {
            $defs = Get-ManualDefaults -Key $key -ArtistMap $artistMap
            $artist = Read-TextWithDefault -Message ("Artist for '" + $key + "'") -Default $defs.Artist
            $title  = Read-TextWithDefault -Message ("Title for '" + $key + "'") -Default $defs.Title
            if (-not [string]::IsNullOrWhiteSpace($artist) -and -not [string]::IsNullOrWhiteSpace($title)) {
                $label = "$artist - $title"
            } elseif (-not [string]::IsNullOrWhiteSpace($artist)) {
                $label = $artist
            } else {
                $label = if (-not [string]::IsNullOrWhiteSpace($title)) { $title } else { ($key -replace '_',' ') }
            }
            $manualCount++
            # Persist into overrides map (create/update)
            if ((-not $overrides.ContainsKey($key)) -or ($overrides[$key] -ne $label)) { $manualSavedCount++ }
            $overrides[$key] = $label
        } else {
            $rest = $key
            if ($rest.StartsWith('EMP_')) { $rest = $rest.Substring(4) }
            $label = ($rest -replace '_',' ')
        }
        $safe = $label -replace '"', "'"
        $outLines += ('    ["{0}"] = "{1}",' -f $key, $safe)
        $total++
        Write-Progress -Activity 'Generating MusicAutoList.lua' -Status $f.Name -PercentComplete (($total / [Math]::Max($totalCount,1)) * 100)
    }

    $outLines += '}'

    $outPath = Join-Path $root 'MusicAutoList.lua'
    Write-Utf8NoBom -Path $outPath -Lines $outLines

    # If manual per song was used, write overrides back to CSV to persist
    if ($manualEach -and $manualSavedCount -gt 0) {
        $ovrPath = Join-Path $root 'music_overrides.csv'
        $ovrLines = @()
        foreach ($k in ($overrides.Keys | Sort-Object)) {
            $ovrLines += ('{0},{1}' -f $k, $overrides[$k])
        }
        Write-Utf8NoBom -Path $ovrPath -Lines $ovrLines
    }

    Write-Host ''
    Write-Host "[OK] Generated: $outPath" -ForegroundColor Green
    Write-Host ("     Tracks found: {0}" -f $total) -ForegroundColor Gray
    Write-Host ("     Overrides loaded: {0}" -f $overrides.Count) -ForegroundColor Gray
    Write-Host ("     Auto-guess: {0}" -f ($(if($autoGuess){'ENABLED'}else{'DISABLED'}))) -ForegroundColor Gray
    if (-not $autoGuess) {
        Write-Host ("     Manual per song: {0}" -f ($(if($manualEach){'ENABLED'}else{'DISABLED'}))) -ForegroundColor Gray
        if ($manualEach) {
            Write-Host ("     Manual entries: {0}" -f $manualCount) -ForegroundColor Gray
            Write-Host ("     Overwrite existing overrides: {0}" -f ($(if($overwriteExisting){'ENABLED'}else{'DISABLED'}))) -ForegroundColor Gray
        }
    }
    Write-Host ("     Source folder: {0}" -f $musicDir) -ForegroundColor Gray
    if ($restorePath) { Write-Host ("     Restored from: {0}" -f $restorePath) -ForegroundColor Gray }
    if ($manualEach -and $manualSavedCount -gt 0) {
        Write-Host ("     Overrides saved: {0} -> {1}" -f $manualSavedCount, (Join-Path $root 'music_overrides.csv')) -ForegroundColor Gray
    }

    # Post-generation backup (destination selectable)
    if (Read-YesNo 'Create a backup of the current state now?' $true) {
        $docs = [Environment]::GetFolderPath('MyDocuments'); if ([string]::IsNullOrWhiteSpace($docs)) { $docs = (Join-Path $env:USERPROFILE 'Documents') }
        $defaultDest = Join-Path $docs 'DBM-EpicMusicPack_Backups'
        $destFolder = Read-TextWithDefault -Message 'Backup destination folder' -Default $defaultDest
        $compressBackup = Read-YesNo 'Compress backup as ZIP?' $true
        try {
            $finalBackup = New-Backup -Root $root -DestinationRoot $destFolder -Compress:$compressBackup
            Write-Host ("[OK] Backup created: {0}" -f $finalBackup.BackupDir) -ForegroundColor DarkGreen
            if ($finalBackup.ZipPath) { Write-Host ("      ZIP: {0}" -f $finalBackup.ZipPath) -ForegroundColor DarkGreen }
        } catch {
            Write-Host ("[WARN] Backup failed: {0}" -f $_.Exception.Message) -ForegroundColor Yellow
        }
    }
    if ($manualEach -and $manualSavedCount -gt 0) {
        Write-Host ("     Overrides saved: {0} -> {1}" -f $manualSavedCount, (Join-Path $root 'music_overrides.csv')) -ForegroundColor Gray
    }

} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
} finally {
    Write-Host ''
    Write-Host 'Press Enter to exit...' -ForegroundColor White
    [void](Read-Host)
}
