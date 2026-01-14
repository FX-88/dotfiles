echo "This script will install ULauncher as an application launcher."

sudo add-apt-repository universe -y 
sudo add-apt-repository ppa:agornostal/ulauncher -y 
sudo apt update
sudo apt install ulauncher

echo "Installation of ULauncher is complete"