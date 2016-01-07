# peco install in ubuntu
curl https://github.com/peco/peco/releases/download/v0.3.2/peco_linux_amd64.tar.gz
tar xfvz peco_linux_amd64.tar.gz
sudo cp peco_linux_amd64/peco /user/bin/
sudo chmod 777 peco

go get github.com/peco/peco/cmd/peco


