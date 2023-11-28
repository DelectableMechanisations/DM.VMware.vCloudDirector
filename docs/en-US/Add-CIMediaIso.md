---
external help file: DM.VMware.vCloudDirector-help.xml
Module Name: DM.VMware.vCloudDirector
online version:
schema: 2.0.0
---

# Add-CIMediaIso

## SYNOPSIS
This function adds an ISO media file to a vCloud Director catalog.

## SYNTAX

```
Add-CIMediaIso [-Path] <String> [-CatalogName] <String> [[-Description] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function adds an ISO media file to a vCloud Director catalog.
Note: You must have the 'VMware.VimAutomation.Cloud' module installed and be connected to a vCloud Director organisation before running this command.

## EXAMPLES

### EXAMPLE 1
```
Add-CIMediaIso -Path 'C:\Temp\Windows2016Installer.iso' -CatalogName 'Christchurch Generic Catalog' -Description 'Official installation media for Windows Server 2016'
```

Uploads the 'C:\Temp\Windows2016Installer.iso' ISO media file to the vCloud Director catalog 'Christchurch Generic Catalog'.

### EXAMPLE 2
```
Connect-CIServer -Server vcloud.mycompany.co.nz -Org corp -Credential (Get-Credential)
Add-CIMediaIso -Path 'C:\Temp\Windows2016Installer.iso' -CatalogName 'Christchurch Generic Catalog' -Description 'Official installation media for Windows Server 2016'
```

Uploads the 'C:\Temp\Windows2016Installer.iso' ISO media file to the vCloud Director catalog 'Christchurch Generic Catalog'.

### EXAMPLE 3
```
oscdimg.exe -m -h -u1 -udfver102 "C:\Temp\IsoFileFolder" "C:\Temp\IsoFile.iso"
Add-CIMediaIso -Path 'C:\Temp\IsoFile.iso' -CatalogName 'Christchurch Generic Catalog'
```

Converts the "C:\Temp\IsoFileFolder" folder into the ISO file "C:\Temp\IsoFile.iso" then uploads this to the vCloud Director catalog 'Christchurch Generic Catalog'.
Note: ocsdimg.exe is a Microsoft command line tool part of Windows ADK for Windows 10 and can be downloaded from Microsoft's website.
After installing the ADK, the executable can be found here and can be copied to any location:
C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe

## PARAMETERS

### -Path
The path to the ISO media file that to upload to a vCloud Directory catalog.
This must have the extension '.iso' and be a valid path.

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

### -CatalogName
The name of the vCloud Director catalog that will store the ISO media file.
This must be a valid vCloud Director catalog name.

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

### -Description
The optional description to add to the ISO media once it has been uploaded to the vCloud Director catalog.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
Developed with help from the following documentation:
https://code.vmware.com/doc/preview?id=6899#/doc/GUID-4DAFB730-9C5B-406E-8348-E42B9036B49A.html

## RELATED LINKS
