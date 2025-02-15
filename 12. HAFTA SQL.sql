/*12. HAFTA KONULAR BÝTTÝ SORGULAR.*/

insert into tTest(Adi) values ('bla bla')
print('Yeni kayýt oluþtu.ID deðeri:')
print(scope_identity)
/*Nereye son kayýt girmiþse onun ID sini döndürür.*/


/*Parametre olarak il adýný alan bir procedure oluþturun.Bu procedure 
hem ili hem de ona baðlý tüm ilçelerde doðan kiþilerin doðum yeri deðerini de 0
olarak güncelleyin.*/
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

/*Parametre olarak Kullanicilarýn Adlarýný istediðin ad ile deðiþtirin*/

create procedure IsýmD (@Isým1 varchar,@Isým2 varchar)
as
update tKullanicilar set Adi='x' where Adi=@Isým1
update tKullanicilar set Adi=@Isým1 where Adi=@Isým2
update tKullanicilar set Adi=@Isým2 where Adi= 'x'



--IIF(koþul, doðru_deðer, yanlýþ_deðer)

/*Kullanici adlarý , soyadlarý aldýðý ders adlari ve Vize ile Final ortalamsýnýn 50 nin altýnda olanlarýnýn
altýnda , üstünde olanlanrýnýn üstünde olarak yazýldýðý sütun ile listeleyin.*/
set language turkish
select (K.Adi + ' ' + K.Soyadi) as 'Öðrencinin Adi ve Soyadi',
Ds.Adi AS 'Ders Adi',
Avg(D.Vize+D.Final) as 'Öðrencinin Ortalama',
iif(Avg(D.Vize+D.Final) > 50,'Üstünde', 'Altýnda') as 'Baþarý Durumu'
from tKullanicilar as K
left join tOgrenciler AS O
on O.Ogrenci_tKullanicilarID = k.ID
left join tDersiAlanOgrenciler AS D
on D.Ogrenci_tOgrencilerID = O.ID
left join tDersler AS Ds
on D.Ders_tDerslerID = dS.ID
where D.Vize is not null and D.Final is not null
group by Ds.Adi,K.Adi,K.Soyadi

/*Bilgisayar Mühendisliði bölümündeki Matematik dersinin 
geçme notu  en yüksek 10 kiþiyi listeleyin*/
Select TOP 10 (D.Vize*0.4+D.Final*0.6) as 'Geçme Notu' , K.Adi,K.Soyadi from tKullanicilar AS K
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
where B.Adi like '%Bilgisayar Mühendisliði Lisans Programý%' AND (Ds.Adi like  '%Matematik%')
order by (D.Vize*0.4+D.Final*0.6) desc

/*Birden fazla isimli ve birden fazla soyisimli kiþileri listeleyin.*/

select K.Adi,K.Soyadi from tKullanicilar as k
where (K.Adi like '% %' ) AND (K.Soyadi like '% %')

/*Parametre olarak kan gruplarýnýn adlarýný aralarýnda virgül olacak þekilde alýp 
o kan gruplarýndan herhangi birine eþit olan kayýtlar varsa cep telefonu numaralarýný ekrana listeleyen 
procedure yazýn.*/
create procedure proc_KanAdlari(@KanAd varchar(10))
AS
Select K.Adi, K.Soyadi,K.Ceptel
from tKullanicilar AS K
left join tKanGruplari AS Kg on k.KanGrubu_tKanGruplariID = kg.ID
where kg.Adi in (
Select value from string_split(@KanAd,','))


/*Kiþilerin adlarýnýn baþ harflerine göre*/
select SUBSTRING(K.Adi,1,1) as 'Baþ Harfi',Avg(LEN(k.Adi)) as 'Ortalama Uzunluk' from tKullanicilar as K
group by  SUBSTRING(K.Adi,1,1)
order by SUBSTRING(K.Adi,1,1)



/*Soru:

Bir prosedür yazýn, parametre olarak bir bölüm adý aldýðýnda, o bölüme ait tüm öðrencilerin öðrenci numaralarýný ve isimlerini listeleyen bir iþlem gerçekleþtirsin.
Gereksinimler:
Prosedür, bölüm adý (string) alacak.
Bölüm adý doðruysa, o bölüme ait tüm öðrencilerin Öðrenci No, Adý, ve Soyadý bilgilerini döndürecek.
Eðer girilen bölüm adý geçerli deðilse, "Böyle bir bölüm bulunmamaktadýr" mesajýný döndürecek.*/
select * from tBolumler

