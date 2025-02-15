select * from tBolumler;
select * from tFakulteler;

select * from tBolumler b1,tFakulteler f1 
where f1.ID = b1.Fakulte_tFakultelerID

select * from tIller;
select * from tIlceler;

SELECT tIlceler.Adi as 'Ýlçe Adý',tIller.Adi as 'Ýl Adý'from  tIlceler,tIller 
where tIlceler.Il_tIllerID = tIller.ID

select * from tKullanicilar
select * from tKanGruplari
select * from tIlceler

select K.Adi,K.Soyadi,I.Adi as 'DogumYeri Ýlçe Adi',KG.Adi as 'KanGruplarý Adi' FROM tKullanicilar as K,tIlceler as I,tKanGruplari as KG
WHERE K.KanGrubu_tKanGruplariID = KG.ID
AND
K.DogumYeri_tIlcelerID = I.ID

select * from tOgrenciler
select * from tBolumler
select * from tFakulteler

select O.OgrenciNo as 'Öðrenci Numarasý',B.Adi as 'Bölüm Adi',F.Adi as 'Fakülte Adi'from tOgrenciler as O ,tBolumler as B , tFakulteler as F
where O.Bolum_tBolumlerID = B.ID
and 
B.Fakulte_tFakultelerID = F.ID

select * from tKullanicilar
select * from tOgrenciler
select * from tFakulteler
select * from tBolumler

select (k.Adi + ' ' + k.Soyadi) as 'Ogrenci Adi', F.Adi as 'Fakülte Adi' from tKullanicilar AS K , tOgrenciler AS O, tBolumler AS B, tFakulteler AS F
where k.ID = O.Ogrenci_tKullanicilarID
and 
F.ID = B.Fakulte_tFakultelerID
and
O.Bolum_tBolumlerID = B.ID

-- her dersi kaç öðrencinin aldýðý 

select * from tDersiAlanOgrenciler
select * from tDersler

select d.Adi as 'Ders Adi',count(*) as 'Öðrenci sayýsý'
from tDersiAlanOgrenciler as dao,tDersler D
WHERE DAO.Ders_tDerslerID = d.ID
GROUP BY d.Adi

-- Son 2008 - 2010 yýllarý arasýnda hangi bölümdeki dersler için toplam ne kadar ücret ödendiði
-- listelenmek istenirse yani bölüm adý,ders adi, toplam ücret þeklinde

select * from tYazOkuluUcretleri
SELECT * from tBolumler
SELECT * FROM tDersler

select SUM(you.Ucret) as 'Tolam Ucret',B.Adi as 'Bolum Adi',D.Adi as 'Ders Adi' FROM tYazOkuluUcretleri AS you, tBolumler AS B, tDersler AS D
where you.Bolum_tBolumlerID = B.ID
and 
you.Ders_tDerslerID = D.ID
AND
YEAR(YOU.IslemTarihi) between 2008 and 2010
GROUP BY b.Adi,D.Adi

select * from tKullanicilar
SELECT * FROM tOgrenciler

select * from tOgrenciler
inner join tKullanicilar on tKullanicilar.ID = tOgrenciler.Ogrenci_tKullanicilarID

select * from tIlceler
SELECT * FROM tIller

select * from tIlceler left join tIller on tIlceler.Il_tIllerID = tIller.ID

select * from tKullanicilar
SELECT * FROM tOgrenciler

select * from tKullanicilar right join tOgrenciler
on tKullanicilar.ID = tOgrenciler.Ogrenci_tKullanicilarID

-- desler
-- bolumeler
-- fakülteler
SELECT * from tBolumler
SELECT * FROM tDersler
select * from tFakulteler

select * from tBolumler left join tFakulteler  on 
tBolumler.Fakulte_tFakultelerID = tFakulteler.ID

/*HOCANIN DERSTE ANLATTIKLARI*/

select * from tFakulteler
select * from tBolumler

select * from tFakulteler,tBolumler
where tBolumler.Fakulte_tFakultelerID = tFakulteler.ID

select * from tBolumler left join tFakulteler
ON tBolumler.Fakulte_tFakultelerID = tFakulteler.ID

select * from tBolumler AS B left join tFakulteler AS F
ON B.Fakulte_tFakultelerID = F.ID

select B.Adi as 'Bölüm Adi',F.Adi AS 'Fakülte Adi' from tBolumler AS B left join tFakulteler AS F
ON B.Fakulte_tFakultelerID = F.ID
GROUP BY F.Adi,B.Adi

