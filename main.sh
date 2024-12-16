#!/bin/bash

echo "Select an option:"
echo "1) Install PHP - MySQL - Composer - VirtualBox - Java"
echo "2) Install NVIM with NvChad from a repository"
echo "3) Install Visual Studio Code and DBeaver"
echo "4) Install Flatpak applications (KeePassXC, Postman, Obsidian)"
echo "5) Install everything"
read -p "Enter your choice [1-5]: " choice

install_php_mysql_composer_virtualbox_java (){
  # Update the system
  sudo dnf update -y

  # PHP
  echo "Installing PHP..."
  sudo dnf install -y php php-cli php-mbstring php-xml php-curl php-zip php-mysqlnd

  # MySQL
  echo "Installing MySQL..."
  sudo dnf install -y @mysql
  sudo systemctl enable mysqld
  sudo systemctl start mysqld

  # Composer
  echo "Installing Composer..."
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  php -r "unlink('composer-setup.php');"

  # VirtualBox
  echo "Installing VirtualBox..."
  sudo dnf install -y @development-tools
  sudo dnf install -y kernel-devel kernel-headers dkms qt5-qtx11extras elfutils-libelf-devel
  sudo dnf config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
  sudo dnf install -y VirtualBox-7.0  # Adjust the version number as needed
  sudo usermod -aG vboxusers $USER

  # Java
  echo "Installing Java..."
  sudo dnf install -y java-17-openjdk java-17-openjdk-devel

  echo "Installation completed. Please restart if necessary."
}

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

install_vscode_dbeaver (){
  echo "Installing VS Code..."
  wget https://go.microsoft.com/fwlink/?LinkID=760867 -O code.rpm
  sudo dnf install -y code.rpm && rm -f code.rpm

  echo "Installing DBeaver..."
  wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.rpm -O dbeaver.rpm
  sudo dnf install -y dbeaver.rpm && rm -f dbeaver.rpm

  echo "VS Code and DBeaver installation completed."
}

install_flatpaks(){
  echo "Installing Flatpak applications..."
  flatpak install flathub org.keepassxc.KeePassXC -y
  flatpak install flathub com.getpostman.Postman -y
  flatpak install flathub md.obsidian.Obsidian -y
  echo "Flatpak applications installed successfully."
}

install_all(){
  echo "Installing all components..."
  install_php_mysql_composer_virtualbox_java
  install_nvim_clonemyrepo
  install_vscode_dbeaver
  install_flatpaks
  echo "All installations completed!"
}

# Switch statement to handle user choice
case $choice in
  1)
    install_php_mysql_composer_virtualbox_java
    ;;
  2)
    install_nvim_clonemyrepo
    ;;
  3)
    install_vscode_dbeaver
    ;;
  4)
    install_flatpaks
    ;;
  5)
    install_all
    ;;
  *)
    echo "Invalid option. Exiting."
    ;;
esac
