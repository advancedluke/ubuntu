# https://zato.io/docs/admin/guide/install-ubuntu.html
sudo apt-get install apt-transport-https -y
sudo apt-get install software-properties-common -y

curl -s https://zato.io/repo/zato-0CBD7F72.pgp.asc | sudo apt-key add -
sudo apt-add-repository https://zato.io/repo/stable/2.0/ubuntu
sudo apt-get update

sudo apt-get install zato
