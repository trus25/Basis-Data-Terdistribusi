# Tugas Implementasi Partisi
### Farhan Zuhdi 5111640000070
# Partition
## Range Partition
Membuat tabel serta melakukan partisi p0 < 5,12 selain itu akan di masukkan ke p3.
```
CREATE TABLE rc1 (
    a INT,
    b INT
)
PARTITION BY RANGE COLUMNS(a, b) (
    PARTITION p0 VALUES LESS THAN (5, 12),
    PARTITION p3 VALUES LESS THAN (MAXVALUE, MAXVALUE)
);
```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/RangePartition1.JPG)
Masukkan data kedalam tabel rc1.
```
INSERT INTO rc1 (a,b) VALUES (4,11);
INSERT INTO rc1 (a,b) VALUES (5,11);
INSERT INTO rc1 (a,b) VALUES (6,11);
INSERT INTO rc1 (a,b) VALUES (4,12);
INSERT INTO rc1 (a,b) VALUES (5,12);
INSERT INTO rc1 (a,b) VALUES (6,12);
INSERT INTO rc1 (a,b) VALUES (4,13);
INSERT INTO rc1 (a,b) VALUES (5,13);
INSERT INTO rc1 (a,b) VALUES (6,13);
INSERT INTO rc1 (a,b) VALUES (4,11);
INSERT INTO rc1 (a,b) VALUES (5,11);
INSERT INTO rc1 (a,b) VALUES (6,11);
INSERT INTO rc1 (a,b) VALUES (4,12);
INSERT INTO rc1 (a,b) VALUES (5,12);
INSERT INTO rc1 (a,b) VALUES (6,12);
INSERT INTO rc1 (a,b) VALUES (4,13);
INSERT INTO rc1 (a,b) VALUES (5,13);
INSERT INTO rc1 (a,b) VALUES (6,13);
```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/RangePartitionInsert.JPG)

Menampilkan hasil partisi dengan ```SELECT *,'p0' FROM rc1 PARTITION (p0) UNION ALL SELECT *,'p3' FROM rc1 PARTITION (p3) ORDER BY a,b ASC;```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/RangePartitionSelect.JPG)

## List Partition
Membuat tabel serta melakukan partisi dengan membagikan daftar ```servername``` ke ```server_east``` dan ```server_west```
```
CREATE TABLE serverlogs (
    servername VARCHAR(20) NOT NULL, 
    logdata BLOB NOT NULL,
    created DATETIME NOT NULL
)
PARTITION BY LIST COLUMNS (servername)(
    PARTITION server_east VALUES IN('northern_east','east_ny'),
    PARTITION server_west VALUES IN('west_city','southern_ca')
);
```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/ListPartition1.JPG)
Masukkan data kedalam tabel serverlogs.
```
INSERT INTO serverlogs (servername,logdata,created) VALUES ('northern_east','test1','2019-03-20 00:00:25');
INSERT INTO serverlogs (servername,logdata,created) VALUES ('west_city','test2','2019-03-20 00:00:25');
INSERT INTO serverlogs (servername,logdata,created) VALUES ('northern_east','test3','2019-03-20 00:00:25');
INSERT INTO serverlogs (servername,logdata,created) VALUES ('east_ny','test4','2019-03-20 00:00:25');
INSERT INTO serverlogs (servername,logdata,created) VALUES ('southern_ca','test5','2019-03-20 00:00:25');
INSERT INTO serverlogs (servername,logdata,created) VALUES ('west_city','test6','2019-03-20 00:00:25');
```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/ListPartitionInsert.JPG)
Menampilkan hasil partisi dengan
```
SELECT *,'server_east' FROM serverlogs PARTITION (server_east) UNION ALL 
SELECT *,'server_west' FROM serverlogs PARTITION (server_west) 
ORDER BY server_east ASC;
```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/ListPartitionSelect.JPG)

