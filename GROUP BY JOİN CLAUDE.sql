/*��rencilerin ad, soyad, vize ve ��renci numaralar�n� getiren kodu yaz�n�z. */
select (k.Adi + ' ' + k.Soyadi) as '��renci Adi ve Soyadi' , O.OgrenciNo '��renci Numaras�',D.Vize as '��rencilerin Vize Notlar�'
from tKullanicilar as k
join tOgrenciler AS O 
ON K.ID = O.Ogrenci_tKullanicilarID
join tDersiAlanOgrenciler AS D 
on D.Ogrenci_tOgrencilerID = O.ID

-- ��rencilerin ad�, soyad� ve b�l�m bilgilerini getiren sorgu

select * from tKullanicilar
select * from tOgrenciler
select * from tBolumler

select (K.Adi + ' ' + k.Soyadi) AS '��renci Adi Soyadi',B.Adi as '��rencinin B�l�m Adi'from tKullanicilar AS K 
inner join tOgrenciler as O on k.ID = O.Ogrenci_tKullanicilarID
inner join tBolumler AS B on B.ID = O.Bolum_tBolumlerID

-- Dersi alan ��rencilerin bilgilerini, ders ad�n� ve hoca bilgisini getiren sorgu

select * from tDersiAlanOgrenciler
select * from tDersler
select * from tOgrenciler
select * from tKullanicilar

SELECT  O.OgrenciNo,
    K.Adi AS OgrenciAdi,
    K.Soyadi AS OgrenciSoyadi,
    H.Adi AS HocaAdi,
    H.Soyadi AS HocaSoyadi,
    Ds.Kodu AS DersKodu,
    Ds.Adi AS DersAdi,
    D.Vize,
    D.Final
FROM tDersiAlanOgrenciler AS D
INNER JOIN tOgrenciler AS O
    ON D.Ogrenci_tOgrencilerID = O.ID
INNER JOIN tKullanicilar AS K
    ON K.ID = O.Ogrenci_tKullanicilarID
INNER JOIN tKullanicilar AS H  -- Hoca bilgileri i�in eklenen JOIN
    ON H.ID = D.Hoca_tKullanicilarID
INNER JOIN tDersler AS Ds
    ON Ds.ID = D.Ders_tDerslerID

--Bir ��rencinin ald��� dersleri, notlar�n� ve bu dersleri veren hocalar� listeleyelim:

select * from tDersiAlanOgrenciler
select * from tKullanicilar
select * from tDersler

select D.Vize as '��rencinin Vize Notu', 
D.Final AS '��rencinin Final Notu' ,
(H.Adi + ' ' + H.Soyadi) as 'Hoca Ad� ve Soyad�',
Ds.Adi as '��rencinin ald��� dersler',
(K.Adi + ' ' + K.Soyadi) as '��rencinin adi ve soyadi'
from tDersiAlanOgrenciler as D
inner join tKullanicilar AS H
ON H.ID = D.Hoca_tKullanicilarID
inner join tDersler AS Ds
on Ds.ID = D.Ders_tDerslerID
inner join tOgrenciler AS O        
ON O.ID = D.Ogrenci_tOgrencilerID  
inner join tKullanicilar AS K
on K.ID = O.Ogrenci_tKullanicilarID 

--Fak�lte ve b�l�mlere g�re ��renci say�lar�n� listeleyelim:

select * from tFakulteler
SELECT * FROM tBolumler
select * from tOgrenciler
set language turkish

select F.Adi as 'Fak�lte Adi', B.Adi as 'B�l�m Adi',Count(*) from tOgrenciler as o
inner join tBolumler AS B
on B.ID = O.Bolum_tBolumlerID
inner join tFakulteler AS F
on B.Fakulte_tFakultelerID = F.ID
group by F.Adi,B.Adi

--��rencilerin ald��� derslerin ortalama notlar�n� hesaplay�n (vize * 0.4 + final * 0.6). ��renci ad�, soyad� ve ders ad�yla birlikte listelensin.
select * from tKullanicilar
SELECT * FROM tOgrenciler
select * from tDersiAlanOgrenciler
SELECT * FROM tDersler

