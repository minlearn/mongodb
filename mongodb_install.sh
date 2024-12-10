##########

echo "Installing Dependencies"
apt-get install -y gnupg
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
echo "Installed Dependencies"

echo "Installing MongoDB"
wget -qO- https://www.mongodb.org/static/pgp/server-7.0.asc | gpg --dearmor >/usr/share/keyrings/mongodb-server-7.0.gpg
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg] http://repo.mongodb.org/apt/debian $(grep '^VERSION_CODENAME=' /etc/os-release | cut -d'=' -f2)/mongodb-org/7.0 main" >/etc/apt/sources.list.d/mongodb-org-7.0.list
apt-get update
apt-get install -y mongodb-org
sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf
systemctl enable -q --now mongod.service
echo "Installed MongoDB"

echo "Cleaning up"
apt-get -y autoremove
apt-get -y autoclean
echo "Cleaned"

###########