alter procedure proc_tBolum(@BolumAdi varchar(250))
As
Begin 
		Declare @BolumAd varchar(250)
		Select @BolumAd = B.Adi FROM tBolumler AS B
		WHERE B.Adi = @BolumAdi 
		
		if @BolumAd is not null
		Begin 
		     Select  B.Adi as 'Bölüm Adi',O.OgrenciNo as 'Öðrenci Numarasý',K.Adi as 'Öðrencinin Adi',K.Soyadi as 'Öðrencinin Soyadi' from tBolumler as B
			 left join tOgrenciler AS O
			 on B.ID = O.Bolum_tBolumlerID
			 left join tKullanicilar as K
			 on K.ID = O.Ogrenci_tKullanicilarID
	         where @BolumAd = B.Adi
			 group by B.Adi,O.OgrenciNo,K.Adi,K.Soyadi
		 
		End

		Else
		Begin
		     print 'Böyle Bir bölüm bulunmamaktýr.'
		End
End

execute  proc_tBolum @BolumAdi = 'Uygulamalý sosyoloji Tezsiz yüksek lisans programý'

/*Bir dersi alan öðrencilerin:
- Baþarý durumlarýný (Geçti/Kaldý)
- Sýnýf ortalamasýný
- En yüksek notu
- En düþük notu
- Dersi geçen öðrenci sayýsýný
- Dersten kalan öðrenci sayýsýný
hesaplayan bir prosedür yazýn. Prosedür ders ID'sini parametre olarak alacak.
Geçme notu: Vize'nin %40'ý + Final'in %60'ý >= 60*/

CREATE PROCEDURE proc_ID (@DersID int)
AS
BEGIN 
    SELECT 
        AVG(D.Vize*0.4 + D.Final*0.6) as 'Sýnýf Ortalamasý',
        MAX(D.Vize*0.4 + D.Final*0.6) as 'En Yüksek Not',
        MIN(D.Vize*0.4 + D.Final*0.6) as 'En Düþük Not',
        SUM(CASE WHEN (D.Vize*0.4 + D.Final*0.6) >= 60 THEN 1 ELSE 0 END) as 'Geçen Öðrenci Sayýsý',
        SUM(CASE WHEN (D.Vize*0.4 + D.Final*0.6) < 60 THEN 1 ELSE 0 END) as 'Kalan Öðrenci Sayýsý'
    FROM tDersler as Ds
    LEFT JOIN tDersiAlanOgrenciler AS D ON Ds.ID = D.Ders_tDerslerID
    LEFT JOIN tOgrenciler as O ON O.ID = D.Ogrenci_tOgrencilerID
    WHERE Ds.ID = @DersID

    -- Öðrenci bazlý baþarý durumlarý için ayrý bir SELECT
    SELECT 
        K.Adi + ' ' + K.Soyadi as 'Öðrenci',
        D.Vize as 'Vize',
        D.Final as 'Final',
        (D.Vize*0.4 + D.Final*0.6) as 'Geçme Notu',
        CASE 
            WHEN (D.Vize*0.4 + D.Final*0.6) >= 60 THEN 'GEÇTÝ'
            ELSE 'KALDI'
        END as 'Baþarý Durumu'
    FROM tDersler as Ds
    LEFT JOIN tDersiAlanOgrenciler AS D ON Ds.ID = D.Ders_tDerslerID
    LEFT JOIN tOgrenciler as O ON O.ID = D.Ogrenci_tOgrencilerID
    LEFT JOIN tKullanicilar as K ON K.ID = O.Ogrenci_tKullanicilarID
    WHERE Ds.ID = @DersID
END


/*Bir öðrencinin TC kimlik numarasý ve doðum tarihini parametre olarak alan bir procedure yazýn.
Eðer bu bilgilerle eþleþen bir öðrenci varsa, öðrencinin bölüm bilgilerini, öðrenci numarasýný ve
not ortalamasýný getirsin. Eðer böyle bir öðrenci yoksa 'Bilgilerinizi kontrol ediniz' mesajý */


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