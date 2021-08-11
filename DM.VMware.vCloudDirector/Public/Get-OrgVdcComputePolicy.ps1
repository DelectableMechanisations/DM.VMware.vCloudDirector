<#
    .SYNOPSIS
        This cmdlet retrieves a list of vCloud Director Compute Policies.

    .DESCRIPTION
        This cmdlet retrieves a list of vCloud Director Compute Policies configured against one or more vDCs.

        You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
        Get-OrgVdc | Where-Object {$_.name -eq 'MyVdc'} | Get-OrgVdcComputePolicy

        Returns the Compute Policies available for the OrgVdc 'MyVdc'

    .EXAMPLE
        $OrgVdc = Get-OrgVdc | Where-Object {$_.name -eq 'MyVdc'}
        Get-OrgVdcComputePolicy -OrgVdc $OrgVdc

        Returns the Compute Policies available for the OrgVdc 'MyVdc' (non-pipeline variation of the previous example).

    .EXAMPLE
        Get-OrgVdc | Get-OrgVdcComputePolicy | Format-Table -Property *

        Returns all Compute Policies in all Vdcs.

    .PARAMETER OrgVdc
        Specifies the vCloud Director VDC(s) you want to retrieve the Compute Policies for.

    .PARAMETER Name
        The name of the vCloud Director Compute Policy to filter on.
        The default value is '*'.
#>
Function Get-OrgVdcComputePolicy {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline = $True)]
        [System.Object[]]
        $OrgVdc,

        [System.String]
        $Name = '*'
    )

    Begin {
        #Create authorisation headers used to connect to vCloud Director
        $headers = Get-vCloudDirectorLogonHeaders
    }

    Process {
        foreach ($vdc in $OrgVdc) {
            #Find the link to the list of Compute Policies
            $vdcComputePolicyReferencesLink = $vdc.ExtensionData.Link | Where-Object {$_.Type -eq 'application/vnd.vmware.vcloud.vdcComputePolicyReferences+xml'}

            #Retrieve the Compute Policies.
            $computePolicies = Invoke-vCloudDirectorWebRequest -Headers $headers -Method Get -Uri $vdcComputePolicyReferencesLink.href

            #Output all Compute Policies.
            $computePolicies.VdcComputePolicyReferences.VdcComputePolicyReference | Select-Object -Property @(
                @{Label = 'OrgVdcName'; Expression = {$vdc.Name}},
                'name',
                'id',
                'href',
                'type'
            ) | Where-Object {$_.name -like $Name} | Write-Output
        }
    }
}
