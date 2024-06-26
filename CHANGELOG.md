# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [1.1.2] - 2024-05-15
### Changed
- Bugfix an issue with Set-CIVMComputePolicy failing due to it processing multiple URLs instead of 1.

## [1.1.1] - 2024-01-11
### Changed
- Update type options output by Get-CIVMMetaData function to more accurately reflect the names used by the vCloud Director API.

## [1.1.0] - 2023-11-23
### Added
- Add new function Dismount-CINamedDisk
- Add new function Get-CINamedDisk
- Add new function Mount-CINamedDisk
- Add new function New-CINamedDisk
- Add new function Remove-CINamedDisk
- Add Convert-vCloudHrefToId function to convert a vCloud Director Href to an object ID.

### Changed
- Add support to Wait-vCloudDirectorTask for a wider array of vCloud Directory tasks using the TaskNode parameter.
- Replace the now deprecated 'x-vcloud-authorization' logon header with 'Authorization' in the Get-vCloudDirectorLogonHeaders function.
- Improve clarify of error messages output by Invoke-vCloudDirectorWebRequest function.

### Removed
- Remove Test-StringIsUri function as this is no longer used.

## [1.0.0] - 2021-08-11

### Added

- First commit