## Hash Partition
Membuat tabel serta melakukan partisi dengan hash yang berjumlah 10 partisi
```
CREATE TABLE serverlogs2 (
    serverid INT NOT NULL, 
    logdata BLOB NOT NULL,
    created DATETIME NOT NULL
)
PARTITION BY HASH (serverid)
PARTITIONS 10;
```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/HashPartition1.JPG)
Memasukkan data kedalam tabel serverlogs2
```
INSERT INTO serverlogs2 (serverid,logdata,created) VALUES ('11','test1','2019-03-20 00:00:25');
INSERT INTO serverlogs2 (serverid,logdata,created) VALUES ('13','test2','2019-03-20 00:00:25');
INSERT INTO serverlogs2 (serverid,logdata,created) VALUES ('17','test3','2019-03-20 00:00:25');
INSERT INTO serverlogs2 (serverid,logdata,created) VALUES ('19','test4','2019-03-20 00:00:25');
INSERT INTO serverlogs2 (serverid,logdata,created) VALUES ('23','test5','2019-03-20 00:00:25');
INSERT INTO serverlogs2 (serverid,logdata,created) VALUES ('47','test6','2019-03-20 00:00:25');
INSERT INTO serverlogs2 (serverid,logdata,created) VALUES ('53','test7','2019-03-20 00:00:25');
INSERT INTO serverlogs2 (serverid,logdata,created) VALUES ('57','test8','2019-03-20 00:00:25');
INSERT INTO serverlogs2 (serverid,logdata,created) VALUES ('67','test9','2019-03-20 00:00:25');
INSERT INTO serverlogs2 (serverid,logdata,created) VALUES ('79','test10','2019-03-20 00:00:25');
```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/HashPartitionInsert.JPG)
Menampilkan hasil partisi dengan
```
SELECT *,'p0' FROM serverlogs2 PARTITION (p0) UNION ALL 
SELECT *,'p1' FROM serverlogs2 PARTITION (p1) UNION ALL
SELECT *,'p2' FROM serverlogs2 PARTITION (p2) UNION ALL 
SELECT *,'p3' FROM serverlogs2 PARTITION (p3) UNION ALL
SELECT *,'p4' FROM serverlogs2 PARTITION (p4) UNION ALL 
SELECT *,'p5' FROM serverlogs2 PARTITION (p5) UNION ALL
SELECT *,'p6' FROM serverlogs2 PARTITION (p6) UNION ALL 
SELECT *,'p7' FROM serverlogs2 PARTITION (p7) UNION ALL
SELECT *,'p8' FROM serverlogs2 PARTITION (p8) UNION ALL 
SELECT *,'p9' FROM serverlogs2 PARTITION (p9)
ORDER BY p0 ASC;
```
hasil partisi dengan hash didapatkan dengan rumus N = MOD(expr, num), di mana N adalah nomor partisi yang dihasilkan, expr adalah ekspression dan num adalah jumlah partisi yang ditentukan dalam keyword PARTISI.
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/HashPartitionSelect.JPG)

## Key Partition
Membuat tabel serta melakukan partisi dengan key yang berjumlah 10 partisi
```
CREATE TABLE serverlogs4 (
    serverid INT NOT NULL, 
    logdata BLOB NOT NULL,
    created DATETIME NOT NULL,
    UNIQUE KEY (serverid)
)
PARTITION BY KEY()
PARTITIONS 10;
```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/KeyPartition1.JPG)
Memasukkan data kedalam tabel serverlogs4
```
INSERT INTO serverlogs4 (serverid,logdata,created) VALUES ('11','test1','2019-03-20 00:00:25');
INSERT INTO serverlogs4 (serverid,logdata,created) VALUES ('13','test2','2019-03-20 00:00:25');
INSERT INTO serverlogs4 (serverid,logdata,created) VALUES ('17','test3','2019-03-20 00:00:25');
INSERT INTO serverlogs4 (serverid,logdata,created) VALUES ('19','test4','2019-03-20 00:00:25');
INSERT INTO serverlogs4 (serverid,logdata,created) VALUES ('23','test5','2019-03-20 00:00:25');
INSERT INTO serverlogs4 (serverid,logdata,created) VALUES ('47','test6','2019-03-20 00:00:25');
INSERT INTO serverlogs4 (serverid,logdata,created) VALUES ('53','test7','2019-03-20 00:00:25');
INSERT INTO serverlogs4 (serverid,logdata,created) VALUES ('57','test8','2019-03-20 00:00:25');
INSERT INTO serverlogs4 (serverid,logdata,created) VALUES ('67','test9','2019-03-20 00:00:25');
INSERT INTO serverlogs4 (serverid,logdata,created) VALUES ('79','test10','2019-03-20 00:00:25');
```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/KeyPartitionInsert.JPG)
Menampilkan hasil partisi dengan
```
SELECT *,'p0' FROM serverlogs4 PARTITION (p0) UNION ALL 
SELECT *,'p1' FROM serverlogs4 PARTITION (p1) UNION ALL
SELECT *,'p2' FROM serverlogs4 PARTITION (p2) UNION ALL 
SELECT *,'p3' FROM serverlogs4 PARTITION (p3) UNION ALL
SELECT *,'p4' FROM serverlogs4 PARTITION (p4) UNION ALL 
SELECT *,'p5' FROM serverlogs4 PARTITION (p5) UNION ALL
SELECT *,'p6' FROM serverlogs4 PARTITION (p6) UNION ALL 
SELECT *,'p7' FROM serverlogs4 PARTITION (p7) UNION ALL
SELECT *,'p8' FROM serverlogs4 PARTITION (p8) UNION ALL 
SELECT *,'p9' FROM serverlogs4 PARTITION (p9)
ORDER BY p0 ASC;
```
Partisi dengan key sangat mirip dengan hash, tetapi key langsung melakukan partisi secara otomatis berdasarkan UNIQUE KEY.
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/KeyPartitionSelect.JPG)

# Testing "A Typical Use Case: Time Series Data"
## Explain
Explain pada tabel measures
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/Explain1.JPG)
Explain pada tabel partitioned_measures
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/Explain2.JPG)
## Benchmark
Running time saat menjalankan query benchmark pada tabel measures adalah 0.623s
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/Benchmark1.JPG)

Running time saat menjalankan query benchmark pada tabel partitioned_measures adalah 0.748s
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/Benchmark2.JPG)
## Big Delete
Penghapusan data pada tabel measures dilakukan dalam waktu 1.097s
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/BigDelete1.JPG)
Sedangkan pada tabel partitioned_measures dilakukan dalam waktu 0.035s
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/BigDelete2.JPG)

# Referensi
https://www.vertabelo.com/blog/technical-articles/everything-you-need-to-know-about-mysql-partitions
