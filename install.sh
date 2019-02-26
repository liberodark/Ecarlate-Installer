#!/bin/bash
#
# About: Install Morrowind Ecarlate automatically
# Author: liberodark
# Thanks : erdnalexi, T0MuX, frju365
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
  	  wget https://www.dropbox.com/s/38il47hyok1sv6s/Version%20Serveur%20Morrowind.txt?dl=1 -O version.txt
  	  version_online=$(md5sum version.txt)
  	  version_local=$(md5sum ~/Games/Morrowind/version.txt)
  	  if [ $version_online -eq $version_local ]; then
  	  	wget https://update.com -o update.tar.gz
  	  	mv update.tar.gz ~/Games/Morrowind/ && tar -xvf ~/Games/Morrowind/update.tar.gz
  	  	rm ~/Games/Morrowind/update.tar.gz
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
  else
      echo "Download Success Morrowind"
  fi

  # Download SHA256
   wget https://stream.and.me.ynh.ovh/site/Morrowind.7z.sha512sum &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Error Download SHA"
  else
      echo "Download Success SHA"
  fi

  # Check Morrowind
  sha256sum -c Morrowind.7z.sha512sum &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Error Check Morrowind"
  else
      echo "Check Success Morrowind"
      rm Morrowind.7z.sha512sum
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
  7z x ~/Games/Morrowind.7z &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Launcher is not Extracted"
  else
      echo "Launcher is Extracted"
      wget https://raw.githubusercontent.com/liberodark/Ecarlate-Installer/master/morrowind.png &> /dev/null
  fi

  sudo mv morrowind.png /usr/share/pixmaps/ &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Install Icon is not Possible"
  else
      echo "Install Icon is done"
      wget https://raw.githubusercontent.com/liberodark/Ecarlate-Installer/master/morrowind.desktop &> /dev/null
  fi

  sudo mv Morrowind.desktop /usr/share/applications/ &> /dev/null

  if [ "$?" != 0 ]; then
      echo "Install Desktop is not Possible"
  else
      echo "Install Desktop is done"
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
  rm ~/Games/Morrowind.7z &> /dev/null

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
  tar -xvf ~/Games/Morrowind/tes3mp.tar.gz &> /dev/null

  if [ "$?" != 0 ]; then
      echo "tes3mp is not Extracted"
  else
      echo "tes3mp is Extracted"
  fi
  exit
