<#
    .SYNOPSIS
        This cmdlet retrieves the Named Disks hosted in vCloud Director.

    .DESCRIPTION
        This cmdlet retrieves the Named Disks hosted in vCloud Director, along with any VMs the disks are attached to.
        Named Disks were previously referred to as Independent Disks and can be moved bewteen VMs.

        You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
        Get-CINamedDisk

        Returns all Named Disks.

    .EXAMPLE
        Get-CINamedDisk | Format-Table -Property *

        Returns all Named Disks and displays them in a table format.

    .EXAMPLE
        Get-CINamedDisk -DiskName 'Named Disk Test'

        Returns the Named Disk with the name 'Named Disk Test'.

    .EXAMPLE
        Get-CINamedDisk -DiskName '*test*'

        Returns all Named Disks with a name matching the filter '*test*'.

    .EXAMPLE
        Get-CINamedDisk -DiskHref 'https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5'

        Returns the Named Disk located at the URI 'https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5'.

    .PARAMETER DiskName
        Specifies the name of the Named Disk to search for.
        This can either be an exact name or use a wildcard based filter.

        The default value is '*' (i.e. retrieve all Named Disks).

    .PARAMETER DiskHref
        Specifies the precise Href (URI) of the Named Disk to retrieve.
        This should be in the following format:
        https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5

    .NOTES
        Built using vCloud Director documentation:
        https://developer.vmware.com/apis/1601/doc/operations/GET-Disk.html
#>
Function Get-CINamedDisk {
    [CmdletBinding(DefaultParameterSetName = 'ByDiskName')]
    Param (
        [Parameter(ParameterSetName = 'ByDiskName')]
        [System.String]
        $DiskName = '*',

        [Parameter(Mandatory, ParameterSetName = 'ByDiskHref')]
        [System.String]
        $DiskHref
    )

    Begin {
        if ($PSCmdlet.ParameterSetName -eq 'ByDiskName') {
            $orgVdcs = @(Get-OrgVdc)

        } elseif ($PSCmdlet.ParameterSetName -eq 'ByDiskHref') {
            #Create authorisation headers used to connect to vCloud Director
            $headers = Get-vCloudDirectorLogonHeaders
        }
    }

    Process {
        if ($PSCmdlet.ParameterSetName -eq 'ByDiskName') {
            foreach ($orgVdc in $orgVdcs) {
                $ciNamedDisks = @($orgVdc.ExtensionData.ResourceEntities.ResourceEntity | Where-Object { $_.Type -eq 'application/vnd.vmware.vcloud.disk+xml'})

                foreach ($ciNamedDisk in $ciNamedDisks) {
                    $ciDisk = $ciNamedDisk.GetCIView()
                    $vmsAttachedTo = $ciDisk.GetAttachedVms().VmReference.Name

                    $ciNamedDiskResult = [PSCustomObject]@{
                        Name           = $ciDisk.Name
                        Description    = $ciDisk.Description
                        SizeGB         = ($ciDisk.SizeMb/1024)
                        BusType        = $ciDisk.BusSubType
                        StorageProfile = $ciDisk.StorageProfile.Name
                        AttachedTo     = $vmsAttachedTo
                        Href           = $ciDisk.Href
                    }

                    if ($ciNamedDiskResult.Name -like $DiskName) {
                        Write-Output -InputObject $ciNamedDiskResult
                    }
                }
            }

        } elseif ($PSCmdlet.ParameterSetName -eq 'ByDiskHref') {
            try {
                $ciNamedDiskByHref = Invoke-vCloudDirectorWebRequest -Uri $DiskHref               -Headers $headers -Method Get -ErrorAction Stop
                $vmsAttachedTo     = Invoke-vCloudDirectorWebRequest -Uri "$DiskHref/attachedVms" -Headers $headers -Method Get

                [PSCustomObject]@{
                    Name           = $ciNamedDiskByHref.Disk.Name
                    Description    = $ciNamedDiskByHref.Disk.Description
                    SizeGB         = ($ciNamedDiskByHref.Disk.SizeMb/1024)
                    BusType        = $ciNamedDiskByHref.Disk.BusSubType
                    StorageProfile = $ciNamedDiskByHref.Disk.StorageProfile.name
                    AttachedTo     = $vmsAttachedTo.Vms.VmReference.name
                    Href           = $ciNamedDiskByHref.Disk.Href
                } | Write-Output

            } catch {
                Write-Error $_.Exception
            }
        }
    }
}
