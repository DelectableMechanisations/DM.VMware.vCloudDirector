---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Mount-CINamedDisk

## SYNOPSIS
This cmdlet attaches a Named Disk to a VM hosted in vCloud Director.

## SYNTAX

```
Mount-CINamedDisk [-DiskHref] <String> [-VMHref] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet attaches a Named Disk hosted to a VM in vCloud Director using both the Href of the Named Disk and the Href of the VM.

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
$Disk = Get-CINamedDisk -DiskName Disk01
$VM   = Get-CIVM SERVER01
Mount-CINamedDisk -DiskHref $Disk.Href -VMHref $VM.Href
```

Attaches the Named Disk 'Disk01' to the VM 'SERVER01' using separate commands to reference each object by their name first and then using their Href property in the proceeding Mount-CINamedDisk command.

### EXAMPLE 2
```
Mount-CINamedDisk `
-DiskHref 'https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5' `
-VMHref   'https://vcloud.example.com/api/vApp/vm-89c84bd6-c6f2-4e4c-8a7d-c44a3489e2e4'
```

Attaches a Named Disk to a VM by referencing their respective Href locations.

## PARAMETERS

### -DiskHref
Specifies the precise Href (URI) of the Named Disk to attach.
This should be in the following format:
https://vcloud.example.com/api/disk/a4752497-5f83-4a44-b96e-3fedd729e1c5

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

### -VMHref
Specifies the precise Href (URI) of the VM to attach the Named Disk to.
This should be in the following format:
https://vcloud.example.com/api/vApp/vm-89c84bd6-c6f2-4e4c-8a7d-c44a3489e2e4

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
https://developer.vmware.com/apis/1601/doc/operations/POST-AttachDisk.html

## RELATED LINKS
