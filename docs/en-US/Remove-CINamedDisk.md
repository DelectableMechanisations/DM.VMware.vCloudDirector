---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Remove-CINamedDisk

## SYNOPSIS
This cmdlet deletes a Named Disk from vCloud Director.

## SYNTAX

### ByDiskName (Default)
```
Remove-CINamedDisk -DiskName <String> [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ByDiskHref
```
Remove-CINamedDisk -DiskHref <String> [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet deletes a Named Disk from vCloud Director using either its name or Href.

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
Remove-CINamedDisk -DiskName Disk02
```

Deletes the Named Disk 'Disk02'.

### EXAMPLE 2
```
Remove-CINamedDisk -DiskHref 'https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5'
```

Deletes a Named Disk by referencing its Href location.

## PARAMETERS

### -DiskName
Specifies the name of the Named Disk to delete.
This can either be an exact name or use a wildcard based filter.

```yaml
Type: String
Parameter Sets: ByDiskName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DiskHref
Specifies the precise Href (URI) of the Named Disk to delete.
This should be in the following format:
https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5

```yaml
Type: String
Parameter Sets: ByDiskHref
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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
Built using vCloud Director documentation:
https://developer.vmware.com/apis/1601/doc/operations/DELETE-Disk.html

## RELATED LINKS
