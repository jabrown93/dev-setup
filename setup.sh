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

echo "Installing git-prune..."
cp utils/git-prune /usr/local/bin/git-prune

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
