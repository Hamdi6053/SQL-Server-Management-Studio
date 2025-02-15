/*Senaryo:
"Öðrencilerin genel durumunu deðerlendiren bir sorgu yazýn:
Ýlk olarak öðrencinin durumunu kontrol edin:
Eðer mezun olmuþsa ve ortalamasý:
80 üstü ise 'Onur Dereceli Mezun'
70-80 arasý ise 'Baþarýlý Mezun'
70 altý ise 'Normal Mezun'
Eðer hala öðrenciyse:
4 yýlý geçmiþ ve ortalamasý 50 altýysa 'Riskli Öðrenci'
4 yýlý geçmiþ ve ortalamasý 50 üstüyse 'Uzatmalý Öðrenci'
4 yýlý geçmemiþ ve ortalamasý 70 üstüyse 'Baþarýlý Öðrenci'
4 yýlý geçmemiþ ve ortalamasý 50-70 arasýysa 'Normal Öðrenci'
4 yýlý geçmemiþ ve ortalamasý 50 altýysa 'Destek Gerekli'
Öðrenci Bilgileri
Fakülte/Bölüm
Baþlangýç Tarihi
Mezuniyet Tarihi (varsa)
Genel Not Ortalamasý
Durum Deðerlendirmesi"
*/
select * from tOgrenciler
select * from tDersiAlanOgrenciler

SELECT 
    K.Adi AS 'Öðrencinin Adi',
    K.Soyadi as 'Öðrencinin Soyadi',
    O.BaslangicTarihi as 'BaslangýcTarihi',
    O.MezuniyetTarihi as 'MezuniyetTarihi',
    (D.Vize*0.4 + D.Final*0.6) as 'GenelNotOrtalamasý',
    CASE
        WHEN O.MezuniyetTarihi IS NOT NULL THEN 
            CASE
                WHEN (D.Vize*0.4 + D.Final*0.6) > 80 THEN 'Onur Dereceli Mezun'
                WHEN (D.Vize*0.4 + D.Final*0.6) BETWEEN 70 AND 80 THEN 'Baþarýlý Mezun'
                WHEN (D.Vize*0.4 + D.Final*0.6) < 70 THEN 'Normal Mezun'
                ELSE 'Deðerlendirme Dýþý'
            END
        ELSE 
            CASE
                WHEN DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) > 4 THEN
                    CASE
                        WHEN (D.Vize*0.4 + D.Final*0.6) < 50 THEN 'Riskli Öðrenci'
                        ELSE 'Uzatmalý Öðrenci'
                    END
                ELSE
                    CASE
                        WHEN (D.Vize*0.4 + D.Final*0.6) > 70 THEN 'Baþarýlý Öðrenci'
                        WHEN (D.Vize*0.4 + D.Final*0.6) BETWEEN 50 AND 70 THEN 'Normal Öðrenci'
                        ELSE 'Destek Gerekli'
                    END
            END
    END AS 'SONUC'
FROM tOgrenciler AS O
INNER JOIN tDersiAlanOgrenciler AS D ON D.Ogrenci_tOgrencilerID = O.ID
INNER JOIN tKullanicilar AS K ON K.ID = O.Ogrenci_tKullanicilarID
INNER JOIN tBolumler as B ON B.ID = O.Bolum_tBolumlerID
INNER JOIN tFakulteler AS F ON F.ID = B.Fakulte_tFakultelerID


