# Implementasi MySQL Cluster
# 1.Yang dibutuhkan
  - Vagrant
  - ubuntu18.04
  - MySQL Remote Software
  - MySQL Data Sample
# 2.Model Arsitektur
  | IP Address | Hostname | Deskripsi |
  | --- | --- | --- |
  | 192.168.100.11 | clusterdb1 | NDB Manager dan MySQL API Node1|
  | 192.168.100.12 | clusterdb2 | Data Node1 dan MySQL API Node2|
  | 192.168.100.13 | clusterdb3 | Data Node2 |
  | 192.168.100.14 | clusterdb4 | Load Balancer |
# 3. Instalasi
  1. ```git clone https://github.com/trus25/Basis-Data-Terdistribusi.git```
  2. Hapus folder .vagrant untuk menghapus konfigurasi VB sebelumnya.
  3. Lakukan vagrant up dan vagrant ssh ditiap clusternya.
# 4. Konfigurasi
## 4.1. Konfigurasi NDB Manager(clusterdb1)
Pertama-tama jalankan beberapa script dibawah ini:
```
cd ~
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-management-server_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-management-server_7.6.9-1ubuntu18.04_amd64.deb
```
Setelah melakukan script diatas lanjukan dengan mengatur konfigurasi pada config.ini: 
```
sudo mkdir /var/lib/mysql-cluster
sudo nano /var/lib/mysql-cluster/config.ini
```
lalu tambahkan konfigurasi berikut:
```
[ndbd default]
# Options affecting ndbd processes on all data nodes:
NoOfReplicas=2  # Number of replicas

[ndb_mgmd]
# Management process options:
hostname=192.168.33.11 # Hostname of the manager
datadir=/var/lib/mysql-cluster  # Directory for the log files

[ndbd]
hostname=192.168.33.12 # Hostname/IP of the first data node
NodeId=2            # Node ID for this data node
datadir=/usr/local/mysql/data   # Remote directory for the data files

[ndbd]
hostname=192.168.33.13 # Hostname/IP of the second data node
NodeId=3            # Node ID for this data node
datadir=/usr/local/mysql/data   # Remote directory for the data files

[mysqld]
# SQL node options:
hostname=192.168.33.11 # In our case the MySQL server/client is on the same Droplet as the cluster manager
[mysqld]
# SQL node options:
hostname=192.168.33.12 # In our case the MySQL server/client is on the same Droplet as the cluster manager
```
Tag ```ndb_mgmd``` adalah konfigurasi untuk manager, ndbd untuk data node, sedangkan mysqld adalah untuk API Node.

Setelah melakukan konfigurasi pada config.ini, lakukan script berikut:
```
sudo ndb_mgmd -f /var/lib/mysql-cluster/config.ini
sudo pkill -f ndb_mgmd
sudo nano /etc/systemd/system/ndb_mgmd.service
```
pada /etc/systemd/system/ndb_mgmd.service tambahkan konfigurasi berikut untuk memberi instruksi pada systemd bagaimana memulai, mengehentikan, dan mengulang proses ndb_mgm.
```
[Unit]
Description=MySQL NDB Cluster Management Server
After=network.target auditd.service

[Service]
Type=forking
ExecStart=/usr/sbin/ndb_mgmd -f /var/lib/mysql-cluster/config.ini
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target
```
Setelah itu, jalankan script berikut
```
sudo systemctl daemon-reload      # Reload Service
sudo systemctl enable ndb_mgmd    # Enable Startup Manager
sudo systemctl start ndb_mgmd     # Starting Service
sudo ufw allow from 192.168.33.12 # Allow Firewall
sudo ufw allow from 192.168.33.13 # Allow Firewall
```
Cluster Manager sudah hidup dan dapat berkomunikasi dengan node lain, lalu kita akan mengkonfigurasi data node yaitu ```clusterdb2``` dan ```clusterdb3```.

