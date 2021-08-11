<#
    .SYNOPSIS
    This cmdlet retrieves the metadata specified on a vCloud Director virtual machine.

    .DESCRIPTION
    This cmdlet retrieves the metadata specified on a vCloud Director virtual machine, including its name, its type and its value.

    You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
    Get-CIVM Server01 | Get-CIVMMetaData

    Returns all metadata configured on the VM 'Server01'

    .EXAMPLE
    Get-CIVMMetaData -CIVM (Get-CIVM Server01)

    Returns all metadata configured on the VM 'Server01' (non-pipeline variation of the previous example).

    .EXAMPLE
    Get-CIVM Server01, Server02 | Get-CIVMMetaData | Format-Table -Property *

    Returns all metadata configured on the the VMs 'Server01' & 'Server02' and displays them in tabular format.

    .EXAMPLE
    Get-CIVM Server01 | Get-CIVMMetaData -Name ServiceOwner

    Returns metadata with the name 'ServiceOwner' configured on the VM 'Server01'

    .EXAMPLE
    Get-CIVM Server01 | Get-CIVMMetaData -Name *Service*

    Returns metadata with a name like '*Service*' configured on the VM 'Server01'

    .PARAMETER CIVM
        Specifies the virtual machine you want to retrieve the virtual metadata for.

    .PARAMETER Name
        Specifies the name of the metadata field you want to retrieve. Do not specify this parameter to return all metadata.
        Accepts wildcard character *.
#>
Function Get-CIVMMetaData {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline = $True)]
        [System.Object[]]
        $CIVM,

        [System.String]
        $Name
    )

    Begin {
        $metadataType = @{
            'VMware.VimAutomation.Cloud.Views.MetadataNumberValue'   = 'Number'
            'VMware.VimAutomation.Cloud.Views.MetadataBooleanValue'  = 'YesAndNo'
            'VMware.VimAutomation.Cloud.Views.MetadataDateTimeValue' = 'DateTime'
            'VMware.VimAutomation.Cloud.Views.MetadataStringValue'   = 'Text'
        }
    }

    Process {
        foreach ($vm in $CIVM) {
            Write-Verbose -Message "Getting Metadata for '$($vm.Name)'."


            $vmMetadata = $vm.ExtensionData.GetMetadata()
            $vmMetadataEntries = $vmMetadata.MetadataEntry

            if ($vmMetadataEntries.Count -ge 1) {
                foreach ($vmMetadataEntry in $vmMetadataEntries) {
                    $vmMetadataEntryProfile = [pscustomobject]@{
                        VMName = $vm.Name
                        Name   = $vmMetadataEntry.Key
                        Type   = $metadataType[($vmMetadataEntry.TypedValue.ToString())]
                        Value  = $vmMetadataEntry.TypedValue.Value
                    }

                    #If the '-Name' parameter has been specified then only return metadata matching that value.
                    if ($PSBoundParameters.ContainsKey('Name')) {
                        if ($vmMetadataEntryProfile.Name -like $Name) {
                            Write-Output -InputObject $vmMetadataEntryProfile

                        } else {
                            Write-Debug -Message "Metadata with name '$($vmMetadataEntryProfile.Name)' is not like '$Name' and so will not be returned."
                        }

                    #If the '-Name' parameter has not been specified then return all metadata.
                    } else {
                        Write-Output -InputObject $vmMetadataEntryProfile
                    }
                }
            } else {
                Write-Verbose -Message "No Metadata specified on '$($vm.Name)'."
            }
        }
    }
}
