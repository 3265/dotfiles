#!/bin/bash

# pkg of choromedriver from apt doesn't have path to exec it
# so i added from source code according to a site below
# see https://gist.github.com/ziadoz/3e8ab7e944d02fe872c3454d17af31a5

CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`
# Install ChromeDriver.
wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/
unzip ~/chromedriver_linux64.zip -d ~/
rm ~/chromedriver_linux64.zip
sudo mv -f ~/chromedriver /usr/local/bin/chromedriver
sudo chown root:root /usr/local/bin/chromedriver
sudo chmod 0755 /usr/local/bin/chromedriver

