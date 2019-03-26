# ETS BDT
# 1.Model Arsitektur
  | IP Address | Hostname | Deskripsi |
  | --- | --- | --- |
  | 192.168.100.11 | clusterdb1 | NDB Manager dan MySQL API Node1|
  | 192.168.100.12 | clusterdb2 | Data Node1 dan MySQL API Node2|
  | 192.168.100.13 | clusterdb3 | Data Node2 |
  | 192.168.100.14 | clusterdb4 | Load Balancer |
  
  Instalasi mysql-cluster sama dengan [tugas](https://github.com/trus25/Basis-Data-Terdistribusi) sebelumnya.
# 2. Instalasi
  1. Tambahkan database ```ets``` pada clusterdb1 dan clusterdb2
     ```
     CREATE DATABASE ets;
     GRANT ALL PRIVILEGES on ets.* to 'bdt'@'%';
     FLUSH PRIVILEGES;
     ```
  2. Install apache dan php
     ```
     sudo apt update && sudo apt install apache2
     sudo apt-get install php -y
     sudo apt-get install php-mysql
     sudo apt-get install -y php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-tidy curl
     ```
  3. Download wordpress dan pindahkan ke /var/www/html setelah di extract.
     ```
     wget -c http://wordpress.org/latest.tar.gz
     tar -xzvf latest.tar.gz -C /var/www/html/
     ```
     
# 3. Konfigurasi
   1. Rename file wp-config-sample.php menjadi wp-config.php dan ubah konfigurasi database menjadi seperti ini
      ```
      /** The name of the database for WordPress */
      define( 'DB_NAME', 'ets' );

      /** MySQL database username */
      define( 'DB_USER', 'userbdt' );

      /** MySQL database password */
      define( 'DB_PASSWORD', 'admin' );

      /** MySQL hostname */
      define( 'DB_HOST', '192.168.33.14:6033' );
      ```
   2. Kemudian, Ubah database engine menjadi ndb pada ```wordpress\wp-admin\includes\schema.php```. Contoh:
      ```
      CREATE TABLE $wpdb->terms (
      term_id bigint(20) unsigned NOT NULL auto_increment,
      name varchar(200) NOT NULL default '',
      slug varchar(200) NOT NULL default '',
      term_group bigint(10) NOT NULL default 0,
      PRIMARY KEY  (term_id),
      KEY slug (slug($max_index_length)),
      KEY name (name($max_index_length))
      )ENGINE=NDB $charset_collate;
      ```
# 4. Dokumentasi
   1. Pada http://192.168.33.14/wordpress, akan muncul tampilan instalasi wordpress. Lakukan sesuai petunjuk dan akan                         muncul menu login.
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/wordpresslogin.JPG)
      wordpress berhasil diinstall.
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/wordpress.JPG)
   2. Isi database setelah membuat post baru.
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/post.JPG)
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/post1.JPG)
   3. Saat salah satu server mati.
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/server1mati.JPG)
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/post.JPG)
   4. Saat salah satu node mati.
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/node1mati.JPG)
      ![alt]()
   5. Saat kedua node mati maka server juga akan mati, sehingga ketika masuk ke http://192.168.33.14/wordpress akan masuk kehalaman           instalasi.
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/semuanodemati.JPG)
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/semuanodemati1.JPG)
   6. Test menggunakan JMeter
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/threadgroup.JPG)
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/requestdefault.JPG)
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/request.JPG)
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/graph.JPG)
      ![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/ETS-BDT/Screenshoot/result.JPG)
# 5. Referensi

