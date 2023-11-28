<#
    .SYNOPSIS
       This cmdlet attaches a Named Disk to a VM hosted in vCloud Director.

    .DESCRIPTION
       This cmdlet attaches a Named Disk hosted to a VM in vCloud Director using both the Href of the Named Disk and the Href of the VM.

       You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
        $Disk = Get-CINamedDisk -DiskName Disk01
        $VM   = Get-CIVM SERVER01
        Mount-CINamedDisk -DiskHref $Disk.Href -VMHref $VM.Href

        Attaches the Named Disk 'Disk01' to the VM 'SERVER01' using separate commands to reference each object by their name first and then using their Href property in the proceeding Mount-CINamedDisk command.

    .EXAMPLE
        Mount-CINamedDisk `
        -DiskHref 'https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5' `
        -VMHref   'https://vcloud.example.com/api/vApp/vm-89c84bd6-c6f2-4e4c-8a7d-c44a3489e2e4'

        Attaches a Named Disk to a VM by referencing their respective Href locations.

    .PARAMETER DiskHref
        Specifies the precise Href (URI) of the Named Disk to attach.
        This should be in the following format:
        https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5

    .PARAMETER VMHref
        Specifies the precise Href (URI) of the VM to attach the Named Disk to.
        This should be in the following format:
        https://vcloud.example.com/api/vApp/vm-89c84bd6-c6f2-4e4c-8a7d-c44a3489e2e4

    .NOTES
        Built using vCloud Director documentation:
        https://developer.vmware.com/apis/1601/doc/operations/POST-AttachDisk.html
#>
Function Mount-CINamedDisk {
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

            #Build the XML used to attach the disk.
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
            $headers['Content-Length'] = $diskAttachOrDetachParamsXml.Length

            #Attach the Named Disk to the VM.
            Write-Verbose -Message "Attaching Named Disk '$($ciNamedDisk.Name)' to VM '$($ciVM.Name)'."
            $vCloudTask = Invoke-vCloudDirectorWebRequest -Uri "$VMHref/disk/action/attach" -Headers $headers -Method Post -Body $diskAttachOrDetachParamsXml

            #Wait for the task to complete.
            Wait-vCloudDirectorTask -Task $vCloudTask -Headers $headers -TaskDescription "Attaching Named Disk '$($ciNamedDisk.Name)' to VM '$($ciVM.Name)'."

        } catch {
            Write-Error $_.Exception.Message
        }
    }
}
