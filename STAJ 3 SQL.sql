select * from dbo.Bolgeler;

select TerritoryTanimi from dbo.Bolgeler
where TerritoryTanimi LIKE '%os%';

select TerritoryID from dbo.Bolgeler
where SUBSTRING(TerritoryID , 2, 2) = '34';

select dbo.Bolgeler.* , SUBSTRING(TerritoryID , 2, 2) AS Karakter from  dbo.Bolgeler;

ALTER TABLE dbo.Bolgeler
ADD Karakter AS SUBSTRING(TerritoryID , 2, 2);



SELECT *,
       CASE  
           WHEN Karakter = '52' THEN 'ORDU'
           WHEN Karakter = '41' THEN 'KOCAELÝ'
           WHEN Karakter = '28' THEN 'GÝRESUN'
           WHEN Karakter = '34' THEN 'ÝSTANBUL'
           WHEN Karakter = '54' THEN 'SAKARYA'
           ELSE 'PLAKA YOK'
       END AS KarakterDescription
FROM dbo.bolgeler;
 
 select * from dbo.Bolgeler
 Group By BolgeID;

 select * from dbo.Kategoriler
 Order By KategoriAdi;

 select * from dbo.Kategoriler
 Order By KategoriAdi DESC;

 select Tanimi from dbo.Kategoriler
 where Tanimi LIKE '%ed%';

 CREATE TABLE SINIF(
 Ogrenci_adi VARCHAR(20) NOT NULL,
 Ogrenci_no NUMERIC(10,0));

 select * from SINIF;

 INSERT INTO SINIF(Ogrenci_adi,Ogrenci_no)
 VALUES('MEHMET',1213121352)

 select * from SINIF;

 INSERT INTO SINIF(Ogrenci_adi,Ogrenci_no)
 VALUES('ALÝ',1215);

 INSERT INTO SINIF(Ogrenci_adi,Ogrenci_no)
 VALUES('TUGBA',65);

DELETE FROM SINIF;

select * from SINIF

DROP TABLE SINIF;

SELECT * FROM SINIF;

select * from dbo.Bolge;