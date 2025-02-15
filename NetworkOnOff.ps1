# Spécifiez le nom de la carte réseau que vous souhaitez gérer
$nomCarteReseau = "Ethernet1"

# Obtenez l'objet de la carte réseau en utilisant le nom
$carteReseau = Get-WmiObject Win32_NetworkAdapter | Where-Object {$_.NetConnectionID -eq $nomCarteReseau}

# Vérifiez si la carte réseau a été trouvée
if ($carteReseau -eq $null) {
    Write-Host "La carte réseau '$nomCarteReseau' n'a pas été trouvée."
} else {
    # Vérifiez si la carte réseau est actuellement activée ou désactivée
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

#ceci est un test
 