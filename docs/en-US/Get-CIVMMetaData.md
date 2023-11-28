---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Get-CIVMMetaData

## SYNOPSIS
This cmdlet retrieves the metadata specified on a vCloud Director virtual machine.

## SYNTAX

```
Get-CIVMMetaData [-CIVM] <Object[]> [-Name <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves the metadata specified on a vCloud Director virtual machine, including its name, its type and its value.

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
Get-CIVM Server01 | Get-CIVMMetaData
```

Returns all metadata configured on the VM 'Server01'

### EXAMPLE 2
```
Get-CIVMMetaData -CIVM (Get-CIVM Server01)
```

Returns all metadata configured on the VM 'Server01' (non-pipeline variation of the previous example).

### EXAMPLE 3
```
Get-CIVM Server01, Server02 | Get-CIVMMetaData | Format-Table -Property *
```

Returns all metadata configured on the the VMs 'Server01' & 'Server02' and displays them in tabular format.

### EXAMPLE 4
```
Get-CIVM Server01 | Get-CIVMMetaData -Name ServiceOwner
```

Returns metadata with the name 'ServiceOwner' configured on the VM 'Server01'

### EXAMPLE 5
```
Get-CIVM Server01 | Get-CIVMMetaData -Name *Service*
```

Returns metadata with a name like '*Service*' configured on the VM 'Server01'

## PARAMETERS

### -CIVM
Specifies the virtual machine you want to retrieve the virtual metadata for.

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

### -Name
Specifies the name of the metadata field you want to retrieve.
Do not specify this parameter to return all metadata.
Accepts wildcard character *.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

## RELATED LINKS
