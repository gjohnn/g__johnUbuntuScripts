#!/bin/bash

echo "Script made by g__john"

echo "Select an option:"
echo "1) Install PHP - MySQL - Composer - VirtualBox - Java"
echo "2) Install NVIM with NvChad from a repository"
echo "3) Install Visual Studio Code and DBeaver"
echo "4) Install Flatpak applications (KeePassXC, Postman, Obsidian)"
echo "5) Install everything"
read -p "Enter your choice [1-5]: " choice

install_php_mysql_composer_virtualbox_java (){
  # Update the system
  sudo apt update && sudo apt upgrade -y

  # PHP
  echo "Installing PHP..."
  sudo apt install -y php php-cli php-mbstring php-xml php-curl php-zip php-mysql

  # MySQL
  echo "Installing MySQL..."
  sudo apt install -y mysql-server
  sudo systemctl enable mysql
  sudo systemctl start mysql

  # Composer
  echo "Installing Composer..."
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  php -r "unlink('composer-setup.php');"

  # VirtualBox
  echo "Installing VirtualBox..."
  sudo apt install -y build-essential dkms linux-headers-$(uname -r)
  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo gpg --dearmor -o /usr/share/keyrings/oracle_vbox_2016.gpg
  echo "deb [signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] https://download.virtualbox.org/virtualbox/debian focal contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
  sudo apt update && sudo apt install -y virtualbox-7.0  # Ajustar la versión según sea necesario
  sudo usermod -aG vboxusers $USER

  # Java
  echo "Installing Java..."
  sudo apt install -y openjdk-17-jdk openjdk-17-jre

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
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
  echo "deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
  sudo apt update && sudo apt install -y code && rm -f microsoft.gpg

  echo "Installing DBeaver..."
  wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb -O dbeaver.deb
  sudo apt install -y ./dbeaver.deb && rm -f dbeaver.deb

  echo "VS Code and DBeaver installation completed."
}

install_flatpaks(){
  echo "Installing Flatpak applications..."
  sudo apt install -y flatpak
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

