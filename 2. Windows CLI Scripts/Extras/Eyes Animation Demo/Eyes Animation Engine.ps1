# WST Eyes Animation - Halloween release candidate
# Console-only animation. No network requests or persistent system changes.
param(
    [ValidateRange(1,20)][int]$EyeCount = 10,
    [ValidateSet('Classic','Mixed','Focus','Combined')][string]$PupilMode = 'Mixed',
    [ValidateRange(0,100)][int]$FastBlinkPercent = 22
)
$ErrorActionPreference = 'Stop'
$rng = [Random]::new()
$oldEncoding = [Console]::OutputEncoding
$oldColor = [Console]::ForegroundColor
$oldVisible = $true
try { $oldVisible = [Console]::CursorVisible } catch {}
$esc = [char]27
$win32OK = $false
# Some classic console hosts show a cursor briefly during position changes.
# Hide it through both the console API and the ANSI/VT sequence when supported.
try {
    Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class WstEyeConsole {
    [StructLayout(LayoutKind.Sequential)] public struct CursorInfo {
        public uint Size;
        [MarshalAs(UnmanagedType.Bool)] public bool Visible;
    }
    [DllImport("kernel32.dll")] public static extern IntPtr GetStdHandle(int id);
    [DllImport("kernel32.dll")] public static extern bool GetConsoleCursorInfo(IntPtr handle, out CursorInfo info);
    [DllImport("kernel32.dll")] public static extern bool SetConsoleCursorInfo(IntPtr handle, ref CursorInfo info);
}
'@ -ErrorAction Stop
    $handle = [WstEyeConsole]::GetStdHandle(-11)
    $saved = New-Object WstEyeConsole+CursorInfo
    $win32OK = [WstEyeConsole]::GetConsoleCursorInfo($handle,[ref]$saved)
    if ($win32OK) {
        $hidden = New-Object WstEyeConsole+CursorInfo
        $hidden.Size = $saved.Size
        $hidden.Visible = $false
        [void][WstEyeConsole]::SetConsoleCursorInfo($handle,[ref]$hidden)
    }
} catch { $win32OK = $false }

# lens: ​‌​‌​‌​​​‌‌​‌​​​​‌‌​‌​​‌​‌‌‌​​‌‌​​‌​​​​​​‌‌​‌​​‌​‌‌‌​​‌‌​​‌​​​​​​‌‌‌​​‌‌​‌‌​‌​​​​‌‌​​​​‌​‌‌​​‌​​​‌‌​‌‌‌‌​‌‌‌​‌‌‌​​‌​​​​​​‌‌‌​‌‌‌​‌‌​‌‌‌‌​‌‌‌​​‌​​‌‌​‌​‌‌​​‌​‌‌‌​
# end 'of truth'

# The single-character pupil is U+0298, a glyph tested on the author's console.
# Keep ASCII-only Classic mode for terminals that do not render it.
$pupil = [string][char]0x0298
$openShapes = if ($PupilMode -eq 'Classic') { @('<O>') } else { @('<O>','<O>','<O>',('<'+$pupil+'>')) }
$eyes = @()
$lastW = -1; $lastH = -1
$darkUntil = [DateTime]::MinValue
$nextDark = [DateTime]::UtcNow.AddSeconds($rng.Next(24,40))
$nextFocus = [DateTime]::UtcNow.AddSeconds($rng.Next(18,35))

