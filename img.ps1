function Get-Snapshot {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    # Ensure path exists
    if (!(Test-Path -Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }

    # Build full file path
    $FilePath = Join-Path -Path $Path -ChildPath "$Name.png"

    # Load required .NET assemblies
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    # Get screen size
    $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
    $Bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height
    $Graphic = [System.Drawing.Graphics]::FromImage($Bitmap)

    # Copy screen to bitmap
    $Graphic.CopyFromScreen($Screen.X, $Screen.Y, 0, 0, $Bitmap.Size)

    # Save the file
    $Bitmap.Save($FilePath, [System.Drawing.Imaging.ImageFormat]::Png)

    # Cleanup
    $Graphic.Dispose()
    $Bitmap.Dispose()

    Write-Host "Snapshot saved to: $FilePath"
}
