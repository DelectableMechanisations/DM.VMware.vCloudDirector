---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Get-CIVMOrgVdc

## SYNOPSIS
This cmdlet retrieves the vCloud Director vDC the VM is part of.

## SYNTAX

```
Get-CIVMOrgVdc [-CIVM] <Object[]> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves the vCloud Director vDC that the VM is part of.
After vCloud Director was updated to version 10 the 'OrgvDC' property is blank when the Get-CIVM command is executed.
This function was written as a workaround to map the VM back to its parent vDC in an easy to use way.

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
Get-CIVM -Name 'Server01' | Get-CIVMOrgVdc
```

Returns the vDC that the VM 'Server01' is part of.

### EXAMPLE 2
```
$CIVM = Get-CIVM -Name 'Server01'
Get-CIVMOrgVdc -CIVM $CIVM
```

Returns the vDC that the VM 'Server01' is part of (non-pipeline variation of the previous example).

### EXAMPLE 3
```
Get-CIVM Server01, Server02 | Get-CIVMOrgVdc | Format-Table -Property *
```

Returns the vDC that the VMs 'Server01' and 'Server02' are part of.

## PARAMETERS

### -CIVM
Specifies the vCloud Director VM(s) you want to return the vDC for.

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
