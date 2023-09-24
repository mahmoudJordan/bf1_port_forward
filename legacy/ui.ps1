Set-Location (Split-Path $MyInvocation.MyCommand.Path)

. .\scripts\Set-Mappings.ps1

# Load the JSON content
$json = Get-Content -Path .\ports.json -Raw

$games = ConvertFrom-Json $json

# Create a WPF window
Add-Type -AssemblyName PresentationFramework

$window = New-Object System.Windows.Window
$window.Title = "Game Ports"
$window.Height = 400
$window.Width = 600

# Create a WrapPanel to hold buttons
$wrapPanel = New-Object System.Windows.Controls.WrapPanel

# Create a RichTextBox for output
$RichTextBox = New-Object System.Windows.Controls.RichTextBox
$RichTextBox.VerticalScrollBarVisibility = "Auto"
$RichTextBox.HorizontalScrollBarVisibility = "Auto"
$RichTextBox.IsReadOnly = $true

# Create a ScrollViewer to hold the RichTextBox
$textScrollViewer = New-Object System.Windows.Controls.ScrollViewer
$textScrollViewer.VerticalScrollBarVisibility = "Auto"
$textScrollViewer.Content = $RichTextBox

# Add both the ScrollViewer with RichTextBox and the ScrollViewer with WrapPanel to a StackPanel
$stackPanel = New-Object System.Windows.Controls.StackPanel
$stackPanel.Children.Add($textScrollViewer)
$stackPanel.Children.Add($wrapPanel)

# Add the StackPanel to the window
$window.Content = $stackPanel

# Function to redirect Write-Host output to RichTextBox
function Write-Host {
    param (
        [string]$Message,
        [ConsoleColor]$ForegroundColor = 'White',
        [ConsoleColor]$BackgroundColor = 'Black'
    )

    $timeStamp = (Get-Date).ToString("HH:mm:ss")
    $output = "$timeStamp - $Message"
    $paragraph = New-Object System.Windows.Documents.Paragraph
    $run = New-Object System.Windows.Documents.Run
    $run.Text = $output
    $run.Foreground = [System.Windows.Media.Brushes]::$ForegroundColor
    $run.Background = [System.Windows.Media.Brushes]::$BackgroundColor
    $paragraph.Inlines.Add($run)
    $RichTextBox.Document.Blocks.Add($paragraph)
    $RichTextBox.ScrollToEnd()
}

# Function to create a button
function Create-Button {
    param (
        [string]$gameName,
        [int[]]$tcpPorts,
        [int[]]$udpPorts
    )

    $button = New-Object System.Windows.Controls.Button
    $button.Content = $gameName
    $button.Margin = "5"
    
    $button.Add_Click({
        Write-Host "Start mapping $gameName entries"
        Set-Mappings -tcp $tcpPorts -udp $udpPorts -name $gameName
    })

    return $button
}

# Add buttons for each game
for ($i = 0; $i -lt $games.Count; $i++) {
    $entry = $games[$i]
    $button = Create-Button -gameName $entry.name -tcpPorts $entry.tcp -udpPorts $entry.udp
    $wrapPanel.Children.Add($button)
}

# Show the window
$window.ShowDialog() | Out-Null
