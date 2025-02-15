/*Kendisine parametre olarak verilen iki do�um tarihi aras�nda do�an ki�i say�s�n� ekrana yazd�ran bir procedure
,tan�mlay�n ve kullan�m� g�sterin.E�er 0 ki�i varsa o zaman ekrana 'Bu tarihler aras�nda do�an kimse yok' yazs�n ��kabilir s�navda*/
select * from tKullanicilar
alter procedure proc_Tarih(@Baslang�cTarihi date , @BitisTarihi date)
as
Begin 
     Declare @KisiSayisi int
	 select @KisiSayisi =count(K.ID)  from tKullanicilar as k
	 Where K.DogumTarihi between @Baslang�cTarihi AND @BitisTarihi
	 
	 if @KisiSayisi>0
	 Begin
	      select count(k.ID) as 'KisiSayisi' from tKullanicilar k
		  Where K.DogumTarihi between @Baslang�cTarihi AND @BitisTarihi
	 End

	 Else if @KisiSayisi = 0
	 Begin
	      print 'Bu tarihler aras�nda do�an kimse yok'
	 End
End


exec proc_Tarih @Baslang�cTarihi = '1980-07-11' ,@BitisTarihi = '2021-05-12'

/*Parametre olarak il ad�n� alan bir procedure olu�turun.Bu procedure 
hem ili hem de ona ba�l� t�m il�elerde do�an ki�ilerin do�um yeri de�erini de 0
olarak g�ncelleyin.*/
create procedure proc_�lilCe(@�LAD� varchar)
as
begin
	declare @ILID int
	select @ILID = I.ID from tIller AS I
	Where I.Adi = @�LAD�
	update tKullanicilar set DogumYeri_tIlcelerID = 0
where DogumYeri_tIlcelerID in
(Select ID from tIlceler where Il_tIllerID =@ILID)

delete from tIlceler WHERE Il_tIllerID = @ILID
delete from tIller WHERE ID = @ILID


/*Kullanici adlar� , soyadlar� ald��� ders adlari ve Vize ile Final ortalams�n�n 50 nin alt�nda olanlar�n�n
alt�nda , �st�nde olanlanr�n�n �st�nde olarak yaz�ld��� s�tun ile listeleyin.*/

select K.Adi as '��renci Adi',
K.Soyadi as '��renci Soyadi',
D.Adi as 'Ders Adi',
iif(AVG(Ds.Vize+Ds.Final)>50,'�st�nde','Alt�nda') as 'Ortalama'
from tKullanicilar AS K
left join tOgrenciler AS O
on k.ID = o.Ogrenci_tKullanicilarID
left join tDersiAlanOgrenciler AS Ds
on ds.Ogrenci_tOgrencilerID = o.ID
left join tDersler AS D
on D.ID = DS.Ders_tDerslerID
where D.Adi is not null and Ds.Vize is not null and Ds.Final is not null
group by D.Adi,K.Adi,K.Soyadi

/*Bilgisayar M�hendisli�i b�l�m�ndeki Matematik dersinin 
ge�me notu  en y�ksek 10 ki�iyi listeleyin*/
select * from tBolumler
select TOP 10 K.Adi as 'Ogrenci Adi',K.Soyadi as 'Ogrenci Soyadi',O.OgrenciNo as 'Ogrenci Numaras� ',DS.Vize as 'Vize Notu ',
DS.Final as 'Final Notu ',(DS.Vize*0.4+DS.Final*0.6) as 'Ge�me Notu' from tKullanicilar as k
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
where b.Adi =  'Bilgisayar M�hendisli�i Lisans Program�' AND  D.Adi like '%Matematik%'
order by (DS.Vize*0.4+DS.Final*0.6)

/*Birden fazla isimli ve birden fazla soyisimli ki�ileri listeleyin.*/
select k.Adi,K.Soyadi from tKullanicilar AS K
where K.Adi like '% %'AND K.Soyadi like '% %'
/*Parametre olarak kan gruplar�n�n adlar�n� aralar�nda virg�l olacak �ekilde al�p 
o kan gruplar�ndan herhangi birine e�it olan kay�tlar varsa cep telefonu numaralar�n� ekrana listeleyen 
procedure yaz�n.*/

create procedure proc_Kan_Adi (@Kan_Adi varchar(10) )
as
Select K.Adi, K.Soyadi,K.Ceptel
from tKullanicilar AS K
left join tKanGruplari AS Kg on k.KanGrubu_tKanGruplariID = kg.ID
where kg.Adi in (
Select value from string_split(@KanAd,','))









/*Bir ��rencinin TC kimlik numaras� ve do�um tarihini parametre olarak alan bir procedure yaz�n.
E�er bu bilgilerle e�le�en bir ��renci varsa, ��rencinin b�l�m bilgilerini, ��renci numaras�n� ve
not ortalamas�n� getirsin. E�er b�yle bir ��renci yoksa 'Bilgilerinizi kontrol ediniz' mesaj� */
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

/*Ki�ilerin adlar�n�n ba� harflerine g�re ortalama ba� harflerine g�re */

select SUBSTRING(K.AD�,1,1) AS 'Bas Harfi',AVG(LEN(K.Adi)) 'Ortalama karakter uzunlu�u' from tKullanicilar AS K
group by SUBSTRING(K.AD�,1,1)
ORDER BY SUBSTRING(K.AD�,1,1)
