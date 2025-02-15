 --Soru 1: Hastalar�n bilgilerinin (ID, ad, soyad, do�um tarihi, cinsiyet) saklanaca�� bir tablo nas�l olu�turulabilir?

CREATE TABLE Hasta_Bilgileri (
    ID INT PRIMARY KEY,
    AD VARCHAR(100),
    SOYAD VARCHAR(100),
    DOGUM_TARIHI DATE, 
    CINSIYET VARCHAR(10)
);
	


--Soru 2: Doktorlar�n bilgilerinin (ID, ad, soyad, uzmanl�k alan�, b�l�m ID'si) saklanaca�� bir tablo nas�l olu�turulabilir ve b�l�mlerle ili�kilendirilebilir?

CREATE TABLE Doktor_Bilgileri(
   ID INT PRIMARY KEY,
   AD VARCHAR(100),
   SOYAD VARCHAR(100),
   UZMANLIK_ALANI VARCHAR(100),
   BOLUM_ID INT
);

--Soru 3: B�l�mlerin bilgilerinin (ID, b�l�m ad�) saklanaca�� bir tablo nas�l olu�turulabilir?

CREATE TABLE Bolum_Bilgileri(
  ID INT PRIMARY KEY,
  B�L�M_ADI VARCHAR(100),
);

--�L��K�LEND�RME

SELECT * FROM Doktor_Bilgileri INNER JOIN Bolum_Bilgileri ON Doktor_Bilgileri.BOLUM_ID = Bolum_Bilgileri.ID

--Soru 4: Randevular�n bilgilerinin (ID, hasta ID'si, doktor ID'si, randevu tarihi) saklanaca�� bir tablo nas�l olu�turulabilir hastalar ve doktorlarla ili�kilendirilebilir?
CREATE TABLE Randevu_Bilgileri (
    ID INT PRIMARY KEY,
    Hasta_ID INT,
    Doktor_ID INT,
    Randevu_Tarihi DATE,
);


SELECT * FROM Randevu_Bilgileri;

--�L��K�LEND�RME
SELECT * FROM Randevu_Bilgileri INNER JOIN Hasta_Bilgileri ON Randevu_Bilgileri.Hasta_ID = Hasta_Bilgileri.ID
INNER JOIN Doktor_Bilgileri ON Randevu_Bilgileri.Doktor_ID = Doktor_Bilgileri.ID

--Soru 5: ' Cardiology ' ve 'Neurology' b�l�mleri Departments tablosuna nas�l eklenebilir?

INSERT INTO Bolum_Bilgileri(ID,B�L�M_ADI)
VALUES(1,'Cardiology');
INSERT INTO Bolum_Bilgileri(ID,B�L�M_ADI)
VALUES(2,'Neurology');

SELECT * FROM Bolum_Bilgileri;

--Soru 6: 'Emre �zeren' isimli kardiyolog ve 'Tankut �izmeci' isimli n�rolog doktorlar Doctors tablosuna nas�l eklenebilir?


INSERT INTO Doktor_Bilgileri(ID,AD,SOYAD,UZMANLIK_ALANI,BOLUM_ID)
VALUES(1,'Emre','�zeren','Cardiology',10);

INSERT INTO Doktor_Bilgileri(ID,AD,SOYAD,UZMANLIK_ALANI,BOLUM_ID)
VALUES(2,'Tankut','�izmeci','Neurology',20);

SELECT * FROM Doktor_Bilgileri;

--Soru 7: 'Necdet Hasg�l' ve 'Mehmet �zba�' isimli hastalar Patients tablosuna nas�l eklenebilir?
INSERT INTO Hasta_Bilgileri(ID,AD,SOYAD,DOGUM_TARIHI,CINSIYET)
VALUES(1,'Necdet','Hasg�l','2001.05.23','Erkek');

INSERT INTO Hasta_Bilgileri(ID,AD,SOYAD,DOGUM_TARIHI,CINSIYET)
VALUES(2,'Mehmet','�zba�','2002.06.03','Erkek');

SELECT * FROM Hasta_Bilgileri;

--Soru 8: 'Necdet Hasg�l' ve 'Emre �zeren' aras�ndaki 5 A�ustos 2024 tarihli randevu ve 'Tankut �izmeci' ve 'Mehmet �zba�' aras�ndaki 6 A�ustos 2024 tarihli randevu Appointments tablosuna nas�l eklenebilir?

INSERT INTO Randevu_Bilgileri(Hasta_ID,Doktor_ID,Randevu_Tarihi)
VALUES(1,1,'2024.08.05');
INSERT INTO Randevu_Bilgileri(Hasta_ID,Doktor_ID,Randevu_Tarihi)
VALUES(2,2,'2024.08.06');
DELETE FROM Randevu_Bilgileri;
SELECT * FROM Randevu_Bilgileri;
--Soru 9: Hastalar�n isimlerini, soyisimlerini ve randevu ald�klar� doktorlar�n isimlerini, soyisimlerini ve randevu tarihlerini listeleyen bir sorgu nas�l yaz�labilir?

SELECT Hasta_Bilgileri.AD AS Hasta_Adi, Hasta_Bilgileri.SOYAD AS Haasta_Soyadi, Doktor_Bilgileri.AD AS Doktor_Adi, Doktor_Bilgileri.SOYAD AS Doktor_Soyad,Randevu_Bilgileri.Randevu_Tarihi
FROM Randevu_Bilgileri
INNER JOIN Doktor_Bilgileri ON Randevu_Bilgileri.Doktor_ID = Doktor_Bilgileri.ID 
INNER JOIN Hasta_Bilgileri ON Randevu_Bilgileri.Hasta_ID = Hasta_Bilgileri.ID;

--Soru 10: 'Cardiology' b�l�m�ndeki doktorlar�n isimlerini, soyisimlerini ve uzmanl�k alanlar�n� listeleyen bir sorgu nas�l yaz�labilir?

SELECT Doktor_Bilgileri.AD, Doktor_Bilgileri.SOYAD, Doktor_Bilgileri.UZMANLIK_ALANI
FROM Doktor_Bilgileri
INNER JOIN Bolum_Bilgileri
ON Doktor_Bilgileri.BOLUM_ID = Bolum_Bilgileri.ID
WHERE Bolum_Bilgileri.B�L�M_ADI = 'Cardiology';

--Soru 11: 5 A�ustos 2024 tarihindeki randevular�n hasta isimlerini, soyisimlerini ve doktor isimlerini, soyisimlerini listeleyen bir sorgu nas�l yaz�labilir?

SELECT Hasta_Bilgileri.AD AS Hasta_Adi, Hasta_Bilgileri.SOYAD AS Haasta_Soyadi, Doktor_Bilgileri.AD AS Doktor_Adi, Doktor_Bilgileri.SOYAD AS Doktor_Soyadi
FROM Randevu_Bilgileri
INNER JOIN Doktor_Bilgileri ON Randevu_Bilgileri.Doktor_ID = Doktor_Bilgileri.ID 
INNER JOIN Hasta_Bilgileri ON Randevu_Bilgileri.Hasta_ID = Hasta_Bilgileri.ID
WHERE Randevu_Bilgileri.Randevu_Tarihi = '2024.08.05';

 
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 --Soru 1: �al��anlar�n bilgilerini (ID, ad, soyad, do�um tarihi, cinsiyet, i�e ba�lama tarihi, departman ID'si) saklayacak bir tablo nas�l olu�turulabilir?
CREATE TABLE Cal�san_Bilgileri (
    ID INT IDENTITY(1,1) PRIMARY KEY, 
    Ad VARCHAR(100),                  
    Soyad VARCHAR(100),                
    DogumTarihi DATE NULL,             
    Cinsiyet CHAR(1) NULL,      
    IsBaslamaTarihi DATE NULL,        
    DepartmanID INT NULL              
);

SELECT * FROM Cal�san_Bilgileri;

--Soru 2: Departmanlar�n bilgilerini (ID, departman ad�) saklayacak bir tablo nas�l olu�turulabilir?

CREATE TABLE Departman_Bilgileri(
   ID INT PRIMARY KEY,
   DEPARTMAN_ADI VARCHAR(100)
);
SELECT * FROM Departman_Bilgileri;

--Soru 3: Maa� bilgilerini (ID, �al��an ID'si, maa�, maa� ba�lang�� tarihi, maa� biti� tarihi) saklayacak bir tablo nas�l olu�turulabilir ve �al��anlarla ili�kilendirilebilir?

CREATE TABLE Maas_Bilgileri(
   ID INT PRIMARY KEY,
   CALISAN_ID INT NULL,
   MAAS INT,
   MAAS_BASLANG�C_TAR�H� DATE,
   MAAS_B�T�S_TAR�H� DATE
);

SELECT * FROM Maas_Bilgileri;

--�L��K�LEND�RME

SELECT * FROM  Maas_Bilgileri INNER JOIN Cal�san_Bilgileri ON Maas_Bilgileri.CALISAN_ID = Cal�san_Bilgileri.ID;

--Soru 4: Performans de�erlendirme bilgilerini (ID, �al��an ID'si, de�erlendirme tarihi, performans puan�, de�erlendirme notlar�) saklayacak bir tablo nas�l olu�turulabilir ve �al��anlarla ili�kilendirilebilir?
CREATE TABLE Performns_Degerlendirme_Bilgileri(
      ID INT PRIMARY KEY,
	  CALISAN_ID INT NULL,
	  DEGERLEND�RME_TAR�H DATE,
	  PERFORMANS_PUANI INT,
	  DEGERLEND�RME_NOTLARI INT NULL
);

SELECT * FROM Performns_Degerlendirme_Bilgileri; 

SELECT * FROM Departman_Bilgileri;

--�L��K�LEND�RME

SELECT * FROM Performns_Degerlendirme_Bilgileri INNER JOIN Cal�san_Bilgileri ON  Performns_Degerlendirme_Bilgileri.CALISAN_ID = Cal�san_Bilgileri.ID;

--Soru 5: 'IT' ve 'Human Resources' departmanlar� Departments tablosuna nas�l eklenebilir?

INSERT INTO Departman_Bilgileri(ID,DEPARTMAN_ADI)
VALUES(1,'IT');

INSERT INTO Departman_Bilgileri(ID,DEPARTMAN_ADI)
VALUES(2,'Human Resources');

SELECT * FROM Departman_Bilgileri;

--Soru 6: 'Ahmet Y�lmaz' isimli IT departman�nda �al��an ve 'Ay�e Demir' isimli �nsan Kaynaklar� departman�nda �al��an ki�iler Employees tablosuna nas�l eklenebilir?

INSERT INTO Cal�san_Bilgileri(AD,SOYAD)
VALUES('Ahmet','Y�lmaz');

INSERT INTO Cal�san_Bilgileri(AD,SOYAD)
VALUES('Ay�e','Demir');

SELECT * FROM Cal�san_Bilgileri;

--Soru 7: 'Ahmet Y�lmaz'�n 1 Ocak 2023 - 31 Aral�k 2023 tarihleri aras�ndaki maa�� 7000 TL ve 'Ay�e Demir'in 1 Ocak 2023 - 31 Aral�k 2023 tarihleri aras�ndaki maa�� 6000 TL nas�l eklenebilir?

INSERT INTO Maas_Bilgileri(ID,MAAS,MAAS_BASLANG�C_TAR�H�,MAAS_B�T�S_TAR�H�)
VALUES(1,7000,'2023.01.01','2023.12.31');

INSERT INTO Maas_Bilgileri(ID,MAAS,MAAS_BASLANG�C_TAR�H�,MAAS_B�T�S_TAR�H�)
VALUES(2,6000,'2023.01.01','2023.01.31');

SELECT * FROM Maas_Bilgileri;

--Soru 8: 'Ahmet Y�lmaz' ve 'Ay�e Demir' i�in s�ras�yla 5 Ocak 2024 ve 10 Ocak 2024 tarihlerinde yap�lan performans de�erlendirmeleri (performans puan� 90 ve 85) nas�l eklenebilir?
INSERT INTO Performns_Degerlendirme_Bilgileri(ID,DEGERLEND�RME_TAR�H,PERFORMANS_PUANI)
VALUES(1,'2024.01.05',90);

INSERT INTO Performns_Degerlendirme_Bilgileri(ID,DEGERLEND�RME_TAR�H,PERFORMANS_PUANI)
VALUES(2,'2024.01.10',85);

SELECT * FROM Performns_Degerlendirme_Bilgileri;

--Soru 9: �al��anlar�n isimlerini, soyisimlerini, departmanlar�n� ve maa�lar�n� listeleyen bir sorgu nas�l yaz�labilir?
SELECT Cal�san_Bilgileri.Ad,Cal�san_Bilgileri.Soyad,Departman_Bilgileri.DEPARTMAN_ADI,Maas_Bilgileri.MAAS FROM Maas_Bilgileri 
INNER JOIN Cal�san_Bilgileri ON Maas_Bilgileri.ID = Cal�san_Bilgileri.ID
INNER JOIN Departman_Bilgileri ON Maas_Bilgileri.ID = Departman_Bilgileri.ID;

--Soru 10: 'IT' departman�ndaki �al��anlar�n isimlerini, soyisimlerini ve performans puanlar�n� listeleyen bir sorgu nas�l yaz�labilir?
SELECT Departman_Bilgileri.DEPARTMAN_ADI,Cal�san_Bilgileri.Ad,Cal�san_Bilgileri.Soyad,Performns_Degerlendirme_Bilgileri.PERFORMANS_PUANI
FROM Cal�san_Bilgileri
INNER JOIN Departman_Bilgileri ON Cal�san_Bilgileri.ID = Departman_Bilgileri.ID
INNER JOIN Performns_Degerlendirme_Bilgileri ON Cal�san_Bilgileri.ID = Performns_Degerlendirme_Bilgileri.ID
WHERE Departman_Bilgileri.DEPARTMAN_ADI = 'IT';

--Soru 11: '1 Ocak 2024' tarihinden sonra yap�lan performans de�erlendirmelerinde puan� 80'in �zerinde olan �al��anlar�n isimlerini, soyisimlerini ve de�erlendirme notlar�n� listeleyen bir sorgu nas�l yaz�labilir?
SELECT Cal�san_Bilgileri.Ad,Cal�san_Bilgileri.Soyad,Performns_Degerlendirme_Bilgileri.DEGERLEND�RME_NOTLARI
FROM Performns_Degerlendirme_Bilgileri
INNER JOIN Cal�san_Bilgileri ON Performns_Degerlendirme_Bilgileri.ID=Cal�san_Bilgileri.ID
WHERE Performns_Degerlendirme_Bilgileri.DEGERLEND�RME_TAR�H > '2024.01.01' AND Performns_Degerlendirme_Bilgileri.PERFORMANS_PUANI > 80;

--Soru 12: �al��anlar�n ortalama maa�lar�n� departman baz�nda listeleyen bir sorgu nas�l yaz�labilir?

SELECT AVG(Maas_Bilgileri.MAAS) AS [ORTALAMA_MAAS] ,Departman_Bilgileri.DEPARTMAN_ADI
FROM Maas_Bilgileri
INNER JOIN Cal�san_Bilgileri ON Maas_Bilgileri.ID = Cal�san_Bilgileri.ID
INNER JOIN Departman_Bilgileri ON Maas_Bilgileri.ID = Departman_Bilgileri.ID
GROUP BY Departman_Bilgileri.DEPARTMAN_ADI
ORDER BY Departman_Bilgileri.DEPARTMAN_ADI; 


--Soru 13: Ayn� departmanda �al��an ve maa�� 5000 TL'nin �zerinde olan �al��anlar�n isimlerini, soyisimlerini ve departmanlar�n� listeleyen bir sorgu nas�l yaz�labilir?

SELECT DISTINCT c1.Ad, c1.Soyad, d.DEPARTMAN_ADI
FROM Cal�san_Bilgileri c1
INNER JOIN Departman_Bilgileri d ON c1.ID = d.ID
INNER JOIN Maas_Bilgileri m ON c1.ID = m.CALISAN_ID
INNER JOIN Cal�san_Bilgileri c2 ON d.ID = c2.ID
INNER JOIN Maas_Bilgileri m2 ON c2.ID = m2.CALISAN_ID
WHERE m.MAAS > 5000
  AND m2.MAAS > 5000
  AND c1.ID <> c2.ID
ORDER BY d.DEPARTMAN_ADI, c1.Soyad;