import os
import shutil

backup_dir = "/home/osbby/Documents/Proyectos/Dotfiles/Dotfiles"

config = [
    "BetterDiscord/",
    "bspwm/",
    "kitty/",
    "dunst/",
    "picom/",
    "polybar/",
    "powerlevel10k/",
    "rofi/",
    "spicetify/",
    "sxhkd/",
    "wallpapers/",
]
home = [
    ".p10k.zsh",
    ".xinitrc",
    ".zprofile",
    ".zshrc"
]
bin = [
    ""
]

def copytree_with_overwrite(src, dst):
    if os.path.exists(dst):
        shutil.rmtree(dst)
    shutil.copytree(src, dst)

def backup_items(items,string,path):
    backup_subdir = os.path.join(backup_dir, string)
    if not os.path.exists(backup_subdir):
        os.makedirs(backup_subdir)

    for item in items:
        try:
            if os.path.isdir(os.path.join(backup_dir, path, item)):
                backup_subdir_item = os.path.join(backup_dir, path, item)
                destination = os.path.join(backup_dir, string, item)
                copytree_with_overwrite(backup_subdir_item, destination)
            elif os.path.isfile(item):
                shutil.copy2(item, os.path.join(backup_subdir, os.path.basename(item)))
            print(f"Respaldo completado para: {item}")
        except Exception as e:
            print(f"Error al respaldar {item}: {e}")

def create_backup():
    backup_items(config,"config/","/home/osbby/.config/")
    backup_items(home,"home/","/home/osbby/")
    backup_items(bin,"bin/","/usr/local/bin")

if __name__ == "__main__":
    create_backup()
