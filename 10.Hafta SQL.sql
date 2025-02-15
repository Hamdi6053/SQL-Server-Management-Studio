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

set @sayi3=22 /*Güncelleme yapýyoruz deðiþken için.*/
select @sayi3

Declare @adi1 varchar(100) , @adi2 varchar(150)
Declare @adi3 varchar(100) = 'a', @adi4 varchar(150)
set @sayi3 = 22
select @sayi3
/*Yaz okulunda ücret ödeyen öðrencilerin her birinin toplam ödenen ücretin 
yüzde kaçý kadar ödeme yaptýðýný kayýtID ,kayýt tarihi ve yüzde oraný olacak þekilde listeleyin
*/

Declare @toplam float /*Deðiþken atamak için.*/
--set @toplam=(Select sum(Ucret) from tYazOkuluUcretleri) /*Deðiþkenin içine deðer atamak için bunu yaptýk set*/
select @toplam = sum(Ucret),@ortalama = avg(Ucret) from tYazOkuluUcretleri /*Yukardaki iþlem bu þekildede olabilir.*/
print(@toplam)
print(@ortalama) /*Tablo þeklinde gelmeyecek metin gelecek bunu için yaptýk.*/
you.Ucret*100/@toplam from tYazOkuluUcretleri you


/*Ortalamanýn altýnda yaz okulu vizesine sahip kiþilere ortalamanýn %10'u kadar puan eklenmesi yapan kodu yazýnýz.*/
select * from tYazOkuluUcretleri

DECLARE  @ortalama float
select @ortalama = avg(Vize) from tYazOkuluUcretleri
update tYazOkuluUcretleri set Vize = Vize+@ortalama*0.1
where vize<@ortalama

print(@@servername)
insert into ttest(Adi) values ('deneme')
print(@@identity)

/*Bir il ve o ile ait ilçe kaydý ekleyin.*/
Begin /*begin ile endler gruplamaya alýr o satýrlarý*/
insert into tIller(Adi) values ('Deneme ili')
insert into tIlceler(Adi,Il_tIllerID)
values('Deneme ilçe',@@IDENTITY)
end
begin
     print('Ýþlem bitti')
end

if @ortalama>50 and @sayi1>10
begin
    update tYazOkuluUcretleri SET Vize= Vize+@ortalama*0.1
	WHERE Vize<@ortalama
	print('Güncelleme yapýldý.')
end
else if @ortalama = 50
     update tYazOkuluUcretleri SET Vize = Vize+@ortalama*0.1
else 
begin
print('herhangi bir iþlem yapýlmadý.')
end 

select 
iif (k.Cinsiyet = 0 ,'Kadýn','Erkek'),/*her satýr için bu iþlemi yapýyor.*/ /*Her satýra þart verme.*/
kg.Adi as Kangrubu,
iif(kg.Adi like '%+%','Pozitif','Negatif')
from tKullanicilar k
left join tKanGruplari kg on K.KanGrubu_tKanGruplariID = kg.ID
--iff(koþul, doðruysa_deðer, yanlýþsa_deðer)
select 
--iif (k.Cinsiyet = 0 ,'Kadýn','Erkek'),/*her satýr için bu iþlemi yapýyor.*/ /*Her satýra þart verme.*/
kg.Adi as Kangrubu,
--iif(kg.Adi like '%+%','Pozitif','Negatif'),
case 
   when kg.Adi = 'Bilinmiyor' then '-'
   when kg.Adi like '%+%' then 'POZÝTÝF'
   ELSE 'Hiçbiri' end
as [Kan Grubu Yeni Baþlýk]
from tKullanicilar k
left join tKanGruplari kg on K.KanGrubu_tKanGruplariID = kg.ID

/*Vize ortalamalarýnýn altýnda olan kiþiler için 'altýnda',+10 üstünde olanlar için 'üstünde'-10 ile +10 arasýnda olanlar
için 'ortalamada' yazan kodu oluþturun.*/

Declare @ortalama float
select 
@ortalama = avg(Vize) 
from tYazOkuluUcretleri

select 
case  
   when vize<@ortalama-10 then 'altýnda'
   when vize<@ortalama+10 then 'üstünde'
   else 'ortalama' end as YeniPuan
from tYazOkuluUcretleri


/*Mezun olan öðrencilere mezun ,4 yýlý aþmasýna raðmen mezun olamayýnca 'uzattý' , 
4 yýl içinde devam edenlere 'devam ediyor' yazan kodu oluþturun*/

select * from tOgrenciler

select 
case 
    when MezuniyetTarihi is null then 'Devam ediyor',
	when year(getdate())-year(BaslangicTarihi)> 4 'Uzadý',
	else 'mezun' end as Durum
from tOgrenciler o

