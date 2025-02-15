[19:58, 25.10.2024] ZAAFIM💕: select * from dbo.Bolgeler;

--select TerritoryTanimi from dbo.Bolgeler
--where TerritoryTanimi LIKE '%os%';

select TerritoryID from dbo.Bolgeler
where SUBSTRING(TerritoryID , 2, 2) = '34';

select dbo.Bolgeler.* , SUBSTRING(TerritoryID , 2, 2) AS Karakter from  dbo.Bolgeler;

ALTER TABLE dbo.Bolgeler
ADD Karakter AS SUBSTRING(TerritoryID , 2, 2);



SELECT *,
       CASE  
           WHEN Karakter = '52' THEN 'ORDU'
           WHEN Karakter = '41' THEN 'KOCAELİ'
           WHEN Karakter = '28' THEN 'GİRESUN'
           WHEN Karakter = '34' THEN 'İSTANBUL'
           WHEN Karakter = '54' THEN 'SAKARYA'
           ELSE 'PLAKA YOK'
       END AS KarakterDescription
FROM dbo.bolgeler;
 
 select * from dbo.Bolgeler
 Group By BolgeID;
[20:00, 25.10.2024] ZAAFIM💕: select * from dbo.Bolgeler;

select TerritoryTanimi from dbo.Bolgeler
where TerritoryTanimi LIKE '%os%';

select TerritoryID from dbo.Bolgeler
where SUBSTRING(TerritoryID , 2, 2) = '34';

select dbo.Bolgeler.* , SUBSTRING(TerritoryID , 2, 2) AS Karakter from  dbo.Bolgeler;

ALTER TABLE dbo.Bolgeler
ADD Karakter AS SUBSTRING(TerritoryID , 2, 2);

ALTER TABLE dbo.Bolgeler
DROP COLUMN Karakter;

SELECT * FROM dbo.Bolgeler;

SELECT *,
       CASE  
           WHEN Karakter = '52' THEN 'ORDU'
           WHEN Karakter = '41' THEN 'KOCAELİ'
           WHEN Karakter = '28' THEN 'GİRESUN'
           WHEN Karakter = '34' THEN 'İSTANBUL'
           WHEN Karakter = '54' THEN 'SAKARYA'
           ELSE 'PLAKA YOK'
       END AS KarakterDescription
FROM dbo.bolgeler;
 
select * from dbo.Bolgeler
Group By BolgeID;

SELECT * FROM dbo.Personeller
WHERE UnvanEki = 'Ms.' AND Bolge IS NULL; 

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
           WHEN Karakter = '41' THEN 'KOCAELİ'
           WHEN Karakter = '28' THEN 'GİRESUN'
           WHEN Karakter = '34' THEN 'İSTANBUL'
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
 VALUES('ALİ',1215);

 INSERT INTO SINIF(Ogrenci_adi,Ogrenci_no)
 VALUES('TUGBA',65);

DELETE FROM SINIF;

select * from SINIF

DROP TABLE SINIF;

SELECT * FROM SINIF;

select * from dbo.Bolge;

select * from dbo.Kategoriler,dbo.Bolge,dbo.Bolgeler,dbo.Tedarikciler;

select * from dbo.Nakliyeciler;

select * from dbo.Tedarikciler;

select * from dbo.Tedarikciler LEFT JOIN dbo.Nakliyeciler ON dbo.Tedarikciler.SirketAdi = dbo.Nakliyeciler.SirketAdi;

select * from dbo.Tedarikciler RIGHT JOIN dbo.Nakliyeciler ON dbo.Tedarikciler.SirketAdi = dbo.Nakliyeciler.SirketAdi;

select NakliyeciID
from dbo.Tedarikciler 
RIGHT JOIN dbo.Nakliyeciler ON dbo.Tedarikciler.SirketAdi = dbo.Nakliyeciler.SirketAdi
WHERE NakliyeciID = '2'
ORDER BY NakliyeciID DESC;

