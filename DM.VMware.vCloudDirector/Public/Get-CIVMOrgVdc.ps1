

<#
    .SYNOPSIS
        This cmdlet retrieves the vCloud Director vDC the VM is part of.

    .DESCRIPTION
        This cmdlet retrieves the vCloud Director vDC that the VM is part of.
        After vCloud Director was updated to version 10 the 'OrgvDC' property is blank when the Get-CIVM command is executed.
        This function was written as a workaround to map the VM back to its parent vDC in an easy to use way.

        You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
        Get-CIVM -Name 'Server01' | Get-CIVMOrgVdc

        Returns the vDC that the VM 'Server01' is part of.

    .EXAMPLE
        $CIVM = Get-CIVM -Name 'Server01'
        Get-CIVMOrgVdc -CIVM $CIVM

        Returns the vDC that the VM 'Server01' is part of (non-pipeline variation of the previous example).

    .EXAMPLE
        Get-CIVM Server01, Server02 | Get-CIVMOrgVdc | Format-Table -Property *

        Returns the vDC that the VMs 'Server01' and 'Server02' are part of.

    .PARAMETER CIVM
        Specifies the vCloud Director VM(s) you want to return the vDC for.
#>
Function Get-CIVMOrgVdc {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline = $True)]
        [System.Object[]]
        $CIVM
    )

    Begin {
        #Create authorisation headers used to connect to vCloud Director
        $headers = Get-vCloudDirectorLogonHeaders
    }

    Process {
        foreach ($vm in $CIVM) {
            #Retrieve the vCloud representation of the vDC by finding its link in the parent vApp.
            $orgVdcLink = $vm.VApp.ExtensionData.Link | Where-Object {$_.type -eq 'application/vnd.vmware.vcloud.vDC+xml'}
            $vCloudOrgVdc = Invoke-vCloudDirectorWebRequest -Headers $headers -Method Get -Uri $orgVdcLink.Href

            #Output the vDC currently applied to the VM.
            $vCloudOrgVdc.Vdc | Select-Object -Property @(
                @{Label = 'VMName'; Expression = {$vm.Name}},
                'name',
                'Description',
                'id',
                'href',
                'type'
            ) | Write-Output
        }
    }
}
