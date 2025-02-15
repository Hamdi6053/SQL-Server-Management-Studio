--T�m fak�ltelerin adlar�n� listeleyen bir stored procedure yazman�z� istiyorum. 
--Procedure'�n ad� "sp_FakulteleriListele" olsun.

create procedure sp_FakulteleriListele 
As
Begin
     Select F.Adi from tFakulteler as F
End

execute  sp_FakulteleriListele 
select * from tFakulteler
--Bir fak�ltenin ID'sini parametre olarak alan ve o fak�lteye ait
--b�l�mleri listeleyen bir stored procedure yazal�m. Procedure'�n ad� "sp_BolumleriGetir" olsun.
set language turkish
create procedure sp_BolumleriGetir (@ID tinyint)
As
Begin
     Select F.Adi as 'Fak�lte Adi',B.Adi as 'B�l�m Adi'from tFakulteler AS F
	 left join tBolumler AS B
	 on F.ID = B.Fakulte_tFakultelerID
	 where F.ID = @ID
	 group by F.Adi ,B.Adi
End

execute sp_BolumleriGetir @ID = 8


/*Bir ��rencinin TC Kimlik numaras�n� parametre olarak alan ve o ��rencinin:
Ad� Soyad�
Fak�ltesi
B�l�m�
Ald��� derslerin adlar� ve notlar� (Vize, Final)
bilgilerini getiren bir stored procedure yazal�m. Ad� "sp_OgrenciDersDetay" olsun.*/

create procedure 
sp_OgrenciDersDetay (@TC char(11))
AS
Begin 
     Select K.Adi as '��rencinin Adi',k.Soyadi AS '��rencinin Soyadi',
	 F.Adi AS 'Fak�lte Adi',B.Adi AS 'B�l�m Adi',
	 Ds.Adi  as 'Ders Adi',D.Vize '��rencinin Vize Notu',
	 D.Final AS '��rencinin Final Notu'
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


/*Bir ��rencinin:

��renci ID'sini (Ogrenci_tOgrencilerID)
Ders ID'sini (Ders_tDerslerID)
Hoca ID'sini (Hoca_tKullanicilarID)
Vize notunu
Final notunu

parametre olarak alan ve:

Bu bilgileri tDersiAlanOgrenciler tablosuna ekleyen
Vize notunun %40'� ve final notunun %60'�n� alarak ge�me notunu hesaplayan
Ge�me notu 60 ve �zerindeyse 'GE�T�', alt�ndaysa 'KALDI' bilgisini d�nd�ren

bir stored procedure yazal�m. Ad� "sp_DersNotuEkle" olsun*/
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

    -- Ge�me notunu hesapla
    DECLARE @GecmeNotu FLOAT;
    SET @GecmeNotu = (@VizeNot * 0.4) + (@FinalNotu * 0.6);

    -- ��rencinin durumu ve bilgileri
    SELECT 
        O.Adi AS '��rencinin Ad�',
        O.Soyadi AS '��rencinin Soyad�',
        @GecmeNotu AS 'Ge�me Notu',
        CASE
            WHEN @GecmeNotu >= 60 THEN 'GE�T�'
            ELSE 'KALDI'
        END AS 'Durum'
    FROM tOgrenciler AS O
    WHERE O.ID = @OgrenciID;
END;







