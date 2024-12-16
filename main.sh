#!/bin/bash
echo 'Ingrese opcion'
echo '1) Instalar PHP - MYSQL - COMPOSER - VIRTUAL BOX - JAVA'
echo '2) Instalar NVIM con Nvchad con repositorio'
echo '3) Instalar Visual Studio Code y Dbeaver'
echo '99) Instalar todo'

install_php_mysql_composer_virtualbox_java (){
  #PHP

  #MYSQL

  #COMPOSER

  #VIRTUAL BOX

  #JAVA
  
}

install_nvim_clonemyrepo (){
  #Download nvim in tar format to extract
  tar -xfzx nvim-linux64.tar.gz
  #Install it in system

  #git clone repository from gjohnn/gjohn_nvim
}

install_vscode_dbeaver (){
  echo "Installing VS Code..."
  
  # Download .RPM for Vs Code
  wget https://go.microsoft.com/fwlink/?LinkID=760867 -O code.rpm
  if [ $? -ne 0 ]; then
    echo "Error downloading VS Code package"
    exit 1
  fi

  # Install VS Code
  sudo dnf install -y code.rpm
  if [ $? -ne 0 ]; then
    echo "Error installing VS Code"
    exit 1
  fi

  # Clean rpm
  rm -f code.rpm

  echo "Installing DBeaver..."
  
  # Download .RPM for DBeaver
  wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.rpm -O dbeaver.rpm
  if [ $? -ne 0 ]; then
    echo "Error downloading DBeaver package"
    exit 1
  fi

  # Install DBeaver
  sudo dnf install -y dbeaver.rpm
  if [ $? -ne 0 ]; then
    echo "Error installing DBeaver"
    exit 1
  fi

  # Clean rpm
  rm -f dbeaver.rpm

  echo "Installation of Vs Code and Dbeaver completed!"
}


install_all(){
  install_php_mysql_composer_virtualbox_java
  install_nvim_clonemyrepo
  install_vscode_dbeaver
}
