<#
    .SYNOPSIS
        This cmdlet retrieves the full CPU details on a vCloud Director VM.

    .DESCRIPTION
        This cmdlet retrieves the CPU details available on a vCloud Director VM and returns the TotalSockets and CoresPerSocket properties.

        You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
        Get-CIVM Server01 | Get-CIVMCpu

        Returns the CPU details for the VM 'Server01'

    .EXAMPLE
        Get-CIVMCpu -CIVM (Get-CIVM Server01)

        Returns the CPU details for the VM 'Server01' (non-pipeline variation of the previous example).

    .EXAMPLE
        Get-CIVM Server01, Server02 | Get-CIVMCpu | Format-Table -Property *

        Returns the CPU details for the VMs 'Server01' & 'Server02' and displays them in tabular format.

    .PARAMETER CIVM
        Specifies the virtual machine you want to retrieve the CPU details for.
#>
Function Get-CIVMCpu {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline = $True)]
        [System.Object[]]
        $CIVM
    )

    Process {
        foreach ($vm in $CIVM) {
            $cpuConfig = $vm.ExtensionData.GetVirtualHardwareSection().Item | Where-Object {$_.ResourceType.Value -eq '3'}
            $coresPerSocketConfig = $cpuConfig.Any | Where-Object {$_.LocalName -eq 'CoresPerSocket'}
            [Int32]$totalCores     = $cpuConfig.VirtualQuantity.Value
            [Int32]$coresPerSocket = $coresPerSocketConfig.'#text'
            [Int32]$totalSockets   = $totalCores/$coresPerSocket


            [PSCustomObject]@{
                Name            = $vm.Name
                AllocationUnits = $cpuConfig.AllocationUnits.Value
                TotalSockets    = $totalSockets
                CoresPerSocket  = $coresPerSocket
                TotalCores      = $totalCores
            }
        }
    }
}
