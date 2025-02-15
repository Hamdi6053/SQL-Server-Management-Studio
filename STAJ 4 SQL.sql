 --Soru 1: Hastalarýn bilgilerinin (ID, ad, soyad, doðum tarihi, cinsiyet) saklanacaðý bir tablo nasýl oluþturulabilir?

CREATE TABLE Hasta_Bilgileri (
    ID INT PRIMARY KEY,
    AD VARCHAR(100),
    SOYAD VARCHAR(100),
    DOGUM_TARIHI DATE, 
    CINSIYET VARCHAR(10)
);
	


--Soru 2: Doktorlarýn bilgilerinin (ID, ad, soyad, uzmanlýk alaný, bölüm ID'si) saklanacaðý bir tablo nasýl oluþturulabilir ve bölümlerle iliþkilendirilebilir?

CREATE TABLE Doktor_Bilgileri(
   ID INT PRIMARY KEY,
   AD VARCHAR(100),
   SOYAD VARCHAR(100),
   UZMANLIK_ALANI VARCHAR(100),
   BOLUM_ID INT
);

--Soru 3: Bölümlerin bilgilerinin (ID, bölüm adý) saklanacaðý bir tablo nasýl oluþturulabilir?

CREATE TABLE Bolum_Bilgileri(
  ID INT PRIMARY KEY,
  BÖLÜM_ADI VARCHAR(100),
);

--ÝLÝÞKÝLENDÝRME

SELECT * FROM Doktor_Bilgileri INNER JOIN Bolum_Bilgileri ON Doktor_Bilgileri.BOLUM_ID = Bolum_Bilgileri.ID

--Soru 4: Randevularýn bilgilerinin (ID, hasta ID'si, doktor ID'si, randevu tarihi) saklanacaðý bir tablo nasýl oluþturulabilir hastalar ve doktorlarla iliþkilendirilebilir?
CREATE TABLE Randevu_Bilgileri (
    ID INT PRIMARY KEY,
    Hasta_ID INT,
    Doktor_ID INT,
    Randevu_Tarihi DATE,
);


SELECT * FROM Randevu_Bilgileri;

--ÝLÝÞKÝLENDÝRME
SELECT * FROM Randevu_Bilgileri INNER JOIN Hasta_Bilgileri ON Randevu_Bilgileri.Hasta_ID = Hasta_Bilgileri.ID
INNER JOIN Doktor_Bilgileri ON Randevu_Bilgileri.Doktor_ID = Doktor_Bilgileri.ID

--Soru 5: ' Cardiology ' ve 'Neurology' bölümleri Departments tablosuna nasýl eklenebilir?

INSERT INTO Bolum_Bilgileri(ID,BÖLÜM_ADI)
VALUES(1,'Cardiology');
INSERT INTO Bolum_Bilgileri(ID,BÖLÜM_ADI)
VALUES(2,'Neurology');

SELECT * FROM Bolum_Bilgileri;

--Soru 6: 'Emre Özeren' isimli kardiyolog ve 'Tankut Çizmeci' isimli nörolog doktorlar Doctors tablosuna nasýl eklenebilir?


INSERT INTO Doktor_Bilgileri(ID,AD,SOYAD,UZMANLIK_ALANI,BOLUM_ID)
VALUES(1,'Emre','Özeren','Cardiology',10);

INSERT INTO Doktor_Bilgileri(ID,AD,SOYAD,UZMANLIK_ALANI,BOLUM_ID)
VALUES(2,'Tankut','Çizmeci','Neurology',20);

SELECT * FROM Doktor_Bilgileri;

--Soru 7: 'Necdet Hasgül' ve 'Mehmet Özbaþ' isimli hastalar Patients tablosuna nasýl eklenebilir?
INSERT INTO Hasta_Bilgileri(ID,AD,SOYAD,DOGUM_TARIHI,CINSIYET)
VALUES(1,'Necdet','Hasgül','2001.05.23','Erkek');

INSERT INTO Hasta_Bilgileri(ID,AD,SOYAD,DOGUM_TARIHI,CINSIYET)
VALUES(2,'Mehmet','Özbaþ','2002.06.03','Erkek');

SELECT * FROM Hasta_Bilgileri;

--Soru 8: 'Necdet Hasgül' ve 'Emre Özeren' arasýndaki 5 Aðustos 2024 tarihli randevu ve 'Tankut Çizmeci' ve 'Mehmet Özbaþ' arasýndaki 6 Aðustos 2024 tarihli randevu Appointments tablosuna nasýl eklenebilir?

INSERT INTO Randevu_Bilgileri(Hasta_ID,Doktor_ID,Randevu_Tarihi)
VALUES(1,1,'2024.08.05');
INSERT INTO Randevu_Bilgileri(Hasta_ID,Doktor_ID,Randevu_Tarihi)
VALUES(2,2,'2024.08.06');
DELETE FROM Randevu_Bilgileri;
SELECT * FROM Randevu_Bilgileri;
--Soru 9: Hastalarýn isimlerini, soyisimlerini ve randevu aldýklarý doktorlarýn isimlerini, soyisimlerini ve randevu tarihlerini listeleyen bir sorgu nasýl yazýlabilir?

SELECT Hasta_Bilgileri.AD AS Hasta_Adi, Hasta_Bilgileri.SOYAD AS Haasta_Soyadi, Doktor_Bilgileri.AD AS Doktor_Adi, Doktor_Bilgileri.SOYAD AS Doktor_Soyad,Randevu_Bilgileri.Randevu_Tarihi
FROM Randevu_Bilgileri
INNER JOIN Doktor_Bilgileri ON Randevu_Bilgileri.Doktor_ID = Doktor_Bilgileri.ID 
INNER JOIN Hasta_Bilgileri ON Randevu_Bilgileri.Hasta_ID = Hasta_Bilgileri.ID;

--Soru 10: 'Cardiology' bölümündeki doktorlarýn isimlerini, soyisimlerini ve uzmanlýk alanlarýný listeleyen bir sorgu nasýl yazýlabilir?

SELECT Doktor_Bilgileri.AD, Doktor_Bilgileri.SOYAD, Doktor_Bilgileri.UZMANLIK_ALANI
FROM Doktor_Bilgileri
INNER JOIN Bolum_Bilgileri
ON Doktor_Bilgileri.BOLUM_ID = Bolum_Bilgileri.ID
WHERE Bolum_Bilgileri.BÖLÜM_ADI = 'Cardiology';

--Soru 11: 5 Aðustos 2024 tarihindeki randevularýn hasta isimlerini, soyisimlerini ve doktor isimlerini, soyisimlerini listeleyen bir sorgu nasýl yazýlabilir?

SELECT Hasta_Bilgileri.AD AS Hasta_Adi, Hasta_Bilgileri.SOYAD AS Haasta_Soyadi, Doktor_Bilgileri.AD AS Doktor_Adi, Doktor_Bilgileri.SOYAD AS Doktor_Soyadi
FROM Randevu_Bilgileri
INNER JOIN Doktor_Bilgileri ON Randevu_Bilgileri.Doktor_ID = Doktor_Bilgileri.ID 
INNER JOIN Hasta_Bilgileri ON Randevu_Bilgileri.Hasta_ID = Hasta_Bilgileri.ID
WHERE Randevu_Bilgileri.Randevu_Tarihi = '2024.08.05';

 
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 --Soru 1: Çalýþanlarýn bilgilerini (ID, ad, soyad, doðum tarihi, cinsiyet, iþe baþlama tarihi, departman ID'si) saklayacak bir tablo nasýl oluþturulabilir?
CREATE TABLE Calýsan_Bilgileri (
    ID INT IDENTITY(1,1) PRIMARY KEY, 
    Ad VARCHAR(100),                  
    Soyad VARCHAR(100),                
    DogumTarihi DATE NULL,             
    Cinsiyet CHAR(1) NULL,      
    IsBaslamaTarihi DATE NULL,        
    DepartmanID INT NULL              
);

SELECT * FROM Calýsan_Bilgileri;

--Soru 2: Departmanlarýn bilgilerini (ID, departman adý) saklayacak bir tablo nasýl oluþturulabilir?

CREATE TABLE Departman_Bilgileri(
   ID INT PRIMARY KEY,
   DEPARTMAN_ADI VARCHAR(100)
);
SELECT * FROM Departman_Bilgileri;

--Soru 3: Maaþ bilgilerini (ID, çalýþan ID'si, maaþ, maaþ baþlangýç tarihi, maaþ bitiþ tarihi) saklayacak bir tablo nasýl oluþturulabilir ve çalýþanlarla iliþkilendirilebilir?

CREATE TABLE Maas_Bilgileri(
   ID INT PRIMARY KEY,
   CALISAN_ID INT NULL,
   MAAS INT,
   MAAS_BASLANGÝC_TARÝHÝ DATE,
   MAAS_BÝTÝS_TARÝHÝ DATE
);

SELECT * FROM Maas_Bilgileri;

--ÝLÝÞKÝLENDÝRME

SELECT * FROM  Maas_Bilgileri INNER JOIN Calýsan_Bilgileri ON Maas_Bilgileri.CALISAN_ID = Calýsan_Bilgileri.ID;

--Soru 4: Performans deðerlendirme bilgilerini (ID, çalýþan ID'si, deðerlendirme tarihi, performans puaný, deðerlendirme notlarý) saklayacak bir tablo nasýl oluþturulabilir ve çalýþanlarla iliþkilendirilebilir?
CREATE TABLE Performns_Degerlendirme_Bilgileri(
      ID INT PRIMARY KEY,
	  CALISAN_ID INT NULL,
	  DEGERLENDÝRME_TARÝH DATE,
	  PERFORMANS_PUANI INT,
	  DEGERLENDÝRME_NOTLARI INT NULL
);

SELECT * FROM Performns_Degerlendirme_Bilgileri; 

SELECT * FROM Departman_Bilgileri;

--ÝLÝÞKÝLENDÝRME

SELECT * FROM Performns_Degerlendirme_Bilgileri INNER JOIN Calýsan_Bilgileri ON  Performns_Degerlendirme_Bilgileri.CALISAN_ID = Calýsan_Bilgileri.ID;

--Soru 5: 'IT' ve 'Human Resources' departmanlarý Departments tablosuna nasýl eklenebilir?

INSERT INTO Departman_Bilgileri(ID,DEPARTMAN_ADI)
VALUES(1,'IT');

INSERT INTO Departman_Bilgileri(ID,DEPARTMAN_ADI)
VALUES(2,'Human Resources');

SELECT * FROM Departman_Bilgileri;

--Soru 6: 'Ahmet Yýlmaz' isimli IT departmanýnda çalýþan ve 'Ayþe Demir' isimli Ýnsan Kaynaklarý departmanýnda çalýþan kiþiler Employees tablosuna nasýl eklenebilir?

INSERT INTO Calýsan_Bilgileri(AD,SOYAD)
VALUES('Ahmet','Yýlmaz');

INSERT INTO Calýsan_Bilgileri(AD,SOYAD)
VALUES('Ayþe','Demir');

SELECT * FROM Calýsan_Bilgileri;

--Soru 7: 'Ahmet Yýlmaz'ýn 1 Ocak 2023 - 31 Aralýk 2023 tarihleri arasýndaki maaþý 7000 TL ve 'Ayþe Demir'in 1 Ocak 2023 - 31 Aralýk 2023 tarihleri arasýndaki maaþý 6000 TL nasýl eklenebilir?

INSERT INTO Maas_Bilgileri(ID,MAAS,MAAS_BASLANGÝC_TARÝHÝ,MAAS_BÝTÝS_TARÝHÝ)
VALUES(1,7000,'2023.01.01','2023.12.31');

INSERT INTO Maas_Bilgileri(ID,MAAS,MAAS_BASLANGÝC_TARÝHÝ,MAAS_BÝTÝS_TARÝHÝ)
VALUES(2,6000,'2023.01.01','2023.01.31');

SELECT * FROM Maas_Bilgileri;

--Soru 8: 'Ahmet Yýlmaz' ve 'Ayþe Demir' için sýrasýyla 5 Ocak 2024 ve 10 Ocak 2024 tarihlerinde yapýlan performans deðerlendirmeleri (performans puaný 90 ve 85) nasýl eklenebilir?
INSERT INTO Performns_Degerlendirme_Bilgileri(ID,DEGERLENDÝRME_TARÝH,PERFORMANS_PUANI)
VALUES(1,'2024.01.05',90);

INSERT INTO Performns_Degerlendirme_Bilgileri(ID,DEGERLENDÝRME_TARÝH,PERFORMANS_PUANI)
VALUES(2,'2024.01.10',85);

SELECT * FROM Performns_Degerlendirme_Bilgileri;

--Soru 9: Çalýþanlarýn isimlerini, soyisimlerini, departmanlarýný ve maaþlarýný listeleyen bir sorgu nasýl yazýlabilir?
SELECT Calýsan_Bilgileri.Ad,Calýsan_Bilgileri.Soyad,Departman_Bilgileri.DEPARTMAN_ADI,Maas_Bilgileri.MAAS FROM Maas_Bilgileri 
INNER JOIN Calýsan_Bilgileri ON Maas_Bilgileri.ID = Calýsan_Bilgileri.ID
INNER JOIN Departman_Bilgileri ON Maas_Bilgileri.ID = Departman_Bilgileri.ID;

--Soru 10: 'IT' departmanýndaki çalýþanlarýn isimlerini, soyisimlerini ve performans puanlarýný listeleyen bir sorgu nasýl yazýlabilir?
SELECT Departman_Bilgileri.DEPARTMAN_ADI,Calýsan_Bilgileri.Ad,Calýsan_Bilgileri.Soyad,Performns_Degerlendirme_Bilgileri.PERFORMANS_PUANI
FROM Calýsan_Bilgileri
INNER JOIN Departman_Bilgileri ON Calýsan_Bilgileri.ID = Departman_Bilgileri.ID
INNER JOIN Performns_Degerlendirme_Bilgileri ON Calýsan_Bilgileri.ID = Performns_Degerlendirme_Bilgileri.ID
WHERE Departman_Bilgileri.DEPARTMAN_ADI = 'IT';

--Soru 11: '1 Ocak 2024' tarihinden sonra yapýlan performans deðerlendirmelerinde puaný 80'in üzerinde olan çalýþanlarýn isimlerini, soyisimlerini ve deðerlendirme notlarýný listeleyen bir sorgu nasýl yazýlabilir?
SELECT Calýsan_Bilgileri.Ad,Calýsan_Bilgileri.Soyad,Performns_Degerlendirme_Bilgileri.DEGERLENDÝRME_NOTLARI
FROM Performns_Degerlendirme_Bilgileri
INNER JOIN Calýsan_Bilgileri ON Performns_Degerlendirme_Bilgileri.ID=Calýsan_Bilgileri.ID
WHERE Performns_Degerlendirme_Bilgileri.DEGERLENDÝRME_TARÝH > '2024.01.01' AND Performns_Degerlendirme_Bilgileri.PERFORMANS_PUANI > 80;

--Soru 12: Çalýþanlarýn ortalama maaþlarýný departman bazýnda listeleyen bir sorgu nasýl yazýlabilir?

SELECT AVG(Maas_Bilgileri.MAAS) AS [ORTALAMA_MAAS] ,Departman_Bilgileri.DEPARTMAN_ADI
FROM Maas_Bilgileri
INNER JOIN Calýsan_Bilgileri ON Maas_Bilgileri.ID = Calýsan_Bilgileri.ID
INNER JOIN Departman_Bilgileri ON Maas_Bilgileri.ID = Departman_Bilgileri.ID
GROUP BY Departman_Bilgileri.DEPARTMAN_ADI
ORDER BY Departman_Bilgileri.DEPARTMAN_ADI; 


--Soru 13: Ayný departmanda çalýþan ve maaþý 5000 TL'nin üzerinde olan çalýþanlarýn isimlerini, soyisimlerini ve departmanlarýný listeleyen bir sorgu nasýl yazýlabilir?

SELECT DISTINCT c1.Ad, c1.Soyad, d.DEPARTMAN_ADI
FROM Calýsan_Bilgileri c1
INNER JOIN Departman_Bilgileri d ON c1.ID = d.ID
INNER JOIN Maas_Bilgileri m ON c1.ID = m.CALISAN_ID
INNER JOIN Calýsan_Bilgileri c2 ON d.ID = c2.ID
INNER JOIN Maas_Bilgileri m2 ON c2.ID = m2.CALISAN_ID
WHERE m.MAAS > 5000
  AND m2.MAAS > 5000
  AND c1.ID <> c2.ID
ORDER BY d.DEPARTMAN_ADI, c1.Soyad;