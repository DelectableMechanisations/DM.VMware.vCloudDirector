---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Get-CINamedDisk

## SYNOPSIS
This cmdlet retrieves the Named Disks hosted in vCloud Director.

## SYNTAX

### ByDiskName (Default)
```
Get-CINamedDisk [-DiskName <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ByDiskHref
```
Get-CINamedDisk -DiskHref <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves the Named Disks hosted in vCloud Director, along with any VMs the disks are attached to.
Named Disks were previously referred to as Independent Disks and can be moved bewteen VMs.

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
Get-CINamedDisk
```

Returns all Named Disks.

### EXAMPLE 2
```
Get-CINamedDisk | Format-Table -Property *
```

Returns all Named Disks and displays them in a table format.

### EXAMPLE 3
```
Get-CINamedDisk -DiskName 'Named Disk Test'
```

Returns the Named Disk with the name 'Named Disk Test'.

### EXAMPLE 4
```
Get-CINamedDisk -DiskName '*test*'
```

Returns all Named Disks with a name matching the filter '*test*'.

### EXAMPLE 5
```
Get-CINamedDisk -DiskHref 'https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5'
```

Returns the Named Disk located at the URI 'https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5'.

## PARAMETERS

### -DiskName
Specifies the name of the Named Disk to search for.
This can either be an exact name or use a wildcard based filter.

The default value is '*' (i.e.
retrieve all Named Disks).

```yaml
Type: String
Parameter Sets: ByDiskName
Aliases:

Required: False
Position: Named
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -DiskHref
Specifies the precise Href (URI) of the Named Disk to retrieve.
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
https://developer.vmware.com/apis/1601/doc/operations/GET-Disk.html

## RELATED LINKS
