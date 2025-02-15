create table tKullanicilar
(
ID smallint identity(1,1) primary key not null,
Adi varchar(200) not null,
Soyadi varchar(200) not null
);

Alter table tKullanicilar
Add Kay�tZaman� smalldatetime ;
-- Var olan bir tabloya s�tun eklenirken 'Add' kullan�l�r.

ALTER TABLE tkullanicilar
ADD CONSTRAINT DF_KayitZamani DEFAULT GETDATE() FOR Kay�tZaman�;
ALTER TABLE tkullanicilar
DROP CONSTRAINT DF_KayitZamani;
select * from tKullanicilar;

Alter table tKullanicilar
Alter column Kay�tZaman� date ;
-- Var olan bir s�tunun �zelli�ini de�i�tirmek istedi�imizde 'Tekrardan Alter' kullan�l�r.

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
-- var olan bir tablodaki s�tunun ismini de�i�tirmede sp_rename veya tablo ad�

exec sp_rename 'tKullanicilar','tKll';

exec sp_rename 'tKll.Adi','KullaniciAdi'


--- Tablodaki verileri g�ncelleme '	UPDATE'  

/* SORU
Kullan�c�lardan cinsiyeti 1 ya da 0 olup kan grubu 4 ya da  5 olan kay�tlar�n soyadlar�n� ve adlar�n� " bilinmiyor" olarak g�ncelleyin.
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
    Adi AS [Kullan�c� Ad�], 
    Soyadi AS [Kullan�c� Soyad�],
	*
FROM 
    tKullanicilar;

select 'Merhaba '+Adi+ ' ' + Soyadi+'  ho�geldiniz.' as Mesaj from tKullanicilar
Where KanGrubu_tKanGruplariID = 7;

/* Final Notu 70'den b�y�k ve Vize Notu 45'ten k���k olan ki�ilerin Vizenin %40'� ile Finalin %60'� olan toplam� g�sterin*/

select (Final * 0.60 + Vize * 0.40) as 'Toplam' from tDersiAlanOgrenciler
Where Final > 70 and Vize < 45;

/* Dogum yeri Ankara ve �stanbul illerinden biri olup kan grubu A rh(+) ve B rh(+) de�erlerinden biri olan ki�ilerin Ad�n� ve soyad�n�
'Kan Verecek' olarak g�ncelleyin. */

select * from tKanGruplari;
select * from tKullanicilar;
select * from tIller;

UPDATE tKullanicilar
SET 
Adi = 'Kan Verecek' , Soyadi = 'Kan Verecek'
WHERE (DogumYeri_tillerID=6 OR DogumYeri_tillerID=34 ) AND ( KanGrubu_tKanGruplariID = 1 OR KanGrubu_tKanGruplariID = 3);

/* ili�kilendirme olmamas� y�z�nden hata*/
/* ili�ki varsa silinmez sat�r veya s�t�n fark etmeksizin o tablo silinmez kuyruk misale en a�a��dan yukar� silinmeli Tablo creat edilirkende ili�kili tablodan ba�lan�p yap�lmal�d�r.*/

--Tabii, i�te �rnek bir UPDATE sorgusu:

--Diyelim ki, tKullanicilar adl� tablomuzda Adi adl� bir s�tun var ve bu s�tundaki de�erlerin uzunlu�u 6'dan b�y�k olan sat�rlarda rastgele bir karakteri b�y�k harfe d�n��t�rmek istiyoruz. 
--�rne�in, Adi s�tununda "mehmet", "ali", "hasan" gibi veriler bulunuyor.

--��te bu i�lemi ger�ekle�tiren bir UPDATE sorgusunun �rne�i:
Update tKullanicilar
set
Adi = UPPER(Substring(Adi,cast(rand()*((Len(Adi)-1)+1) as int),1))
WHERE LEN(Adi)>4
