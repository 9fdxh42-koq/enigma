#!/bin/bash

# Prompt for license key
read -p "Enter license key: " license_key

# Check if the license key is valid
if [ "$license_key" == "Obscurax" ]; then
  echo "License key is valid."

  # Instalasi
  sudo apt install git
  cd /var/www && git clone https://github.com/9fdxh42-koq/enigma.git
  mv /var/www/9fdxh42-koq/enigma.zip /var/www/
  rm -r 9fdxh42-koq
  apt install unzip
  unzip enigma.zip         
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  sudo apt update
  apt install nodejs -y
  npm i -g yarn

  # Run build process
  yarn
  yarn build:production

  echo "Installation complete!"

else
  echo "Invalid license key."
fi
