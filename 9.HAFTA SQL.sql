select * from tBolumler;
select * from tFakulteler;

select * from tBolumler b1,tFakulteler f1 
where f1.ID = b1.Fakulte_tFakultelerID

select * from tIller;
select * from tIlceler;

SELECT tIlceler.Adi as '�l�e Ad�',tIller.Adi as '�l Ad�'from  tIlceler,tIller 
where tIlceler.Il_tIllerID = tIller.ID

select * from tKullanicilar
select * from tKanGruplari
select * from tIlceler

select K.Adi,K.Soyadi,I.Adi as 'DogumYeri �l�e Adi',KG.Adi as 'KanGruplar� Adi' FROM tKullanicilar as K,tIlceler as I,tKanGruplari as KG
WHERE K.KanGrubu_tKanGruplariID = KG.ID
AND
K.DogumYeri_tIlcelerID = I.ID

select * from tOgrenciler
select * from tBolumler
select * from tFakulteler

select O.OgrenciNo as '��renci Numaras�',B.Adi as 'B�l�m Adi',F.Adi as 'Fak�lte Adi'from tOgrenciler as O ,tBolumler as B , tFakulteler as F
where O.Bolum_tBolumlerID = B.ID
and 
B.Fakulte_tFakultelerID = F.ID

select * from tKullanicilar
select * from tOgrenciler
select * from tFakulteler
select * from tBolumler

select (k.Adi + ' ' + k.Soyadi) as 'Ogrenci Adi', F.Adi as 'Fak�lte Adi' from tKullanicilar AS K , tOgrenciler AS O, tBolumler AS B, tFakulteler AS F
where k.ID = O.Ogrenci_tKullanicilarID
and 
F.ID = B.Fakulte_tFakultelerID
and
O.Bolum_tBolumlerID = B.ID

-- her dersi ka� ��rencinin ald��� 

select * from tDersiAlanOgrenciler
select * from tDersler

select d.Adi as 'Ders Adi',count(*) as '��renci say�s�'
from tDersiAlanOgrenciler as dao,tDersler D
WHERE DAO.Ders_tDerslerID = d.ID
GROUP BY d.Adi

-- Son 2008 - 2010 y�llar� aras�nda hangi b�l�mdeki dersler i�in toplam ne kadar �cret �dendi�i
-- listelenmek istenirse yani b�l�m ad�,ders adi, toplam �cret �eklinde

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
-- fak�lteler
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

select B.Adi as 'B�l�m Adi',F.Adi AS 'Fak�lte Adi' from tBolumler AS B left join tFakulteler AS F
ON B.Fakulte_tFakultelerID = F.ID
GROUP BY F.Adi,B.Adi

--Ben yazd�m bunu group by 
--Hocan�n yazd���

select B.Adi as 'B�l�m Adi',F.Adi AS 'Fak�lte Adi' from tBolumler AS B left join tFakulteler AS F
ON B.Fakulte_tFakultelerID = F.ID

/*Her bir fak�ltenin ka� adet b�l�m� oldu�unu fak�lte ad� ve b�l�m say�s� olacak �ekilde
iki s�tunla bir yap�da listele*/

select * from tBolumler
select * from tFakulteler

select f.Adi as 'Fak�lte Adi', Count(*) 'B�l�m Sayisi' from tBolumler AS B left join tFakulteler as F 
on B.Fakulte_tFakultelerID =  F.ID
Group by F.Adi

Select ID from tFakulteler WHERE tFakulteler.Adi like '%b%'

select * from tBolumler b
where b.Fakulte_tFakultelerID in (Select ID from tFakulteler WHERE tFakulteler.Adi like '%b%')

/*Dogum yerine g�re hangi ilde en y�ksek ki�i vard�r */
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

/*Yaz Okulu �cretleri incelendi�inde en y�ksek toplam �cret �demesi yap�lan fak�lte  hangisidir? */

select * from tYazOkuluUcretleri
select * from tBolumler
select * from tFakulteler

select TOP 1 F.Adi , Sum(You.Ucret) AS 'En y�ksek �cret'from tYazOkuluUcretleri AS you
left join tBolumler AS B
on B.ID = you.Bolum_tBolumlerID
left join tFakulteler AS F
on f.ID = B.Fakulte_tFakultelerID
GROUP BY F.Adi
order by sum(YOU.Ucret) desc

-- kan grubu "A Rh (+)" olan ��rencilerin b�l�mlere g�re da��l�m�n� g�steriyor. Sonu�lar ��renci say�s�na g�re azalan �ekilde s�ralan�yor.

select * from tKullanicilar
select * from tKanGruplari
select * from tBolumler
select * from tOgrenciler

