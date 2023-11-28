---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Get-CIVMCpu

## SYNOPSIS
This cmdlet retrieves the full CPU details on a vCloud Director VM.

## SYNTAX

```
Get-CIVMCpu [-CIVM] <Object[]> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves the CPU details available on a vCloud Director VM and returns the TotalSockets and CoresPerSocket properties.

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
Get-CIVM Server01 | Get-CIVMCpu
```

Returns the CPU details for the VM 'Server01'

### EXAMPLE 2
```
Get-CIVMCpu -CIVM (Get-CIVM Server01)
```

Returns the CPU details for the VM 'Server01' (non-pipeline variation of the previous example).

### EXAMPLE 3
```
Get-CIVM Server01, Server02 | Get-CIVMCpu | Format-Table -Property *
```

Returns the CPU details for the VMs 'Server01' & 'Server02' and displays them in tabular format.

## PARAMETERS

### -CIVM
Specifies the virtual machine you want to retrieve the CPU details for.

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
