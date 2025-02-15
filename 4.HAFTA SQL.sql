create table tKullanicilar
(
ID smallint identity(1,1) primary key not null,
Adi varchar(200) not null,
Soyadi varchar(200) not null
);

Alter table tKullanicilar
Add KayýtZamaný smalldatetime ;
-- Var olan bir tabloya sütun eklenirken 'Add' kullanýlýr.

ALTER TABLE tkullanicilar
ADD CONSTRAINT DF_KayitZamani DEFAULT GETDATE() FOR KayýtZamaný;
ALTER TABLE tkullanicilar
DROP CONSTRAINT DF_KayitZamani;
select * from tKullanicilar;

Alter table tKullanicilar
Alter column KayýtZamaný date ;
-- Var olan bir sütunun özelliðini deðiþtirmek istediðimizde 'Tekrardan Alter' kullanýlýr.

Alter table tKullanicilar
Add Constraint UQ_KLL unique(Adi);

Alter table tKullanicilar
Add TcKimlikNo char(11);

Alter table tKullanicilar
Add CepTel char(10);

select * from tKullanicilar;

Alter table tKullanicilar
Add constraint Nl_TcKimlikNo  unique(TcKimlikNo);

Alter table tKullanicilar
Add constraint Cp_Ceptel unique(CepTel);

select * from tKullanicilar;
-- var olan bir tablodaki sütunun ismini deðiþtirmede sp_rename veya tablo adý

exec sp_rename 'tKullanicilar','tKll';

exec sp_rename 'tKll.Adi','KullaniciAdi'


--- Tablodaki verileri güncelleme '	UPDATE'  

/* SORU
Kullanýcýlardan cinsiyeti 1 ya da 0 olup kan grubu 4 ya da  5 olan kayýtlarýn soyadlarýný ve adlarýný " bilinmiyor" olarak güncelleyin.
*/
update tKullanicilar
set 
Soyadi = 'Bilinmiyor' , Adi = 'Bilinmiyor'
where  (Cinsiyet = 1 or Cinsiyet = 0) and (KanGrubu_tKanGruplariID = 4 or KanGrubu_tKanGruplariID=5);

Delete from tKullanicilar
Where DogumTarihi >= '2004-01-01';

Delete from tKullanicilar
where year(getdate())- year(dogumTarihi)=20;

select Adi + ' ' + Soyadi as AdSoyad from tKullanicilar;

SELECT 
    Adi + ' ' + Soyadi AS 'Ad Soyad', 
    Adi AS [Kullanýcý Adý], 
    Soyadi AS [Kullanýcý Soyadý],
	*
FROM 
    tKullanicilar;

select 'Merhaba '+Adi+ ' ' + Soyadi+'  hoþgeldiniz.' as Mesaj from tKullanicilar
Where KanGrubu_tKanGruplariID = 7;

/* Final Notu 70'den büyük ve Vize Notu 45'ten küçük olan kiþilerin Vizenin %40'ý ile Finalin %60'ý olan toplamý gösterin*/

select (Final * 0.60 + Vize * 0.40) as 'Toplam' from tDersiAlanOgrenciler
Where Final > 70 and Vize < 45;

/* Dogum yeri Ankara ve Ýstanbul illerinden biri olup kan grubu A rh(+) ve B rh(+) deðerlerinden biri olan kiþilerin Adýný ve soyadýný
'Kan Verecek' olarak güncelleyin. */

select * from tKanGruplari;
select * from tKullanicilar;
select * from tIller;

UPDATE tKullanicilar
SET 
Adi = 'Kan Verecek' , Soyadi = 'Kan Verecek'
WHERE (DogumYeri_tillerID=6 OR DogumYeri_tillerID=34 ) AND ( KanGrubu_tKanGruplariID = 1 OR KanGrubu_tKanGruplariID = 3);

/* iliþkilendirme olmamasý yüzünden hata*/
/* iliþki varsa silinmez satýr veya sütün fark etmeksizin o tablo silinmez kuyruk misale en aþaðýdan yukarý silinmeli Tablo creat edilirkende iliþkili tablodan baþlanýp yapýlmalýdýr.*/

--Tabii, iþte örnek bir UPDATE sorgusu:

--Diyelim ki, tKullanicilar adlý tablomuzda Adi adlý bir sütun var ve bu sütundaki deðerlerin uzunluðu 6'dan büyük olan satýrlarda rastgele bir karakteri büyük harfe dönüþtürmek istiyoruz. 
--Örneðin, Adi sütununda "mehmet", "ali", "hasan" gibi veriler bulunuyor.

--Ýþte bu iþlemi gerçekleþtiren bir UPDATE sorgusunun örneði:
Update tKullanicilar
set
Adi = UPPER(Substring(Adi,cast(rand()*((Len(Adi)-1)+1) as int),1))
WHERE LEN(Adi)>4
