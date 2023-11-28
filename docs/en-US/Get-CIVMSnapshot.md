---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Get-CIVMSnapshot

## SYNOPSIS
This cmdlet retrieves snapshot details of a vCloud Director VM.

## SYNTAX

```
Get-CIVMSnapshot [-CIVM] <Object[]> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves snapshot details of one or more vCloud Director VMs.

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
Get-CIVM -Name 'Server01' | Get-CIVMSnapshot
```

Returns the snapshot details for VM 'Server01'.

### EXAMPLE 2
```
$CIVM = Get-CIVM -Name 'Server01'
Get-CIVMSnapshot -CIVM $CIVM
```

Returns the snapshot details for VM 'Server01' (non-pipeline variation of the previous example).

### EXAMPLE 3
```
Get-CIVM Server01, Server02 | Get-CIVMSnapshot
```

Returns the snapshot details for VMs 'Server01' and 'Server02'.

## PARAMETERS

### -CIVM
Specifies the vCloud Director VM(s) you want to retrieve the snapshot for.

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
