/*12. HAFTA KONULAR B�TT� SORGULAR.*/

insert into tTest(Adi) values ('bla bla')
print('Yeni kay�t olu�tu.ID de�eri:')
print(scope_identity)
/*Nereye son kay�t girmi�se onun ID sini d�nd�r�r.*/


/*Parametre olarak il ad�n� alan bir procedure olu�turun.Bu procedure 
hem ili hem de ona ba�l� t�m il�elerde do�an ki�ilerin do�um yeri de�erini de 0
olarak g�ncelleyin.*/
select * from tIller
SELECT * FROM tIlceler
select * from tKullanicilar


create procedure ilSil(@IlAdi varchar)
As
Declare @ILID int
Select @IlID = ID from tIller WHERE Adi = @ILAdi

update tKullanicilar set DogumYeri_tIlcelerID = 0
where DogumYeri_tIlcelerID in
(Select ID from tIlceler where Il_tIllerID =@ILID)

delete from tIlceler WHERE Il_tIllerID = @ILID
delete from tIller WHERE ID = @ILID

/*Parametre olarak Kullanicilar�n Adlar�n� istedi�in ad ile de�i�tirin*/

create procedure Is�mD (@Is�m1 varchar,@Is�m2 varchar)
as
update tKullanicilar set Adi='x' where Adi=@Is�m1
update tKullanicilar set Adi=@Is�m1 where Adi=@Is�m2
update tKullanicilar set Adi=@Is�m2�where�Adi=�'x'



--IIF(ko�ul, do�ru_de�er, yanl��_de�er)

/*Kullanici adlar� , soyadlar� ald��� ders adlari ve Vize ile Final ortalams�n�n 50 nin alt�nda olanlar�n�n
alt�nda , �st�nde olanlanr�n�n �st�nde olarak yaz�ld��� s�tun ile listeleyin.*/
set language turkish
select (K.Adi + ' ' + K.Soyadi) as '��rencinin Adi ve Soyadi',
Ds.Adi AS 'Ders Adi',
Avg(D.Vize+D.Final) as '��rencinin Ortalama',
iif(Avg(D.Vize+D.Final) > 50,'�st�nde', 'Alt�nda') as 'Ba�ar� Durumu'
from tKullanicilar as K
left join tOgrenciler AS O
on O.Ogrenci_tKullanicilarID = k.ID
left join tDersiAlanOgrenciler AS D
on D.Ogrenci_tOgrencilerID = O.ID
left join tDersler AS Ds
on D.Ders_tDerslerID = dS.ID
where D.Vize is not null and D.Final is not null
group by Ds.Adi,K.Adi,K.Soyadi

/*Bilgisayar M�hendisli�i b�l�m�ndeki Matematik dersinin 
ge�me notu  en y�ksek 10 ki�iyi listeleyin*/
Select TOP 10 (D.Vize*0.4+D.Final*0.6) as 'Ge�me Notu' , K.Adi,K.Soyadi from tKullanicilar AS K
left join tOgrenciler as O
on O.Ogrenci_tKullanicilarID = K.ID
left join tBolumler AS B
on B.ID = O.Bolum_tBolumlerID
left join tFakulteler AS F
on F.ID = B.Fakulte_tFakultelerID
left join tDersiAlanOgrenciler as D
on D.Ogrenci_tOgrencilerID = o.ID
left join tDersler AS Ds
on Ds.ID = D.Ders_tDerslerID
where B.Adi like '%Bilgisayar M�hendisli�i Lisans Program�%' AND (Ds.Adi like  '%Matematik%')
order by (D.Vize*0.4+D.Final*0.6) desc

/*Birden fazla isimli ve birden fazla soyisimli ki�ileri listeleyin.*/

select K.Adi,K.Soyadi from tKullanicilar as k
where (K.Adi like '% %' ) AND (K.Soyadi like '% %')

/*Parametre olarak kan gruplar�n�n adlar�n� aralar�nda virg�l olacak �ekilde al�p 
o kan gruplar�ndan herhangi birine e�it olan kay�tlar varsa cep telefonu numaralar�n� ekrana listeleyen 
procedure yaz�n.*/
create procedure proc_KanAdlari(@KanAd varchar(10))
AS
Select K.Adi, K.Soyadi,K.Ceptel
from tKullanicilar AS K
left join tKanGruplari AS Kg on k.KanGrubu_tKanGruplariID = kg.ID
where kg.Adi in (
Select value from string_split(@KanAd,','))


/*Ki�ilerin adlar�n�n ba� harflerine g�re*/
select SUBSTRING(K.Adi,1,1) as 'Ba� Harfi',Avg(LEN(k.Adi)) as 'Ortalama Uzunluk' from tKullanicilar as K
group by  SUBSTRING(K.Adi,1,1)
order by SUBSTRING(K.Adi,1,1)



/*Soru:

Bir prosed�r yaz�n, parametre olarak bir b�l�m ad� ald���nda, o b�l�me ait t�m ��rencilerin ��renci numaralar�n� ve isimlerini listeleyen bir i�lem ger�ekle�tirsin.
Gereksinimler:
Prosed�r, b�l�m ad� (string) alacak.
B�l�m ad� do�ruysa, o b�l�me ait t�m ��rencilerin ��renci No, Ad�, ve Soyad� bilgilerini d�nd�recek.
E�er girilen b�l�m ad� ge�erli de�ilse, "B�yle bir b�l�m bulunmamaktad�r" mesaj�n� d�nd�recek.*/
select * from tBolumler