/*"Öðrencilerin ders ve fakülte bazýnda baþarý durumlarýný deðerlendiren bir sorgu yazýn. Deðerlendirme kriterleri þöyle olsun:
Týp Fakültesi öðrencileri için:
Öðrenci 1-2. sýnýftaysa (baþlangýç tarihine göre):
Ortalama 80+ ise "Baþarýlý Týp Öðrencisi"
Ortalama 70-80 arasý ise "Normal Týp Öðrencisi"
Ortalama 70 altý ise "Desteklenmeli"
Öðrenci 3-6. sýnýftaysa:
Ortalama 85+ ise "Üstün Baþarýlý Týp Öðrencisi"
Ortalama 75-85 arasý ise "Ýyi Týp Öðrencisi"
Ortalama 75 altý ise "Geliþtirilmeli"
Diðer fakülteler için:
4 yýllýk süreyi aþmamýþ ve:
Ortalama 75+ ise "Baþarýlý Öðrenci"
Ortalama 60-75 arasý ise "Normal Öðrenci"
Ortalama 60 altý ise "Geliþtirilmeli"
4 yýllýk süreyi aþmýþ ve:
Ortalama 60+ ise "Uzatmalý - Baþarýlý"
Ortalama 60 altý ise "Uzatmalý - Riskli"
Sorguda görmek istediðimiz bilgiler:
Öðrenci Adý Soyadý
Fakülte ve Bölüm Bilgileri
Kaçýncý sýnýfta olduðu
Baþlangýç Tarihi
Vize ve Final Notlarý
Ortalama
Deðerlendirme Sonucu"
Bu sorguyu yazmayý denemek ister misiniz?*/
SELECT * FROM tDersiAlanOgrenciler

SELECT K.Adi as 'Öðrenci Adi',K.Soyadi as 'Öðrenci Soyadi',F.Adi as 'Fakülte Adi',B.Adi as 'Bölüm Adi',
DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) as 'Kaçýncý Sýnýf',
O.BaslangicTarihi AS 'Baþlangýç Tarihi',D.Vize as 'Vize Notu',
D.Final as 'Final Notu',(D.Vize * 0.4 + D.Final * 0.6) as 'Genel Ortalama',
    CASE
        WHEN F.Adi LIKE 'Týp Fakültesi' THEN 
            CASE 
                WHEN DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) = 1 OR DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) = 2 THEN
                    CASE 
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) > 80 THEN 'Baþarýlý Týp Öðrencisi'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) BETWEEN 70 AND 80 THEN 'Normal Týp Öðrencisi'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) < 70 THEN 'DESTEKLENMELÝ'
                        ELSE 'DEÐERLENDÝRME DIÞI'
                    END
                WHEN DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) >= 3 AND DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) <= 6 THEN 
                    CASE 
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) > 85 THEN 'Üstün Baþarýlý Týp Öðrencisi'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) BETWEEN 75 AND 85 THEN 'Ýyi Týp Öðrencisi'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) < 75 THEN 'Geliþtirilmeli'
                        ELSE 'DEÐERLENDÝRME DIÞI'
                    END
                ELSE 'DEÐERLENDÝRME DIÞI'
            END
        WHEN F.Adi NOT LIKE 'Týp Fakültesi' THEN
            CASE 
                WHEN DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) <= 4 THEN
                    CASE
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) > 75 THEN 'Baþarýlý Öðrenci'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) BETWEEN 60 AND 75 THEN 'Normal Öðrenci'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) < 60 THEN 'Geliþtirilmeli Öðrenci'
                        ELSE 'DEÐERLENDÝRME DIÞI'
                    END
                WHEN DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) > 4 THEN
                    CASE
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) > 60 THEN 'Uzatmalý - Baþarýlý'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) < 60 THEN 'Uzatmalý - Riskli'
                        ELSE 'DEÐERLENDÝRME DIÞI'
                    END
                ELSE 'DEÐERLENDÝRME DIÞI'
            END
        ELSE 'DEÐERLENDÝRME DIÞI'
    END AS 'Deðerlendirme Sonucu'
FROM tKullanicilar AS K
LEFT JOIN tOgrenciler AS O ON O.Ogrenci_tKullanicilarID = K.ID
LEFT JOIN tDersiAlanOgrenciler AS D ON D.Ogrenci_tOgrencilerID = O.ID
LEFT JOIN tBolumler AS B ON B.ID = O.Bolum_tBolumlerID
LEFT JOIN tFakulteler AS F ON F.ID = B.Fakulte_tFakultelerID;
WHERE D.Vize IS NOT NULL AND D.Final IS NOT NULL;