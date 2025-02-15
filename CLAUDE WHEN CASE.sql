/*Senaryo:
"��rencilerin genel durumunu de�erlendiren bir sorgu yaz�n:
�lk olarak ��rencinin durumunu kontrol edin:
E�er mezun olmu�sa ve ortalamas�:
80 �st� ise 'Onur Dereceli Mezun'
70-80 aras� ise 'Ba�ar�l� Mezun'
70 alt� ise 'Normal Mezun'
E�er hala ��renciyse:
4 y�l� ge�mi� ve ortalamas� 50 alt�ysa 'Riskli ��renci'
4 y�l� ge�mi� ve ortalamas� 50 �st�yse 'Uzatmal� ��renci'
4 y�l� ge�memi� ve ortalamas� 70 �st�yse 'Ba�ar�l� ��renci'
4 y�l� ge�memi� ve ortalamas� 50-70 aras�ysa 'Normal ��renci'
4 y�l� ge�memi� ve ortalamas� 50 alt�ysa 'Destek Gerekli'
��renci Bilgileri
Fak�lte/B�l�m
Ba�lang�� Tarihi
Mezuniyet Tarihi (varsa)
Genel Not Ortalamas�
Durum De�erlendirmesi"
*/
select * from tOgrenciler
select * from tDersiAlanOgrenciler

SELECT 
    K.Adi AS '��rencinin Adi',
    K.Soyadi as '��rencinin Soyadi',
    O.BaslangicTarihi as 'Baslang�cTarihi',
    O.MezuniyetTarihi as 'MezuniyetTarihi',
    (D.Vize*0.4 + D.Final*0.6) as 'GenelNotOrtalamas�',
    CASE
        WHEN O.MezuniyetTarihi IS NOT NULL THEN 
            CASE
                WHEN (D.Vize*0.4 + D.Final*0.6) > 80 THEN 'Onur Dereceli Mezun'
                WHEN (D.Vize*0.4 + D.Final*0.6) BETWEEN 70 AND 80 THEN 'Ba�ar�l� Mezun'
                WHEN (D.Vize*0.4 + D.Final*0.6) < 70 THEN 'Normal Mezun'
                ELSE 'De�erlendirme D���'
            END
        ELSE 
            CASE
                WHEN DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) > 4 THEN
                    CASE
                        WHEN (D.Vize*0.4 + D.Final*0.6) < 50 THEN 'Riskli ��renci'
                        ELSE 'Uzatmal� ��renci'
                    END
                ELSE
                    CASE
                        WHEN (D.Vize*0.4 + D.Final*0.6) > 70 THEN 'Ba�ar�l� ��renci'
                        WHEN (D.Vize*0.4 + D.Final*0.6) BETWEEN 50 AND 70 THEN 'Normal ��renci'
                        ELSE 'Destek Gerekli'
                    END
            END
    END AS 'SONUC'
FROM tOgrenciler AS O
INNER JOIN tDersiAlanOgrenciler AS D ON D.Ogrenci_tOgrencilerID = O.ID
INNER JOIN tKullanicilar AS K ON K.ID = O.Ogrenci_tKullanicilarID
INNER JOIN tBolumler as B ON B.ID = O.Bolum_tBolumlerID
INNER JOIN tFakulteler AS F ON F.ID = B.Fakulte_tFakultelerID


