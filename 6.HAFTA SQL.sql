select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar as k
where k.Adi != 'Yasemin''in'
/* as yerine boþluk býrsksakta sadece olur*/
/* Eþit deðilse ünlemi kullan*/
/* iki tane kesme iþareti koyduðumuzda bir tane kesme iþareti anlamýna geliyor. */
select 
k.Adi,k.Soyadi,k.DogumTarihi,k.KanGrubu_tKanGruplariID
from tKullanicilar k
where k.KanGrubu_tKanGruplariID = '4'
/* tam sayý ise tek týrnak kullanabiliriz.*/

select 
k.Adi,k.Soyadi,k.DogumTarihi,k.KanGrubu_tKanGruplariID
from tKullanicilar  k
where k.KanGrubu_tKanGruplariID ='4.4'
/* çalýþmayacak çünkü float içine tek týrnakla yazamayýz. */

select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where k.DogumTarihi= '1984.07.01'
/* tersten yazýlýr tarihler hata alýrýz normal formda*/

set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where k.DogumTarihi= '18/07/1984'
/* bu formatta istediðimiz þekilde yazabilriz tarihi*/

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
or Adi = 'Engin' or k.Adi = 'Özlem' or k.Adi = 'Ömer'

set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where
--kAdi in ('Engin','Özlem','Ömer')
k.KanGrubu_tKanGruplariID in(3,5,1);


set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where
--kAdi in ('Engin','Özlem','Ömer')
k.KanGrubu_tKanGruplariID not in(3,5,1)
/* bu kayýtlardan biri olmayan anlamýna gelir*/ 

set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi
from tKullanicilar k
where
--kAdi in ('Engin','Özlem','Ömer')
--k.KanGrubu_tKanGruplariID not in(3,5,1)
--k.KanGrubu_tKanGruplariID between 3 and 6 
k.KanGrubu_tKanGruplariID not between 3 and 6
/* aralýk verebilirsin her þey için ifade tarih ya da integer float oldukça metin hariç tabi ki*/

set dateformat dmy
select 
k.Adi,k.Soyadi,k.DogumTarihi,k.KanGrubu_tKanGruplariID
from tKullanicilar k
where len(k.Adi) = 5
/*Adýnýn karakter sayýsý 5 olanlarý getiriyor.*/

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

/* adý a ile baþlayan kiþilerin adlarýný ve yanlarýna adlarýnýn uzunluklarýný gösterin .Liste adlarýný en uzun karakter sayýsýndan en az karakter sayýsýna göre sýralý gösterin */

select 
k.Adi , len(k.Adi) as 'Adlarýn_Uzunluklarý'
from tKullanicilar as k
Where 
k.Adi like 'a%' 
order by len(k.Adi) desc;

/* 1980 yýlý ve sonrasý doðmuþ adýnda c gecen  fakat soyadýnda c geçmeyen kiþilerden 
kan grubu 5 den büyük kiþilerin adýna göre tersten adlarý ayný olanlarýn ise soyadýný a dan z ye sýralayýn*/

set dateformat dmy
select 
K.Adi from tKullanicilar k
where
k.DogumTarihi>= '01.01.1980' and k.Adi like '%c%' k.Soyadi not like '%c%'
and k.KanGrubu_tKanGruplariID>5
order by k.Adi desc, k.Soyadi asc;

/* adi Ali,Mehmet,Ahmet ya da Hakan olan kiþilerin soyadý a ya da b ile biten kiþilerden Kan grubu 2 ile 5 arasýnda olanlarý listeleyin*/
select
k.Adi,k.Soyadi from tKullanicilar k
where k.Adi in ('Ali','Mehmet','Ahmet','Hakan') 
and (k.Soyadi like '%a' or k.Soyadi like '%b')
and (k.KanGrubu_tKanGruplariID between 2 and 5)
/* her þart kendi içinde ayrý olsun diye belirttik*/

select distinct
k.Adi,k.Soyadi
from tKullanicilar k
where k.Adi like 'a%'

/*satýrlarý azaltmaya yarar tekil getirir*/

select distinct
k.Adi,k.Soyadi
from tKullanicilar k
where k.Adi like '%et'

select 
k.Adi+''+k.Soyadi+k.KanGrubu_tKanGruplariID
from tKullanicilar k
/* bu halde hata alýcaz metin ve integer*/

