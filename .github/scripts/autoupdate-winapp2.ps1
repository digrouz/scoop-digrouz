$MyURL="https://content.thewebatom.net/files/winapp2.ini"

$wc = [System.Net.WebClient]::new()
$FileHash = Get-FileHash -InputStream ($wc.OpenRead($MyURL))

$FileHash.Hash

$a = Get-Content '.\bucket\ccleanerpro.json' -raw | ConvertFrom-Json
$a.hash[1]=$FileHash.Hash
$a | ConvertTo-Json -depth 32 | %{[Regex]::Replace($_,"\\u(?<Value>[a-zA-Z0-9]{4})", {param($m) ([char]([int]::Parse($m.Groups['Value'].Value, [System.Globalization.NumberStyles]::HexNumber))).ToString() } )} |set-content '.\bucket\ccleanerpro.json'