select dbo.Tedarikciler.Adres from dbo.Tedarikciler LEFT JOIN dbo.Nakliyeciler ON dbo.Tedarikciler.SirketAdi = dbo.Nakliyeciler.SirketAdi
where  dbo.Tedarikciler.Adres LIKE '%an%'
Order by dbo.Tedarikciler.Adres ASC;

WITH YeniProje AS(
     SELECT Adres,Bolge,Sehir
	 FROM dbo.Tedarikciler
)
SELECT * FROM YeniProje;

SELECT 
    CASE 
        WHEN Ulke = 'Australia' THEN '12'
        ELSE 'NULL'
    END AS YeniUlkeKodlari
FROM dbo.Tedarikciler;

WITH YENİ_PROJE AS(
     SELECT Sehir 
	 FROM dbo.Tedarikciler
)
SELECT * FROM YENİ_PROJE
WHERE Sehir = 'London';

WITH YENİ_PROJE AS(
     SELECT Sehir 
	 FROM dbo.Tedarikciler
)
SELECT * FROM YENİ_PROJE
ORDER BY  Sehir DESC;

SELECT * FROM dbo.Musteriler
WHERE Sehir = 'London'
ORDER BY MusteriID;

SELECT * FROM dbo.Satislar;

CREATE TABLE SINIF(
Ders_No NUMERIC(10,2),
DERS_Adi VARCHAR(25),
);

INSERT INTO SINIF(Ders_No,DERS_Adi)
VALUES(1213,'Hayat Bilgisi');

SELECT * FROM SINIF;

DELETE FROM SINIF;

DROP TABLE SINIF;

SELECT * FROM SINIF;

SELECT dbo.Bolgeler.BolgeID FROM dbo.Bolgeler;
SELECT * FROM dbo.Bolge;

SELECT * FROM dbo.Bolgeler LEFT JOIN dbo.Bolge ON dbo.Bolgeler.BolgeID = dbo.Bolge.BolgeID;

SELECT dbo.Bolgeler.BolgeID FROM dbo.Bolgeler RIGHT JOIN dbo.Bolge ON dbo.Bolgeler.BolgeID = dbo.Bolge.BolgeID;

SELECT * FROM dbo.Bolge RIGHT JOIN dbo.Bolgeler ON dbo.Bolgeler.BolgeID = dbo.Bolge.BolgeID;

SELECT * FROM dbo.Bolgeler INNER JOIN dbo.Bolge ON dbo.Bolgeler.BolgeID = dbo.Bolge.BolgeID;

SELECT * FROM dbo.Bolgeler;

SELECT * FROM dbo.Bolge;
    
	SELECT 
    CASE
        WHEN BolgeTanimi = 'Northern' THEN 'A'
        WHEN BolgeTanimi = 'Southern' THEN 'B'
        ELSE 'C'
    END AS BolgeSonucu
FROM dbo.Bolge;

SELECT * FROM PersonelBolgeler;
SELECT * FROM dbo.Tedarikciler;
SELECT * FROM dbo.Musteriler;

SELECT dbo.Tedarikciler.MusteriAdi,dbo.Tedarikciler.Ulke FROM dbo.Tedarikciler LEFT JOIN dbo.Musteriler ON dbo.Tedarikciler.SirketAdi = dbo.Musteriler.SirketAdi
WHERE dbo.Tedarikciler.MusteriAdi LIKE '%R'
GROUP BY dbo.Tedarikciler.Ulke,dbo.Tedarikciler.MusteriAdi
HAVING dbo.Tedarikciler.Ulke = 'USA';

-- SELECT İFADESİNDE BULUNUN KOLONLARIN GROUP BY KOLONUNDA BİREBİR BULUNMASI GEREK.

SELECT * FROM dbo.Tedarikciler INNER JOIN dbo.Musteriler ON dbo.Tedarikciler.SirketAdi = dbo.Musteriler.SirketAdi;

