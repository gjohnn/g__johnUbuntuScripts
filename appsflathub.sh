echo 'Installing Postman...'
flatpak install flathub com.getpostman.Postman -y
echo 'Installing KeePassXC'
flatpak install flathub org.keepassxc.KeePassXC -y
echo 'Installing Obsidian...'
flatpak install flathub md.obsidian.Obsidian -y
echo 'Installing VLC...'
su -
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install vlc
dnf install python-vlc (optional)
