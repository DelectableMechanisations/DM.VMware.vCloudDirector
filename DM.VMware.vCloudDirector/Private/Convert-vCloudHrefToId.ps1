Function Convert-vCloudHrefToId {
    Param (
        [Parameter(Mandatory)]
        [System.String]
        $Href
    )
    #Remove all but the last block of the URI.
    $vCloudRawId = $Href.Split('/')[-1]

    #Find the position of the vCloud type prefix in the raw ID.
    $vCloudTypePrefixIndex = $vCloudRawId.IndexOf('-')

    #Separate the vCloud type prefix from the raw ID into separate variables.
    $vCloudCleanId = $vCloudRawId.Substring($vCloudTypePrefixIndex + 1)
    $vCloudTypePrefix = $vCloudRawId.Substring(0, $vCloudTypePrefixIndex)

    #Output the vCloud ID in the format accepted by commands like Get-CIVM
    Write-Output -InputObject "urn:vcloud:$($vCloudTypePrefix):$($vCloudCleanId)"
}
