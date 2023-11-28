<#
    .SYNOPSIS
       This cmdlet deletes a Named Disk from vCloud Director.

    .DESCRIPTION
       This cmdlet deletes a Named Disk from vCloud Director using either its name or Href.

       You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
        Remove-CINamedDisk -DiskName Disk02

        Deletes the Named Disk 'Disk02'.

    .EXAMPLE
        Remove-CINamedDisk -DiskHref 'https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5'

        Deletes a Named Disk by referencing its Href location.

    .PARAMETER DiskName
        Specifies the name of the Named Disk to delete.
        This can either be an exact name or use a wildcard based filter.

    .PARAMETER DiskHref
        Specifies the precise Href (URI) of the Named Disk to delete.
        This should be in the following format:
        https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5

    .NOTES
        Built using vCloud Director documentation:
        https://developer.vmware.com/apis/1601/doc/operations/DELETE-Disk.html
#>
Function Remove-CINamedDisk {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High', DefaultParameterSetName = 'ByDiskName')]
    Param (
        [Parameter(Mandatory, ParameterSetName = 'ByDiskName')]
        [System.String]
        $DiskName,

        [Parameter(Mandatory, ParameterSetName = 'ByDiskHref')]
        [System.String]
        $DiskHref
    )

    Begin {
        #Create authorisation headers used to connect to vCloud Director
        $headers = Get-vCloudDirectorLogonHeaders
    }

    Process {
        #Find the disks to remove.
        switch ($PSCmdlet.ParameterSetName) {
            'ByDiskName' {
                $ciNamedDisksToRemove = @(Get-CINamedDisk -DiskName $DiskName)
                $cmdParameterDetails = "Named Disk(s) with name matching filter '$DiskName'."
                Break
            }

            'ByDiskHref' {
                $ciNamedDisksToRemove = @(Get-CINamedDisk -DiskHref $DiskHref)
                $cmdParameterDetails = "Named Disk with a Href of '$DiskHref'."
                Break
            }
        }

        if ($ciNamedDisksToRemove.Count -gt 0) {
            Write-Verbose -Message "Found $($ciNamedDisksToRemove.Count) $cmdParameterDetails"

            foreach ($ciNamedDisk in $ciNamedDisksToRemove) {
                #Confirm the disk isn't currently attached to a VM.
                if ($null -eq $ciNamedDisk.AttachedTo) {
                    try {
                        #Delete the disk.
                        if($PSCmdlet.ShouldProcess("$($ciNamedDisk.Name)", 'Remove-CINamedDisk')) {
                            Write-Verbose -Message "Deleting Named Disk with name '$($ciNamedDisk.Name)'."
                            $vCloudTask = Invoke-vCloudDirectorWebRequest -Uri $ciNamedDisk.Href -Headers $headers -Method Delete

                            #Wait for the task to complete.
                            Wait-vCloudDirectorTask -Task $vCloudTask -Headers $headers -TaskDescription "Deleting Named Disk with name '$($ciNamedDisk.Name)'."
                        }
                    } catch {
                        Write-Error $_.Exception
                    }

                #Display an error message if the disk is attached to a VM.
                } else {
                    Write-Error -Message @"
Unable to delete Named Disk name '$($ciNamedDisk.Name)' because it is attached to VM '$($ciNamedDisk.AttachedTo)'.
Detach this using 'Dismount-CINamedDisk' before continuing.
"@
                }
            }
        } else {
            Write-Warning -Message "Found 0 $cmdParameterDetails"
        }
    }
}
