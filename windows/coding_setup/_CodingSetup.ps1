irm get.scoop.sh -outfile '.\install.ps1'
.\install.ps1 -RunAsAdmin
rm .\install.ps1
scoop bucket add main
scoop bucket add extras	
scoop bucket add versions
scoop install pwsh oh-my-posh
scoop install windows-terminal
mkdir "C:\Users\$env:UserName\AppData\Local\Microsoft\Windows Terminal"
cp ".\settings.json" "C:\Users\$env:UserName\AppData\Local\Microsoft\Windows Terminal"
cp -r ".\Powershell" "C:\!MYCOR"
scoop install python310 main/nodejs-lts
w10uninstall.bat
$input = Read-Host -Prompt "Press any button to continue"
cp ".\winterm.bat" "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
scoop install zig
# git clone --depth 1 https://github.com/AstroNvim/AstroNvim C:/Users/$env:UserName/AppData/Local/nvim
# git clone https://github.com/Pixaler/astronvim_config C:/Users/$env:UserName/AppData/Local/nvim/lua/user
scoop install lazygit
