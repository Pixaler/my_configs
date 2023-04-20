oh-my-posh init pwsh -c "C:\Users\$env:UserName\scoop\apps\oh-my-posh\current\themes\gruvbox.omp.json"  | Invoke-Expression
$OutputEncoding = [System.Text.UTF8Encoding]::new()

Import-Module -Name Terminal-Icons
