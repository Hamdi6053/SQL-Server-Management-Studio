/*Öðrencilerin ad, soyad, vize ve öðrenci numaralarýný getiren kodu yazýnýz. */
select (k.Adi + ' ' + k.Soyadi) as 'Öðrenci Adi ve Soyadi' , O.OgrenciNo 'Öðrenci Numarasý',D.Vize as 'Öðrencilerin Vize Notlarý'
from tKullanicilar as k
join tOgrenciler AS O 
ON K.ID = O.Ogrenci_tKullanicilarID
join tDersiAlanOgrenciler AS D 
on D.Ogrenci_tOgrencilerID = O.ID

-- Öðrencilerin adý, soyadý ve bölüm bilgilerini getiren sorgu

select * from tKullanicilar
select * from tOgrenciler
select * from tBolumler

select (K.Adi + ' ' + k.Soyadi) AS 'Öðrenci Adi Soyadi',B.Adi as 'Öðrencinin Bölüm Adi'from tKullanicilar AS K 
inner join tOgrenciler as O on k.ID = O.Ogrenci_tKullanicilarID
inner join tBolumler AS B on B.ID = O.Bolum_tBolumlerID

-- Dersi alan öðrencilerin bilgilerini, ders adýný ve hoca bilgisini getiren sorgu

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
INNER JOIN tKullanicilar AS H  -- Hoca bilgileri için eklenen JOIN
    ON H.ID = D.Hoca_tKullanicilarID
INNER JOIN tDersler AS Ds
    ON Ds.ID = D.Ders_tDerslerID

--Bir öðrencinin aldýðý dersleri, notlarýný ve bu dersleri veren hocalarý listeleyelim:

select * from tDersiAlanOgrenciler
select * from tKullanicilar
select * from tDersler

select D.Vize as 'Öðrencinin Vize Notu', 
D.Final AS 'Öðrencinin Final Notu' ,
(H.Adi + ' ' + H.Soyadi) as 'Hoca Adý ve Soyadý',
Ds.Adi as 'Öðrencinin aldýðý dersler',
(K.Adi + ' ' + K.Soyadi) as 'Öðrencinin adi ve soyadi'
from tDersiAlanOgrenciler as D
inner join tKullanicilar AS H
ON H.ID = D.Hoca_tKullanicilarID
inner join tDersler AS Ds
on Ds.ID = D.Ders_tDerslerID
inner join tOgrenciler AS O        
ON O.ID = D.Ogrenci_tOgrencilerID  
inner join tKullanicilar AS K
on K.ID = O.Ogrenci_tKullanicilarID 

--Fakülte ve bölümlere göre öðrenci sayýlarýný listeleyelim:

select * from tFakulteler
SELECT * FROM tBolumler
select * from tOgrenciler
set language turkish

select F.Adi as 'Fakülte Adi', B.Adi as 'Bölüm Adi',Count(*) from tOgrenciler as o
inner join tBolumler AS B
on B.ID = O.Bolum_tBolumlerID
inner join tFakulteler AS F
on B.Fakulte_tFakultelerID = F.ID
group by F.Adi,B.Adi

--Öðrencilerin aldýðý derslerin ortalama notlarýný hesaplayýn (vize * 0.4 + final * 0.6). Öðrenci adý, soyadý ve ders adýyla birlikte listelensin.
select * from tKullanicilar
SELECT * FROM tOgrenciler
select * from tDersiAlanOgrenciler
SELECT * FROM tDersler

select (D.Vize * 0.4 + D.Final * 0.6) as 'Ortalama notlar',
K.Adi as 'Öðrenci Adi',K.Soyadi as 'Öðrenci Soyadi'
, DS.Adi AS 'Ders Adi'
from tKullanicilar AS K
inner join tOgrenciler AS O
ON K.ID = O.Ogrenci_tKullanicilarID
inner join tDersiAlanOgrenciler as d
on D.Ogrenci_tOgrencilerID = O.ID
inner join tDersler AS DS
ON Ds.ID = D.Ders_tDerslerID


--Yaz okulunda en çok ders veren hocalarý listeleyelim
select * from tYazOkuluUcretleri
select * from tDersiAlanOgrenciler
select * from tKullanicilar
select * from tDersler

