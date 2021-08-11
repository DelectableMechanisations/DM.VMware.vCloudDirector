<#
    .SYNOPSIS
        Invoke-vCloudDirectorWebRequest is a wrapper function for Invoke-WebRequest.
        It behaves much the same as Invoke-WebRequest except the -UseBasicParsing parameter is always used and the Content is automatically converted to an Xml Document if detected.
        Invoke-RestMethod is not used because when it fails it only ever displays a generic error message and never anything useful.
#>
Function Invoke-vCloudDirectorWebRequest {
    [CmdletBinding()]
    Param (
        [System.Uri]
        $Uri,

        [System.Collections.IDictionary]
        $Headers,

        [Microsoft.PowerShell.Commands.WebRequestMethod]
        $Method,

        [System.Object]
        $Body,

        [System.String]
        $ContentType,

        [System.String]
        $InFile,

        [System.String]
        $OutFile
    )

    #Add all input parameters to a hash table.
    $invokeWebRequestParameters = @{} + $PSBoundParameters

    #Enable Basic Parsing so the command can be run on Server Core.
    $invokeWebRequestParameters['UseBasicParsing'] = $true
    $invokeWebRequestParameters['ErrorAction']     = 'Stop'

    #Use Invoke-WebRequest to make the request.
    $vCloudOperation = Invoke-WebRequest @invokeWebRequestParameters

    #If XML content is detected then convert to a XML object and return.
    if ($vCloudOperation.Content -like '<?xml version="1.0"*') {
        [Xml]$vCloudOperationOutput = $vCloudOperation.Content
        Write-Output -InputObject $vCloudOperationOutput
    }
}