WITH YeniIsım AS(
    SELECT dbo.Tedarikciler.MusteriAdi,dbo.Tedarikciler.Ulke 
	FROM dbo.Tedarikciler LEFT JOIN dbo.Musteriler ON dbo.Tedarikciler.SirketAdi = dbo.Musteriler.SirketAdi
    WHERE dbo.Tedarikciler.MusteriAdi LIKE '%R'
    GROUP BY dbo.Tedarikciler.Ulke,dbo.Tedarikciler.MusteriAdi
    HAVING dbo.Tedarikciler.Ulke = 'USA'
)
SELECT * FROM YeniIsım;

  WITH YeniIsım AS (
    SELECT 
        dbo.Tedarikciler.MusteriAdi,
        dbo.Tedarikciler.Ulke 
    FROM dbo.Tedarikciler 
    LEFT JOIN dbo.Musteriler 
        ON dbo.Tedarikciler.SirketAdi = dbo.Musteriler.SirketAdi
    WHERE dbo.Tedarikciler.MusteriAdi LIKE '%R'
    GROUP BY dbo.Tedarikciler.Ulke, dbo.Tedarikciler.MusteriAdi
    HAVING dbo.Tedarikciler.Ulke = 'USA'
)
SELECT 
    MusteriAdi,
    Ulke,
    CASE 
        WHEN MusteriAdi = 'Cherly Saylor' THEN 'A'
        ELSE 'Other'f4
    END AS MusteriIsmi
FROM YeniIsım;

SELECT PersonelID FROM dbo.PersonelBolgeler
GROUP BY PersonelID;

SELECT TOP 3 PersonelID FROM  dbo.PersonelBolgeler
GROUP BY PersonelID
ORDER BY PersonelID DESC

SELECT * FROM dbo.[Satis Detaylari];
SELECT COUNT(*) FROM dbo.[Satis Detaylari];

SELECT SUM(Miktar) AS [Toplam Miktar] 
FROM dbo.[Satis Detaylari];

SELECT AVG(Miktar) AS [Ortalama Miktar] 
FROM dbo.[Satis Detaylari];

SELECT POWER (Miktar,2) AS [Kare_Miktar] 
FROM dbo.[Satis Detaylari];
 
SELECT MIN (Miktar) AS [Minimum Miktar	] 
FROM dbo.[Satis Detaylari];

SELECT MAX(Miktar)  AS [Maximum Miktar] 
FROM dbo.[Satis Detaylari];

SELECT ROUND(POWER (Miktar,2), 1) AS [MİKTAR İSLENMİS HALİ] FROM dbo.[Satis Detaylari];



SELECT 
       SUM(Miktar) AS [Toplam Miktar],
       AVG(Miktar) AS [Ortalama Miktar] ,
	   POWER (Miktar,2) AS [Kare_Miktar], 
	   MIN (Miktar) AS [Minimum Miktar] ,
	   MAX(Miktar)  AS [Maximum Miktar],
	   COUNT(Miktar) AS [Satır Satısı Toplam]
 FROM dbo.[Satis Detaylari]
 GROUP BY Miktar;

 -- Her miktar için grup oluşturarak ayrı yarı hesaplama yapacak.

--SELECT dbo.[Satis Detaylari].*,COUNT(Miktar) AS [Satır Satısı Toplam]  FROM dbo.[Satis Detaylari]
--GROUP BY Miktar;

SELECT * FROM dbo.[Satis Detaylari];
SELECT * FROM dbo.Satislar;

SELECT * FROM dbo.Satislar INNER JOIN dbo.[Satis Detaylari] ON dbo.Satislar.SatisID = dbo.[Satis Detaylari].SatisID;

SELECT DISTINCT(Ulke) FROM dbo.Musteriler;

SELECT * FROM dbo.Musteriler;

--UPDATE dbo.Musteriler
--SET Ulke = CASE 
                --WHEN Ulke IN ('Austria','Belgium', 'Denmark', 'Finland', 'France', 'Germany','Ireland','Italy','Norway','Poland','Porugal','Spain','Sweden','Switzerland','UK') THEN 'EMEA'
				--WHEN Ulke IN ('Canada','USA') THEN 'UCAN'
				--WHEN Ulke IN ('Argentina','Brazil','Mexico','Venezuela') THEN 'LATAM'
				--ELSE 'APAC'
			--END;
SELECT * FROM dbo.Musteriler;