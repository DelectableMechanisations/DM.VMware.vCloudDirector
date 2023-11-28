<#
    .SYNOPSIS
        Waits for a vCloud Director Task to complete. Retuns an error if the task status does not return "success".
#>
Function Wait-vCloudDirectorTask {
    [CmdletBinding(DefaultParameterSetName = 'ByTask')]
    Param (
        [Parameter(Mandatory, ParameterSetName = 'ByTask')]
        [System.Xml.XmlDocument]
        $Task,

        [Parameter(Mandatory, ParameterSetName = 'ByTaskNode')]
        [System.Xml.XmlElement]
        $TaskNode,

        [Parameter(Mandatory, ParameterSetName = 'ByTask')]
        [Parameter(Mandatory, ParameterSetName = 'ByTaskNode')]
        [System.Collections.IDictionary]
        $Headers,

        [Parameter(ParameterSetName = 'ByTask')]
        [Parameter(ParameterSetName = 'ByTaskNode')]
        [System.String]
        $TaskDescription = "Waiting for vCloud Director Operation to complete"
    )

    #Depending on the parameter input type, use a common variable for all operations that follow.
    switch ($PSCmdlet.ParameterSetName) {
        'ByTask'     {$taskInstance = $Task    ; Break}
        'ByTaskNode' {$taskInstance = $TaskNode; Break}
    }

    #Wait for the task to finish executing. Check on the task every 6 seconds.
    $loopIteration     = 1
    $maxLoopIterations = 20
    Do {
        Write-Progress -Activity $TaskDescription -CurrentOperation $taskInstance.Task.operation -PercentComplete (Get-Percentage -Count $loopIteration -Total $maxLoopIterations)
        $taskStatus = Invoke-vCloudDirectorWebRequest -Headers $Headers -Method Get -Uri $taskInstance.Task.href -Verbose:$false
        Start-Sleep -Seconds 6
        $loopIteration++

    #Exit the loop if the task status changes to 'success' or 'error', or if the maximum loop iteration is reached.
    } Until (@('success', 'error') -contains $taskStatus.Task.status -or $loopIteration -eq $maxLoopIterations)

    switch ($taskStatus.Task.status) {
        #If the task completed successfully.
        'success' {Write-Debug -Message "vCloud Director Task completed successfully. Operation: '$($taskInstance.Task.operation)'"}

        #If the task failed.
        'error'   {Write-Error "vCloud Director Task failed. Operation: '$($taskInstance.Task.operation)'. `n`rError Message:$($taskStatus.Task.Details)"}

        #If the task still hasn't completed after the alotted time.
        'queued'  {Write-Error "vCloud Director Task failed to complete in the alotted time. Operation: '$($taskInstance.Task.operation)'"}
    }
}