--Ben yazdým bunu group by 
--Hocanýn yazdýðý

select B.Adi as 'Bölüm Adi',F.Adi AS 'Fakülte Adi' from tBolumler AS B left join tFakulteler AS F
ON B.Fakulte_tFakultelerID = F.ID

/*Her bir fakültenin kaç adet bölümü olduðunu fakülte adý ve bölüm sayýsý olacak þekilde
iki sütunla bir yapýda listele*/

select * from tBolumler
select * from tFakulteler

select f.Adi as 'Fakülte Adi', Count(*) 'Bölüm Sayisi' from tBolumler AS B left join tFakulteler as F 
on B.Fakulte_tFakultelerID =  F.ID
Group by F.Adi

Select ID from tFakulteler WHERE tFakulteler.Adi like '%b%'

select * from tBolumler b
where b.Fakulte_tFakultelerID in (Select ID from tFakulteler WHERE tFakulteler.Adi like '%b%')

/*Dogum yerine göre hangi ilde en yüksek kiþi vardýr */
select * from tKullanicilar
select * from tIlceler
select * from tIller

select top 1 
IL.Adi from tKullanicilar AS K
LEFT join tIlceler as I ON K.DogumYeri_tIlcelerID =I.ID
LEFT join tIller AS IL on I.Il_tIllerID = IL.ID
GROUP BY IL.Adi
order by count(*) desc

select concat(K.Adi,' ',K.Soyadi) as OgrenciAdSoyad,
concat(H.Adi,' ', H.Soyadi) as HocaAdSoyad
from tYazOkuluUcretleri AS You
left join tKullanicilar as H
on H.ID = You.Hoca_tKullanicilarID 
left join tKullanicilar AS k
ON  k.ID = YOU.Ogrenci_tKullanicilarID

/*Yaz Okulu Ücretleri incelendiðinde en yüksek toplam ücret ödemesi yapýlan fakülte  hangisidir? */

select * from tYazOkuluUcretleri
select * from tBolumler
select * from tFakulteler

select TOP 1 F.Adi , Sum(You.Ucret) AS 'En yüksek Ücret'from tYazOkuluUcretleri AS you
left join tBolumler AS B
on B.ID = you.Bolum_tBolumlerID
left join tFakulteler AS F
on f.ID = B.Fakulte_tFakultelerID
GROUP BY F.Adi
order by sum(YOU.Ucret) desc

-- kan grubu "A Rh (+)" olan öðrencilerin bölümlere göre daðýlýmýný gösteriyor. Sonuçlar öðrenci sayýsýna göre azalan þekilde sýralanýyor.

select * from tKullanicilar
select * from tKanGruplari
select * from tBolumler
select * from tOgrenciler

select B.Adi as 'Bölüm Adi',Count(O.ID) as 'Öðrenci Sayisi' from tKullanicilar as K
left join tOgrenciler as O
on k.ID = O.Ogrenci_tKullanicilarID
left join tBolumler as B
on B.ID =O.Bolum_tBolumlerID
left join tKanGruplari AS kg
ON KG.ID = K.KanGrubu_tKanGruplariID
where KG.Adi = 'A Rh (+)'
GROUP BY B.Adi
order by Count(O.ID) desc


/*Ýstatislik öðrencilerinden adýnda a geçen kiþilerin adlarýnýn tekil hali ile bilgisayar öðrencilerinden adýnda b geçen kiþilerin tekil hallerini listeleyin.*/
/*Burda bir öðrencinin bölümü hem istatistik hem de bilgisayar olamaz o yüzden where için öyle birleþik and 'ler koyamayýz .*/ 
/*Ýki farklý select sorgusu tek tablo için unýon kullandýk .iki farklý tabloda kullanabilirdik*/
select * from tBolumler
select * from tOgrenciler
SELECT * FROM tKullanicilar

select distinct K.Adi from tOgrenciler O
left join tKullanicilar K 
ON o.Ogrenci_tKullanicilarID = k.ID
left join tBolumler as b
on o.Bolum_tBolumlerID = B.ID
WHERE K.Adi like '%a%' and B.Adi like '%Ýstatistik%'
UNION
select distinct K.Adi from tOgrenciler O
left join tKullanicilar K 
ON o.Ogrenci_tKullanicilarID = k.ID
left join tBolumler as b
on o.Bolum_tBolumlerID = B.ID
WHERE K.Adi like '%b%' and B.Adi like '%Bilgisayar%'

