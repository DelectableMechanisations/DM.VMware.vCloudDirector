---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Get-CIVMComputePolicy

## SYNOPSIS
This cmdlet retrieves the vCloud Director Compute Policy applied to a VM.

## SYNTAX

```
Get-CIVMComputePolicy [-CIVM] <Object[]> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves the vCloud Director Compute Policy applied to one or more VMs.

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
Get-CIVM -Name 'Server01' | Get-CIVMComputePolicy
```

Returns the Compute Policy applied to VM 'Server01'.

### EXAMPLE 2
```
$CIVM = Get-CIVM -Name 'Server01'
Get-CIVMComputePolicy -CIVM $CIVM
```

Returns the Compute Policy applied to VM 'Server01' (non-pipeline variation of the previous example).

### EXAMPLE 3
```
Get-CIVM Server01, Server02 | Get-CIVMComputePolicy | Format-Table -Property *
```

Returns the Compute Policy applied to VMs 'Server01' and 'Server02'.

## PARAMETERS

### -CIVM
Specifies the vCloud Director VM(s) you want to return Compute Policy for.

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

## RELATED LINKS
