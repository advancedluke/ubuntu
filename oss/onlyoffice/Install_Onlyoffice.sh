###  Please see the list of all supported kernel versions http://onlyo.co/1PABPEI

sudo wget http://download.onlyoffice.com/repo/onlyoffice.key 
sudo apt-key add onlyoffice.key
echo "deb http://download.onlyoffice.com/repo/debian squeeze main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install onlyoffice
