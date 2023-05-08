# Remove startup greetings 
set fish_greeting

# Aliases
alias lcf="sudo cpupower --cpu all frequency-set --max 2.0GHz"
alias scf="sudo cpupower --cpu all frequency-set --max 3.9GHz"

# alias nvim="gnome-terminal --window --maximize -- nvim"
alias clean="sudo dnf autoremove -y && sudo dnf clean all"
alias uu="sudo dnf update -y && sudo dnf autoremove -y && flatpak update -y"

