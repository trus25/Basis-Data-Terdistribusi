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
  Instalasi mysql-cluster sama dengan tugas(https://github.com/trus25/Basis-Data-Terdistribusi) sebelumnya.
# 3. Instalasi
  1. ```git clone https://github.com/trus25/Basis-Data-Terdistribusi.git```
  2. Hapus folder .vagrant untuk menghapus konfigurasi VB sebelumnya.
  3. Lakukan vagrant up dan vagrant ssh ditiap clusternya.
# 4. Konfigurasi

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
## 5.5 Contoh Proses Query
Menampilkan data pada tabel employee:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/select%20database.jpg)

Memasukkan data ke tabel employee:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/insert%20data.jpg)

## 5.6 Hasil Instalasi dan Konfigurasi ProxySQL
Proxy status, kedua hostname berstatus ```ONLINE```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/statusproxy.JPG)
Proxy status, dengan salah satu dimatikan servicenya sehingga statusnya menjadi ```SHUNNED```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/statusproxyshunned.JPG)
Menampilkan data pada tabel employee, setelah ditambahkan di API
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/proxyselect.JPG)
## 5.7 ProxySQL with SQLYog
Menampilkan hostname di SQLyog:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/sqlyoghostname.JPG)
Menampilkan data pada tabel employee di SQLyog:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/sqlyogselect.JPG)
Menambahkan data ke tabel employee:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/sqlyoginsert.JPG)
Menampilkan data pada tabel employee, setelah ditambahkan di SQLyog. Data sudah sesusai dengan yang sudah ditambahkan
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/proxyselectakhir.JPG)
Data juga sudah sesuai di clusterdb 1:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/clusterdb1selectakhir.JPG)
dan clusterdb2:
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/mysql-cluster/screenshoot/clusterdb2selectakhir.JPG)

