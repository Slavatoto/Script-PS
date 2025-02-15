$nomCarteReseau = "Ethernet1"

# Retourne l'objet de la carte réseau en utilisant le nom
$carteReseau = Get-WmiObject Win32_NetworkAdapter | Where-Object {$_.NetConnectionID -eq $nomCarteReseau}

# Vérifie si la carte réseau a été trouvée
if ($carteReseau -eq $null) {
    Write-Host "La carte réseau '$nomCarteReseau' n'a pas été trouvée."
} else {
    # Vérifie si la carte réseau est actuellement activée ou désactivée
    if ($carteReseau.NetConnectionStatus -eq 2) {
        Write-Host "Désactivation de la carte réseau '$nomCarteReseau'..."
        $carteReseau.Disable()
        Write-Host "La carte réseau '$nomCarteReseau' a été désactivée."
    } else {
        Write-Host "Activation de la carte réseau '$nomCarteReseau'..."
        $carteReseau.Enable()
        Write-Host "La carte réseau '$nomCarteReseau' a été activée."
    }
}
 