select 
cast (k.Adi+' '+k.Soyadi+k.KanGrubu_tKanGruplariID as varchar(10))
from tKullanicilar k
/* sadece o deðerde bu veri deðiþikliðini yapar.*/

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
convert(date,'04.11.2024',104) as tarih,/*104 gelir sýnavda*/
convert(date,'Nisan 14 2020', 107) as tarih
from tKullanicilar k 

/*tarih veri türünü daha çok metine çevirme karþýmýza çýkar.*/


set language turkish
select distinct
 k.Adi+' '+k.Soyadi+
cast(k.KanGrubu_tKanGruplariID as varchar(10)),
cast('5.5' as float)+3+cast('3.5' as float) as toplam,
convert(float,'5.5')+3+convert(float,'3.5') as toplam,
convert(date,'04.11.2024',104) as tarih,/*104 gelir sýnavda*/
convert(date,'Nisan 14 2020', 107) as tarih,
convert(varchar,k.DogumTarihi,104) as dogumtarihi2,
convert(varchar, getdate(),114) as zaman
from tKullanicilar k 

/*format yöntemi kullanýlýr daha çok anlaþýlýr.*/

set language turkish
select distinct
 k.Adi+' '+k.Soyadi+
cast(k.KanGrubu_tKanGruplariID as varchar(10)),
cast('5.5' as float)+3+cast('3.5' as float) as toplam,
convert(float,'5.5')+3+convert(float,'3.5') as toplam,
convert(date,'04.11.2024',104) as tarih,/*104 gelir sýnavda*/
convert(date,'Nisan 14 2020', 107) as tarih,
convert(varchar,k.DogumTarihi,104) as dogumtarihi2,
convert(varchar, getdate(),114) as zaman,
format(getdate(),'dd-MM-yyyy HH:mm') as dogumtarihi3,
format(getdate(),'dddd MMMM yy') as dogumtarihi4
from tKullanicilar k
/* format veri türü tarih veri türünden metine çevirir 104 falan bunlar metinden tarihe çevirir.*/


/* yaz okulunda alýnan ücretlerin her birini aþaðýdaki þekilde listelenmesini saðlayýn
4 Kasým 2024 tarihinde 145.67 Tl ücret alýndý.*/
set language turkish
select
format(you.IslemTarihi,'dd,MMMM,yyyy') + ' tarihinde ' +
cast(you.Ucret as varchar) + 'TL ücret alýndý.'
from tYazOkuluUcretleri you

select format(105.3467, 'N')
/* sayýlarý metinlere dönüþtürüyoruz.*/


/* Yaz okulundaki geçme notu 60 týr. Geçme notu vizenin %40 ve % 60 toplamýndan hesaplanýr.
Buna göre 2022 yýlýndan sonra yaz okuluna gelen ve kalan öðrenci sayýsý kaçtýr?*/


select * from tYazOkuluUcretleri;

set language turkish
select you.Vize*0.4 + you.Final*0.6 as Puani
from tYazOkuluUcretleri as you
where  you.Vize*0.4 + you.Final*0.6<60
and you.IslemTarihi>'2022-01-01';

/* yaz okulunda 132 ve 268 numaralý dersleri alan öðrencilerden finali 40 altý olan kiþilere aþaðýdaki mesajý göndermek istiyoruz
Gerekli kodu yazýn.
Merhaba, Kasým 2024'te almýþ olduðunuz dersten final 40 puan altýnda olmasý nedeniyle kaldýnýz.*/
select * from tYazOkuluUcretleri
set language turkish
select
'Merhaba,'+ format(IslemTarihi,'MMMM,yyyy') + ''' te almýþ olduðunuz dersten final ' + cast(Final as varchar) +' puan altýnda olmasý nedeniyle kaldýnýz.'
from [OGRENCILER].[dbo].[tYazOkuluUcretleri]
where Ders_tDerslerID in (132,268)   and Final < 40;



/* iki isimli kiþilerden soyadý a,b,c harflaerinden birini içermeyen kaç farklý ad soyad olduðunu listeleyin.*/

select distinct k.Adi + '' +k.Soyadi
from tKullanicilar as k
where k.Adi like '% %' and (k.Soyadi not like '%a%' or k.Soyadi not like '%b%' or k.Soyadi not like '%c%')
/*like için satýrýn içindeki in ise satýrlaardaki deðerlere bakarýz. in içine girmez*/


