#!/bin/bash
#
# About: Install Morrowind Ecarlate automatically
# Author: liberodark
# Thanks : erdnalexi, T0MuX
# License: GNU GPLv3

  update_source="https://raw.githubusercontent.com/liberodark/Ecarlate-Installer/master/install.sh"
  version="0.7.0.9.9.9.5"

  echo "Welcome on Morrowind - Ecarlate Install Script $version"

  # make update if asked
  if [ "$1" = "noupdate" ]; then
    update_status="false"
  else
    update_status="true"
  fi ;

  # update updater
  if [ "$update_status" = "true" ]; then
    wget -O $0 $update_source
    $0 noupdate
    exit 0
  fi ;

  # Check OS & wget

  which wget &> /dev/null

  if [ $? != 0 ]; then
    echo "wget is not Installed"
     distribution=$(cat /etc/issue | head -n +1 | awk '{print $1}')

    if [ "$distribution" = "Manjaro" ]; then
      sudo pacman -S wget # Manjaro / Arch Linux
    
    elif [ "$distribution" = "Ubuntu" ]; then
      sudo apt install wget # Ubuntu / Debian
    
    elif [ "$distribution" = "OpenSuse" ]; then
      sudo yum install wget # OpenSuse / CentOS
    
    elif [ "$distribution" = "Fedora" ]; then
      sudo dnf install wget # Fedora
    
    elif [ "$distribution" = "CentOS" ]; then
      sudo yum install wget # OpenSuse / CentOS
    
    elif [ "$distribution" = "Debian" ]; then
      sudo apt install wget # Ubuntu / Debian
    
    elif [ "$distribution" = "Gentoo" ]; then
      su -c emerge wget # Gentoo
    fi
    else
  echo "wget is Installed"
  fi

  # Check OS & unzip

  which unzip &> /dev/null

  if [ $? != 0 ]; then
    echo "unzip is not Installed"
     distribution=$(cat /etc/issue | head -n +1 | awk '{print $1}')

    if [ "$distribution" = "Manjaro" ]; then
      sudo pacman -S unzip # Manjaro / Arch Linux
    
    elif [ "$distribution" = "Ubuntu" ]; then
      sudo apt install unzip # Ubuntu / Debian
    
    elif [ "$distribution" = "OpenSuse" ]; then
      sudo yum install unzip # OpenSuse / CentOS
    
    elif [ "$distribution" = "Fedora" ]; then
      sudo dnf install unzip # Fedora
    
    elif [ "$distribution" = "CentOS" ]; then
      sudo yum install unzip # OpenSuse / CentOS
    
    elif [ "$distribution" = "Debian" ]; then
      sudo apt install unzip # Ubuntu / Debian
    
    elif [ "$distribution" = "Gentoo" ]; then
      su -c emerge unzip # Gentoo
    fi
    else
  echo "unzip is Installed"
  fi

  # Check OS & sudo

  which sudo &> /dev/null

  if [ $? != 0 ]; then
    echo "sudo is not Installed"
     distribution=$(cat /etc/issue | head -n +1 | awk '{print $1}')

    if [ "$distribution" = "Manjaro" ]; then
      su pacman -S sudo # Manjaro / Arch Linux
    
    elif [ "$distribution" = "OpenSuse" ]; then
      su yum install sudo # OpenSuse / CentOS
    
    elif [ "$distribution" = "Fedora" ]; then
      su dnf install sudo # Fedora
    
    elif [ "$distribution" = "CentOS" ]; then
      su yum install sudo # OpenSuse / CentOS
    
    elif [ "$distribution" = "Gentoo" ]; then
      su -c emerge sudo # Gentoo
    fi
    else
  echo "sudo is Installed"
  fi

    # Check OS & openmw

  which openmw &> /dev/null

  if [ $? != 0 ]; then
    echo "openmw is not Installed"
     distribution=$(cat /etc/issue | head -n +1 | awk '{print $1}')

    if [ "$distribution" = "Manjaro" ]; then
      su pacman -S openmw # Manjaro / Arch Linux
    
    elif [ "$distribution" = "OpenSuse" ]; then
      su yum install openmw # OpenSuse / CentOS
    
    elif [ "$distribution" = "Fedora" ]; then
      su dnf install openmw # Fedora
    
    elif [ "$distribution" = "CentOS" ]; then
      su yum install openmw # OpenSuse / CentOS
    
    elif [ "$distribution" = "Gentoo" ]; then
      su -c emerge openmw # Gentoo
    fi
    else
  echo "openmw is Installed"
  fi

### Install Morrowind ###

  # Download Morrowind
  wget https://stream.and.me.ynh.ovh/site/Morrowind.tar.gz &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Error Downloading Morrowind"
  else
      echo "Download Success Morrowind"
  fi

  # Download SHA256
   wget https://stream.and.me.ynh.ovh/site/Morrowind.tar.gz.sha256sum &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Error Download SHA"
  else
      echo "Download Success SHA"
  fi

  # Check Morrowind
  sha256sum -c Morrowind.tar.gz.sha512sum &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Error Check Morrowind"
  else
      echo "Check Success Morrowind"
      rm Morrowind.tar.gz.sha256sum
  fi


  mkdir ~/Games/ &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Morrowind is not Installed"
  else
      echo "Morrowind is Installed"
  fi

  mv Morrowind.tar.gz ~/Games/ &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Install Launcher is not Possible"
  else
      echo "Install Launcher is done"
  fi

  # Extract
  tar -xvf Morrowind.tar.gz &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Launcher is not Extracted"
  else
      echo "Launcher is Extracted"
      wget https://raw.githubusercontent.com/liberodark/Ecarlate-Installer/master/morrowind.png &> /dev/null
  fi

  sudo mv ~/Games/morrowind.png /usr/share/pixmaps/ &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Install Icon is not Possible"
  else
      echo "Install Icon is done"
      wget https://raw.githubusercontent.com/liberodark/Ecarlate-Installer/master/morrowind.desktop &> /dev/null
  fi

  sudo mv ~/Games/Morrowind.desktop /usr/share/applications/ &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Install Desktop is not Possible"
  else
      echo "Install Desktop is done"
  fi

  # Run chmod
  sudo chmod +x /opt/Last-Epoch/Launcher &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Launcher is not Executable"
  else
      echo "Launcher is Executable"
  fi

  # Create version file
  touch ~/Games/Morrowind/version.txt &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Version file is not Created"
  else
      echo "Version file is Created"
  fi

  # Update version file
  echo "$version" > ~/Games/Morrowind/version.txt &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Version file is not Updated"
  else
      echo "Version file is Updated"
  fi

  # Clean
  rm ~/Games/Morrowind.tar.gz &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Download is not Cleaned"
  else
      echo "Download is Cleaned"
  fi

### Install tes3mp ###

  # Download tes3mp
  wget https://github.com/TES3MP/openmw-tes3mp/releases/download/0.7.0-alpha/tes3mp-GNU+Linux-x86_64-release-0.7.0-alpha-0df32accca-edbcae5b0e.tar.gz -o tes3mp.tar.gz &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Error Downloading tes3mp"
  else
      echo "Download Success tes3mp"
  fi

  mv tes3mp.tar.gz ~/Games/Morrowind/ &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Install tes3mp is not Possible"
  else
      echo "Install tes3mp is done"
  fi

  # Extract
  tar -xvf tes3mp.tar.gz &> /dev/null

  if [ "$?" != 0 ]; then
      echo "tes3mp is not Extracted"
  else
      echo "tes3mp is Extracted"
  fi