function Draw-At([int]$x,[int]$y,[string]$value) {
    try {
        $w = [Console]::WindowWidth; $h = [Console]::WindowHeight
        if ($x -lt 0 -or $y -lt 0 -or $y -ge ($h-1) -or ($x+$value.Length) -ge $w) { return }
        [Console]::SetCursorPosition($x,$y)
        [Console]::Write($value)
    } catch { } # A resize may happen between checking and drawing.
}
function Render-Eye($eye,[string]$shape) {
    if ($eye.Drawn -eq $shape) { return } # Never redraw an unchanged eye.
    Draw-At $eye.X $eye.Y $shape
    $eye.Drawn = $shape
}
function Reset-Eyes {
    $script:eyes = @()
    $w=[Console]::WindowWidth; $h=[Console]::WindowHeight
    [Console]::Clear()
    if ($w -lt 35 -or $h -lt 12) {
        Draw-At 1 1 'Enlarge the console to continue.'
        return
    }
    # Use more regions for the 20-eye experiment to prevent clustering.
    # Smaller consoles retain the original distribution logic.
    if ($EyeCount -ge 18 -and $w -ge 85 -and $h -ge 24) {
        $nx=5; $ny=4
    } else {
        $nx=if ($w -ge 85) {4} else {2}
        $ny=if ($h -ge 24) {3} else {2}
    }
    $cells=@()
    for ($cy=0;$cy -lt $ny;$cy++) {
        for ($cx=0;$cx -lt $nx;$cx++) {
            $cells += [pscustomobject]@{ CX=$cx; CY=$cy; Sort=$rng.Next() }
        }
    }
    $cells=@($cells | Sort-Object Sort)
    $count=[Math]::Min($EyeCount,[Math]::Max(1,[int](($w-4)*($h-4)/50)))
    for ($i=0;$i -lt $count;$i++) {
        $cell=$cells[$i % $cells.Count]
        $x0=[Math]::Max(1,[int][Math]::Floor($cell.CX*$w/$nx))
        $x1=[Math]::Max($x0,[int][Math]::Floor(($cell.CX+1)*$w/$nx)-5)
        $y0=[Math]::Max(2,[int][Math]::Floor($cell.CY*$h/$ny))
        $y1=[Math]::Max($y0,[Math]::Min($h-3,[int][Math]::Floor(($cell.CY+1)*$h/$ny)-1))
        $ok=$false
        for ($tries=0;$tries -lt 60;$tries++) {
            $px=$rng.Next($x0,$x1+1); $py=$rng.Next($y0,$y1+1)
            $overlap=@($script:eyes | Where-Object { [Math]::Abs($_.X-$px) -lt 8 -and [Math]::Abs($_.Y-$py) -lt 3 }).Count -gt 0
            if (-not $overlap) { $ok=$true; break }
        }
        if (-not $ok) { continue }
        $script:eyes += [pscustomobject]@{
            X=$px;Y=$py;Drawn='   ';Visible=$false;Phase=0;Fast=$false;Focused=$false
            OpenShape=$openShapes[$rng.Next($openShapes.Count)]
            Next=[DateTime]::UtcNow.AddMilliseconds($rng.Next(300,4700))
        }
    }
}
function Open-Shape($eye) {
    if ($eye.Focused) { return '<'+$pupil+'>' }
    return $eye.OpenShape
}
try {
    [Console]::OutputEncoding = [Text.UTF8Encoding]::new($false)
    try { [Console]::CursorVisible = $false } catch {}
    try { [Console]::Write("${esc}[?25l") } catch {}
    $nextCursorHide = [DateTime]::UtcNow
    while ($true) {
        $now=[DateTime]::UtcNow
        $w=[Console]::WindowWidth; $h=[Console]::WindowHeight
        if ($w -ne $lastW -or $h -ne $lastH) {
            $lastW=$w; $lastH=$h
            Reset-Eyes
            # Console Host can restore a visible cursor when the window is resized.
            # Reapply the existing Win32 cursor setting without changing eye rendering.
            if ($win32OK) {
                try { [void][WstEyeConsole]::SetConsoleCursorInfo($handle,[ref]$hidden) } catch {}
            }
        }
        # Some console hosts restore the cursor after the resize event itself.
        # Reinforce the existing hidden state occasionally, without moving the cursor.
        if ($win32OK -and $now -ge $nextCursorHide) {
            try { [void][WstEyeConsole]::SetConsoleCursorInfo($handle,[ref]$hidden) } catch {}
            $nextCursorHide = $now.AddMilliseconds(250)
        }
        if ($w -lt 35 -or $h -lt 12) { Start-Sleep -Milliseconds 200; continue }
        if ($now -ge $nextDark -and $darkUntil -eq [DateTime]::MinValue) {
            foreach ($eye in $eyes) {
                if ($eye.Visible) { Render-Eye $eye '   '; $eye.Visible=$false }
            }
            $darkUntil=$now.AddMilliseconds($rng.Next(900,1900))
            $nextDark=$now.AddSeconds($rng.Next(26,45))
        }
        if ($darkUntil -ne [DateTime]::MinValue) {
            if ($now -lt $darkUntil) { Start-Sleep -Milliseconds 50; continue }
            $darkUntil=[DateTime]::MinValue
            foreach ($eye in $eyes) {
                $eye.Phase=0; $eye.Fast=$false; $eye.Focused=$false
                $eye.Next=$now.AddMilliseconds($rng.Next(150,2500))
            }
        }
        # Rare focus event, one eye at a time. Enabled in Focus and Combined modes.
        if (($PupilMode -eq 'Focus' -or $PupilMode -eq 'Combined') -and $now -ge $nextFocus) {
            $eligible=@($eyes | Where-Object { $_.Visible -and $_.Phase -eq 0 -and -not $_.Focused -and $_.OpenShape -eq '<O>' })
            if ($eligible.Count -gt 0) {
                $chosen=$eligible[$rng.Next($eligible.Count)]
                $chosen.Focused=$true
                Render-Eye $chosen (Open-Shape $chosen)
            }
            $nextFocus=$now.AddSeconds($rng.Next(20,40))
        }
        foreach ($eye in $eyes) {
            if ($now -lt $eye.Next) { continue }
            if (-not $eye.Visible) {
                $eye.Visible=$true; $eye.Phase=0
                Render-Eye $eye (Open-Shape $eye)
                $eye.Next=$now.AddMilliseconds($rng.Next(850,4700))
                continue
            }
            if ($eye.Phase -eq 0) {
                $eye.Focused=$false
                $eye.Fast=($rng.Next(100) -lt $FastBlinkPercent)
                $eye.Phase=if ($eye.Fast) {2} else {1}
            } elseif ($eye.Fast -and $eye.Phase -eq 2) {
                $eye.Phase=4
            } else {
                $eye.Phase++
            }
            $shape=switch ($eye.Phase) {
                1 {'<o>'}
                2 {'<->'}
                3 {'<o>'}
                default { Open-Shape $eye }
            }
            Render-Eye $eye $shape
            if ($eye.Phase -ge 4) {
                $eye.Phase=0
                $delay=if ($rng.Next(100) -lt 12) { $rng.Next(180,340) } else { $rng.Next(1200,5400) }
                $eye.Next=$now.AddMilliseconds($delay)
            } else {
                $delay=if ($eye.Phase -eq 2) { $rng.Next(100,180) } else { $rng.Next(65,135) }
                $eye.Next=$now.AddMilliseconds($delay)
            }
        }
        Start-Sleep -Milliseconds 40
    }
} finally {
    try { [Console]::Write("${esc}[?25h") } catch {}
    if ($win32OK) { try { [void][WstEyeConsole]::SetConsoleCursorInfo($handle,[ref]$saved) } catch {} }
    try { [Console]::CursorVisible=$oldVisible } catch {}
    try { [Console]::OutputEncoding=$oldEncoding } catch {}
    try { [Console]::ForegroundColor=$oldColor } catch {}
}
