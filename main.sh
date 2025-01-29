#!/bin/bash

echo "Script made by  ---- g__john ----"
echo "dnf update -y running.."
sudo dnf update -y
echo "dnf update -y finished."
#Select option section
echo "Select an option:"
echo "1) Install NVIM with NvChad from a repository"
echo "2) Install VirtualBox, DBeaver, VLC, VSCode and VSCodium (RPM)"
echo "3) Install Obsidian, KeePass, Thunderbird (Flatpak)"
echo "4) Install Docker Engine and Docker Desktop Fedora"
echo "5) Install everything"
read -p "Enter your choice [1-4]: " choice

#Nvim 0.10.3 with NvChad and my configs
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
install_dockerEngine_DockerDesktop(){
  # For non-GNOME desktop environments, gnome-terminal must be installed:
  sudo dnf install -y gnome-terminal
  
  # Repositories for Docker Engine
  sudo dnf -y install dnf-plugins-core
  sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  
  # Install Docker Engine (Latest)
  sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo systemctl enable --now docker
  sudo docker run hello-world
  
  # Install Docker Desktop
  sudo dnf install -y https://desktop.docker.com/linux/main/amd64/docker-desktop-x86_64.rpm
  
  echo "Docker Engine and Docker Desktop installed."
  
  read -p "Do you use an account in Docker Desktop? (y/n): " choiceDockerAccount

  case $choiceDockerAccount in
    "y")
      gpg --generate-key
      idEnter=$(gpg --list-keys --keyid-format LONG | grep '^pub' | head -n 1 | awk '{print $2}' | cut -d'/' -f2)
      pass init $idEnter
      echo "All configured!"
      ;;
    *)
      echo "All configured!"
  esac
}

#Install all if Fedora based distro is a fresh install
install_all(){
  echo "Installing all components..."
  install_nvim_clonemyrepo
  install_rpm_software
  install_flatpak_software
  install_dockerEngine_DockerDesktop
  echo "All installations completed!"
}

install_rpm_software(){
  echo "Installing VirtualBox, DBeaver, VLC, VSCode, VSCodium (RPM)..."
  
  # Install VirtualBox
  sudo dnf install -y https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox-6.1-6.1.36_146713_fedora34-1.x86_64.rpm
  
  # Install DBeaver
  sudo dnf install -y https://dbeaver.io/files/dbeaver-ce-22.3.0-stable.x86_64.rpm
  
  # Install VLC
  sudo dnf install -y https://download.videolan.org/pub/vlc/last/fedora/vlc-3.0.11.1-1.fc34.x86_64.rpm
  
  # Install VSCode
  sudo dnf install -y https://code.visualstudio.com/sha/download?build=stable&os=rpm
  
  # Install VSCodium
  sudo dnf install -y https://github.com/VSCodium/vscodium/releases/download/1.70.1/codium-1.70.1-1620979981.x86_64.rpm
  
  echo "VirtualBox, DBeaver, VLC, VSCode, and VSCodium installation completed."
}

#
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
    install_dockerEngine_DockerDesktop
    ;;
  5)
    install_all
    ;;
  *)
    echo "Invalid option. Exiting."
    ;;
esac