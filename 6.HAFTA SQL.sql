select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar as k
where k.Adi != 'Yasemin''in'
/* as yerine bo�luk b�rsksakta sadece olur*/
/* E�it de�ilse �nlemi kullan*/
/* iki tane kesme i�areti koydu�umuzda bir tane kesme i�areti anlam�na geliyor. */
select 
k.Adi,k.Soyadi,k.DogumTarihi,k.KanGrubu_tKanGruplariID
from tKullanicilar k
where k.KanGrubu_tKanGruplariID = '4'
/* tam say� ise tek t�rnak kullanabiliriz.*/

select 
k.Adi,k.Soyadi,k.DogumTarihi,k.KanGrubu_tKanGruplariID
from tKullanicilar  k
where k.KanGrubu_tKanGruplariID ='4.4'
/* �al��mayacak ��nk� float i�ine tek t�rnakla yazamay�z. */

select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where k.DogumTarihi= '1984.07.01'
/* tersten yaz�l�r tarihler hata al�r�z normal formda*/

set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where k.DogumTarihi= '18/07/1984'
/* bu formatta istedi�imiz �ekilde yazabilriz tarihi*/

set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where k.DogumTarihi <= '18/07/1984'



set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where k.DogumTarihi <= '18/07/1984'
and k.Adi = 'Engin'

set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where k.DogumTarihi <= '18/07/1984'
or k.Adi = 'Engin'


set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where k.DogumTarihi <= '18/07/1984'
or Adi = 'Engin' or k.Adi = '�zlem' or k.Adi = '�mer'

set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where
--kAdi in ('Engin','�zlem','�mer')
k.KanGrubu_tKanGruplariID in(3,5,1);


set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where
--kAdi in ('Engin','�zlem','�mer')
k.KanGrubu_tKanGruplariID not in(3,5,1)
/* bu kay�tlardan biri olmayan anlam�na gelir*/ 

set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where
--kAdi in ('Engin','�zlem','�mer')
--k.KanGrubu_tKanGruplariID not in(3,5,1)
--k.KanGrubu_tKanGruplariID between 3 and 6 
k.KanGrubu_tKanGruplariID not between 3 and 6
/* aral�k verebilirsin her �ey i�in ifade tarih ya da integer float olduk�a metin hari� tabi ki*/

set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi,k.KanGrubu_tKanGruplariID
from tKullanicilar k
where len(k.Adi) = 5
/*Ad�n�n karakter say�s� 5 olanlar� getiriyor.*/

set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi,k.KanGrubu_tKanGruplariID
from tKullanicilar k
where
k.Adi like 'm%t'


set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi,k.KanGrubu_tKanGruplariID
from tKullanicilar k
where
k.Adi like 'm%t'
order by k.Adi,k.Soyadi


set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi,k.KanGrubu_tKanGruplariID
from tKullanicilar k
where
k.Adi like 'm%t'
order by k.Adi asc


set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi,k.KanGrubu_tKanGruplariID
from tKullanicilar k
where
k.Adi like 'm%t'
order by k.Adi desc , k.Soyadi asc ,k.DogumTarihi desc 

/* ad� a ile ba�layan ki�ilerin adlar�n� ve yanlar�na adlar�n�n uzunluklar�n� g�sterin .Liste adlar�n� en uzun karakter say�s�ndan en az karakter say�s�na g�re s�ral� g�sterin */

select 
k.Adi , len(k.Adi) as 'Adlar�n_Uzunluklar�'
from tKullanicilar as k
Where 
k.Adi like 'a%' 
order by len(k.Adi) desc;

/* 1980 y�l� ve sonras� do�mu� ad�nda c gecen  fakat soyad�nda c ge�meyen ki�ilerden 
kan grubu 5 den b�y�k ki�ilerin ad�na g�re tersten adlar� ayn� olanlar�n ise soyad�n� a dan z ye s�ralay�n*/

set dateformat dmy
select 
K.Adi from tKullanicilar k
where
k.DogumTarihi>= '01.01.1980' and k.Adi like '%c%' k.Soyadi not like '%c%'
and k.KanGrubu_tKanGruplariID>5
order by k.Adi desc, k.Soyadi asc;

/* adi Ali,Mehmet,Ahmet ya da Hakan olan ki�ilerin soyad� a ya da b ile biten ki�ilerden Kan grubu 2 ile 5 aras�nda olanlar� listeleyin*/
select
k.Adi,k.Soyadi from tKullanicilar k
where k.Adi in ('Ali','Mehmet','Ahmet','Hakan') 
and (k.Soyadi like '%a' or k.Soyadi like '%b')
and (k.KanGrubu_tKanGruplariID between 2 and 5)
/* her �art kendi i�inde ayr� olsun diye belirttik*/

select distinct
k.Adi,k.Soyadi
from tKullanicilar k
where k.Adi like 'a%'

/*sat�rlar� azaltmaya yarar tekil getirir*/

select distinct
k.Adi,k.Soyadi
from tKullanicilar k
where k.Adi like '%et'

