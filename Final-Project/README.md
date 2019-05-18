# IMPLEMENTASI REDIS
# 1.Model Arsitektur
  | 192.168.100.11 | clusterdb1 | NDB Manager dan Redis Master|
  | 192.168.100.12 | clusterdb2 | Data Node1 dan MySQL API 1 dan Redis Slave 1| 
  | 192.168.100.13 | clusterdb3 | Data Node2 dan MySQL API 2 dan Redis Slave 2|
  | 192.168.100.14 | clusterdb4 | Load Balancer |
# 2.Instalasi
## 2.1 Install Mysql Cluster
Pertama lakukan instalasi Mysql Cluster. Cara instalasi terdapat di [Implementasi Mysql Cluster](https://github.com/trus25/Basis-Data-Terdistribusi) 
## 2.2. Install WordPress
Setelah itu, melakukan instalasi WordPress. Cara instalasi terdapat di [ETS-BDT](https://github.com/trus25/Basis-Data-Terdistribusi/tree/master/ETS-BDT)
## 2.3. Install Redis
Setelah menginstall WordPress dilanjutkan dengan menginstall Redis. Cara instalasi terdapat di [Tugas-Implementasi-Redis](https://github.com/trus25/Basis-Data-Terdistribusi/tree/master/Tugas-Implementasi-Redis).<br/>

Node yang digunakan adalah:
```
192.168.33.11 Sebagai Master
192.168.33.12 Sebagai Slave1
192.168.33.13 Sebagai Slave2
```
## 2.4. Install Redis Plugin Pada WordPress
Setelah redis berhasil diinstall dan dapat melakukan replikasi, Install Redis Object Cache di WordPress. Instalasi dapat dilakukan dengan masuk ke Dashboard->Plugin->Add new->cari "Redis Object Cache"->Install. Tetapi sebelumnya untuk instalasi plugin pada wordpress akan dimintai FTP credentials, maka dari itu perlu melakukan instalasi FTP terlebih dahulu pada server. Cara install FTP dapat dilihat di https://linuxize.com/post/how-to-setup-ftp-server-with-vsftpd-on-ubuntu-18-04/#1-ftp-access.

Setelah FTP berhasil di Install, masukkan username dan password yaitu ```vagrant``` serta hostname ```server yang digunakan```. Namun instalasi tidak akan berhasil karena wordpress tidak dapat mengakses file yang berada di ```/var/www/html/```, maka dari itu lakukan ```sudo chown -Rf www-data.www-data /var/www/html/``` terlebih dahulu, agar  WordPress dapat merubah file yang berada di folder tersebut.
# 3. Aktivasi Redis Plugin
Untuk mengaktifkan plugin buka file wp-config.php dengan ```sudo cd /var/www/html/wordpress/wp-config.php```. Kemudian tambahkan beberapa line berikut kedalam file tersebut. Karena saya menggunakan Redis Sentinel, maka saya tambahkan line berikut:
```
define( 'WP_REDIS_CLIENT', 'predis' );
define( 'WP_REDIS_SENTINEL', 'mymaster' );
define( 'WP_REDIS_SERVERS', [
    'tcp://192.168.33.11:26379', #IP node beserta port sentinel
    'tcp://192.168.33.12:26379',
    'tcp://192.168.33.13:26379',
] );
```
Setelah itu aktifkan Redis Object Cache, maka seperti ini hasilnya.<br/>
![alt](Src/redisaktivasi.JPG)
# 4. Failover
Saat master mati, maka slave akan menunjuk salah 1 master untuk menjadi master yang baru. Mematikan master dapat dilakukan dengan menjalankan ```redis-cli -p 6379 DEBUG SEGFAULT```:
![alt](Src/failoverslave1.JPG)<br/>
![alt](Src/failoverslave2.JPG)<br/>
# 5. Referensi
https://medium.com/@amila922/redis-sentinel-high-availability-everything-you-need-to-know-from-dev-to-prod-complete-guide-deb198e70ea6



