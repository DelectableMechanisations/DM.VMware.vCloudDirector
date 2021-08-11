

<#
    .SYNOPSIS
        This cmdlet retrieves the vCloud Director Compute Policy applied to a VM.

    .DESCRIPTION
        This cmdlet retrieves the vCloud Director Compute Policy applied to one or more VMs.

        You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
        Get-CIVM -Name 'Server01' | Get-CIVMComputePolicy

        Returns the Compute Policy applied to VM 'Server01'.

    .EXAMPLE
        $CIVM = Get-CIVM -Name 'Server01'
        Get-CIVMComputePolicy -CIVM $CIVM

        Returns the Compute Policy applied to VM 'Server01' (non-pipeline variation of the previous example).

    .EXAMPLE
        Get-CIVM Server01, Server02 | Get-CIVMComputePolicy | Format-Table -Property *

        Returns the Compute Policy applied to VMs 'Server01' and 'Server02'.

    .PARAMETER CIVM
        Specifies the vCloud Director VM(s) you want to return Compute Policy for.
#>
Function Get-CIVMComputePolicy {
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
            #Retrieve the vCloud representation of the VM.
            $vCloudVM = Invoke-vCloudDirectorWebRequest -Headers $headers -Method Get -Uri $vm.Href

            #Output the Compute Policy currently applied to the VM.
            $vCloudVM.Vm.VdcComputePolicy | Select-Object -Property @(
                @{Label = 'VMName'; Expression = {$vm.Name}},
                'name',
                'id',
                'href',
                'type'
            ) | Write-Output
        }
    }
}
