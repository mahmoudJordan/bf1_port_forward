function Get-ApplicationPath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApplicationName
    )

    # Define the common Windows application folders
    $applicationFolders = @(
        "$env:ProgramFiles",
        "$env:ProgramFiles (x86)"
    )

    # Iterate through each application folder and check if the folder exists
    foreach ($folder in $applicationFolders) {
        $applicationPath = Join-Path -Path $folder -ChildPath $ApplicationName

        # Check if the folder exists in the current application folder
        if (Test-Path -Path $applicationPath) {
            return $applicationPath
        }
    }

    # Application folder not found in any of the common application folders
    return $null
}
