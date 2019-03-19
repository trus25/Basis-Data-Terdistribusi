# Partition
## Range Partition
Create tabel serta melakukan partisi p0 < 5,12 selain itu akan di masukkan ke p3.
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
Create tabel serta melakukan partisi dengan membagikan daftar ```servername``` ke ```server_east``` dan ```server_west```
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
Menampilkan hasil partisi dengan ```SELECT *,'server_east' FROM serverlogs PARTITION (server_east) UNION ALL SELECT *,'server_west' 
FROM serverlogs PARTITION (server_west) ORDER BY server_east ASC;```
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/ListPartitionSelect.JPG)
## Hash Partition
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/HashPartition1.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/HashPartitionInsert.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/HashPartitionSelect.JPG)
## Key Partition
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/KeyPartition1.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/KeyPartitionInsert.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/KeyPartitionSelect.JPG)

# Testing "A Typical Use Case: Time Series Data"
## Explain
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/Explain1.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/Explain2.JPG)
## Benchmark
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/Benchmark1.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/Benchmark2.JPG)
## Big Delete
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/BigDelete.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/BigDelete1.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/BigDelete2.JPG)
