# === Percorsi ===
$vault = "C:\Users\giuli\Desktop\Obsidian\UniNotes"
$quartz = "C:\Users\giuli\Desktop\Obsidian\PublicNotes\content"

# Cartelle da sincronizzare
$folders = @("ADE", "BD", "MDP", "SO")

Write-Host "Sync in corso..."

foreach ($folder in $folders) {
    $src = Join-Path $vault $folder
    $dest = Join-Path $quartz $folder

    Write-Host "Copio $folder → $dest"

    # Cancella destinazione
    if (Test-Path $dest) {
        Remove-Item $dest -Recurse -Force
    }

    # Ricrea destinazione
    New-Item -ItemType Directory -Path $dest | Out-Null

    # Copia tutto tranne .obsidian e _Images
    robocopy $src $dest /E /XD ".obsidian" "_Images"
}

# === Copia IMMAGINI ===
$imagesSrc = Join-Path $vault "_Images"
$imagesDest = Join-Path $quartz "_Images"

Write-Host "Copio immagini → $imagesDest"

foreach ($folder in $folders) {
    $srcImg = Join-Path $imagesSrc ($folder + "-images")
    $destImg = Join-Path $imagesDest ($folder + "-images")

    if (Test-Path $srcImg) {
        if (Test-Path $destImg) {
            Remove-Item $destImg -Recurse -Force
        }

        New-Item -ItemType Directory -Path $destImg | Out-Null
        robocopy $srcImg $destImg /E
    }
}

Write-Host "Commit & push..."

Set-Location "C:\Users\giuli\Desktop\Obsidian\PublicNotes"
git add .
git commit -m "Sync + build $(Get-Date)" --allow-empty
git push origin main

npx quartz build

Write-Host "Sync completato!"

