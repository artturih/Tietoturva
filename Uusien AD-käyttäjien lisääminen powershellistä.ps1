# Luodaan AD-käyttäjiä tiedoston CSV perusteella tai avulla

# kysytään CSV-tiedoston tiedot käyttäjiltä ja tallennetaan ne muuttujaan
Write-Warning("Luodaan käyttäjätilejä CSV-tiedostosta")
$Tiedosto = Read-Host("Anna tiedoston nimi ja polku") 
$Uudetkäyttäjät = Import-Csv -Path $Tiedosto -Delimiter ";" -Encoding Default

# kryptataan ensimmäinen salasana
$EkaSalasana = ConvertTo-SecureString "MuutaHet1" -AsPlainText -Force

# Määritetään organisaatioyksikkö, johon käyttäjät luodaan
$Osasto = "OU=Markkinointi, DC=Firma, DC=intra"

# Luodaan AD-käyttäjät
$Uudetkäyttäjät | New-ADUser -AccountPassword $EkaSalasana -ChangePasswordAtLogon 1 -Enabled 1 -Path $Osasto

$Määrä = $Uudetkäyttäjät.count
Write-Warning("$määrä käyttäjää lisätty")