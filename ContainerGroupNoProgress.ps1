#Clear-Host
$DEBUG = $false;

$numbers = 1..4;
$Create = $false;
$Docker = $true;

If ($DEBUG) { Write-Host "Total items in range:" $numbers.Count; }
If ($DEBUG) { Write-Host "First range item:" $numbers[0];}

ForEach ($number in $numbers) {
    $newAgent = "agent" + $number;

    If(!$Create) {
        Write-Host -NoNewLine "Stopping: ";
        If ($Docker) { docker stop $newAgent }
    }

    If ($Create) {
        Write-Host -NoNewLine "Starting item $($number): ";
        If ($Docker) { docker run -t -d `
            --name $newAgent `
            --env "CUSTOMERID=100" `
            --env "SERVERADDRESS=10.199.41.40" `
            agent_env
        }
    }
}

# List all containers running
docker ps
