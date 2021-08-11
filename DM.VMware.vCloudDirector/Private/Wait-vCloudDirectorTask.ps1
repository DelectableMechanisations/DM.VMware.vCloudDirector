<#
    .SYNOPSIS
        Waits for a vCloud Director Task to complete. Retuns an error if the task status does not return "success".
#>
Function Wait-vCloudDirectorTask {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [ValidateScript({
            if (Test-StringIsUri -String $_.Task.href) {
                $true
            } else {
                throw "The '-Task' parameter does not have a Task.href subproperty of type URI."
            }

            if (-not ([System.String]::IsNullOrWhiteSpace($_.Task.status))) {
                $true
            } else {
                throw "The '-Task' parameter does not have a Task.status subproperty."
            }
        })]
        [System.Xml.XmlDocument]
        $Task,

        [Parameter(Mandatory)]
        [System.Collections.IDictionary]
        $Headers,

        [System.String]
        $TaskDescription = "Waiting for vCloud Director Operation to complete"
    )

    #Wait for the task to finish executing. Check on the task every 6 seconds.
    $loopIteration     = 1
    $maxLoopIterations = 20
    Do {
        Write-Progress -Activity $TaskDescription -CurrentOperation $Task.Task.operation -PercentComplete (Get-Percentage -Count $loopIteration -Total $maxLoopIterations)
        $taskStatus = Invoke-vCloudDirectorWebRequest -Headers $Headers -Method Get -Uri $Task.Task.href -Verbose:$false
        Start-Sleep -Seconds 6
        $loopIteration++

    #Exit the loop if the task status changes to 'success' or 'error', or if the maximum loop iteration is reached.
    } Until (@('success', 'error') -contains $taskStatus.Task.status -or $loopIteration -eq $maxLoopIterations)

    switch ($taskStatus.Task.status) {
        #If the task completed successfully.
        'success' {Write-Debug -Message "vCloud Director Task completed successfully. Operation: '$($Task.Task.operation)'"}

        #If the task failed.
        'error'   {Write-Error "vCloud Director Task failed. Operation: '$($Task.Task.operation)'. `n`rError Message:$($taskStatus.Task.Details)"}

        #If the task still hasn't completed after the alotted time.
        'queued'  {Write-Error "vCloud Director Task failed to complete in the alotted time. Operation: '$($Task.Task.operation)'"}
    }
}