select H.ID , count(*) as 'Hocanýn verdiði ders sayýsý' from tYazOkuluUcretleri AS you
inner join tKullanicilar AS H
on H.ID = you.Hoca_tKullanicilarID
group by H.ID
order by Count(*) desc


--Öðrencilerin doðum yerlerine göre (illere ve ilçelere)  daðýlýmýný görelim:

select * from tOgrenciler
SELECT * FROM tKullanicilar
select * from tIlceler
select * from tIller

select II.Adi as 'Ýl Adi' ,I.Adi AS 'Ýlçe Adi',count(*) as 'Öðrenci Sayisi' from tKullanicilar AS K
inner join tOgrenciler AS O
on O.Ogrenci_tKullanicilarID = K.ID
inner join tIlceler AS I
on I.ID = K.DogumYeri_tIlcelerID
inner join tIller AS II
on II.ID = I.Il_tIllerID
GROUP BY II.Adi,I.Adi 
order by II.Adi,I.Adi 
--Yaz okulunda hangi bölümlerde kaç ders açýlmýþ onu listeleyelim mi?
select * from tBolumler
SELECT * FROM tDersiAlanOgrenciler
select * from tDersler
select * from tYazOkuluUcretleri

SELECT B.Adi as 'Bölüm Adi',Ds.Adi as 'Ders Adi' , count(*) as 'Bölüm için Kaç Ders Açýlmýþ' FROM tYazOkuluUcretleri as You
inner join tBolumler AS B
ON B.ID = You.Bolum_tBolumlerID
INNER JOIN tDersler AS Ds ON Ds.ID = You.Ders_tDerslerID
group by B.Adi,Ds.Adi

-- Her bölümde yaz okulunda en yüksek not ortalamasýna sahip öðrenciyi ve aldýðý dersi listeleyelim:
select * from tYazOkuluUcretleri
select * from tOgrenciler
SELECT * FROM tKullanicilar
select * from tBolumler
select * from tDersiAlanOgrenciler
select * from tDersler

select (K.Adi + ' ' + K.Soyadi) AS 'Öðrenci Adi ve Soyadi',
(you.Vize*0.4+you.Final*0.6) as 'Not Ortalamasý',
B.Adi as 'Bölüm Adi',
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

--Her bölümdeki toplam öðrenci sayýsýný bulalým
select * from tBolumler
SELECT B.Adi,Count(*) as 'Bölümdeki öðrenci sayýsý'
from tOgrenciler as O
inner join tBolumler AS B
on B.ID = o.Bolum_tBolumlerID
GROUP BY B.Adi
order by Count(*) desc

--Her bölümdeki öðrencilerin not ortalamasýný bulalým. Bu sefer:

--Bölüm adý
--Öðrenci sayýsý
--Vize ortalamasý
--Final ortalamasý
--Genel ortalama (Vize %40 + Final %60)

--gösterilmeli.

select * from tOgrenciler
SELECT * FROM tBolumler
select * from tDersiAlanOgrenciler
set language turkish

select B.Adi,AVG(Do.Vize*0.4+Do.Final*0.6) AS 'Genel Ortalama' ,
AVG(DO.Vize) as 'Vize ortalamasý',
AVG(DO.Final) as 'Final ortalamasý',
Ds.Adi,
Count(*) as 'Öðrenci sayisi' 
from tOgrenciler as O
inner join tDersiAlanOgrenciler AS DO
on o.ID = DO.Ogrenci_tOgrencilerID
inner join tBolumler AS B
on B.ID = o.Bolum_tBolumlerID
inner join tDersler as Ds
on Ds.ID = DO.Ders_tDerslerID
group by B.Adi,Ds.Adi

--Her fakülte için:

--Fakülte adýný
--Toplam bölüm sayýsýný
--Toplam öðrenci sayýsýný
--Fakültedeki tüm öðrencilerin genel not ortalamasýný (Vize0.4 + Final0.6)

select * from tFakulteler
SELECT * FROM tBolumler
select * from tOgrenciler
select * from tDersiAlanOgrenciler

