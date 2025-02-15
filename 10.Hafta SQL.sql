/*create database tTest
(
id int identity(1,1),
Adi varchar(100)
)
GO	
insert into tTest (Adi) values ('Test')*/

declare @sayi1 int
declare @sayi2 int=35
declare @sayi3 int=(select top1 ID from tTest 
order by ID desc)

set @sayi3=22 /*G�ncelleme yap�yoruz de�i�ken i�in.*/
select @sayi3

Declare @adi1 varchar(100) , @adi2 varchar(150)
Declare @adi3 varchar(100) = 'a', @adi4 varchar(150)
set @sayi3 = 22
select @sayi3
/*Yaz okulunda �cret �deyen ��rencilerin her birinin toplam �denen �cretin 
y�zde ka�� kadar �deme yapt���n� kay�tID ,kay�t tarihi ve y�zde oran� olacak �ekilde listeleyin
*/

Declare @toplam float /*De�i�ken atamak i�in.*/
--set @toplam=(Select sum(Ucret) from tYazOkuluUcretleri) /*De�i�kenin i�ine de�er atamak i�in bunu yapt�k set*/
select @toplam = sum(Ucret),@ortalama = avg(Ucret) from tYazOkuluUcretleri /*Yukardaki i�lem bu �ekildede olabilir.*/
print(@toplam)
print(@ortalama) /*Tablo �eklinde gelmeyecek metin gelecek bunu i�in yapt�k.*/
you.Ucret*100/@toplam from tYazOkuluUcretleri you


/*Ortalaman�n alt�nda yaz okulu vizesine sahip ki�ilere ortalaman�n %10'u kadar puan eklenmesi yapan kodu yaz�n�z.*/
select * from tYazOkuluUcretleri

DECLARE  @ortalama float
select @ortalama = avg(Vize) from tYazOkuluUcretleri
update tYazOkuluUcretleri set Vize = Vize+@ortalama*0.1
where vize<@ortalama

print(@@servername)
insert into ttest(Adi) values ('deneme')
print(@@identity)

/*Bir il ve o ile ait il�e kayd� ekleyin.*/
Begin /*begin ile endler gruplamaya al�r o sat�rlar�*/
insert into tIller(Adi) values ('Deneme ili')
insert into tIlceler(Adi,Il_tIllerID)
values('Deneme il�e',@@IDENTITY)
end
begin
     print('��lem bitti')
end

if @ortalama>50 and @sayi1>10
begin
    update tYazOkuluUcretleri SET Vize= Vize+@ortalama*0.1
	WHERE Vize<@ortalama
	print('G�ncelleme yap�ld�.')
end
else if @ortalama = 50
     update tYazOkuluUcretleri SET Vize = Vize+@ortalama*0.1
else 
begin
print('herhangi bir i�lem yap�lmad�.')
end 

select 
iif (k.Cinsiyet = 0 ,'Kad�n','Erkek'),/*her sat�r i�in bu i�lemi yap�yor.*/ /*Her sat�ra �art verme.*/
kg.Adi as Kangrubu,
iif(kg.Adi like '%+%','Pozitif','Negatif')
from tKullanicilar k
left join tKanGruplari kg on K.KanGrubu_tKanGruplariID = kg.ID
--iff(ko�ul, do�ruysa_de�er, yanl��sa_de�er)
select 
--iif (k.Cinsiyet = 0 ,'Kad�n','Erkek'),/*her sat�r i�in bu i�lemi yap�yor.*/ /*Her sat�ra �art verme.*/
kg.Adi as Kangrubu,
--iif(kg.Adi like '%+%','Pozitif','Negatif'),
case 
   when kg.Adi = 'Bilinmiyor' then '-'
   when kg.Adi like '%+%' then 'POZ�T�F'
   ELSE 'Hi�biri' end
as [Kan Grubu Yeni Ba�l�k]
from tKullanicilar k
left join tKanGruplari kg on K.KanGrubu_tKanGruplariID = kg.ID

/*Vize ortalamalar�n�n alt�nda olan ki�iler i�in 'alt�nda',+10 �st�nde olanlar i�in '�st�nde'-10 ile +10 aras�nda olanlar
i�in 'ortalamada' yazan kodu olu�turun.*/

Declare @ortalama float
select 
@ortalama = avg(Vize) 
from tYazOkuluUcretleri

select 
case  
   when vize<@ortalama-10 then 'alt�nda'
   when vize<@ortalama+10 then '�st�nde'
   else 'ortalama' end as YeniPuan
from tYazOkuluUcretleri


/*Mezun olan ��rencilere mezun ,4 y�l� a�mas�na ra�men mezun olamay�nca 'uzatt�' , 
4 y�l i�inde devam edenlere 'devam ediyor' yazan kodu olu�turun*/

select * from tOgrenciler

select 
case 
    when MezuniyetTarihi is null then 'Devam ediyor',
	when year(getdate())-year(BaslangicTarihi)> 4 'Uzad�',
	else 'mezun' end as Durum
from tOgrenciler o

Declare @sayac int = 10
while @sayac>0
begin
    insert into tTest(Adi) values (('adi',@sayac))
	set @sayac = @sayac - 1 
