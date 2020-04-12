#!/bin/bash

set -euo pipefail

if [ $# -lt 2 ]; then
  echo '    $ sudo bash insta-onion.sh <onion_service_name> <local_http_port_your_app_is_listening_on>'
  echo
  echo 'or'
  echo
  echo '    # bash insta-onion.sh <onion_service_name> <local_http_port_your_app_is_listening_on>'
  echo
  echo 'Note: onion_service_name will be used to create a folder at /var/lib/tor/<onion_service_name>'
  exit
fi
export onion_service_name="${1:-onion_service_`date -I`}"
export local_http_port="${2:-8000}"

export distro="$(lsb_release -is)"
if [[ ("$distro" != 'Debian') && ("$distro" != 'Ubuntu') ]]; then
    echo "For now, this script only works on Debian and Ubuntu. Sorry!";
    exit
fi

if [[ "$(lsb_release -cs)" == "trusty" ]]; then
    echo "$(lsb_release -ds) is too old! Consider upgrading."
    exit
fi

sudo apt-get update && sudo apt-get install -y curl gnupg2

curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
echo "deb http://deb.torproject.org/torproject.org $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/tor.list
sudo apt-get update
sudo apt-get install -y tor

export onion_dir="/var/lib/tor/$onion_service_name"

sudo mkdir "$onion_dir"
sudo chown debian-tor:debian-tor "$onion_dir"
sudo chmod 0700 "$onion_dir"

echo 'Appending to /etc/tor/torrc ...'

echo "" | sudo tee -a /etc/tor/torrc
echo "" | sudo tee -a /etc/tor/torrc
echo "HiddenServiceDir $onion_dir" | sudo tee -a /etc/tor/torrc
echo "HiddenServicePort 80 127.0.0.1:$local_http_port" | sudo tee -a /etc/tor/torrc

sudo service tor restart

echo -n '

...Now just wait a few minutes for your Onion service to register with the Tor network!'
echo ' Once it has, you can view your new, randomly-generated .onion address by running

    $ sudo cat '"$onion_dir"/hostname'
'
