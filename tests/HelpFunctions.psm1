<#
    This module contains functions used by Help.Tests.ps1
#>
function FilterOutCommonParams {
    param ($Params)
    $commonParams = @(
        'Debug', 'ErrorAction', 'ErrorVariable', 'InformationAction', 'InformationVariable',
        'OutBuffer', 'OutVariable', 'PipelineVariable', 'Verbose', 'WarningAction',
        'WarningVariable', 'Confirm', 'Whatif'
    )
    $params | Where-Object { $_.Name -notin $commonParams } | Sort-Object -Property Name -Unique
}