select 
k.Adi+''+k.Soyadi+k.KanGrubu_tKanGruplariID
from tKullanicilar k
/* bu halde hata al�caz metin ve integer*/

select 
cast (k.Adi+' '+k.Soyadi+k.KanGrubu_tKanGruplariID as varchar(10))
from tKullanicilar k
/* sadece o de�erde bu veri de�i�ikli�ini yapar.*/

select k.Adi+' '+k.Soyadi+
cast(k.KanGrubu_tKanGruplariID as varchar(10)),
cast('5.5' as float)+3+cast('3.5' as float) as toplam
from tKullanicilar k


set language turkish
select distinct
 k.Adi+' '+k.Soyadi+
cast(k.KanGrubu_tKanGruplariID as varchar(10)),
cast('5.5' as float)+3+cast('3.5' as float) as toplam,
convert(float,'5.5')+3+convert(float,'3.5') as toplam,
convert(date,'04.11.2024',104) as tarih,/*104 gelir s�navda*/
convert(date,'Nisan 14 2020', 107) as tarih
from tKullanicilar k 

/*tarih veri t�r�n� daha �ok metine �evirme kar��m�za ��kar.*/


set language turkish
select distinct
 k.Adi+' '+k.Soyadi+
cast(k.KanGrubu_tKanGruplariID as varchar(10)),
cast('5.5' as float)+3+cast('3.5' as float) as toplam,
convert(float,'5.5')+3+convert(float,'3.5') as toplam,
convert(date,'04.11.2024',104) as tarih,/*104 gelir s�navda*/
convert(date,'Nisan 14 2020', 107) as tarih,
convert(varchar,k.DogumTarihi,104) as dogumtarihi2,
convert(varchar, getdate(),114) as zaman
from tKullanicilar k 

/*format y�ntemi kullan�l�r daha �ok anla��l�r.*/

set language turkish
select distinct
 k.Adi+' '+k.Soyadi+
cast(k.KanGrubu_tKanGruplariID as varchar(10)),
cast('5.5' as float)+3+cast('3.5' as float) as toplam,
convert(float,'5.5')+3+convert(float,'3.5') as toplam,
convert(date,'04.11.2024',104) as tarih,/*104 gelir s�navda*/
convert(date,'Nisan 14 2020', 107) as tarih,
convert(varchar,k.DogumTarihi,104) as dogumtarihi2,
convert(varchar, getdate(),114) as zaman,
format(getdate(),'dd-MM-yyyy HH:mm') as dogumtarihi3,
format(getdate(),'dddd MMMM yy') as dogumtarihi4
from tKullanicilar k
/* format veri t�r� tarih veri t�r�nden metine �evirir 104 falan bunlar metinden tarihe �evirir.*/


/* yaz okulunda al�nan �cretlerin her birini a�a��daki �ekilde listelenmesini sa�lay�n
4 Kas�m 2024 tarihinde 145.67 Tl �cret al�nd�.*/
set language turkish
select
format(you.IslemTarihi,'dd,MMMM,yyyy') + ' tarihinde ' +
cast(you.Ucret as varchar) + 'TL �cret al�nd�.'
from tYazOkuluUcretleri you

select format(105.3467, 'N')
/* say�lar� metinlere d�n��t�r�yoruz.*/


/* Yaz okulundaki ge�me notu 60 t�r. Ge�me notu vizenin %40 ve % 60 toplam�ndan hesaplan�r.
Buna g�re 2022 y�l�ndan sonra yaz okuluna gelen ve kalan ��renci say�s� ka�t�r?*/


select * from tYazOkuluUcretleri;

set language turkish
select you.Vize*0.4 + you.Final*0.6 as Puani
from tYazOkuluUcretleri as you
where  you.Vize*0.4 + you.Final*0.6<60
and you.IslemTarihi>'2022-01-01';

/* yaz okulunda 132 ve 268 numaral� dersleri alan ��rencilerden finali 40 alt� olan ki�ilere a�a��daki mesaj� g�ndermek istiyoruz
Gerekli kodu yaz�n.
Merhaba, Kas�m 2024'te alm�� oldu�unuz dersten final 40 puan alt�nda olmas� nedeniyle kald�n�z.*/
select * from tYazOkuluUcretleri
set language turkish
select
'Merhaba,'+ format(IslemTarihi,'MMMM,yyyy') + ''' te alm�� oldu�unuz dersten final ' + cast(Final as varchar) +' puan alt�nda olmas� nedeniyle kald�n�z.'
from [OGRENCILER].[dbo].[tYazOkuluUcretleri]
where Ders_tDerslerID in (132,268)   and Final < 40;



/* iki isimli ki�ilerden soyad� a,b,c harflaerinden birini i�ermeyen ka� farkl� ad soyad oldu�unu listeleyin.*/

select distinct k.Adi + '' +k.Soyadi
from tKullanicilar as k
where k.Adi like '% %' and (k.Soyadi not like '%a%' or k.Soyadi not like '%b%' or k.Soyadi not like '%c%')
/*like i�in sat�r�n i�indeki in ise sat�rlaardaki de�erlere bakar�z. in i�ine girmez*/


