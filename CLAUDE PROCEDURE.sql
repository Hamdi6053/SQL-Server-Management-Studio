--Tüm fakültelerin adlarýný listeleyen bir stored procedure yazmanýzý istiyorum. 
--Procedure'ün adý "sp_FakulteleriListele" olsun.

create procedure sp_FakulteleriListele 
As
Begin
     Select F.Adi from tFakulteler as F
End

execute  sp_FakulteleriListele 
select * from tFakulteler
--Bir fakültenin ID'sini parametre olarak alan ve o fakülteye ait
--bölümleri listeleyen bir stored procedure yazalým. Procedure'ün adý "sp_BolumleriGetir" olsun.
set language turkish
create procedure sp_BolumleriGetir (@ID tinyint)
As
Begin
     Select F.Adi as 'Fakülte Adi',B.Adi as 'Bölüm Adi'from tFakulteler AS F
	 left join tBolumler AS B
	 on F.ID = B.Fakulte_tFakultelerID
	 where F.ID = @ID
	 group by F.Adi ,B.Adi
End

execute sp_BolumleriGetir @ID = 8


/*Bir öðrencinin TC Kimlik numarasýný parametre olarak alan ve o öðrencinin:
Adý Soyadý
Fakültesi
Bölümü
Aldýðý derslerin adlarý ve notlarý (Vize, Final)
bilgilerini getiren bir stored procedure yazalým. Adý "sp_OgrenciDersDetay" olsun.*/

create procedure 
sp_OgrenciDersDetay (@TC char(11))
AS
Begin 
     Select K.Adi as 'Öðrencinin Adi',k.Soyadi AS 'Öðrencinin Soyadi',
	 F.Adi AS 'Fakülte Adi',B.Adi AS 'Bölüm Adi',
	 Ds.Adi  as 'Ders Adi',D.Vize 'Öðrencinin Vize Notu',
	 D.Final AS 'Öðrencinin Final Notu'
	 from tKullanicilar as K
	 left join tOgrenciler as O
	 on k.ID = o.Ogrenci_tKullanicilarID
	 left join tBolumler as B
	 on B.ID = O.Bolum_tBolumlerID
	 left join tFakulteler as F
	 on F.ID = B.Fakulte_tFakultelerID
	 left join tDersiAlanOgrenciler AS D
	 on D.Ogrenci_tOgrencilerID= O.ID
	 left join tDersler AS Ds
	 on Ds.ID = D.Ders_tDerslerID
	 Where k.TCKimlikNo = @TC
End

execute sp_OgrenciDersDetay @TC = 55375512897


/*Bir öðrencinin:

Öðrenci ID'sini (Ogrenci_tOgrencilerID)
Ders ID'sini (Ders_tDerslerID)
Hoca ID'sini (Hoca_tKullanicilarID)
Vize notunu
Final notunu

parametre olarak alan ve:

Bu bilgileri tDersiAlanOgrenciler tablosuna ekleyen
Vize notunun %40'ý ve final notunun %60'ýný alarak geçme notunu hesaplayan
Geçme notu 60 ve üzerindeyse 'GEÇTÝ', altýndaysa 'KALDI' bilgisini döndüren

bir stored procedure yazalým. Adý "sp_DersNotuEkle" olsun*/
SELECT * FROM tDersiAlanOgrenciler

CREATE PROCEDURE sp_DersNotuEkle (
    @OgrenciID INT,
    @DersID INT,
    @HocaID INT,
    @VizeNot FLOAT,
    @FinalNotu FLOAT
)
AS
BEGIN
    -- Bilgileri tDersiAlanOgrenciler tablosuna ekle
    INSERT INTO tDersiAlanOgrenciler (
        Ogrenci_tOgrencilerID,
        Ders_tDerslerID,
        Hoca_tKullanicilarID,
        Vize,
        Final
    )
    VALUES (
        @OgrenciID,
        @DersID,
        @HocaID,
        @VizeNot,
        @FinalNotu
    );

    -- Geçme notunu hesapla
    DECLARE @GecmeNotu FLOAT;
    SET @GecmeNotu = (@VizeNot * 0.4) + (@FinalNotu * 0.6);

    -- Öðrencinin durumu ve bilgileri
    SELECT 
        O.Adi AS 'Öðrencinin Adý',
        O.Soyadi AS 'Öðrencinin Soyadý',
        @GecmeNotu AS 'Geçme Notu',
        CASE
            WHEN @GecmeNotu >= 60 THEN 'GEÇTÝ'
            ELSE 'KALDI'
        END AS 'Durum'
    FROM tOgrenciler AS O
    WHERE O.ID = @OgrenciID;
END;