select (D.Vize * 0.4 + D.Final * 0.6) as 'Ortalama notlar',
K.Adi as '��renci Adi',K.Soyadi as '��renci Soyadi'
, DS.Adi AS 'Ders Adi'
from tKullanicilar AS K
inner join tOgrenciler AS O
ON K.ID = O.Ogrenci_tKullanicilarID
inner join tDersiAlanOgrenciler as d
on D.Ogrenci_tOgrencilerID = O.ID
inner join tDersler AS DS
ON Ds.ID = D.Ders_tDerslerID


--Yaz okulunda en �ok ders veren hocalar� listeleyelim
select * from tYazOkuluUcretleri
select * from tDersiAlanOgrenciler
select * from tKullanicilar
select * from tDersler

select H.ID , count(*) as 'Hocan�n verdi�i ders say�s�' from tYazOkuluUcretleri AS you
inner join tKullanicilar AS H
on H.ID = you.Hoca_tKullanicilarID
group by H.ID
order by Count(*) desc


--��rencilerin do�um yerlerine g�re (illere ve il�elere)  da��l�m�n� g�relim:

select * from tOgrenciler
SELECT * FROM tKullanicilar
select * from tIlceler
select * from tIller

select II.Adi as '�l Adi' ,I.Adi AS '�l�e Adi',count(*) as '��renci Sayisi' from tKullanicilar AS K
inner join tOgrenciler AS O
on O.Ogrenci_tKullanicilarID = K.ID
inner join tIlceler AS I
on I.ID = K.DogumYeri_tIlcelerID
inner join tIller AS II
on II.ID = I.Il_tIllerID
GROUP BY II.Adi,I.Adi 
order by II.Adi,I.Adi 
--Yaz okulunda hangi b�l�mlerde ka� ders a��lm�� onu listeleyelim mi?
select * from tBolumler
SELECT * FROM tDersiAlanOgrenciler
select * from tDersler
select * from tYazOkuluUcretleri

SELECT B.Adi as 'B�l�m Adi',Ds.Adi as 'Ders Adi' , count(*) as 'B�l�m i�in Ka� Ders A��lm��' FROM tYazOkuluUcretleri as You
inner join tBolumler AS B
ON B.ID = You.Bolum_tBolumlerID
INNER JOIN tDersler AS Ds ON Ds.ID = You.Ders_tDerslerID
group by B.Adi,Ds.Adi

-- Her b�l�mde yaz okulunda en y�ksek not ortalamas�na sahip ��renciyi ve ald��� dersi listeleyelim:
select * from tYazOkuluUcretleri
select * from tOgrenciler
SELECT * FROM tKullanicilar
select * from tBolumler
select * from tDersiAlanOgrenciler
select * from tDersler

select (K.Adi + ' ' + K.Soyadi) AS '��renci Adi ve Soyadi',
(you.Vize*0.4+you.Final*0.6) as 'Not Ortalamas�',
B.Adi as 'B�l�m Adi',
D.Adi as 'Ders Adi'
from tYazOkuluUcretleri AS YOU
inner join tOgrenciler AS o
on o.ID = YOU.Ogrenci_tKullanicilarID
inner join tKullanicilar AS K
on K.ID = O.Ogrenci_tKullanicilarID
inner join tBolumler AS B
on B.ID = you.Bolum_tBolumlerID
inner join tDersiAlanOgrenciler AS do
on do.Ders_tDerslerID = you.Ders_tDerslerID
inner join tDersler AS D
on D.ID = DO.Ders_tDerslerID
group by B.Adi,D.Adi,(you.Vize*0.4+you.Final*0.6),(K.Adi + ' ' + K.Soyadi) 
order by (you.Vize*0.4+you.Final*0.6) desc

--Her b�l�mdeki toplam ��renci say�s�n� bulal�m
select * from tBolumler
SELECT B.Adi,Count(*) as 'B�l�mdeki ��renci say�s�'
from tOgrenciler as O
inner join tBolumler AS B
on B.ID = o.Bolum_tBolumlerID
GROUP BY B.Adi
order by Count(*) desc