/*"��rencilerin ders ve fak�lte baz�nda ba�ar� durumlar�n� de�erlendiren bir sorgu yaz�n. De�erlendirme kriterleri ��yle olsun:
T�p Fak�ltesi ��rencileri i�in:
��renci 1-2. s�n�ftaysa (ba�lang�� tarihine g�re):
Ortalama 80+ ise "Ba�ar�l� T�p ��rencisi"
Ortalama 70-80 aras� ise "Normal T�p ��rencisi"
Ortalama 70 alt� ise "Desteklenmeli"
��renci 3-6. s�n�ftaysa:
Ortalama 85+ ise "�st�n Ba�ar�l� T�p ��rencisi"
Ortalama 75-85 aras� ise "�yi T�p ��rencisi"
Ortalama 75 alt� ise "Geli�tirilmeli"
Di�er fak�lteler i�in:
4 y�ll�k s�reyi a�mam�� ve:
Ortalama 75+ ise "Ba�ar�l� ��renci"
Ortalama 60-75 aras� ise "Normal ��renci"
Ortalama 60 alt� ise "Geli�tirilmeli"
4 y�ll�k s�reyi a�m�� ve:
Ortalama 60+ ise "Uzatmal� - Ba�ar�l�"
Ortalama 60 alt� ise "Uzatmal� - Riskli"
Sorguda g�rmek istedi�imiz bilgiler:
��renci Ad� Soyad�
Fak�lte ve B�l�m Bilgileri
Ka��nc� s�n�fta oldu�u
Ba�lang�� Tarihi
Vize ve Final Notlar�
Ortalama
De�erlendirme Sonucu"
Bu sorguyu yazmay� denemek ister misiniz?*/
SELECT * FROM tDersiAlanOgrenciler

SELECT K.Adi as '��renci Adi',K.Soyadi as '��renci Soyadi',F.Adi as 'Fak�lte Adi',B.Adi as 'B�l�m Adi',
DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) as 'Ka��nc� S�n�f',
O.BaslangicTarihi AS 'Ba�lang�� Tarihi',D.Vize as 'Vize Notu',
D.Final as 'Final Notu',(D.Vize * 0.4 + D.Final * 0.6) as 'Genel Ortalama',
    CASE
        WHEN F.Adi LIKE 'T�p Fak�ltesi' THEN 
            CASE 
                WHEN DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) = 1 OR DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) = 2 THEN
                    CASE 
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) > 80 THEN 'Ba�ar�l� T�p ��rencisi'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) BETWEEN 70 AND 80 THEN 'Normal T�p ��rencisi'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) < 70 THEN 'DESTEKLENMEL�'
                        ELSE 'DE�ERLEND�RME DI�I'
                    END
                WHEN DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) >= 3 AND DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) <= 6 THEN 
                    CASE 
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) > 85 THEN '�st�n Ba�ar�l� T�p ��rencisi'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) BETWEEN 75 AND 85 THEN '�yi T�p ��rencisi'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) < 75 THEN 'Geli�tirilmeli'
                        ELSE 'DE�ERLEND�RME DI�I'
                    END
                ELSE 'DE�ERLEND�RME DI�I'
            END
        WHEN F.Adi NOT LIKE 'T�p Fak�ltesi' THEN
            CASE 
                WHEN DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) <= 4 THEN
                    CASE
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) > 75 THEN 'Ba�ar�l� ��renci'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) BETWEEN 60 AND 75 THEN 'Normal ��renci'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) < 60 THEN 'Geli�tirilmeli ��renci'
                        ELSE 'DE�ERLEND�RME DI�I'
                    END
                WHEN DATEDIFF(YEAR, O.BaslangicTarihi, GETDATE()) > 4 THEN
                    CASE
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) > 60 THEN 'Uzatmal� - Ba�ar�l�'
                        WHEN (D.Vize * 0.4 + D.Final * 0.6) < 60 THEN 'Uzatmal� - Riskli'
                        ELSE 'DE�ERLEND�RME DI�I'
                    END
                ELSE 'DE�ERLEND�RME DI�I'
            END
        ELSE 'DE�ERLEND�RME DI�I'
    END AS 'De�erlendirme Sonucu'
FROM tKullanicilar AS K
LEFT JOIN tOgrenciler AS O ON O.Ogrenci_tKullanicilarID = K.ID
LEFT JOIN tDersiAlanOgrenciler AS D ON D.Ogrenci_tOgrencilerID = O.ID
LEFT JOIN tBolumler AS B ON B.ID = O.Bolum_tBolumlerID
LEFT JOIN tFakulteler AS F ON F.ID = B.Fakulte_tFakultelerID;
WHERE D.Vize IS NOT NULL AND D.Final IS NOT NULL;