## 4.2. Konfigurasi Data Node (clusterdb2 dan clusterdb3)
Pertama-tama jalankan beberapa script dibawah ini:
```
cd ~
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-data-node_7.6.6-1ubuntu18.04_amd64.deb
sudo apt update
sudo apt install libclass-methodmaker-perl
sudo dpkg -i mysql-cluster-community-data-node_7.6.9-1ubuntu18.04_amd64.deb
sudo nano /etc/my.cnf
```
Kemudian, pada /etc/my.cnf tambahkan konfigurasi berikut, sehingga NDB akan dapat mengkoneksikan data node dengan mysql cluster yang terdapat pada 192.168.33.11(clusterdb1).
```
[mysql_cluster]
# Options for NDB Cluster processes:
ndb-connectstring=192.168.33.11  # location of cluster manager
```
Lalu, jalankan kembali beberapa script berikut:
```
sudo mkdir -p /usr/local/mysql/data
sudo ndbd
sudo ufw allow from 192.168.33.11
sudo ufw allow from 192.168.33.12
sudo pkill -f ndbd
sudo nano /etc/systemd/system/ndbd.service
```
Pada /etc/systemd/system/ndbd.service tambahkan konfigurasi dibawah ini:
```
[Unit]
Description=MySQL NDB Data Node Daemon
After=network.target auditd.service

[Service]
Type=forking
ExecStart=/usr/sbin/ndbd
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target
```
Fungsi konfigurasi tersebut sama seperti konfigurasi ```ndb_mgmd.service``` pada manager sebelumnya.

Setelah itu reload systemd manager dengan ```daemon reload```, dan lakukan beberapa script berikut:
```
sudo systemctl daemon-reload
sudo systemctl enable ndbd
sudo systemctl start ndbd
sudo systemctl status ndbd
```
Setelah menyelesaikan tahap ini, ulangi kembali tahap ini untuk membuat datanode lainnya yaitu pada ```clusterdb3```.

## 4.3. Konfigurasi MySQL API Node
Setelah melakukan tahap-tahap diatas, kita akan melakukan instalasi MySQl API pada clusterdb1 dan clusterdb2.
```
cd ~
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster_7.6.6-1ubuntu18.04_amd64.deb-bundle.tar

mkdir install
tar -xvf mysql-cluster_7.6.6-1ubuntu18.04_amd64.deb-bundle.tar -C install/
cd install

sudo apt update
sudo apt install libaio1 libmecab2
sudo dpkg -i mysql-common_7.6.9-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-client_7.6.9-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-client_7.6.9-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-server_7.6.9-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-server_7.6.9-1ubuntu18.04_amd64.deb
```
Sekarang kita perlu mengkonfigurasi instalasi server MySQL ini.
Konfigurasi untuk MySQL Server disimpan dalam file /etc/mysql/my.cnf default.
Buka file tersebut dengan ```sudo nano /etc/mysql/my.cnf``` dan tambahkan konfigurasi berikut dibawahnya untuk mengarahkan server ke manager.
```
[mysqld]
# Options for mysqld process:
ndbcluster                      # run NDB storage engine

[mysql_cluster]
# Options for NDB Cluster processes:
ndb-connectstring=192.168.33.11  # location of management server
```
Lalu jalankan
```
sudo systemctl restart mysql
sudo systemctl enable mysql
```
## 4.4. Konfigurasi proxysql
### 4.4.1 Instalasi proxysql
Pada tahap ini kita akan membuat proxysql sebagai load balancer.
```
sudo apt-get update

sudo cd /tmp

sudo curl -OL https://github.com/sysown/proxysql/releases/download/v2.0.2/proxysql_2.0.2-dbg-ubuntu18_amd64.deb

sudo dpkg -i proxysql_*

sudo rm proxysql_*

sudo apt-get update
sudo apt-get install mysql-client
sudo systemctl start proxysql
```
### 4.4.2 Mengubah password admin
Kemudian, lakukan perubahan password admin dengan cara masuk ke antarmuka admin ```mysql -u admin -p -h 127.0.0.1 -P 6032 --prompt='ProxySQLAdmin> '```, yang kemudian akan diminta memasukkan password yang defaultnya adalah ```admin```.

