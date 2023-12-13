Add-Type -AssemblyName System.Windows.Forms

$portStr = "COM5"
$baudRate = 9600
$parity = [System.IO.Ports.Parity]::None
$port = new-Object System.IO.Ports.SerialPort $portStr, $baudRate, $parity

try {
    $port.Open()

    while ($true) {
        try {
            $tag = $port.ReadLine()
            if ($tag -ne "") {
                $stx = [char]2
                $etx = [char]3

                # Trim Start of Text, End of Text and new line characters
                $trimmedTag = $tag -replace "$stx|$etx|`n|`r", ""

                $body = @{
                    user = @{
                        auth_tag = $trimmedTag
                    }
                } | ConvertTo-Json

                # TODO add your URI
                $uri = "https://some-example-uri.com"
                $webResponse = Invoke-WebRequest -Method Post -Uri $uri -Body $body -ContentType "application/json"
                $response = $webResponse.Content | ConvertFrom-Json

                if ($response -and $response.token) {
                    $token = $response.token
                    Start-Process "$uri?token=$token"
                }
            }
        } catch {
            if ($_.Exception.Response.StatusCode -eq 404) {
               [System.Windows.Forms.MessageBox]::Show('Invalid tag', 'Info')
            } else {
               [System.Windows.Forms.MessageBox]::Show("Web error: $_", 'Error')
            }
        }
    }
} catch {
	[System.Windows.Forms.MessageBox]::Show("Failed to open serial port $portStr: $_", 'Error')
} finally {
    $port.Close()
}

$port.Close()
