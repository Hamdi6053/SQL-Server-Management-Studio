/*VÝEW SANAL BÝR TABLO GÝBÝDÝR.BÝRDEN FAZLA TABLODAN ALINABÝLÝR VERÝLER
CREATE ÝLE OLUÞTURDUK
ALTER ÝLE UPDATE ETTÝK.
DROP KOMUTU ÝLE OLUÞTURDUÐUMUZ VÝEWÝ KALDIRABÝLÝRÝZ.
VERÝ TABANIN DA FÝZÝKSEL YER KAPLAMAZLAR. VÝEW = GÖRÜNÜM
SOYUTLAMA VÝEW KAVRAMI
VERÝ YOKTUR ANCAK HER VERÝYÝ ALABÝLMEK ÝÇÝN SORGU BARINDIRIR.
YANÝ HER GÖRÜNÜM ÝÇÝN ONA EKLENMÝÞ GÖRÜNÜM VARDIR.
FÝZÝKSEL OLARAK VÝEWÝN YAZILAN SORGULARI SAKLANIR 
VERÝ TABANINDA ASLINDA DATABASE ÝÇÝNDEKÝ FÝZÝKSEL TABLOLAR VERÝ KAYNAÐIMIZ.
SORGU ÇALIÞTIRILDIÐINDA BÝRDEN FAZLA TABLODAN 
VERÝ ALACAK VE GÖRÜNÜMÜ EKRANA GETÝRECEKTÝR.
GEREKSÝZ KOD TEKRARININ ÖNÜNE GEÇME.
ORDER BY SÖZCÜÐÜNÜ KULLANMAYIZ BU YAPI ÝLE.
BÝRDEN FAZLA AYNI JOÝNLEME ÝÞLEMÝNÝN ÖNÜNE GEÇME .
YAPILAN SORGU BÝR KEZ KONTROL EDÝLÝR VE HER ÇAÐRILDIÐINDA KONTROLE GEREK KALMAZ VÝEWM ÝLE
OLUÞTURULAN GÖRÜNÜMDE.
OLUÞTURDUÐUM VÝEW ÜZERÝNDEN SORGULAR YAZABÝLECEÐÝZ KOMUTLARI UZATMADAN.*/

alter view vKullaniciBilgileri
as
select k.ID, concat(k.Adi,' ',k.Soyadi) as 'Ad Soyad',
kg.Adi as KanGrubu, i.Adi as DogumYeri,k.Ceptel from tKullanicilar as k
left join tKanGruplari kg on k.KanGrubu_tKanGruplariID = kg.ID
left join tIlceler ilc on k.DogumYeri_tIlcelerID = ilc.ID
left join tIller i on ilc.Il_tIllerID = i.ID


create view vKullaniciBilgileri
as
select k.ID, concat(k.Adi,' ',k.Soyadi) as 'Ad Soyad',
kg.Adi as KanGrubu, i.Adi as DogumYeri,k.Ceptel from tKullanicilar as k
left join tKanGruplari kg on k.KanGrubu_tKanGruplariID = kg.ID
left join tIlceler ilc on k.DogumYeri_tIlcelerID = ilc.ID
left join tIller i on ilc.Il_tIllerID = i.ID

-- telefondakini yaz.

create unique nonclustered index
ind_tKullanicilarEposta
on tKullanicilar (Eposta)

create nonclustered index
ind_DersiAlanOgrenciler
on tDersiAlanOgrenciler (Ogrenci_tOgrencilerID,Ders_tDerslerID)

------------------
--METOT
alter procedure procKullaniBilgileri (@KullaniciID int)
as
Select Concat(Adi,' ',Soyadi) from tKullanicilar
WHERE ID = @KullaniciID
exec procKullaniBilgileri 268
/*deðiþiklik alter ile */
/*procedure ile istediðin kodu içine yazabilirsin sayfalarca*/

/*Kendisine parametre olarak verilen iki doðum tarihi arasýnda doðan kiþi sayýsýný ekrana yazdýran bir procedure
,tanýmlayýn ve kullanýmý gösterin.Eðer 0 kiþi varsa o zaman ekrana 'Bu tarihler arasýnda doðan kimse yok' yazsýn çýkabilir sýnavda*/
create procedure prockontrol(@baslangic date , @bitis date)
as
Declare @KisiSayisi int
select @KisiSayisi = count(*) from tKullanicilar
WHERE DogumTarihi between @baslangic and @bitis
  
if @KisiSayisi = 0
   Print 'Bu tarihler arasýnda kimse yok'
else
   Print @kisiSayisi
--set dateformat ymd
--exec procKontrol '2000-01-05','2001-05-04'
-------------------------------------
create function fnYasHesapla(@dogumTarihi date)
returns int
Begin
    declare @yas int
	Select @yas = DATEDIFF(YEAR,@dogumTarihi,GETDATE())
	return @yas
