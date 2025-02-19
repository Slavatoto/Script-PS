$cheminDossier = "C:\Users\Administrateur\Documents\projets perso"

# Vérifie si le répertoire existe
if (-Not (Test-Path -Path $cheminDossier)) {
    Write-Error "Le répertoire n'existe pas : $cheminDossier"
    exit
}

$fichiersZip = Get-ChildItem -Path $cheminDossier -Filter "*.zip"

foreach ($fichier in $fichiersZip) {
    $cheminFichierZip = $fichier.FullName

    # Chemin du dossier cible pour extraire le contenu
    $dossierExtraction = Join-Path -Path $cheminDossier -ChildPath $fichier.BaseName

    # Créer le dossier cible s'il n'existe pas
    if (-Not (Test-Path -Path $dossierExtraction)) {
        New-Item -ItemType Directory -Path $dossierExtraction | Out-Null
    }

    # Extraire le contenu du fichier ZIP
    try {
        Expand-Archive -Path $cheminFichierZip -DestinationPath $dossierExtraction -Force
        Write-Host "Extraction réussie pour : $cheminFichierZip"

        # Supprimer le fichier ZIP après extraction
        Remove-Item -Path $cheminFichierZip -Force
        Write-Host "Fichier ZIP supprimé : $cheminFichierZip"
    } catch {
        Write-Error "Erreur lors de l'extraction ou de la suppression de : $cheminFichierZip. $_"
    }
}

Write-Host "Processus terminé."