SELECT  
F.Adi as 'Fakülte Adý',
COUNT(DISTINCT B.ID) as 'Bölüm Sayýsý',
COUNT(DISTINCT O.ID) as 'Öðrenci Sayýsý',
AVG(DO.Vize*0.4 + DO.Final*0.6) AS 'Genel Ortalama' 
FROM tFakulteler AS F
INNER JOIN tBolumler as B
ON F.ID = B.Fakulte_tFakultelerID
INNER JOIN tOgrenciler as O
ON O.Bolum_tBolumlerID = B.ID
INNER JOIN tDersiAlanOgrenciler as DO
ON DO.Ogrenci_tOgrencilerID = O.ID
GROUP BY F.Adi

--Her öðrencinin:
--Adý Soyadý
--Bölümü
--Aldýðý ders sayýsý
--Tüm derslerinin genel ortalamasý (Vize%40 + Final%60)
--Bu sorgu için düþünelim:
select * from tKullanicilar
select * from tOgrenciler
select * from tBolumler
select * from tDersiAlanOgrenciler
select * from tDersler

select K.Adi,K.Soyadi ,B.Adi , COUNT(DISTINCT Do.Ders_tDerslerID) as 'Aldýðý ders sayisi', AVG(DO.Vize*0.4+Final*0.6) as 'Genel not ortalamasý' FROM tOgrenciler AS O
inner join tKullanicilar AS K
on O.Ogrenci_tKullanicilarID = K.ID
inner join tBolumler AS B
on B.ID = O.Bolum_tBolumlerID 
inner join tDersiAlanOgrenciler as DO
on DO.Ogrenci_tOgrencilerID = O.ID
GROUP BY K.Adi,K.Soyadi,B.Adi

--Soru: Her fakültedeki bölümlerde okuyan öðrencilerin not ortalamalarý 70'in üzerinde olanlarýn sayýsýný bulmanýzý istiyorum. 
--Yani hangi fakültede kaç tane baþarýlý öðrenci var, bunu görmek istiyorum. Sonuçlarý fakülte adýna göre sýralayalým.
select * from tFakulteler
SELECT * FROM tOgrenciler
select * from tDersiAlanOgrenciler
SELECT * FROM tBolumler

select F.Adi AS 'FAKÜLTE ADÝ',AVG(D.Vize*0.4+D.Final*0.6) AS 'GENEL ORTALAMA',COUNT(DISTINCT O.ID) AS 'ÖÐRENCÝ SAYÝSÝ' FROM tOgrenciler as O
inner join tDersiAlanOgrenciler AS D
on D.Ogrenci_tOgrencilerID = O.ID
inner join tBolumler AS B
On B.ID = O.Bolum_tBolumlerID 
inner join tFakulteler AS F
on F.ID = B.Fakulte_tFakultelerID
GROUP BY F.Adi
Having AVG(D.Vize*0.4+D.Final*0.6) > 70
ORDER BY F.Adi DESC

--Her bölümdeki öðrencilerin yaþ ortalamalarýný görmek istiyorum. 
--Ayrýca her bölümün kayýtlý olduðu fakülte adý da görünsün. Sonuçlarý fakülte adýna göre sýralayalým.

select * from tBolumler
select * from tOgrenciler
select * from tKullanicilar
select * from tFakulteler

SELECT AVG(YEAR(GETDATE()) - YEAR(K.DogumTarihi)) AS 'Yas Ortalamasý' from tKullanicilar AS K

select F.ADÝ as 'Fakülte Adi', B.Adi as 'Bölümün Adi',AVG(YEAR(GETDATE()) - YEAR(K.DogumTarihi)) AS 'Yas Ortalamasý' from tKullanicilar as k
inner join tOgrenciler as O
on k.ID = O.Ogrenci_tKullanicilarID
inner join tBolumler AS b
on b.ID = o.Bolum_tBolumlerID 
inner join tFakulteler as F
ON F.ID = B.Fakulte_tFakultelerID
GROUP BY F.Adi,B.Adi
order by F.Adi

--Soru: Bölüm bazýnda her bir dersin kaç kez tekrar alýndýðýný (baþarýsýz olunup tekrar alýnan) 
--ve bu derslerin ortalama baþarý puanýný listeleyelim.

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

--"Tüm fakülteleri listeleyin, bu fakültelerin bölümlerini, bölümlerdeki öðrenci sayýlarýný ve o bölümlerde ders veren hoca sayýlarýný gösterin. 
--Hiç öðrencisi olmayan veya hiç hocasý olmayan bölümler de listelenmelidir."

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