

<#
    .SYNOPSIS
        This cmdlet changes the vCloud Director Compute Policy applied to a VM.

    .DESCRIPTION
        This cmdlet changes the vCloud Director Compute Policy applied to one or more VMs.

        You must have an existing vCloud session (Connect-CIServer) for this function to work.

    .EXAMPLE
        $OrgVdc = Get-OrgVdc | Where-Object {$_.name -eq 'MyVdc'}
        $ComputePolicy = Get-OrgVdcComputePolicy -OrgVdc $OrgVdc -Name 'MyComputePolicy'

        Get-CIVM -Name 'Server01' | Set-CIVMComputePolicy -ComputePolicy $ComputePolicy

        Changes the Compute Policy applied to VM 'Server01'.

    .EXAMPLE
        $CIVM = Get-CIVM -Name 'Server01'
        Get-CIVMComputePolicy -CIVM $CIVM

        $OrgVdc = Get-OrgVdc | Where-Object {$_.name -eq 'MyVdc'}
        $ComputePolicy = Get-OrgVdcComputePolicy -OrgVdc $OrgVdc -Name 'MyComputePolicy'
        $CIVM = Get-CIVM -Name 'Server01'

        Set-CIVMComputePolicy -CIVM $CIVM -ComputePolicy $ComputePolicy

        Changes the Compute Policy applied to VM 'Server01' (non-pipeline variation of the previous example).

    .EXAMPLE
        $OrgVdc = Get-OrgVdc | Where-Object {$_.name -eq 'MyVdc'}
        $ComputePolicy = Get-OrgVdcComputePolicy -OrgVdc $OrgVdc -Name 'MyComputePolicy'

        Get-CIVM Server01, Server02 | Set-CIVMComputePolicy -ComputePolicy $ComputePolicy

        Changes the Compute Policy applied to VMs 'Server01' and 'Server02'.

    .PARAMETER CIVM
        Specifies the vCloud Director VM(s) to change the Compute Policy.

    .PARAMETER ComputePolicy
        Specifies the vCloud Director Compute Policy to add VM(s) to.
        This parameter must be passed as an object with the properties 'href','id','name','type' present.
        See the Examples section for more information.

    .NOTES
        vCloud Director documentation:
        https://vdc-download.vmware.com/vmwb-repository/dcr-public/0e2c37c4-878b-4c83-b690-6f78b13a177a/d8b0a3a5-175b-4e26-8511-f12aa57970e6/vmware_cloud_director_sp_api_guide_34_0.pdf
#>
Function Set-CIVMComputePolicy {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline = $True)]
        [System.Object[]]
        $CIVM,

        [Parameter(Mandatory)]
        [ValidateScript({
            #Confirm the -ComputePolicy parameter has the properties 'href','id','name','type' assigned to it.
            $requiredProperties = @('href','id','name','type')

            $parameterProperties = Get-Member -InputObject $_ -MemberType NoteProperty | Select-Object -ExpandProperty Name
            $missingProperties = Compare-Object -ReferenceObject $requiredProperties -DifferenceObject $parameterProperties -ErrorAction SilentlyContinue | Where-Object {$_.SideIndicator -eq '<='}

            if (-not ($missingProperties)) {
                $true
            } else {
                $missingProperties | ForEach-Object {
                    throw [System.Management.Automation.ValidationMetadataException] "Property: '$($_.InputObject)' missing"
                }
            }
        })]
        [System.Object]
        $ComputePolicy
    )

    Begin {
        #Create authorisation headers used to connect to vCloud Director
        $headers = Get-vCloudDirectorLogonHeaders
    }

    Process {
        foreach ($vm in $CIVM) {
            #Retrieve the vCloud representation of the VM.
            $vCloudVM = Invoke-vCloudDirectorWebRequest -Headers $headers -Method Get -Uri $vm.Href

            #Update the VdcComputePolicy to reference the new compute policy.
            $vCloudVM.Vm.VdcComputePolicy.href = $ComputePolicy.href
            $vCloudVM.Vm.VdcComputePolicy.id   = $ComputePolicy.id
            $vCloudVM.Vm.VdcComputePolicy.name = $ComputePolicy.name
            $vCloudVM.Vm.VdcComputePolicy.type = $ComputePolicy.type

            #Retrieve the URL used to make the change
            $reconfigureVmLink = $vm.ExtensionData.Link | Where-Object {$_.Rel -eq 'reconfigureVm'}

            #Update the Compute Policy for the VM.
            Write-Verbose -Message "Updating vDC Compute Policy on '$($vm.Name)' from '$($vm.ExtensionData.VdcComputePolicy.Name)' to $($ComputePolicy.name)."
            $vCloudTask = Invoke-vCloudDirectorWebRequest -Headers $headers -Method Post -Uri $reconfigureVmLink.Href -Body $vCloudVM.Vm -ContentType $reconfigureVmLink.Type

            #Wait for the task to complete.
            Wait-vCloudDirectorTask -Task $vCloudTask -Headers $headers -TaskDescription 'Updating VM Compute Policy'
        }
    }
}
