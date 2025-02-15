/*V�EW SANAL B�R TABLO G�B�D�R.B�RDEN FAZLA TABLODAN ALINAB�L�R VER�LER
CREATE �LE OLU�TURDUK
ALTER �LE UPDATE ETT�K.
DROP KOMUTU �LE OLU�TURDU�UMUZ V�EW� KALDIRAB�L�R�Z.
VER� TABANIN DA F�Z�KSEL YER KAPLAMAZLAR. V�EW = G�R�N�M
SOYUTLAMA V�EW KAVRAMI
VER� YOKTUR ANCAK HER VER�Y� ALAB�LMEK ���N SORGU BARINDIRIR.
YAN� HER G�R�N�M ���N ONA EKLENM�� G�R�N�M VARDIR.
F�Z�KSEL OLARAK V�EW�N YAZILAN SORGULARI SAKLANIR 
VER� TABANINDA ASLINDA DATABASE ���NDEK� F�Z�KSEL TABLOLAR VER� KAYNA�IMIZ.
SORGU �ALI�TIRILDI�INDA B�RDEN FAZLA TABLODAN 
VER� ALACAK VE G�R�N�M� EKRANA GET�RECEKT�R.
GEREKS�Z KOD TEKRARININ �N�NE GE�ME.
ORDER BY S�ZC���N� KULLANMAYIZ BU YAPI �LE.
B�RDEN FAZLA AYNI JO�NLEME ��LEM�N�N �N�NE GE�ME .
YAPILAN SORGU B�R KEZ KONTROL ED�L�R VE HER �A�RILDI�INDA KONTROLE GEREK KALMAZ V�EWM �LE
OLU�TURULAN G�R�N�MDE.
OLU�TURDU�UM V�EW �ZER�NDEN SORGULAR YAZAB�LECE��Z KOMUTLARI UZATMADAN.*/

alter view vKullaniciBilgileri
as
select k.ID, concat(k.Adi,' ',k.Soyadi) as 'Ad Soyad',
kg.Adi as KanGrubu, i.Adi as DogumYeri,k.Ceptel from tKullanicilar as k
left join tKanGruplari kg on k.KanGrubu_tKanGruplariID = kg.ID
left join tIlceler ilc on k.DogumYeri_tIlcelerID = ilc.ID
left join tIller i on ilc.Il_tIllerID�=�i.ID


create view vKullaniciBilgileri
as
select k.ID, concat(k.Adi,' ',k.Soyadi) as 'Ad Soyad',
kg.Adi as KanGrubu, i.Adi as DogumYeri,k.Ceptel from tKullanicilar as k
left join tKanGruplari kg on k.KanGrubu_tKanGruplariID = kg.ID
left join tIlceler ilc on k.DogumYeri_tIlcelerID = ilc.ID
left join tIller i on ilc.Il_tIllerID�=�i.ID

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
/*de�i�iklik alter ile */
/*procedure ile istedi�in kodu i�ine yazabilirsin sayfalarca*/

/*Kendisine parametre olarak verilen iki do�um tarihi aras�nda do�an ki�i say�s�n� ekrana yazd�ran bir procedure
,tan�mlay�n ve kullan�m� g�sterin.E�er 0 ki�i varsa o zaman ekrana 'Bu tarihler aras�nda do�an kimse yok' yazs�n ��kabilir s�navda*/
create procedure prockontrol(@baslangic date , @bitis date)
as
Declare @KisiSayisi int
select @KisiSayisi = count(*) from tKullanicilar
WHERE DogumTarihi between @baslangic and @bitis
  
if @KisiSayisi = 0
   Print 'Bu tarihler aras�nda kimse yok'
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
/*fonksiyonu selectin i�ine koyabiliriz ama prosed�r ba��ms�z �al���r.*/
/*�nce yazd���n fonksiyonun tamam�n� �al��t�r.*/

/*Eposta adresi verilen ��renciye ait t�m bilgileri silen bir procudure yaz�n.*/
--Yani anla��ld��� �zere parametre olarak e posta verece�iz.

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

/*Kullan�c�lar tablosunda KullaniciAdi ve Sifre adl� alanlar�n oldu�unu varsay�n.
Parametre olarak kullan�c� Ad� ve �ifreyi alan bir procedure tan�mlay�n.Bu procedure
bu bilgilere sahip bir kay�t varsa o ki�inin ID de�erinin d�nd�recek.E�er bu bilgilere ait bir kay�t yoksa 
'Yanl�� kullan�c� ad� veya �ifre' ifadesini d�nd�recek*/
create procedure proc_Kullanici(@Kullanc_Ad� varchar,@�ifre varchar)
as
Begin 
    Declare @KisiID int
	Select @KisiID = k.ID from tKullanicilar AS K
	where @Kullanc_Ad� = K.KullaniciAdi and @�ifre = K.Sifre

	if @KisiID is not null
	
	Begin 
		return 'Yanl�� kullan�c� ad� veya �ifre'
	end

	Else
	
	Begin
	    return @KisiID
	End
End

/*ilce adi ve il adi parametre olarak alan bir procedure olusturun. Bu procedure parametre
olarak verilen il yoksa �ncelikle ili olusturmali
 Ve sonrasinda altina il�e eklemeli. Eger il var
ama il�e yoksa o ilin altina il�eyi eklemeli.
Fakat hem ilce hem de il kayitli ise t�m veriler kayitli mesajini�d�nmelidir.*/
SELECT * FROM tIlceler
create procedure proc_t�lilce(@�lceAdi varchar , @�lAdi varchar)
as
Declare @ILID int,@ILceID int
select @ILID = �.ID from tIller AS �
WHERE I.Adi = @�lAdi

if @ILID is not null
select @ILceID = ID from tIlceler
WHERE Adi = @�lceAdi AND Il_tIllerID = @ILID

if @ILceID is null and @ILID is not null

begin 
	insert into tIlceler(Il_tIllerID,Adi)
	values (@ILID,@�lceAdi)
end

else if @ILceID is null and @ILID is null
begin
	insert into tIller (Adi)
    values (@�lAdi)
	insert into tIlceler(Il_tIllerID,Adi)
	values (SCOPE_IDENTITY(),@�lceAdi)
End

else if @ILID is not null and @ILceID is not null
begin
    print 'T�m Veriler Kayitli'
End

/* Kullan�c�lar�n ad�n�,soyad�n� eposta ve tc
de�erlerini parametre olarak alan bir procedure yaz�n 
Bu procedure bu eposta de�erine ait bir kay�t varsa o kayd�n ad ve soyad�n� g�nceller
Yoksa yeni bir kay�t ekler.E�er ad ve soyad ayn� ise
hi�bir de�i�iklik yapmadan kay�t g�ncel bilgisini ekrana yazd�r�r.*/

create procedure proc_Kay�t(@ad varchar,@soyad varchar,@eposta varchar,@Tc varchar)
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
		SELECT 'T�m Bilgileri G�ncelle'

		else 
		   update tKullanicilar SET Adi = @ad,Soyadi = @soyad,
		     TcKimlikNo = @Tc 
			 where  Eposta = @eposta
	
	