end

Select Adi,Soyadi,dbo.fnYasHesapla(DogumTarihi) from tKullanicilar
/*fonksiyonu selectin içine koyabiliriz ama prosedür baðýmsýz çalýþýr.*/
/*Önce yazdýðýn fonksiyonun tamamýný çalýþtýr.*/

/*Eposta adresi verilen öðrenciye ait tüm bilgileri silen bir procudure yazýn.*/
--Yani anlaþýldýðý üzere parametre olarak e posta vereceðiz.

create procedure proc_Sil(@Eposta varchar(255))
AS
Declare @KullaniciID int ,@ogrenciID int
Select @KullaniciID = K.ID , @ogrenciID = O.ID 
from tKullanicilar AS K
left join tOgrenciler AS O on O.Ogrenci_tKullanicilarID = k.ID
where k.Eposta = @Eposta

Delete from tDersiAlanOgrenciler Where Ogrenci_tOgrencilerID = @ogrenciID
Delete from tOgrenciler where Ogrenci_tKullanicilarID = @KullaniciID
Delete from tKullanicilar where ID = @KullaniciID

/*Kullanýcýlar tablosunda KullaniciAdi ve Sifre adlý alanlarýn olduðunu varsayýn.
Parametre olarak kullanýcý Adý ve þifreyi alan bir procedure tanýmlayýn.Bu procedure
bu bilgilere sahip bir kayýt varsa o kiþinin ID deðerinin döndürecek.Eðer bu bilgilere ait bir kayýt yoksa 
'Yanlýþ kullanýcý adý veya þifre' ifadesini döndürecek*/
create procedure proc_Kullanici(@Kullanc_Adý varchar,@þifre varchar)
as
Begin 
    Declare @KisiID int
	Select @KisiID = k.ID from tKullanicilar AS K
	where @Kullanc_Adý = K.KullaniciAdi and @þifre = K.Sifre

	if @KisiID is not null
	
	Begin 
		return 'Yanlýþ kullanýcý adý veya þifre'
	end

	Else
	
	Begin
	    return @KisiID
	End
End

/*ilce adi ve il adi parametre olarak alan bir procedure olusturun. Bu procedure parametre
olarak verilen il yoksa öncelikle ili olusturmali
 Ve sonrasinda altina ilçe eklemeli. Eger il var
ama ilçe yoksa o ilin altina ilçeyi eklemeli.
Fakat hem ilce hem de il kayitli ise tüm veriler kayitli mesajini dönmelidir.*/
SELECT * FROM tIlceler
create procedure proc_tÝlilce(@ÝlceAdi varchar , @ÝlAdi varchar)
as
Declare @ILID int,@ILceID int
select @ILID = ý.ID from tIller AS ý
WHERE I.Adi = @ÝlAdi

if @ILID is not null
select @ILceID = ID from tIlceler
WHERE Adi = @ÝlceAdi AND Il_tIllerID = @ILID

if @ILceID is null and @ILID is not null

begin 
	insert into tIlceler(Il_tIllerID,Adi)
	values (@ILID,@ÝlceAdi)
end

else if @ILceID is null and @ILID is null
begin
	insert into tIller (Adi)
    values (@ÝlAdi)
	insert into tIlceler(Il_tIllerID,Adi)
	values (SCOPE_IDENTITY(),@ÝlceAdi)
End

else if @ILID is not null and @ILceID is not null
begin
    print 'Tüm Veriler Kayitli'
End

/* Kullanýcýlarýn adýný,soyadýný eposta ve tc
deðerlerini parametre olarak alan bir procedure yazýn 
Bu procedure bu eposta deðerine ait bir kayýt varsa o kaydýn ad ve soyadýný günceller
Yoksa yeni bir kayýt ekler.Eðer ad ve soyad ayný ise
hiçbir deðiþiklik yapmadan kayýt güncel bilgisini ekrana yazdýrýr.*/

create procedure proc_Kayýt(@ad varchar,@soyad varchar,@eposta varchar,@Tc varchar)
As
Begin
    Declare @eskiAd varchar,@eskiSoyad varchar
	Select @eskiAd = K.Adi,@eskiSoyad = k.Soyadi from tKullanicilar as k
	WHERE Eposta = @eposta
	
	if @eskiAd is null
		insert into tKullanicilar(Adi,Soyadi,Eposta,TCKimlikNo)
		values(@ad,@soyad,@eposta,@Tc)

	Else
	    if @eskiAd = @ad AND @eskiSoyad = @soyad
		SELECT 'Tüm Bilgileri Güncelle'

		else 
		   update tKullanicilar SET Adi = @ad,Soyadi = @soyad,
		     TcKimlikNo = @Tc 
			 where  Eposta = @eposta
	
	