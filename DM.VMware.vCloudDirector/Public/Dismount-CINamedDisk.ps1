<#
    .SYNOPSIS
       This cmdlet detaches a Named Disk from a VM hosted in vCloud Director.

    .DESCRIPTION
       This cmdlet detaches a Named Disk hosted from a VM in vCloud Director using both the Href of the Named Disk and the Href of the VM.

       You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
        $Disk = Get-CINamedDisk -DiskName Disk01
        $VM   = Get-CIVM $Disk.AttachedTo
        Dismount-CINamedDisk -DiskHref $Disk.Href -VMHref $VM.Href

        This command finds the Named Disk 'Disk01', along with the VM it is currently attached to.
        It then detaches the Named Disk from this VM.

    .EXAMPLE
        Dismount-CINamedDisk `
        -DiskHref 'https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5' `
        -VMHref   'https://vcloud.example.com/api/vApp/vm-89c84bd6-c6f2-4e4c-8a7d-c44a3489e2e4'

        Detaches a Named Disk from a VM by referencing their respective Href locations.

    .PARAMETER DiskHref
        Specifies the precise Href (URI) of the Named Disk to detach.
        This should be in the following format:
        https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5

    .PARAMETER VMHref
        Specifies the precise Href (URI) of the VM to detach the Named Disk from.
        This should be in the following format:
        https://vcloud.example.com/api/vApp/vm-89c84bd6-c6f2-4e4c-8a7d-c44a3489e2e4

    .NOTES
        Built using vCloud Director documentation:
        https://developer.vmware.com/apis/1601/doc/operations/POST-DetachDisk.html
#>
Function Dismount-CINamedDisk {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [System.String]
        $DiskHref,

        [Parameter(Mandatory)]
        [System.String]
        $VMHref
    )

    Begin {
        #Create authorisation headers used to connect to vCloud Director
        $headers = Get-vCloudDirectorLogonHeaders
    }

    Process {
        try {
            #Find the Named Disk and VM associated with the input parameters.
            $ciNamedDisk = Get-CINamedDisk -DiskHref $DiskHref
            $ciVM        = Get-CIVM -Id (Convert-vCloudHrefToId -Href $VMHref)

            #Build the XML used to detach the disk.
            $diskAttachOrDetachParamsXml = @"
<?xml version="1.0" encoding="UTF-8"?>
<DiskAttachOrDetachParams xmlns="http://www.vmware.com/vcloud/v1.5">
    <Disk
        href="$DiskHref"
        type="application/vnd.vmware.vcloud.disk+xml"
    />
</DiskAttachOrDetachParams>
"@

            $headers['Content-Type']   = 'application/vnd.vmware.vcloud.diskAttachOrDetachParams+xml'
            $headers['Content-Length'] = $diskdetachOrDetachParamsXml.Length

            #Detach the Named Disk from the VM.
            Write-Verbose -Message "Detaching Named Disk '$($ciNamedDisk.Name)' from VM '$($ciVM.Name)'."
            $vCloudTask = Invoke-vCloudDirectorWebRequest -Uri "$VMHref/disk/action/detach" -Headers $headers -Method Post -Body $diskAttachOrDetachParamsXml

            #Wait for the task to complete.
            Wait-vCloudDirectorTask -Task $vCloudTask -Headers $headers -TaskDescription "Detaching Named Disk '$($ciNamedDisk.Name)' from VM '$($ciVM.Name)'."

        } catch {
            Write-Error $_.Exception.Message
        }
    }
}
