#provision for dbcluster1
sudo apt-get update
cd ~
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-management-server_7.6.9-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-management-server_7.6.9-1ubuntu18.04_amd64.deb
sudo mkdir /var/lib/mysql-cluster
sudo cp '/vagrant/files/config.ini' '/var/lib/mysql-cluster/config.ini'
sudo ndb_mgmd -f /var/lib/mysql-cluster/config.ini
sudo cp '/vagrant/files/ndb_mgmd.service' '/etc/systemd/system/ndb_mgmd.service'
sudo systemctl daemon-reload
sudo systemctl enable ndb_mgmd
sudo pkill -f ndb_mgmd
sudo systemctl start ndb_mgmd
sudo ufw allow from 192.168.33.12
sudo ufw allow from 192.168.33.13