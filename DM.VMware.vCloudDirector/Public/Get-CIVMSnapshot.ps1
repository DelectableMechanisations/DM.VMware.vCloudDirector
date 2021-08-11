

<#
    .SYNOPSIS
        This cmdlet retrieves snapshot details of a vCloud Director VM.

    .DESCRIPTION
        This cmdlet retrieves snapshot details of one or more vCloud Director VMs.

        You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
        Get-CIVM -Name 'Server01' | Get-CIVMSnapshot

        Returns the snapshot details for VM 'Server01'.

    .EXAMPLE
        $CIVM = Get-CIVM -Name 'Server01'
        Get-CIVMSnapshot -CIVM $CIVM

        Returns the snapshot details for VM 'Server01' (non-pipeline variation of the previous example).

    .EXAMPLE
        Get-CIVM Server01, Server02 | Get-CIVMSnapshot

        Returns the snapshot details for VMs 'Server01' and 'Server02'.

    .PARAMETER CIVM
        Specifies the vCloud Director VM(s) you want to retrieve the snapshot for.
#>
Function Get-CIVMSnapshot {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline = $True)]
        [System.Object[]]
        $CIVM
    )

    Process {
        foreach ($vm in $CIVM) {
            $snapshot = $CIVM.ExtensionData.GetSnapshotSection().Snapshot

            if ($null -ne $snapshot) {
                Write-Verbose -Message "Snapshot detected on '$($CIVM.Name)'."
                [PSCustomObject]@{
                    VMName      = $CIVM.Name
                    DateCreated = $snapshot.Created
                    SizeGB      = Get-RoundNumber -Number ($snapshot.Size/1GB)
                } | Write-Output

            } else {
                Write-Verbose -Message "No snapshot detected on '$($CIVM.Name)'."
            }
        }
    }
}
