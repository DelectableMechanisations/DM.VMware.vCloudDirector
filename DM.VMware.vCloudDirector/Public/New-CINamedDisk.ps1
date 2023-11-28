<#
    .SYNOPSIS
        This cmdlet creates a new Named Disk in vCloud Director.

    .DESCRIPTION
        This cmdlet creates a new Named Disk in vCloud Director.
        Named Disks were previously referred to as Independent Disks and can be moved bewteen VMs.

        You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
        New-CINamedDisk -DiskName TestDisk -OrgVdc MyVdc

        Creates a new Named Disk called 'TestDisk' in the OrgVdc 'MyVdc'.

    .EXAMPLE
        New-CINamedDisk -DiskName TestDisk -OrgVdc MyVdc -DiskSizeGB 20 -DiskDescription 'Test disk description'

        Creates a new Named Disk called 'TestDisk' in the OrgVdc 'MyVdc' that is 20GB in size and has a description.

    .EXAMPLE
        New-CINamedDisk `
        -DiskName        'TestDisk' `
        -OrgVdc          'MyVdc' `
        -DiskSizeGB      20 `
        -DiskDescription 'Test disk description'

        An alternative method of writing the PowerShell code used to create the Named Disk from the previous example.
        Creates a new Named Disk called 'TestDisk' in the OrgVdc 'MyVdc' that is 20GB in size and has a description.

    .EXAMPLE
        $vm = Get-CIVM TestVM
        $disk = New-CINamedDisk -DiskName TestDisk2 -OrgVdc $vm.OrgVdc
        Mount-CINamedDisk -DiskHref $disk.Href -VMHref $vm.Href

        Find a VM called 'TestVM', create a new Named Disk called 'TestDisk2' in the same OrgVdc and attach it to the VM.

    .PARAMETER DiskName
        Specifies the name of the Named Disk to create.

    .PARAMETER OrgVdc
        Specifies the OrgVdc to create the Named Disk in.
        This can be passed through as output from the Get-OrgVdc cmdlet or reference the name of the OrgVdc.

    .PARAMETER DiskSizeGB
        Specifies the size of the Named Disk to create in GB.
        Defaults to 10 GB.

    .PARAMETER DiskDescription
        Specifies the optional description to add to the Named Disk.

    .NOTES
        Built using vCloud Director documentation:
        https://developer.vmware.com/apis/1601/doc/operations/POST-CreateDisk.html
#>
Function New-CINamedDisk {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [System.String]
        $DiskName,

        [Parameter(Mandatory)]
        [System.Object]
        $OrgVdc,

        [System.Int32]
        $DiskSizeGB = 10,

        [System.String]
        $DiskDescription
    )

    Begin {
        #Create authorisation headers used to connect to vCloud Director
        $headers = Get-vCloudDirectorLogonHeaders
    }

    Process {
        #Confirm the value specified in the -OrgVdc parameter is correct.
        $orgVdcCheck = @(Get-OrgVdc $OrgVdc -ErrorAction SilentlyContinue)
        if ($orgVdcCheck.Count -eq 1) {
            $vdcNamedDiskReferenceLink = $orgVdcCheck.ExtensionData.Link | Where-Object {$_.Type -eq 'application/vnd.vmware.vcloud.diskCreateParams+xml'}

        } elseif ($orgVdcCheck.Count -eq 0) {
            throw "Cannot validate argument on parameter 'OrgVdc'. Value '$OrgVdc' is not a valid OrgVdc."

        } elseif ($orgVdcCheck.Count -gt 1) {
            throw "Cannot validate argument on parameter 'OrgVdc'. Value '$OrgVdc' resolves to more than one OrgVdc."
        }

        #Build the XML code used to create the new disk.
        $diskXml = @"
<?xml version="1.0" encoding="UTF-8"?>
<DiskCreateParams xmlns="http://www.vmware.com/vcloud/v1.5">
    <Disk
        name="$DiskName"
        busSubType="lsilogicsas"
        busType="6"
        sizeMb="$($DiskSizeGB * 1024)">
        <Description>$DiskDescription</Description>
    </Disk>
</DiskCreateParams>
"@

        $headers['Content-Type']   = 'application/vnd.vmware.vcloud.diskCreateParams+xml'
        $headers['Content-Length'] = $diskXml.Length

        #Create the Named Disk.
        Write-Verbose -Message "Creating Named Disk '$DiskName' in VDC '$($orgVdcCheck.Name)'."
        $vCloudTask = Invoke-vCloudDirectorWebRequest -Uri $vdcNamedDiskReferenceLink.Href -Headers $headers -Method Post -Body $diskXml

        #Wait for the task to complete.
        Wait-vCloudDirectorTask -TaskNode $vCloudTask.Disk.Tasks -Headers $headers -TaskDescription "Creating Named Disk with name '$DiskName'."

        #Return the details of the recently created disk.
        Get-CINamedDisk -DiskHref $vCloudTask.Disk.href
    }
}
