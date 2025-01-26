#!/bin/bash

echo "Script made by g__john"

echo "Select an option:"
echo "1) Install PHP - MySQL - Composer - VirtualBox - Java"
echo "2) Install NVIM with NvChad from a repository"
echo "3) Install everything"
read -p "Enter your choice [1-3]: " choice

install_php83_mysql8_composerLatest_java17 (){
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

install_all(){
  echo "Installing all components..."
  install_php_mysql_composer_virtualbox_java
  install_nvim_clonemyrepo
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
    install_all
    ;;
  *)
    echo "Invalid option. Exiting."
    ;;
esac

