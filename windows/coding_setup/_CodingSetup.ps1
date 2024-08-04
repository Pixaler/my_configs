irm get.scoop.sh -outfile '.\install.ps1'
.\install.ps1 -RunAsAdmin
rm .\install.ps1
scoop bucket add main
scoop bucket add extras	
scoop bucket add versions
scoop install pwsh oh-my-posh
scoop install windows-terminal
mkdir "C:\Users\$env:UserName\scoop\apps\windows-terminal\current\settings"
cp ".\settings.json" "C:\Users\$env:UserName\scoop\apps\windows-terminal\current\settings"
cp -r ".\Powershell" "C:\!MYCOR"
scoop install python310 main/nodejs-lts
w10uninstall.bat
$input = Read-Host -Prompt "Press any button to continue"
cp ".\winterm.bat" "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
scoop install zig
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
cp -r "D:\07_Projects\my_configs\linux\.config\nvim" "$env:LOCALAPPDATA"
scoop install lazygit
cp -r "D:\07_Projects\my_configs\linux\.ssh" "$env:LOCALAPPDATA"