--UNION
select F.Adi from tFakulteler as F
UNION
select B.Adi from tBolumler AS B

/*En çok öðrencinin aldýðý 2 ders arasýndaki farký kaçtýr.*/

select * from tOgrenciler
select * from tDersiAlanOgrenciler
select * from tDersler

select TOP 2 D.Adi AS 'Ders Adi',Count(O.ID) 'Öðrenci Sayisi' from tOgrenciler AS O
left join tDersiAlanOgrenciler AS DO
on O.ID = DO.Ogrenci_tOgrencilerID
left join tDersler AS D
on D.ID = DO.Ders_tDerslerID
GROUP BY D.Adi
ORDER BY Count(O.ID) DESC


/*Her bir fakültenin kaç adet bölümü olduðunu fakülte adý ve bölüm sayýsý olacak þekilde iki sütunlu bir yapýda listele*/

select * from tFakulteler
SELECT * FROM tBolumler

select F.Adi as 'Fakülte Adi',count(B.Adi) as 'Bölüm sayisi' from tBolumler as B
left join tFakulteler as F
on F.ID = B.Fakulte_tFakultelerID
group by F.Adi

/*Kan grubu pozitif olan kiþi sayisi ile negatif olan kiþi sayisi arasýndaki fark nedir?*/

select * from tKullanicilar
select * from tKanGruplari
SET LANGUAGE Turkish 

SELECT
abs((select Count(*) from tKullanicilar AS K
left join tKanGruplari AS kg
on kg.ID = k.KanGrubu_tKanGruplariID
where kg.Adi like '%(+)%')
-
(select Count(*) from tKullanicilar AS K
left join tKanGruplari AS kg
on kg.ID = k.KanGrubu_tKanGruplariID
where kg.Adi like '%(-)%')) AS 'POZÝTÝF VE NEGATÝF KÝÞÝ SAYÝSÝ FARKÝ'

/*Ýstatistik öðrencilerinin telefon numaralarýnýnn ilk 3 hanesi göre her birinden kaç tane olduðunu listeleyin*/
select * from tOgrenciler
SELECT * from tKullanicilar
select * from tBolumler

select Count(*) 'Telefon Numara Ýlk Üç Hane Sayisi',SUBSTRING(K.CepTel,1,3) as 'Telefon Numara Ýlk Üç Hane'from tKullanicilar as K
left join tOgrenciler as O
on O.Ogrenci_tKullanicilarID = k.ID
left join tBolumler AS B
ON B.ID = O.Bolum_tBolumlerID
where B.Adi like '%Ýstatistik%'
group by SUBSTRING(K.CepTel,1,3)

/*Mühendislik fakültesindeki en çok öðrencinin aldýðý dersteki öðrenci sayisi ile insan ve toplum bilimlerindeki 
en çok öðrencinin aldýðý dersteki öðrenci sayisi arasýndaki fark kaçtýr?*/

select * from tBolumler
SELECT * FROM tFakulteler
select * from tOgrenciler
SELECT * FROM tDersiAlanOgrenciler

SELECT
(select TOP 1 COUNT(*)AS 'Öðrenci Sayisi'from tDersiAlanOgrenciler as Do
left join tOgrenciler as O
ON do.Ogrenci_tOgrencilerID = O.ID
left join tBolumler AS b
ON B.ID = O.Bolum_tBolumlerID
left join tFakulteler AS f
ON F.ID = b.Fakulte_tFakultelerID
WHERE F.Adi = 'Mühendislik Fakültesi'
group by F.Adi,Do.Ders_tDerslerID
ORDER BY COUNT(*) DESC)
-
(select TOP 1 COUNT(*)AS 'Öðrenci Sayisi'from tDersiAlanOgrenciler as Do
left join tOgrenciler as O
ON do.Ogrenci_tOgrencilerID = O.ID
left join tBolumler AS b
ON B.ID = O.Bolum_tBolumlerID
left join tFakulteler AS f
ON F.ID = b.Fakulte_tFakultelerID
WHERE F.Adi = 'Ýnsan ve Toplum Bilimleri Fakültesi '
group by F.Adi,Ders_tDerslerID
ORDER BY COUNT(*) DESC
) as 'FARK'