select B.Adi as 'B�l�m Adi',Count(O.ID) as '��renci Sayisi' from tKullanicilar as K
left join tOgrenciler as O
on k.ID = O.Ogrenci_tKullanicilarID
left join tBolumler as B
on B.ID =O.Bolum_tBolumlerID
left join tKanGruplari AS kg
ON KG.ID = K.KanGrubu_tKanGruplariID
where KG.Adi = 'A Rh (+)'
GROUP BY B.Adi
order by Count(O.ID) desc


/*�statislik ��rencilerinden ad�nda a ge�en ki�ilerin adlar�n�n tekil hali ile bilgisayar ��rencilerinden ad�nda b ge�en ki�ilerin tekil hallerini listeleyin.*/
/*Burda bir ��rencinin b�l�m� hem istatistik hem de bilgisayar olamaz o y�zden where i�in �yle birle�ik and 'ler koyamay�z .*/ 
/*�ki farkl� select sorgusu tek tablo i�in un�on kulland�k .iki farkl� tabloda kullanabilirdik*/
select * from tBolumler
select * from tOgrenciler
SELECT * FROM tKullanicilar

select distinct K.Adi from tOgrenciler O
left join tKullanicilar K 
ON o.Ogrenci_tKullanicilarID = k.ID
left join tBolumler as b
on o.Bolum_tBolumlerID = B.ID
WHERE K.Adi like '%a%' and B.Adi like '%�statistik%'
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

/*En �ok ��rencinin ald��� 2 ders aras�ndaki fark� ka�t�r.*/

select * from tOgrenciler
select * from tDersiAlanOgrenciler
select * from tDersler

select TOP 2 D.Adi AS 'Ders Adi',Count(O.ID) '��renci Sayisi' from tOgrenciler AS O
left join tDersiAlanOgrenciler AS DO
on O.ID = DO.Ogrenci_tOgrencilerID
left join tDersler AS D
on D.ID = DO.Ders_tDerslerID
GROUP BY D.Adi
ORDER BY Count(O.ID) DESC


/*Her bir fak�ltenin ka� adet b�l�m� oldu�unu fak�lte ad� ve b�l�m say�s� olacak �ekilde iki s�tunlu bir yap�da listele*/

select * from tFakulteler
SELECT * FROM tBolumler

select F.Adi as 'Fak�lte Adi',count(B.Adi) as 'B�l�m sayisi' from tBolumler as B
left join tFakulteler as F
on F.ID = B.Fakulte_tFakultelerID
group by F.Adi

/*Kan grubu pozitif olan ki�i sayisi ile negatif olan ki�i sayisi aras�ndaki fark nedir?*/

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
where kg.Adi like '%(-)%')) AS 'POZ�T�F VE NEGAT�F K��� SAY�S� FARK�'

/*�statistik ��rencilerinin telefon numaralar�n�nn ilk 3 hanesi g�re her birinden ka� tane oldu�unu listeleyin*/
select * from tOgrenciler
SELECT * from tKullanicilar
select * from tBolumler

select Count(*) 'Telefon Numara �lk �� Hane Sayisi',SUBSTRING(K.CepTel,1,3) as 'Telefon Numara �lk �� Hane'from tKullanicilar as K
left join tOgrenciler as O
on O.Ogrenci_tKullanicilarID = k.ID
left join tBolumler AS B
ON B.ID = O.Bolum_tBolumlerID
where B.Adi like '%�statistik%'
group by SUBSTRING(K.CepTel,1,3)

/*M�hendislik fak�ltesindeki en �ok ��rencinin ald��� dersteki ��renci sayisi ile insan ve toplum bilimlerindeki 
en �ok ��rencinin ald��� dersteki ��renci sayisi aras�ndaki fark ka�t�r?*/

select * from tBolumler
SELECT * FROM tFakulteler
select * from tOgrenciler
SELECT * FROM tDersiAlanOgrenciler

SELECT
(select TOP 1 COUNT(*)AS '��renci Sayisi'from tDersiAlanOgrenciler as Do
left join tOgrenciler as O
ON do.Ogrenci_tOgrencilerID = O.ID
left join tBolumler AS b
ON B.ID = O.Bolum_tBolumlerID
left join tFakulteler AS f
ON F.ID = b.Fakulte_tFakultelerID
WHERE F.Adi = 'M�hendislik Fak�ltesi'
group by F.Adi,Do.Ders_tDerslerID
ORDER BY COUNT(*) DESC)
-
(select TOP 1 COUNT(*)AS '��renci Sayisi'from tDersiAlanOgrenciler as Do
left join tOgrenciler as O
ON do.Ogrenci_tOgrencilerID = O.ID
left join tBolumler AS b
ON B.ID = O.Bolum_tBolumlerID
left join tFakulteler AS f
ON F.ID = b.Fakulte_tFakultelerID
WHERE F.Adi = '�nsan ve Toplum Bilimleri Fak�ltesi '
group by F.Adi,Ders_tDerslerID
ORDER BY COUNT(*) DESC
) as 'FARK'





