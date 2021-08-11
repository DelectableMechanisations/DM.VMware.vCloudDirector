Function Get-vCloudDirectorApiSupportedVersion {
    [CmdletBinding()]
    Param (
        [System.String]
        $Server = $global:DefaultCIServers[0].Name,

        [Switch]
        $All
    )

    #Query for the list of API versions.
    try {
        $apiVersions = Invoke-RestMethod -Uri "https://$Server/api/versions" -Method GET -ErrorAction Stop

    } catch {
        throw $_
    }

    #Return all versions of the API if the $All switch is specified.
    if ($All) {
        $apiVersions.SupportedVersions.VersionInfo | Select-Object -Property deprecated, Version, LoginUrl | Write-Output


    #Default behaviour is to just return the most recent version of the API supported
    } else {
        [Array]$apiVersionsNotDeprecated = $apiVersions.SupportedVersions.VersionInfo | Where-Object {$_.deprecated -ne $true}
        $latestApiVersion = $apiVersionsNotDeprecated | Sort-Object -Property {[System.Double]$_.Version} | Select-Object -Last 1
        Write-Output -InputObject $latestApiVersion.Version
    }
}
