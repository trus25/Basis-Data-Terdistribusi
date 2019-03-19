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
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/ListPartition1.JPG)
![alt](https://github.com/trus25/Basis-Data-Terdistribusi/blob/master/Tugas-implementasi-partisi/Screenshoot/ListPartitionInsert.JPG)
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
