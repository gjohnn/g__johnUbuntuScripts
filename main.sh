#!/bin/bash

echo "Script made by g__john"

echo "Select an option:"
echo "1) Install NVIM with NvChad from a repository"
echo "2) Install VirtualBox, DBeaver, VLC (RPM)"
echo "3) Install Obsidian, KeePass, Thunderbird (Flatpak)"
echo "4) Install everything"
read -p "Enter your choice [1-11]: " choice

install_nvim_clonemyrepo (){
  echo "Installing Neovim..."
  wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz -O nvim-linux64.tar.gz
  tar -xzf nvim-linux64.tar.gz
  sudo mv nvim-linux64 /usr/local/nvim
  sudo ln -s /usr/local/nvim/bin/nvim /usr/local/bin/nvim
  rm -f nvim-linux64.tar.gz

  echo "Cloning NvChad configuration..."
  git clone https://github.com/gjohnn/gjohn_nvim ~/.config/nvim
  echo "Neovim installation and configuration completed."
}

install_all(){
  echo "Installing all components..."
  install_nvim_clonemyrepo
  echo "All installations completed!"
}

install_rpm_software(){
  echo "Installing VirtualBox, DBeaver, VLC (RPM)..."
  sudo dnf install -y https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox-6.1-6.1.36_146713_fedora34-1.x86_64.rpm
  sudo dnf install -y https://dbeaver.io/files/dbeaver-ce-22.3.0-stable.x86_64.rpm
  sudo dnf install -y https://download.videolan.org/pub/vlc/last/fedora/vlc-3.0.11.1-1.fc34.x86_64.rpm
  echo "VirtualBox, DBeaver, and VLC installation completed."
}

install_flatpak_software(){
  echo "Installing Obsidian, KeePass, Thunderbird (Flatpak)..."
  flatpak install --user -y flathub md.obsidian.Obsidian
  flatpak install --user -y flathub org.keepassxc.KeePassXC
  flatpak install --user -y flathub org.mozilla.Thunderbird
  echo "Obsidian, KeePass, and Thunderbird installation completed."
}

# Switch statement to handle user choice
case $choice in
  1)
    install_nvim_clonemyrepo
    ;;
  2)install_rpm_software
    ;;
  3)
    install_flatpak_software
    ;;
  4)
    install_all
    ;;
  *)
    echo "Invalid option. Exiting."
    ;;
esac