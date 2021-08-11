# DM.VMware.vCloudDirector

Contains functions used to manage a VMware vCloud Director tenant and is designed to supplement VMware's VMware.VimAutomation.Cloud module.
All functions have been designed for use by an Organisation Administrator and so vCloud Administrator permissions are not required.

## Installation

As of May 2021 this module has not been published to the PowerShell Gallery yet so the module needs to be manually imported.

1. Install VMware's vCloud Director module.

   ```powershell
   Install-Module VMware.VimAutomation.Cloud
   ```

2. Download the latest release of this module and import into your preferred module path (pick one):
   ```
   %ProgramFiles%\PowerShell\Modules
   %UserProfile%\Documents\PowerShell\Modules
   ```

## Examples

Note: Before using any of these examples you'll need to connect to your vCloud Director organisation:

```powershell
Connect-CIServer -Server vcloud.mycompany.co.nz -Org corp -Credential (Get-Credential)
```

### Example 1

Uploads the 'C:\Temp\Windows2016Installer.iso' ISO media file to the vCloud Director catalog 'Christchurch Generic Catalog'.

```powershell
Add-CIMediaIso -Path 'C:\Temp\Windows2016Installer.iso' -CatalogName 'Christchurch Generic Catalog' -Description 'Official installation media for Windows Server 2016'
```

### Example 2

Returns the Compute Policy applied to VM 'SQL01'.

```powershell
Get-CIVM SQL01 | Get-CIVMComputePolicy | Format-Table -Property *
```
```
VMName      name       id                                  href
------      ----       --                                  ----
SQL01       cp-SQL     urn:vcloud:vdcComputePolicy:0000    https://<url>
```

### Example 3

Queries each VM for the Compute Policy applied and exports to a CSV file on the desktop.

```powershell
$filePath = "$([System.Environment]::GetFolderPath('Desktop'))\VM Compute Policies.csv"
Get-CIVM | Get-CIVMComputePolicy | Export-Csv -Path $filePath -NoTypeInformation
```

### Example 4

Returns the CPU details for the VM 'Server01'

```powershell
Get-CIVM Server01 | Get-CIVMCpu
```
```
Name            : Server01
AllocationUnits : hertz * 10^6
TotalSockets    : 4
CoresPerSocket  : 1
TotalCores      : 4
```

### Example 5

Returns all Hard Disks attached to the VM 'Server01'

```powershell
Get-CIVM Server01 | Get-CIVMHardDisk | Format-Table -Property *
```
```
VMName   DiskName     CapacityGB StorageProfile BusType              BusNumber UnitNumber
------   --------     ---------- -------------- -------              --------- ----------
Server01 Hard disk 1         100 SP-Fast        LSI Logic SAS (SCSI) 0         0
Server01 Hard disk 2          50 SP-Slow        LSI Logic SAS (SCSI) 0         1
Server01 Hard disk 3         600 SP-Fast        LSI Logic SAS (SCSI) 0         2
Server01 Hard disk 4        1500 SP-Fast        LSI Logic SAS (SCSI) 0         3
Server01 Hard disk 5         580 SP-Fast        Paravirtual (SCSI)   1         0
Server01 Hard disk 6        1880 SP-Slow        Paravirtual (SCSI)   1         1
```

### Example 6

Measures the total size of disks attached to all VMs with "*sql*" in the name.

```powershell
Get-CIVM *sql* | Get-CIVMHardDisk | Measure-Object -Property CapacityGB -Sum
```
```
Count             : 12
Average           :
Sum               : 15860
Maximum           :
Minimum           :
StandardDeviation :
Property          : CapacityGB
```

### Example 7

Returns all metadata configured on the VM 'Server01'

```powershell
Get-CIVM Server01 | Get-CIVMMetaData
```
```
VMName   Name                    Type     Value
------   ----                    ----     -----
Server01 Installation Date       DateTime 04/12/2020 1:00:00 pm
Server01 Service                 Text     FileServer
Server01 SnapshotBackup          YesAndNo False
Server01 Installation CR         Number   123456
```

### Example 8

Returns the snapshot details for VM 'Server01'.

```powershell
Get-CIVM -Name 'Server01' | Get-CIVMSnapshot
```
```
VMName     DateCreated           SizeGB
------     -----------           ------
Server01   24/05/2021 5:56:16 pm    100
```

### Example 9

Returns all Compute Policies in all Vdcs.

```powershell
Get-OrgVdc | Get-OrgVdcComputePolicy | Format-Table -Property *
```
```
OrgVdcName           name             id                                href
----------           ----             --                                ----
Auckland VDC         System Default   urn:vcloud:vdcComputePolicy:0000  https://<url>
Christchurch VDC     System Default   urn:vcloud:vdcComputePolicy:0001  https://<url>
Christchurch VDC     cp-SQL           urn:vcloud:vdcComputePolicy:0002  https://<url>
Christchurch VDC     cp-Oracle        urn:vcloud:vdcComputePolicy:0003  https://<url>
```

### Example 10

Changes the Compute Policy applied to VM 'SQL01'.

```powershell
$OrgVdc = Get-OrgVdc -Name 'Christchurch VDC'
$ComputePolicy = Get-OrgVdcComputePolicy -OrgVdc $OrgVdc -Name 'cp-SQL'

Get-CIVM -Name 'SQL01' | Set-CIVMComputePolicy -ComputePolicy $ComputePolicy
```

### Example 11

Changes the Compute Policy applied to all VMs with '*SQL*' in the name.

```powershell
$OrgVdc = Get-OrgVdc -Name 'Christchurch VDC'
$ComputePolicy = Get-OrgVdcComputePolicy -OrgVdc $OrgVdc -Name 'cp-SQL'

Get-CIVM -Name '*sql*' | Set-CIVMComputePolicy -ComputePolicy $ComputePolicy
```

## Build
This module is built using version 0.4.0 of the Plaster template Stucco <https://github.com/devblackops/Stucco>

To do a manual build of the module:
1. Clone the repo to your local machine.
2. Browse to the repo root using PowerShell 7+
3. Run the build.ps1 script:
   ```powershell
   .\build.ps1 -Bootstrap
   ```
   Note: You only need to use the '-BootStrap' parameter the first time round to download the module dependencies. For subsequent runs this parameter can be omitted.
4. The build.ps1 script will call psakeFile.ps1, perform the build of the module and output it to the .\Output directory.
