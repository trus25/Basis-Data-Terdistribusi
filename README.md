# Implementasi MySQL Cluster
# 1.Yang dibutuhkan
  - Vagrant
  - ubuntu18.04
  - MySQL Remote Software
  - MySQL Data Sample
# 2.Model Arsitektur
  | IP Address | Hostname | Deskripsi |
  | --- | --- | --- |
  | 192.168.100.11 | clusterdb1 | Node manager dan service 1|
  | 192.168.100.12 | clusterdb2 | Node 1 dan service 2|
  | 192.168.100.13 | clusterdb3 | Node 2|
  | 192.168.100.14 | clusterdb4 | Load Balancer |
# 3. Instalasi
  1. ```git clone https://github.com/ahmadkikok/bdt-mysql_cluster.git```
  2. Hapus folder .vagrant untuk menghapus konfigurasi VB sebelumnya.
  3. Lakukan vagrant up dan lakukan vagrant ssh ditiap clusternya.
# 4. Configurasi pada clusterdb1(Manager
