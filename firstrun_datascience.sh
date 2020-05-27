# install r etc
apt-get update
apt-get install r-base
apt-get install gdebi-core
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.5042-amd64.deb
gdebi rstudio-server-1.2.5042-amd64.deb