--Her b�l�mdeki ��rencilerin not ortalamas�n� bulal�m. Bu sefer:

--B�l�m ad�
--��renci say�s�
--Vize ortalamas�
--Final ortalamas�
--Genel ortalama (Vize %40 + Final %60)

--g�sterilmeli.

select * from tOgrenciler
SELECT * FROM tBolumler
select * from tDersiAlanOgrenciler
set language turkish

select B.Adi,AVG(Do.Vize*0.4+Do.Final*0.6) AS 'Genel Ortalama' ,
AVG(DO.Vize) as 'Vize ortalamas�',
AVG(DO.Final) as 'Final ortalamas�',
Ds.Adi,
Count(*) as '��renci sayisi' 
from tOgrenciler as O
inner join tDersiAlanOgrenciler AS DO
on o.ID = DO.Ogrenci_tOgrencilerID
inner join tBolumler AS B
on B.ID = o.Bolum_tBolumlerID
inner join tDersler as Ds
on Ds.ID = DO.Ders_tDerslerID
group by B.Adi,Ds.Adi

--Her fak�lte i�in:

--Fak�lte ad�n�
--Toplam b�l�m say�s�n�
--Toplam ��renci say�s�n�
--Fak�ltedeki t�m ��rencilerin genel not ortalamas�n� (Vize0.4 + Final0.6)

select * from tFakulteler
SELECT * FROM tBolumler
select * from tOgrenciler
select * from tDersiAlanOgrenciler

SELECT  
F.Adi as 'Fak�lte Ad�',
COUNT(DISTINCT B.ID) as 'B�l�m Say�s�',
COUNT(DISTINCT O.ID) as '��renci Say�s�',
AVG(DO.Vize*0.4 + DO.Final*0.6) AS 'Genel Ortalama' 
FROM tFakulteler AS F
INNER JOIN tBolumler as B
ON F.ID = B.Fakulte_tFakultelerID
INNER JOIN tOgrenciler as O
ON O.Bolum_tBolumlerID = B.ID
INNER JOIN tDersiAlanOgrenciler as DO
ON DO.Ogrenci_tOgrencilerID = O.ID
GROUP BY F.Adi

--Her ��rencinin:
--Ad� Soyad�
--B�l�m�
--Ald��� ders say�s�
--T�m derslerinin genel ortalamas� (Vize%40 + Final%60)
--Bu sorgu i�in d���nelim:
select * from tKullanicilar
select * from tOgrenciler
select * from tBolumler
select * from tDersiAlanOgrenciler
select * from tDersler

select K.Adi,K.Soyadi ,B.Adi , COUNT(DISTINCT Do.Ders_tDerslerID) as 'Ald��� ders sayisi', AVG(DO.Vize*0.4+Final*0.6) as 'Genel not ortalamas�' FROM tOgrenciler AS O
inner join tKullanicilar AS K
on O.Ogrenci_tKullanicilarID = K.ID
inner join tBolumler AS B
on B.ID = O.Bolum_tBolumlerID 
inner join tDersiAlanOgrenciler as DO
on DO.Ogrenci_tOgrencilerID = O.ID
GROUP BY K.Adi,K.Soyadi,B.Adi

--Soru: Her fak�ltedeki b�l�mlerde okuyan ��rencilerin not ortalamalar� 70'in �zerinde olanlar�n say�s�n� bulman�z� istiyorum. 
--Yani hangi fak�ltede ka� tane ba�ar�l� ��renci var, bunu g�rmek istiyorum. Sonu�lar� fak�lte ad�na g�re s�ralayal�m.
select * from tFakulteler
SELECT * FROM tOgrenciler
select * from tDersiAlanOgrenciler
SELECT * FROM tBolumler

