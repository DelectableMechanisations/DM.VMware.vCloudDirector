<#
    .SYNOPSIS
       This cmdlet retrieves the virtual hard disks available on a vCloud Director system.

    .DESCRIPTION
       This cmdlet retrieves the virtual hard disks available on a vCloud Director system and returns (roughly) the same properties displayed in the vCloud Director Web Portal.
       It only supports the retrieval of SCSI and SATA based virtual hard disks (it will not work for IDE drives).

       You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
       Get-CIVM Server01 | Get-CIVMHardDisk

       Returns all Hard Disks attached to the VM 'Server01'

    .EXAMPLE
       Get-CIVMHardDisk -CIVM (Get-CIVM Server01)

       Returns all Hard Disks attached to the VM 'Server01' (non-pipeline variation of the previous example).

    .EXAMPLE
       Get-CIVM Server01, Server02 | Get-CIVMHardDisk | Format-Table -Property *

       Returns all Hard Disks attached to the VMs 'Server01' & 'Server02' and displays them in tabular format.

    .PARAMETER CIVM
        Specifies the virtual machine you want to retrieve the virtual hard disks for.

    .NOTES
        Derived from Alan Renouf (VMware): http://blogs.vmware.com/PowerCLI/2013/03/retrieving-vcloud-director-vm-hard-disk-size.html
#>
Function Get-CIVMHardDisk {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline = $True)]
        [System.Object[]]
        $CIVM
    )


    #Define the different types of Storage Profiles and SCSI Controllers.
    Begin {
        #Map the available Storage Profiles to their reference numbers.
        [Array]$storageProfiles = Get-OrgVdc | ForEach-Object {$_.ExtensionData.VdcStorageProfiles.VdcStorageProfile}
        $storageProfileHash = @{}
        $storageProfiles | ForEach-Object {$storageProfileHash[($_.Href)] = $_.Name}


        #Map the Controller Types to their reference names used by the vCloud Director API.
        $storageControllerType = @{
            'buslogic'         = 'BusLogic Parallel (SCSI)'
            'lsilogic'         = 'LSI Logic Parallel (SCSI)'
            'lsilogicsas'      = 'LSI Logic SAS (SCSI)'
            'VirtualSCSI'      = 'Paravirtual (SCSI)'
            'vmware.sata.ahci' = 'SATA'
        }
    }


    Process {
        foreach ($vm in $CIVM) {
            Write-Verbose -Message "Getting Hard Disks for '$($vm.Name)'."

            #Create a list of all Storage Controllers (storage connected to IDE controllers is ignored).
            [Array]$tempStorageControllers = $vm.ExtensionData.GetVirtualHardwareSection().Item | Where-Object {$_.Description.Value -eq 'SCSI Controller' -or $_.Description.Value -eq 'SATA Controller'}
            $storageControllers = @{}

            foreach ($storageController in $tempStorageControllers) {
                $storageControllers[($storageController.InstanceID.Value)] = New-Object -TypeName psobject -Property @{
                    InstanceID  = $storageController.InstanceID.Value
                    BusNumber   = $storageController.Address.Value
                    Description = $storageController.Description.Value
                    ElementName = $storageController.ElementName.Value
                    BusType     = $storageControllerType[($storageController.ResourceSubType.Value)]
                }
            }


            #Gather all relevant information for each Hard Disk and output one at a time to the pipeline.
            [Array]$hardDisks = $vm.ExtensionData.GetVirtualHardwareSection().Item | Where-Object {$_.Description -match 'Hard Disk'}
            foreach ($hardDisk in $hardDisks) {

                #Determine whether or not the disk is using the Default VM Storage Profile.
                switch (($hardDisk.HostResource[0].AnyAttr | Where-Object {$_.LocalName -eq 'storageProfileOverrideVmDefault'}).Value) {
                    'true'  {$UseDefaultVMStorageProfile = $false}
                    'false' {$UseDefaultVMStorageProfile = $true}
                }


                #Build a profile of each disk.
                $hardDiskProfile = [pscustomobject]@{
                    'VMName'                     = $vm.Name
                    'DiskName'                   = $hardDisk.ElementName.Value
                    'CapacityGB'                 = ([System.Math]::Round((($hardDisk.HostResource[0].AnyAttr | Where-Object {$_.LocalName -eq 'capacity'}).Value)/1024,2))
                    'StorageProfile'             = $storageProfileHash[(($hardDisk.HostResource[0].AnyAttr | Where-Object {$_.LocalName -eq 'storageProfileHref'}).Value)]
                    'UseDefaultVMStorageProfile' = $UseDefaultVMStorageProfile
                    'BusType'                    = ($storageControllers[($hardDisk.Parent.Value)]).BusType
                    'BusNumber'                  = ($storageControllers[($hardDisk.Parent.Value)]).BusNumber
                    'UnitNumber'                 = $hardDisk.AddressOnParent.Value
                }

                #Return the profile to the pipeline.
                Write-Output -InputObject $hardDiskProfile
            }
        }
    }
}
