#!/bin/bash
#
# About: Install Morrowind Ecarlate automatically
# Author: liberodark
# Thanks : erdnalexi, T0MuX, frju365
# License: GNU GPLv3

  update_source="https://raw.githubusercontent.com/liberodark/Ecarlate-Installer/master/install.sh"
  version="1.0"

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
    
    elif [ "$distribution" = "Ubuntu" -o "$distribution" = "Debian" ]; then
      sudo apt install wget # Ubuntu / Debian
    
    elif [ "$distribution" = "OpenSuse" -o "$distribution" = "CentOS" ]; then
      sudo yum install wget # OpenSuse / CentOS
    
    elif [ "$distribution" = "Fedora" ]; then
      sudo dnf install wget # Fedora
    
    elif [ "$distribution" = "Gentoo" ]; then
      su -c emerge wget # Gentoo
    fi
  else
  echo "wget is Installed"
  fi

  # Check OS & p7zip

  which 7z &> /dev/null

  if [ $? != 0 ]; then
    echo "p7zip is not Installed"
     distribution=$(cat /etc/issue | head -n +1 | awk '{print $1}')

    if [ "$distribution" = "Manjaro" ]; then
      sudo pacman -S p7zip # Manjaro / Arch Linux
    
    elif [ "$distribution" = "Ubuntu" -o "$distribution" = "Debian" ]; then
      sudo apt install p7zip # Ubuntu / Debian
    
    elif [ "$distribution" = "OpenSuse" -o "$distribution" = "CentOS" ]; then
      sudo yum install p7zip # OpenSuse / CentOS
    
    elif [ "$distribution" = "Fedora" ]; then
      sudo dnf install p7zip # Fedora
    
    elif [ "$distribution" = "Gentoo" ]; then
      su -c emerge p7zip # Gentoo
    fi
    else
  echo "p7zip is Installed"
  fi

  # Check OS & sudo

  which sudo &> /dev/null

  if [ $? != 0 ]; then
    echo "sudo is not Installed"
     distribution=$(cat /etc/issue | head -n +1 | awk '{print $1}')

    if [ "$distribution" = "Manjaro" ]; then
      su pacman -S sudo # Manjaro / Arch Linux
    
    elif [ "$distribution" = "OpenSuse" -o "$distribution" = "CentOS" ]; then
      su yum install sudo # OpenSuse / CentOS
    
    elif [ "$distribution" = "Fedora" ]; then
      su dnf install sudo # Fedora
    
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
    
    elif [ "$distribution" = "OpenSuse" -o "$distribution" = "CentOS" ]; then
      su yum install openmw # OpenSuse / CentOS
    
    elif [ "$distribution" = "Fedora" ]; then
      su dnf install openmw # Fedora
    
    elif [ "$distribution" = "Gentoo" ]; then
      su -c emerge openmw # Gentoo
    fi
    else
  echo "openmw is Installed"
  fi

### Check Morrowind Install ###

  # Check Morrowind Install
  if [ -e ~/Games/Morrowind/version.txt ]; then
  	  echo "Success Morrowind is installed"
  	  wget https://raw.githubusercontent.com/liberodark/Ecarlate-Installer/master/version.txt -O version.txt
  	  version_online=$(md5sum version.txt)
  	  version_local=$(md5sum ~/Games/Morrowind/version.txt)
  	  if [ $version_online -eq $version_local ]; then
  	  	wget https://update.com -o update.tar.gz
  	  	mv update.tar.gz ~/Games/Morrowind/ && tar -xvf ~/Games/Morrowind/update.tar.gz
  	  	rm ~/Games/Morrowind/update.tar.gz
        mv version.txt ~/Games/Morrowind/version.txt
      fi
      echo "Success Morrowind is up to date"
      exit
  else
      echo "Error Morrowind is not Installed"
  fi

### Install Morrowind ###

  # Download Morrowind
  wget https://stream.and.me.ynh.ovh/site/Morrowind.7z &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Error Downloading Morrowind"
      exit
  else
      echo "Download Success Morrowind"
  fi

  # Download SHA256
   wget https://stream.and.me.ynh.ovh/site/Morrowind.7z.sha512sum &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Error Download SHA"
      exit
  else
      echo "Download Success SHA"
  fi

  # Check Morrowind
  sha512sum -c Morrowind.7z.sha512sum &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Error Check Morrowind"
      exit
  else
      echo "Check Success Morrowind"
      rm Morrowind.7z.sha512sum
  fi


  mkdir -p ~/Games/ &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Folder is not Created"
  else
      echo "Folder is Created"
  fi

  mv Morrowind.7z ~/Games/ &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Install Launcher is not Possible"
  else
      echo "Install Launcher is done"
  fi

  # Extract
  7z x ~/Games/Morrowind.7z &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Launcher is not Extracted"
  else
      echo "Launcher is Extracted"
  fi

  sudo mv ~/Games/Morrowind/morrowind.png /usr/share/pixmaps/ &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Install Icon is not Possible"
  else
      echo "Install Icon is done"
  fi

  sudo mv ~/Games/Morrowind/morrowind.desktop /usr/share/applications/ &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Install Desktop is not Possible"
  else
      echo "Install Desktop is done"
  fi

  # Clean
  #rm ~/Games/Morrowind.7z &> /dev/null

  #if [ "$?" != 0 ]; then
  #    echo "Download is not Cleaned"
  #else
  #    echo "Download is Cleaned"
  #fi
  exit