end

/*Kullan�c�lardan ilk 10 ki�inin do�umTarihini 2000-2020 rastgele bir do�um tarihi ile de�i�tirin */



set language turkish
Begin try 
     declare @sonuc  float = 4/0
end try
begin catch
      print('Hata al�nd�:'+error_message())
end catch 


/*Fak�ltelerin vize ortalamalar�n� ve final ortalamalar�n� listeleyin*/ 
select * from tFakulteler
select * from tYazOkuluUcretleri
SELECT* FROM tBolumler

SET LANGUAGE TURK�SH

SELECT F.Adi as 'Fak�lte Adi',AVG(D.Vize) as 'Fak�lte Vize Ortalamas� ',AVG(Final) as 'Fak�lte Final Ortalamas�'FROM tFakulteler as F
left join tBolumler AS B
on b.Fakulte_tFakultelerID = f.ID
left join tOgrenciler as O
on o.Bolum_tBolumlerID = B.ID
left join tDersiAlanOgrenciler as D
on D.Ogrenci_tOgrencilerID = O.ID
group by F.Adi
--�DEV
--EN Y�KSE VE EN D���K ORTALAMAYA SAH�P FAK�LTELER� BULUP A�A�IDAK� G�B� B�R MESAJ OLU�TURUN
-- �LAH�YAT EN D���K V�ZE ORTALAMASINA SAH�PKEN M�hendislik EN Y�KSEK V�ZE ORTALAMASINA SAH�PT�R
SELECT CONCAT(
(select TOP 1  F.AD�  from tFakulteler as F
left join tBolumler as B
on f.ID = b.Fakulte_tFakultelerID 
left join tOgrenciler AS O
on o.Bolum_tBolumlerID = b.ID
left join tDersiAlanOgrenciler AS D
on D.Ogrenci_tOgrencilerID = o.ID
WHERE D.Vize IS NOT NULL
group by F.Adi
order by AVG(V�ZE) ASC) , ' EN D���K V�ZE ORTALAMASINA SAH�PKEN ',
(select TOP 1 F.AD�  from tFakulteler as F
left join tBolumler as B
on f.ID = b.Fakulte_tFakultelerID 
left join tOgrenciler AS O
on o.Bolum_tBolumlerID = b.ID
left join tDersiAlanOgrenciler AS D
on D.Ogrenci_tOgrencilerID = o.ID
WHERE D.Vize IS NOT NULL
group by F.Adi
order by AVG(V�ZE) DESC) , ' EN Y�KSEK V�ZE ORTALAMAS�NA SAH�PT�R. ' )

--Vizenin % 40 ve finalin % 60 ile hesaplanan ge�me notu 50 dir .Ge�en ve kalan ��rencilere ge�ti ve kald� �eklinde listeleyin.

SELECT  
    (K.Adi + ' ' + K.Soyadi) as '��rencinin Ad� Soyad�',D.Vize as 'Vize Notu',
    CASE
        WHEN (D.Vize * 0.4 + D.Final * 0.6) >= 50 THEN 'GE�T�'
        WHEN (D.Vize * 0.4 + D.Final * 0.6) < 50 THEN 'KALDI'
        ELSE 'DE�ERLEND�RME DI�I'
    END AS 'DE�ERLEND�RME SONUCU'
FROM tDersiAlanOgrenciler as D
LEFT JOIN tOgrenciler as O ON D.Ogrenci_tOgrencilerID = O.ID
LEFT JOIN tKullanicilar as K ON K.ID = O.Ogrenci_tKullanicilarID

-- 10 ve daha az il�eye sahip illeri aralar�nda virg�l olacak �ekilde yan yana yaz�n

IF EXISTS (
    SELECT 1
    FROM tIlceler AS IL
    GROUP BY IL.Il_tIllerID
    HAVING COUNT(*) <= 10
)
BEGIN
    SELECT STRING_AGG(I.Adi, ', ') AS Iller
    FROM tIller AS I
    WHERE I.ID IN (
        SELECT IL.Il_tIllerID
        FROM tIlceler AS IL
        GROUP BY IL.Il_tIllerID
        HAVING COUNT(*) <= 10
    );
END
ELSE
BEGIN
    SELECT 'DE�ERLEND�RME DI�I' AS Sonuc;
END;

--Bir ��rencinin ald��� dersten ba�ar�l� olup olmad���n� kontrol et. 
--E�er ��rencinin vize ve final notlar� ge�er notun �zerindeyse (�rne�in, 50), "Ba�ar�l�" yazs�n. E�er ba�ar�s�zsa, "Ba�ar�s�z" yazs�n.
SELECT 
iif(D.Vize > 50 and D.Final >50 , 'Basar�l�','Basar�s�z') as 'Basar� Durumu',(K.Adi + ' ' + K.Soyadi) AS '��rencinin Adi Soyadi',o.OgrenciNo
from tDersiAlanOgrenciler AS d 
left join tOgrenciler AS O
on O.ID = d.Ogrenci_tOgrencilerID
left join tKullanicilar as k
ON K.ID = O.Ogrenci_tKullanicilarID