Setelah berhasil masuk, jalankan query berikut untuk mengubah password
```ProxySQLAdmin> UPDATE global_variables SET variable_value='admin:password' WHERE variable_name='admin-admin_credentials';```
Ganti "admin:'password'" dengan password yang diinginkan.
Kemudian, lakukan
```
ProxySQLAdmin> LOAD ADMIN VARIABLES TO RUNTIME;
ProxySQLAdmin> SAVE ADMIN VARIABLES TO DISK;
```
### 4.4.3 Konfigurasi pada ProxySQL
Pertama-tama, masuk pada salah satu node server. Lalu download sql file berikut yang berisi fungsi penting agar proxysql group replication bekerja.
```curl -OL https://gist.github.com/lefred/77ddbde301c72535381ae7af9f968322/raw/5e40b03333a3c148b78aa348fd2cd5b5dbb36e4d/addition_to_sys.sql
```
Setelah itu masuk ke MySQL dan buat user baru
```
mysql> CREATE USER 'monitor'@'%' IDENTIFIED BY 'monitorpassword';
mysql> GRANT SELECT on sys.* to 'monitor'@'%';
mysql> FLUSH PRIVILEGES;
```
Lalu kita harus memperbarui ProxySQL dengan informasi untuk user itu agar user tersebut dapat mengakses MySQL node dengan masuk kembali ke interface admin ProxySQL dan jalankan query berikut.
```
UPDATE global_variables SET variable_value='monitor' WHERE variable_name='mysql-monitor_username';
LOAD MYSQL VARIABLES TO RUNTIME;
SAVE MYSQL VARIABLES TO DISK;

INSERT INTO mysql_group_replication_hostgroups (writer_hostgroup, backup_writer_hostgroup, reader_hostgroup, offline_hostgroup, active, max_writers, writer_is_also_reader, max_transactions_behind) VALUES (2, 4, 3, 1, 1, 3, 1, 100);

INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (2, '192.168.33.11', 3306);
INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (2, '192.168.33.12', 3306);

LOAD MYSQL SERVERS TO RUNTIME;
SAVE MYSQL SERVERS TO DISK;

INSERT INTO mysql_users(username, password, default_hostgroup) VALUES ('userbdt', 'admin', 2);

LOAD MYSQL USERS TO RUNTIME;
SAVE MYSQL USERS TO DISK;
```
Pada query diatas kita juga sudah membuat user untuk ProxySQl, maka kita juga harus membuat user pada mysql  yang dapat diakses dari luar localhost dan kita akan menggunakan mysql sample database.
```
mysql> CREATE USER 'userbdt'@'%' IDENTIFIED BY 'admin';
mysql> GRANT SELECT on classicmodels.* to 'userbdt'@'%';
mysql> FLUSH PRIVILEGES;
```
# 5. Dokumentasi
## 5.1 Hasil Instalasi dan Konfigurasi NDB Manager
clusterdb1 NDB Manager:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/clusterdb1status.JPG)
## 5.2 Hasil Instalasi dan Konfigurasi Data Node
clusterdb2 Data Node:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/clusterdb2status.JPG)
clusterdb3 Data Node:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/clusterdb3status.JPG)
## 5.3 Hasil Instalasi dan Konfigurasi MySQL API Node
clusterdb1 MySQL API:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/clusterdb1servicestatus.JPG)
clusterdb2 MySQL API:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/clusterdb2servicestatus.JPG)
## 5.4 ndb_mgm
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/ndb_mgm.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/insert%20data.jpg)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/clusterdb1servicestatus.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/clusterdb1servicestatus.JPG)

## 5.5 Contoh Proses Query
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/select%20database.jpg)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/insert%20data.jpg)
## 5.6 Hasil Instalasi dan Konfigurasi ProxySQL
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/statusproxy.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/statusproxyshunned.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/proxyselect.JPG)
## 5.7 ProxySQL with SQLYog
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/statusproxy.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/statusproxyshunned.JPG)