alter procedure proc_tBolum(@BolumAdi varchar(250))
As
Begin 
		Declare @BolumAd varchar(250)
		Select @BolumAd = B.Adi FROM tBolumler AS B
		WHERE B.Adi = @BolumAdi 
		
		if @BolumAd is not null
		Begin 
		     Select  B.Adi as 'B�l�m Adi',O.OgrenciNo as '��renci Numaras�',K.Adi as '��rencinin Adi',K.Soyadi as '��rencinin Soyadi' from tBolumler as B
			 left join tOgrenciler AS O
			 on B.ID = O.Bolum_tBolumlerID
			 left join tKullanicilar as K
			 on K.ID = O.Ogrenci_tKullanicilarID
	         where @BolumAd = B.Adi
			 group by B.Adi,O.OgrenciNo,K.Adi,K.Soyadi
		 
		End

		Else
		Begin
		     print 'B�yle Bir b�l�m bulunmamakt�r.'
		End
End

execute  proc_tBolum @BolumAdi = 'Uygulamal� sosyoloji Tezsiz y�ksek lisans program�'

/*Bir dersi alan ��rencilerin:
- Ba�ar� durumlar�n� (Ge�ti/Kald�)
- S�n�f ortalamas�n�
- En y�ksek notu
- En d���k notu
- Dersi ge�en ��renci say�s�n�
- Dersten kalan ��renci say�s�n�
hesaplayan bir prosed�r yaz�n. Prosed�r ders ID'sini parametre olarak alacak.
Ge�me notu: Vize'nin %40'� + Final'in %60'� >= 60*/

CREATE PROCEDURE proc_ID (@DersID int)
AS
BEGIN 
    SELECT 
        AVG(D.Vize*0.4 + D.Final*0.6) as 'S�n�f Ortalamas�',
        MAX(D.Vize*0.4 + D.Final*0.6) as 'En Y�ksek Not',
        MIN(D.Vize*0.4 + D.Final*0.6) as 'En D���k Not',
        SUM(CASE WHEN (D.Vize*0.4 + D.Final*0.6) >= 60 THEN 1 ELSE 0 END) as 'Ge�en ��renci Say�s�',
        SUM(CASE WHEN (D.Vize*0.4 + D.Final*0.6) < 60 THEN 1 ELSE 0 END) as 'Kalan ��renci Say�s�'
    FROM tDersler as Ds
    LEFT JOIN tDersiAlanOgrenciler AS D ON Ds.ID = D.Ders_tDerslerID
    LEFT JOIN tOgrenciler as O ON O.ID = D.Ogrenci_tOgrencilerID
    WHERE Ds.ID = @DersID

    -- ��renci bazl� ba�ar� durumlar� i�in ayr� bir SELECT
    SELECT 
        K.Adi + ' ' + K.Soyadi as '��renci',
        D.Vize as 'Vize',
        D.Final as 'Final',
        (D.Vize*0.4 + D.Final*0.6) as 'Ge�me Notu',
        CASE 
            WHEN (D.Vize*0.4 + D.Final*0.6) >= 60 THEN 'GE�T�'
            ELSE 'KALDI'
        END as 'Ba�ar� Durumu'
    FROM tDersler as Ds
    LEFT JOIN tDersiAlanOgrenciler AS D ON Ds.ID = D.Ders_tDerslerID
    LEFT JOIN tOgrenciler as O ON O.ID = D.Ogrenci_tOgrencilerID
    LEFT JOIN tKullanicilar as K ON K.ID = O.Ogrenci_tKullanicilarID
    WHERE Ds.ID = @DersID
END


/*Bir ��rencinin TC kimlik numaras� ve do�um tarihini parametre olarak alan bir procedure yaz�n.
E�er bu bilgilerle e�le�en bir ��renci varsa, ��rencinin b�l�m bilgilerini, ��renci numaras�n� ve
not ortalamas�n� getirsin. E�er b�yle bir ��renci yoksa 'Bilgilerinizi kontrol ediniz' mesaj� */


alter procedure proc_TcDg(@TcKimlik varchar(11),@DogumTarihi date)
As
 Begin 
       Declare @Dg date , @Tc varchar(11)
	   select @Dg = k.DogumTarihi, @Tc = K.TcKimlikNo from tKullanicilar as K
	   where  k.DogumTarihi= @DogumTarihi And  K.TcKimlikNo= @TcKimlik

	   if (@Dg is not null) And (@Tc is not null)
	   Begin
	       Select B.Adi, O.OgrenciNo, (D.Vize*0.4+D.Final*0.6) FROM tDersiAlanOgrenciler as D
		   left join tOgrenciler AS O
		   on O.ID = D.Ogrenci_tOgrencilerID
		   LEFT join tBolumler AS B
		   on B.ID = O.Bolum_tBolumlerID
		   left join tKullanicilar AS K
		   on K.ID = O.Ogrenci_tKullanicilarID
		   where @Dg= K.DogumTarihi And @Tc= K.TCKimlikNo
		End

		Else
		Begin 
		    print 'Bilgilerinizi kontrol ediniz'
		End
End
select * from tKullanicilar

exec proc_TcDg @TcKimlik = '76668319137' ,@DogumTarihi = '1991-05-28'