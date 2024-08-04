#!/bin/fish
echo "Vivaldi update started"
wget https://repo.vivaldi.com/archive/deb/dists/stable/main/binary-amd64/Packages -q

set ver (tac Packages| grep -m1 Version | cut -d " " -f2)

echo "Download update"
wget https://repo.vivaldi.com/archive/deb/pool/main/vivaldi-stable_"$ver"_amd64.deb -q

echo "Install update"
ar x ./vivaldi-stable_*.deb data.tar.xz 
tar -xf data.tar.xz ./opt/vivaldi -C $HOME

rm Packages vivaldi-stable_*.deb data.tar.xz

echo "Updated to version $ver"
