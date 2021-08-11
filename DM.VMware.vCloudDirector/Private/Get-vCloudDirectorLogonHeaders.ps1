Function Get-vCloudDirectorLogonHeaders {
    [CmdletBinding()]
    Param ()

    #Terminate if not currently connected to vCloud Director.
    if (-not $global:DefaultCIServers) {
        throw "You are not currently connected to any servers. Please connect first using the Connect-CIServer cmdlet."
    }

    #Populate the $global:DefaultCIApiVersion variable if it doesn't exist
    if (-not $global:DefaultCIApiVersion) {
        New-Variable -Name DefaultCIApiVersion -Scope Global -Value (Get-vCloudDirectorApiSupportedVersion)
    }

    #Create authorisation headers used to connect to vCloud Director
    $headers = @{
        "x-vcloud-authorization" = $global:DefaultCIServers[0].sessionid
        "Accept"                 = "application/*+xml;version=$global:DefaultCIApiVersion"
    }

    Write-Output -InputObject $headers
}
