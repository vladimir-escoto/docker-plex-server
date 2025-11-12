$MediaRoot = if ($env:MEDIA_ROOT) { $env:MEDIA_ROOT } else { 'C:\docker-services\media' }
$DownloadsRoot = if ($env:DOWNLOADS_ROOT) { $env:DOWNLOADS_ROOT } else { Join-Path $MediaRoot 'downloads' }
$CompletedDir = if ($env:COMPLETED_DIR) { $env:COMPLETED_DIR } else { Join-Path $DownloadsRoot 'completed' }
$IncompleteDir = if ($env:INCOMPLETE_DIR) { $env:INCOMPLETE_DIR } else { Join-Path $DownloadsRoot 'incomplete' }

function Remove-OldFiles {
    param (
        [string]$Path,
        [int]$Days
    )

    if (Test-Path $Path) {
        Get-ChildItem -Path $Path -Recurse -File |
            Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$Days) } |
            Remove-Item -Force
    }
    else {
        Write-Host "Directorio no encontrado: $Path"
    }
}

Write-Host 'Limpiando descargas antiguas...'
Remove-OldFiles -Path $CompletedDir -Days 30
Remove-OldFiles -Path $IncompleteDir -Days 7
Write-Host 'Limpieza completada.'