Declare @sayac int = 10
while @sayac>0
begin
    insert into tTest(Adi) values (('adi',@sayac))
	set @sayac = @sayac - 1 
end

/*Kullanýcýlardan ilk 10 kiþinin doðumTarihini 2000-2020 rastgele bir doðum tarihi ile deðiþtirin */



set language turkish
Begin try 
     declare @sonuc  float = 4/0
end try
begin catch
      print('Hata alýndý:'+error_message())
end catch 


/*Fakültelerin vize ortalamalarýný ve final ortalamalarýný listeleyin*/ 
select * from tFakulteler
select * from tYazOkuluUcretleri
SELECT* FROM tBolumler

SET LANGUAGE TURKÝSH

SELECT F.Adi as 'Fakülte Adi',AVG(D.Vize) as 'Fakülte Vize Ortalamasý ',AVG(Final) as 'Fakülte Final Ortalamasý'FROM tFakulteler as F
left join tBolumler AS B
on b.Fakulte_tFakultelerID = f.ID
left join tOgrenciler as O
on o.Bolum_tBolumlerID = B.ID
left join tDersiAlanOgrenciler as D
on D.Ogrenci_tOgrencilerID = O.ID
group by F.Adi
--ÖDEV
--EN YÜKSE VE EN DÜÞÜK ORTALAMAYA SAHÝP FAKÜLTELERÝ BULUP AÞAÐIDAKÝ GÝBÝ BÝR MESAJ OLUÞTURUN
-- ÝLAHÝYAT EN DÜÞÜK VÝZE ORTALAMASINA SAHÝPKEN Mühendislik EN YÜKSEK VÝZE ORTALAMASINA SAHÝPTÝR
SELECT CONCAT(
(select TOP 1  F.ADÝ  from tFakulteler as F
left join tBolumler as B
on f.ID = b.Fakulte_tFakultelerID 
left join tOgrenciler AS O
on o.Bolum_tBolumlerID = b.ID
left join tDersiAlanOgrenciler AS D
on D.Ogrenci_tOgrencilerID = o.ID
WHERE D.Vize IS NOT NULL
group by F.Adi
order by AVG(VÝZE) ASC) , ' EN DÜÞÜK VÝZE ORTALAMASINA SAHÝPKEN ',
(select TOP 1 F.ADÝ  from tFakulteler as F
left join tBolumler as B
on f.ID = b.Fakulte_tFakultelerID 
left join tOgrenciler AS O
on o.Bolum_tBolumlerID = b.ID
left join tDersiAlanOgrenciler AS D
on D.Ogrenci_tOgrencilerID = o.ID
WHERE D.Vize IS NOT NULL
group by F.Adi
order by AVG(VÝZE) DESC) , ' EN YÜKSEK VÝZE ORTALAMASÝNA SAHÝPTÝR. ' )

--Vizenin % 40 ve finalin % 60 ile hesaplanan geçme notu 50 dir .Geçen ve kalan öðrencilere geçti ve kaldý þeklinde listeleyin.

SELECT  
    (K.Adi + ' ' + K.Soyadi) as 'Öðrencinin Adý Soyadý',D.Vize as 'Vize Notu',
    CASE
        WHEN (D.Vize * 0.4 + D.Final * 0.6) >= 50 THEN 'GEÇTÝ'
        WHEN (D.Vize * 0.4 + D.Final * 0.6) < 50 THEN 'KALDI'
        ELSE 'DEÐERLENDÝRME DIÞI'
    END AS 'DEÐERLENDÝRME SONUCU'
FROM tDersiAlanOgrenciler as D
LEFT JOIN tOgrenciler as O ON D.Ogrenci_tOgrencilerID = O.ID
LEFT JOIN tKullanicilar as K ON K.ID = O.Ogrenci_tKullanicilarID

-- 10 ve daha az ilçeye sahip illeri aralarýnda virgül olacak þekilde yan yana yazýn

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
    SELECT 'DEÐERLENDÝRME DIÞI' AS Sonuc;
END;

--Bir öðrencinin aldýðý dersten baþarýlý olup olmadýðýný kontrol et. 
--Eðer öðrencinin vize ve final notlarý geçer notun üzerindeyse (örneðin, 50), "Baþarýlý" yazsýn. Eðer baþarýsýzsa, "Baþarýsýz" yazsýn.
SELECT 
iif(D.Vize > 50 and D.Final >50 , 'Basarýlý','Basarýsýz') as 'Basarý Durumu',(K.Adi + ' ' + K.Soyadi) AS 'Öðrencinin Adi Soyadi',o.OgrenciNo
from tDersiAlanOgrenciler AS d 
left join tOgrenciler AS O
on O.ID = d.Ogrenci_tOgrencilerID
left join tKullanicilar as k
ON K.ID = O.Ogrenci_tKullanicilarID


