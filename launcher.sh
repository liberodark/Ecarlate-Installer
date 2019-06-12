#!/bin/bash
#
# About: Install Morrowind Ecarlate automatically
# Author: liberodark
# Thanks : erdnalexi, T0MuX, frju365
# License: GNU GPLv3

  update_source="https://raw.githubusercontent.com/liberodark/Ecarlate-Launcher/master/launcher.sh"
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
    wget -O "$0" $update_source
    $0 noupdate
    exit 0
  fi ;
  
#=================================================
# RETRIEVE ARGUMENTS FROM THE MANIFEST AND VAR
#=================================================

distribution=$(cat /etc/*release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/["]//g' | awk '{print $1}')

  # Check OS & wget

  if ! command -v wget &> /dev/null; then
  echo "wget is not Installed"

    if [[ "$distribution" = "Manjaro" ]]; then
      sudo pacman -S wget # Manjaro / Arch Linux
    
    elif [[ "$distribution" = "Ubuntu" || "$distribution" = "Debian" ]]; then
      sudo apt install wget # Ubuntu / Debian
    
    elif [[ "$distribution" = CentOS || "$distribution" = CentOS || "$distribution" = Red\ Hat || "$distribution" = Fedora || "$distribution" = Suse ]]; then
      sudo yum install wget # OpenSuse / CentOS
    
    elif [[ "$distribution" = "Gentoo" ]]; then
      su -c emerge wget # Gentoo
    fi
  else
  echo "wget is Installed"
  fi

  # Check OS & p7zip

  if ! command -v 7z &> /dev/null; then
  echo "p7zip is not Installed"

    if [[ "$distribution" = "Manjaro" ]]; then
      sudo pacman -S p7zip # Manjaro / Arch Linux
    
    elif [[ "$distribution" = "Ubuntu" || "$distribution" = "Debian" ]]; then
      sudo apt install p7zip # Ubuntu / Debian
    
    elif [[ "$distribution" = CentOS || "$distribution" = CentOS || "$distribution" = Red\ Hat || "$distribution" = Fedora || "$distribution" = Suse ]]; then
      sudo yum install p7zip # OpenSuse / CentOS
    
    elif [[ "$distribution" = "Gentoo" ]]; then
      su -c emerge p7zip # Gentoo
    fi
    else
  echo "p7zip is Installed"
  fi

  # Check OS & sudo

  if ! command -v sudo &> /dev/null; then
  echo "sudo is not Installed"

    if [[ "$distribution" = "Manjaro" ]]; then
      su pacman -S sudo # Manjaro / Arch Linux
    
    elif [[ "$distribution" = CentOS || "$distribution" = CentOS || "$distribution" = Red\ Hat || "$distribution" = Fedora || "$distribution" = Suse ]]; then
      su yum install sudo # OpenSuse / CentOS
    
    elif [[ "$distribution" = "Gentoo" ]]; then
      su -c emerge sudo # Gentoo
    fi
    else
  echo "sudo is Installed"
  fi

    # Check OS & openmw

  if ! command -v openmw &> /dev/null; then
  echo "openmw is not Installed"

    if [[ "$distribution" = "Manjaro" ]]; then
      su pacman -S openmw # Manjaro / Arch Linux
    
    elif [[ "$distribution" = CentOS || "$distribution" = CentOS || "$distribution" = Red\ Hat || "$distribution" = Fedora || "$distribution" = Suse ]]; then
      su yum install openmw # OpenSuse / CentOS
    
    elif [[ "$distribution" = "Gentoo" ]]; then
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
  	  if [ "$version_online" -eq "$version_local" ]; then
  	  	wget https://update.com -o update.tar.gz
  	  	mv update.tar.gz ~/Games/Morrowind/ && tar -xvf ~/Games/Morrowind/update.tar.gz
  	  	rm ~/Games/Morrowind/update.tar.gz
        mv version.txt ~/Games/Morrowind/version.txt
        bash -x ~/Games/Morrowind/openmw-launcher &> /dev/null
      fi
      echo "Success Morrowind is up to date"
      exit
  else
      echo "Error Morrowind is not Installed"
  fi

### Install Morrowind ###

  # Download Morrowind  

 if ! wget https://stream.and.me.ynh.ovh/site/Morrowind.7z &> /dev/null
 then
      echo "Error Downloading Morrowind"
      exit
  else
      echo "Download Success Morrowind"
  fi

  # Download SHA256

 if ! wget https://stream.and.me.ynh.ovh/site/Morrowind.7z.sha512sum &> /dev/null
 then
      echo "Error Download SHA"
      exit
  else
      echo "Download Success SHA"
  fi

  # Check Morrowind

 if ! sha512sum -c Morrowind.7z.sha512sum &> /dev/null
 then
      echo "Error Check Morrowind"
      exit
  else
      echo "Check Success Morrowind"
      rm Morrowind.7z.sha512sum
  fi

 if ! mkdir -p ~/Games/ &> /dev/null
 then
      echo "Folder is not Created"
  else
      echo "Folder is Created"
  fi

 if ! mv Morrowind.7z ~/Games/ &> /dev/null
 then
      echo "Install Launcher is not Possible"
  else
      echo "Install Launcher is done"
  fi

  # Extract
  

 if ! 7z x ~/Games/Morrowind-FR.7z -o"$HOME"/Games/ &> /dev/null
 then
      echo "Launcher is not Extracted"
  else
      echo "Launcher is Extracted"
  fi

  

 if ! sudo mv ~/Games/Morrowind/morrowind.png /usr/share/pixmaps/ &> /dev/null
 then
      echo "Install Icon is not Possible"
  else
      echo "Install Icon is done"
  fi

  

 if ! sudo mv ~/Games/Morrowind/morrowind.desktop /usr/share/applications/ &> /dev/null
 then
      echo "Install Desktop is not Possible"
  else
      echo "Install Desktop is done"
  fi
  
  
 if ! cp ~/.config/openmw/openmw.cfg ~/.config/openmw/openmw.cfg.save &> /dev/null
 then
      echo "Install Desktop is not Possible"
  else
      echo "Install Desktop is done"
      mv ~/Games/Morrowind/openmw.cfg ~/.config/openmw/openmw.cfg &> /dev/null
  fi

  # Clean

 if ! rm ~/Games/Morrowind.7z &> /dev/null
 then
      echo "Download is not Cleaned"
  else
      echo "Download is Cleaned"
  fi
  
  exit
