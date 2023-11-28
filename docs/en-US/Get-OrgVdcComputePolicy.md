---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Get-OrgVdcComputePolicy

## SYNOPSIS
This cmdlet retrieves a list of vCloud Director Compute Policies.

## SYNTAX

```
Get-OrgVdcComputePolicy [-OrgVdc] <Object[]> [-Name <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves a list of vCloud Director Compute Policies configured against one or more vDCs.

You must have an existing vCloud session (Connect-CIServer) for this function to work.

## EXAMPLES

### EXAMPLE 1
```
Get-OrgVdc | Where-Object {$_.name -eq 'MyVdc'} | Get-OrgVdcComputePolicy
```

Returns the Compute Policies available for the OrgVdc 'MyVdc'

### EXAMPLE 2
```
$OrgVdc = Get-OrgVdc | Where-Object {$_.name -eq 'MyVdc'}
Get-OrgVdcComputePolicy -OrgVdc $OrgVdc
```

Returns the Compute Policies available for the OrgVdc 'MyVdc' (non-pipeline variation of the previous example).

### EXAMPLE 3
```
Get-OrgVdc | Get-OrgVdcComputePolicy | Format-Table -Property *
```

Returns all Compute Policies in all Vdcs.

## PARAMETERS

### -OrgVdc
Specifies the vCloud Director VDC(s) you want to retrieve the Compute Policies for.

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
The name of the vCloud Director Compute Policy to filter on.
The default value is '*'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: *
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
