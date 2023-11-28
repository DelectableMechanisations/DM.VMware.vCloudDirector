---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Get-CIVMHardDisk

## SYNOPSIS
This cmdlet retrieves the virtual hard disks available on a vCloud Director system.

## SYNTAX

```
Get-CIVMHardDisk [-CIVM] <Object[]> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves the virtual hard disks available on a vCloud Director system and returns (roughly) the same properties displayed in the vCloud Director Web Portal.
It only supports the retrieval of SCSI and SATA based virtual hard disks (it will not work for IDE drives).

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
Get-CIVM Server01 | Get-CIVMHardDisk
```

Returns all Hard Disks attached to the VM 'Server01'

### EXAMPLE 2
```
Get-CIVMHardDisk -CIVM (Get-CIVM Server01)
```

Returns all Hard Disks attached to the VM 'Server01' (non-pipeline variation of the previous example).

### EXAMPLE 3
```
Get-CIVM Server01, Server02 | Get-CIVMHardDisk | Format-Table -Property *
```

Returns all Hard Disks attached to the VMs 'Server01' & 'Server02' and displays them in tabular format.

## PARAMETERS

### -CIVM
Specifies the virtual machine you want to retrieve the virtual hard disks for.

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
Derived from Alan Renouf (VMware): http://blogs.vmware.com/PowerCLI/2013/03/retrieving-vcloud-director-vm-hard-disk-size.html

## RELATED LINKS
