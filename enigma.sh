#!/bin/bash

# Prompt for license key
read -p "Enter license key: " license_key

# Check if the license key is valid
if [ "$license_key" == "Obscurax" ]; then
  echo "License key is valid."

  # Update and install dependencies
  sudo apt update
  sudo apt install -y git unzip curl gnupg

  # Clone the repository
  if [ ! -d "/var/www" ]; then
    sudo mkdir -p /var/www
  fi
  cd /var/www
  sudo git clone https://github.com/9fdxh42-koq/enigma.git
  sudo mv /var/www/enigma/enigma.zip /var/www/
  sudo rm -rf enigma

  # Extract the theme
  sudo unzip enigma.zip -d /var/www/
  sudo rm enigma.zip

  # Setup Node.js repository and install Node.js
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  sudo apt update
  sudo apt install -y nodejs
  sudo npm i -g yarn

  # Run build process
  cd /var/www
  yarn install
  yarn build:production

  echo "Installation complete!"
else
  echo "Invalid license key."
fi
