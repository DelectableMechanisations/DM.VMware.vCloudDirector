---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Set-CIVMComputePolicy

## SYNOPSIS
This cmdlet changes the vCloud Director Compute Policy applied to a VM.

## SYNTAX

```
Set-CIVMComputePolicy [-CIVM] <Object[]> -ComputePolicy <Object> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet changes the vCloud Director Compute Policy applied to one or more VMs.

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
$OrgVdc = Get-OrgVdc | Where-Object {$_.name -eq 'MyVdc'}
$ComputePolicy = Get-OrgVdcComputePolicy -OrgVdc $OrgVdc -Name 'MyComputePolicy'
```

Get-CIVM -Name 'Server01' | Set-CIVMComputePolicy -ComputePolicy $ComputePolicy

Changes the Compute Policy applied to VM 'Server01'.

### EXAMPLE 2
```
$CIVM = Get-CIVM -Name 'Server01'
Get-CIVMComputePolicy -CIVM $CIVM
```

$OrgVdc = Get-OrgVdc | Where-Object {$_.name -eq 'MyVdc'}
$ComputePolicy = Get-OrgVdcComputePolicy -OrgVdc $OrgVdc -Name 'MyComputePolicy'
$CIVM = Get-CIVM -Name 'Server01'

Set-CIVMComputePolicy -CIVM $CIVM -ComputePolicy $ComputePolicy

Changes the Compute Policy applied to VM 'Server01' (non-pipeline variation of the previous example).

### EXAMPLE 3
```
$OrgVdc = Get-OrgVdc | Where-Object {$_.name -eq 'MyVdc'}
$ComputePolicy = Get-OrgVdcComputePolicy -OrgVdc $OrgVdc -Name 'MyComputePolicy'
```

Get-CIVM Server01, Server02 | Set-CIVMComputePolicy -ComputePolicy $ComputePolicy

Changes the Compute Policy applied to VMs 'Server01' and 'Server02'.

## PARAMETERS

### -CIVM
Specifies the vCloud Director VM(s) to change the Compute Policy.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ComputePolicy
Specifies the vCloud Director Compute Policy to add VM(s) to.
This parameter must be passed as an object with the properties 'href','id','name','type' present.
See the Examples section for more information.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
vCloud Director documentation:
https://vdc-download.vmware.com/vmwb-repository/dcr-public/0e2c37c4-878b-4c83-b690-6f78b13a177a/d8b0a3a5-175b-4e26-8511-f12aa57970e6/vmware_cloud_director_sp_api_guide_34_0.pdf

## RELATED LINKS
