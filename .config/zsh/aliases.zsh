# Manual aliases
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat=/usr/bin/bat
alias catn=/usr/bin/cat
alias wifi="nmtui-connect"
alias icat="kitty +kitten icat"
alias cp="cp -r"
alias dw="cd ~/Downloads/"
alias rmf="rm -rf"
alias nano="nvim"
alias vpnon="sudo wg-quick up ArchPavillon"
alias vpnoff="sudo wg-quick down ArchPavillon"
alias obsidian="env --unset=WAYLAND_DISPLAY obsidian --enable-features=UseOzonePlatform --ozone-platform=x11"
alias browse="zen-browser"

gp() {
  git add .
  git commit -m "$1"
  git push
}
