<#
    .SYNOPSIS
        Function to test that a string is a URI.
        It does not test the validity of the URI.
#>
Function Test-StringIsUri {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [System.String]
        $String
    )
    $uriKind = [System.UriKind]::Absolute

    [System.Uri]::IsWellFormedUriString($String, $uriKind) | Write-Output
}
