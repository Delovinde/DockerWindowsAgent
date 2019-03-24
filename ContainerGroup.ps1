Clear-Host
$DEBUG = $true;

$numbers = 1..1;
$wait = 2;

$Create = $true;
$Docker = $false;

If ($DEBUG) { Write-Host $numbers; }
If ($DEBUG) { Write-Host "First range item:" $numbers[0];}

ForEach ($number in $numbers) {
    If ($Create -and ($number -ne $numbers[0])) {
        For ($i = 0; $i -le $wait; $i++) {
            Write-Progress -SecondsRemaining $i -Status "$i / $wait" `
                -Activity "Waiting $wait secs to start up agent.";
            Start-Sleep 1;
        }
        Write-Progress -Activity "Waiting $wait secs to start up agent." -Completed;
    }

    $newAgent = "agent" + $number;

    If(!$Create) {
        Write-Host -NoNewLine "Stopping: ";
        If ($Docker) { docker stop $newAgent }
    }

    If ($Create) {
        Write-Host -NoNewLine "Starting: ";
        If ($Docker) { docker run -t -d --name $newAgent --dns "10.199.66.10 winagent_cust1634 }
        }
}

# List all containers running
docker ps
