#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install Mac App Store apps
mas install 443987910 # 1Password
mas install 420212497 # Byword
mas install 668208984 # Giphy Capture
# mas install 584653203 # Paw
mas install 507257563 # Sip
# mas install 402476602 # Sketch
mas install 557168941 # Tweetbot

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/lumen-installer laravel/valet

# Symlink fonts directory to Dropbox
cp -R ~/Library/Fonts ~/Library/Fonts.backup
rm -rf ~/Library/Fonts
ln -s ~/Dropbox/Fonts ~/Library/Fonts

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Create a Code directory
mkdir $HOME/Code

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
