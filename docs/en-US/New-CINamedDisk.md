---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# New-CINamedDisk

## SYNOPSIS
This cmdlet creates a new Named Disk in vCloud Director.

## SYNTAX

```
New-CINamedDisk [-DiskName] <String> [-OrgVdc] <Object> [[-DiskSizeGB] <Int32>] [[-DiskDescription] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet creates a new Named Disk in vCloud Director.
Named Disks were previously referred to as Independent Disks and can be moved bewteen VMs.

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
New-CINamedDisk -DiskName TestDisk -OrgVdc MyVdc
```

Creates a new Named Disk called 'TestDisk' in the OrgVdc 'MyVdc'.

### EXAMPLE 2
```
New-CINamedDisk -DiskName TestDisk -OrgVdc MyVdc -DiskSizeGB 20 -DiskDescription 'Test disk description'
```

Creates a new Named Disk called 'TestDisk' in the OrgVdc 'MyVdc' that is 20GB in size and has a description.

### EXAMPLE 3
```
New-CINamedDisk `
-DiskName        'TestDisk' `
-OrgVdc          'MyVdc' `
-DiskSizeGB      20 `
-DiskDescription 'Test disk description'
```

An alternative method of writing the PowerShell code used to create the Named Disk from the previous example.
Creates a new Named Disk called 'TestDisk' in the OrgVdc 'MyVdc' that is 20GB in size and has a description.

### EXAMPLE 4
```
$vm = Get-CIVM TestVM
$disk = New-CINamedDisk -DiskName TestDisk2 -OrgVdc $vm.OrgVdc
Mount-CINamedDisk -DiskHref $disk.Href -VMHref $vm.Href
```

Find a VM called 'TestVM', create a new Named Disk called 'TestDisk2' in the same OrgVdc and attach it to the VM.

## PARAMETERS

### -DiskName
Specifies the name of the Named Disk to create.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OrgVdc
Specifies the OrgVdc to create the Named Disk in.
This can be passed through as output from the Get-OrgVdc cmdlet or reference the name of the OrgVdc.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DiskSizeGB
Specifies the size of the Named Disk to create in GB.
Defaults to 10 GB.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -DiskDescription
Specifies the optional description to add to the Named Disk.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
https://developer.vmware.com/apis/1601/doc/operations/POST-CreateDisk.html

## RELATED LINKS
