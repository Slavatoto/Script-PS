$cheminDossier = "C:\Users\Administrateur\Documents\projets perso"

# Vérifier si le répertoire existe
if (-Not (Test-Path -Path $cheminDossier)) {
    Write-Error "Le répertoire spécifié n'existe pas : $cheminDossier"
    exit
}

$dossiers = Get-ChildItem -Path $cheminDossier -Directory

foreach ($dossier in $dossiers) {
    $cheminDossierComplet = $dossier.FullName

    # Nom du fichier ZIP (ajouter ".zip" au nom du dossier)
    $fichierZip = Join-Path -Path $cheminDossier -ChildPath "$($dossier.Name).zip"

    # Créer le fichier ZIP
    try {
        Compress-Archive -Path $cheminDossierComplet -DestinationPath $fichierZip -Force
        Write-Host "Compression réussie pour : $cheminDossierComplet"

        # Supprimer le dossier original après compression
        Remove-Item -Path $cheminDossierComplet -Recurse -Force
        Write-Host "Dossier supprimé : $cheminDossierComplet"
    } catch {
        Write-Error "Erreur lors de la compression ou de la suppression de : $cheminDossierComplet. $_"
    }
}

Write-Host "Processus terminé."
