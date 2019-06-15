#!/usr/bin/env bash

xcode-select --version || xcode-select --install

if [ ! -f ~/.ssh/config ]; then
  echo "Setting up SSH config..."
  cp ./ssh_config ~/.ssh/config
fi

if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Generating RSA Key Pair..."
  ssh-keygen -t rsa -b 4096 -m PEM -f ~/.ssh/id_rsa
  ssh-add ~/.ssh/id_rsa
fi

if [ ! -f /usr/local/bin/brew ]; then
  echo "Installing brew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Brew installed"
else
  echo "Brew already installed, skipping..."
fi

echo "Installing Brewfile packages..."
brew bundle
brew cleanup

if [ ! -O /usr/local/n ]; then
  echo "Creating n directory, requires sudo..."
  sudo mkdir /usr/local/n/
  sudo chown `whoami`:admin /usr/local/n/
  echo "Installing LTS Node"
  n lts
fi

if [ ! -f /usr/local/bin/git-prune ]; then
  echo "Installing git-prune..."
  cp utils/git-prune /usr/local/bin/git-prune
else
  echo "Git Prune already exists, skipping..."
fi

if [ ! -f ~/.bash_profile ]; then
  echo "Adding bash profile..."
  cat .bash_profile >> ~/.bash_profile
else
  echo "Bash profile already exists, skipping..."
fi

if [ ! -f ~/.gitconfig ]; then
  echo "Adding git config..."
  cat .gitconfig >> ~/.gitconfig
else
  echo "Git config already exists, skipping..."
fi

if [ -f /usr/local/bin/atom ]; then
  echo "Installing Atom plugins..."
  apm install --packages-file atom-packages.txt
else
  echo "Atom not installed, skipping..."
fi

if [ ! -O ~/.oh-my-zsh ]; then
  echo "Installing Oh My ZSH..."
  curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
  sh install.sh --unattended

  echo "Installing Powerline Fonts..."
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts

  cp .zshrc ~/.zshrc
  chsh -s $(which zsh)
else
  echo "Oh My ZSH already installed, skipping..."
fi