select F.Adi AS 'FAK�LTE AD�',AVG(D.Vize*0.4+D.Final*0.6) AS 'GENEL ORTALAMA',COUNT(DISTINCT O.ID) AS '��RENC� SAY�S�' FROM tOgrenciler as O
inner join tDersiAlanOgrenciler AS D
on D.Ogrenci_tOgrencilerID = O.ID
inner join tBolumler AS B
On B.ID = O.Bolum_tBolumlerID 
inner join tFakulteler AS F
on F.ID = B.Fakulte_tFakultelerID
GROUP BY F.Adi
Having AVG(D.Vize*0.4+D.Final*0.6) > 70
ORDER BY F.Adi DESC

--Her b�l�mdeki ��rencilerin ya� ortalamalar�n� g�rmek istiyorum. 
--Ayr�ca her b�l�m�n kay�tl� oldu�u fak�lte ad� da g�r�ns�n. Sonu�lar� fak�lte ad�na g�re s�ralayal�m.

select * from tBolumler
select * from tOgrenciler
select * from tKullanicilar
select * from tFakulteler

SELECT AVG(YEAR(GETDATE()) - YEAR(K.DogumTarihi)) AS 'Yas Ortalamas�' from tKullanicilar AS K

select F.AD� as 'Fak�lte Adi', B.Adi as 'B�l�m�n Adi',AVG(YEAR(GETDATE()) - YEAR(K.DogumTarihi)) AS 'Yas Ortalamas�' from tKullanicilar as k
inner join tOgrenciler as O
on k.ID = O.Ogrenci_tKullanicilarID
inner join tBolumler AS b
on b.ID = o.Bolum_tBolumlerID 
inner join tFakulteler as F
ON F.ID = B.Fakulte_tFakultelerID
GROUP BY F.Adi,B.Adi
order by F.Adi

--Soru: B�l�m baz�nda her bir dersin ka� kez tekrar al�nd���n� (ba�ar�s�z olunup tekrar al�nan) 
--ve bu derslerin ortalama ba�ar� puan�n� listeleyelim.

select * from tBolumler
select * from tOgrenciler
SELECT * FROM tDersiAlanOgrenciler

SELECT 
    b.Adi as [Bolum], 
    d.Kodu as [Ders Kodu],
    d.Adi as [Ders Adi],
    COUNT(*) as [Toplam Alan Ogrenci],
    COUNT(DISTINCT dao.Ogrenci_tOgrencilerID) as [Tekil Ogrenci Sayisi],
    AVG(dao.Final) as [Ortalama Final],
    AVG(dao.Vize) as [Ortalama Vize]
FROM tDersiAlanOgrenciler dao
LEFT JOIN tOgrenciler o ON dao.Ogrenci_tOgrencilerID = o.ID
LEFT JOIN tBolumler b ON o.Bolum_tBolumlerID = b.ID
LEFT JOIN tDersler d ON dao.Ders_tDerslerID = d.ID
GROUP BY b.Adi, d.Kodu, d.Adi
HAVING COUNT(*) > COUNT(DISTINCT dao.Ogrenci_tOgrencilerID)
ORDER BY [Toplam Alan Ogrenci] DESC

--"T�m fak�lteleri listeleyin, bu fak�ltelerin b�l�mlerini, b�l�mlerdeki ��renci say�lar�n� ve o b�l�mlerde ders veren hoca say�lar�n� g�sterin. 
--Hi� ��rencisi olmayan veya hi� hocas� olmayan b�l�mler de listelenmelidir."

select * from tFakulteler
select * from tBolumler
select * from tOgrenciler
select * from tDersiAlanOgrenciler
 
SELECT 
    f.Adi AS FakulteAdi,
    b.Adi AS BolumAdi,
    COUNT(DISTINCT o.ID) AS OgrenciSayisi,
    COUNT(DISTINCT dao.Hoca_tKullanicilarID) AS HocaSayisi
FROM 
    tFakulteler f
    LEFT JOIN tBolumler b ON f.ID = b.Fakulte_tFakultelerID
    LEFT JOIN tOgrenciler o ON b.ID = o.Bolum_tBolumlerID
    LEFT JOIN tDersiAlanOgrenciler dao ON o.ID = dao.Ogrenci_tOgrencilerID
GROUP BY 
    f.Adi,
    b.Adi
ORDER BY 
    f.Adi, b.Adi;