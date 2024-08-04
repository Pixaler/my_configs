set fish_greeting
set WINEESYNC 1
set WINEFSYNC 1

function ccf
  set FREQ (math $argv"*"1000000)
  echo $FREQ | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq &> /dev/null
end

function backup
  echo "Backup flatpaks app list"
  flatpak list --columns=application --app > flatpaks.txt
  echo "Backup .var folders"
  tar --exclude={".var/app/*/.ld.so", ".var/app/*/cache"} -zcvf !LBACKUP"("(date +%d.%m.%Y)")".tar.gz .var flatpaks.txt .ssh opt &> /dev/null
  echo "Move backup archive"
  mv !LBACKUP* /mnt/storage/06_Linux/!BACKUP &> /dev/null
end

# PATH
set -U fish_user_paths ~/.bin $fish_user_paths

# Aliases
alias lcf="echo 2500000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq &> /dev/null"
alias scf="echo 3900000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq &> /dev/null"


alias muse="minidlnad -f /home/$USER/.config/minidlna/minidlna.conf -P /home/$USER/.config/minidlna/minidlna.pid"
alias remuse="killall minidland
rm /home/pixaler/.cache/minidlna/files.db
rm /home/pixaler/.config/minidlna/minidlna.log
rm -rf /home/pixaler/.cache/minidlna/art_cache
minidlnad -R -f /home/pixaler/.config/minidlna/minidlna.conf
echo 'Database rebuilded' "

alias uu="sudo pacman -Syyuu 
flatpak update"
alias clean="flatpak uninstall --unused --delete-data
sudo pacman -Scc --noconfirm
sudo paccache -r
sudo paccache -rk1
sudo paccache -ruk0
sudo pacman -Rns (pacman -Qtdq)
fc-cache -frv
sudo truncate -s 0 /var/log/pacman.log
rm -rf ~/.cache/
sudo rm -rf /tmp/*"

alias upgrub="sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg"
alias upconf="source ~/.config/fish/config.fish"
# alias uu="sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y && sudo snap refresh && flatpak update -y"
# alias uu="sudo dnf update -y && flatpak update -y"
alias trim="sudo fstrim -av"

alias ..="cd .."
alias ...="cd ../.."

# Changing "ls" to "exa"
alias ls='eza' # my preferred listing
alias la='eza -a'  # all files and dirs
alias ll='eza -al'  # long format
# alias lt='exa -aT --color=always --group-directories-first' # tree listing
# alias l.='exa -a | egrep "^\."'

# sashimi
# Source: https://github.com/isacikgoz/sashimi
function fish_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -g red (set_color -o red)
  set -g blue (set_color -o blue)
  set -l green (set_color -o green)
  set -g normal (set_color normal)

  set -l ahead (_git_ahead)
  set -g whitespace ' '

  if test $last_status = 0
    set initial_indicator "$green◆"
    set status_indicator "$normal❯$cyan❯$green❯"
  else
    set initial_indicator "$red✖ $last_status"
    set status_indicator "$red❯$red❯$red❯"
  end
  set -l cwd $cyan(basename (prompt_pwd))

  if [ (_git_branch_name) ]

    if test (_git_branch_name) = 'master'
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($red$git_branch$normal)"
    else
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($blue$git_branch$normal)"
    end

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_info "$git_info$dirty"
    end
  end

  # Notify if a command took more than 5 minutes
  if [ "$CMD_DURATION" -gt 300000 ]
    echo The last command took (math "$CMD_DURATION/1000") seconds.
  end

  echo -n -s $initial_indicator $whitespace $cwd $git_info $whitespace $ahead $status_indicator $whitespace

end

function _git_ahead
  set -l commits (command git rev-list --left-right '@{upstream}...HEAD' 2>/dev/null)
  if [ $status != 0 ]
    return
  end
  set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
  set -l ahead  (count (for arg in $commits; echo $arg; end | grep -v '^<'))
  switch "$ahead $behind"
    case ''     # no upstream
    case '0 0'  # equal to upstream
      return
    case '* 0'  # ahead of upstream
      echo "$blue↑$normal_c$ahead$whitespace"
    case '0 *'  # behind upstream
      echo "$red↓$normal_c$behind$whitespace"
    case '*'    # diverged from upstream
      echo "$blue↑$normal$ahead $red↓$normal_c$behind$whitespace"
  end
end

function _git_branch_name
  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end
# END sahsimi
