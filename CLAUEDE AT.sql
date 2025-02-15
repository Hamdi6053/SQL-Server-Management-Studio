/*Kendisine parametre olarak verilen iki doðum tarihi arasýnda doðan kiþi sayýsýný ekrana yazdýran bir procedure
,tanýmlayýn ve kullanýmý gösterin.Eðer 0 kiþi varsa o zaman ekrana 'Bu tarihler arasýnda doðan kimse yok' yazsýn çýkabilir sýnavda*/
select * from tKullanicilar
alter procedure proc_Tarih(@BaslangýcTarihi date , @BitisTarihi date)
as
Begin 
     Declare @KisiSayisi int
	 select @KisiSayisi =count(K.ID)  from tKullanicilar as k
	 Where K.DogumTarihi between @BaslangýcTarihi AND @BitisTarihi
	 
	 if @KisiSayisi>0
	 Begin
	      select count(k.ID) as 'KisiSayisi' from tKullanicilar k
		  Where K.DogumTarihi between @BaslangýcTarihi AND @BitisTarihi
	 End

	 Else if @KisiSayisi = 0
	 Begin
	      print 'Bu tarihler arasýnda doðan kimse yok'
	 End
End


exec proc_Tarih @BaslangýcTarihi = '1980-07-11' ,@BitisTarihi = '2021-05-12'

/*Parametre olarak il adýný alan bir procedure oluþturun.Bu procedure 
hem ili hem de ona baðlý tüm ilçelerde doðan kiþilerin doðum yeri deðerini de 0
olarak güncelleyin.*/
create procedure proc_ÝlilCe(@ÝLADÝ varchar)
as
begin
	declare @ILID int
	select @ILID = I.ID from tIller AS I
	Where I.Adi = @ÝLADÝ
	update tKullanicilar set DogumYeri_tIlcelerID = 0
where DogumYeri_tIlcelerID in
(Select ID from tIlceler where Il_tIllerID =@ILID)

delete from tIlceler WHERE Il_tIllerID = @ILID
delete from tIller WHERE ID = @ILID


/*Kullanici adlarý , soyadlarý aldýðý ders adlari ve Vize ile Final ortalamsýnýn 50 nin altýnda olanlarýnýn
altýnda , üstünde olanlanrýnýn üstünde olarak yazýldýðý sütun ile listeleyin.*/

select K.Adi as 'Öðrenci Adi',
K.Soyadi as 'Öðrenci Soyadi',
D.Adi as 'Ders Adi',
iif(AVG(Ds.Vize+Ds.Final)>50,'Üstünde','Altýnda') as 'Ortalama'
from tKullanicilar AS K
left join tOgrenciler AS O
on k.ID = o.Ogrenci_tKullanicilarID
left join tDersiAlanOgrenciler AS Ds
on ds.Ogrenci_tOgrencilerID = o.ID
left join tDersler AS D
on D.ID = DS.Ders_tDerslerID
where D.Adi is not null and Ds.Vize is not null and Ds.Final is not null
group by D.Adi,K.Adi,K.Soyadi

/*Bilgisayar Mühendisliði bölümündeki Matematik dersinin 
geçme notu  en yüksek 10 kiþiyi listeleyin*/
select * from tBolumler
select TOP 10 K.Adi as 'Ogrenci Adi',K.Soyadi as 'Ogrenci Soyadi',O.OgrenciNo as 'Ogrenci Numarasý ',DS.Vize as 'Vize Notu ',
DS.Final as 'Final Notu ',(DS.Vize*0.4+DS.Final*0.6) as 'Geçme Notu' from tKullanicilar as k
left join tOgrenciler as O
on k.ID = o.Ogrenci_tKullanicilarID
left join tBolumler AS B 
ON B.ID = O.Bolum_tBolumlerID
LEFT join tDersiAlanOgrenciler AS Ds
On ds.Ogrenci_tOgrencilerID = o.ID
left join tDersler AS d
ON D.ID = DS.Ders_tDerslerID
LEFT join tFakulteler AS F
on F.ID = B.Fakulte_tFakultelerID
where b.Adi =  'Bilgisayar Mühendisliði Lisans Programý' AND  D.Adi like '%Matematik%'
order by (DS.Vize*0.4+DS.Final*0.6)

/*Birden fazla isimli ve birden fazla soyisimli kiþileri listeleyin.*/
select k.Adi,K.Soyadi from tKullanicilar AS K
where K.Adi like '% %'AND K.Soyadi like '% %'
/*Parametre olarak kan gruplarýnýn adlarýný aralarýnda virgül olacak þekilde alýp 
o kan gruplarýndan herhangi birine eþit olan kayýtlar varsa cep telefonu numaralarýný ekrana listeleyen 
procedure yazýn.*/

create procedure proc_Kan_Adi (@Kan_Adi varchar(10) )
as
Select K.Adi, K.Soyadi,K.Ceptel
from tKullanicilar AS K
left join tKanGruplari AS Kg on k.KanGrubu_tKanGruplariID = kg.ID
where kg.Adi in (
Select value from string_split(@KanAd,','))









/*Bir öðrencinin TC kimlik numarasý ve doðum tarihini parametre olarak alan bir procedure yazýn.
Eðer bu bilgilerle eþleþen bir öðrenci varsa, öðrencinin bölüm bilgilerini, öðrenci numarasýný ve
not ortalamasýný getirsin. Eðer böyle bir öðrenci yoksa 'Bilgilerinizi kontrol ediniz' mesajý */
alter procedure proc_TcDgKimlik (@Tc varchar,@Dg date)
as
Begin
     Declare @TcKimlikNo varchar(11), @DogumTarihi date
	 select @TcKimlikNo = K.TCKimlikNo , @DogumTarihi = K.DogumTarihi from tKullanicilar AS K
	 where @Tc = k.TCKimlikNo and @Dg = k.TCKimlikNo

	 if @TcKimlikNo is not null and @DogumTarihi is not null
	 Begin
		Select O.OgrenciNo,B.Adi,D.Adi,(Ds.Vize*0.4+Ds.Final*0.6) from tOgrenciler as O
		left join tKullanicilar AS K
		ON K.ID = O.Ogrenci_tKullanicilarID
		left join tBolumler AS B
	    on O.Bolum_tBolumlerID = B.ID
		left join tDersiAlanOgrenciler AS Ds
		on Ds.Ogrenci_tOgrencilerID = o.ID
		left join tDersler as D
		on D.ID= Ds.Ders_tDerslerID
		where @Dg= K.DogumTarihi And @Tc= K.TCKimlikNo
		group by O.OgrenciNo,B.Adi,D.Adi,Ds.Vize,Ds.Final
	 End

	 Else
	 Begin
	      Select('Bilgilerinizi kontrol ediniz')
	 End
End
set language turkish
select * from tKullanicilar
exec proc_TcDgKimlik  @Tc = '76668319137' ,@Dg = '1991-05-28'

/*Kiþilerin adlarýnýn baþ harflerine göre ortalama baþ harflerine göre */

select SUBSTRING(K.ADÝ,1,1) AS 'Bas Harfi',AVG(LEN(K.Adi)) 'Ortalama karakter uzunluðu' from tKullanicilar AS K
group by SUBSTRING(K.ADÝ,1,1)
ORDER BY SUBSTRING(K.ADÝ,1,1)
