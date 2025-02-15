
select * from tYazOkuluUcretleri
select
Vize*0.4+Final*0.6
from tYazOkuluUcretleri YOU
where Vize*0.4+Final*0.6 > 60

update tYazOkuluUcretleri
SET
Vize = Vize+Vize*0.1
insert into tYazOkuluUcretleri (Vize) values (30*0.1)


select 
SUM(Vize) as 'Vize Toplam' from tYazOkuluUcretleri as You
Where you.Ders_tDerslerID = 301

select 
AVG(Vize) as 'Ortalama Vize', 
Min(Vize) as 'En K�c�k Vize Notu',
Max(Vize) as 'En B�y�k Vize Notu',
Count(Vize) as 'Sat�r say�s� ',
stdev(Vize) as 'Vizenin Standart Sapmas�',
Sum(Vize) as 'Vize Toplam'
from tYazOkuluUcretleri as you

select 
you.Ders_tDerslerID , avg(Vize) as 'Vize Ortalamalar�' 
from tYazOkuluUcretleri as you
Group by you.Ders_tDerslerID;
/* Group by�n i�ine yazd���m her �eyi select sorgusunda getirmeliyim ��nk� bir �eyleri k�meliyorum k�meledi�im �eye g�re hesaplamalar vs yapabilirim
avg sum stdev max min  bunlarda akl�nda bulunsun mutlaka group by*/

select 
you.Ders_tDerslerID , avg(Vize) as 'Vize Ortalamalar�' ,Hoca_tKullanicilarID
from tYazOkuluUcretleri as you
Group by you.Ders_tDerslerID,Hoca_tKullanicilarID;
/*�nce derslere g�re gruplayacak daha sonra hocaya g�re gruplayacak */

/*Vizesi 40 �n ve Finali 60 �n alt�nda olan derslerin her bir hocaya g�re vize ortalamalar�n�n y�zde 10 fazlas�n� listeleyin. */
select * from tYazOkuluUcretleri;

select 
you.Hoca_tKullanicilarID,Avg(Vize) +Avg(Vize) * 0.1 as 'Vizenin y�zde 10 fazlas�'
from tYazOkuluUcretleri AS you
Where you.Vize < 40 and you.Final < 60
group by you.Hoca_tKullanicilarID;

/* listeyi belirledikten sonra istenenden dolay� ku�llan�lan group bydan sonra sadece group by ile �art ko�mak having ile m�mk�n t�pki where gibidir.*/


/*Vizesi 40 �n ve Finali 60 �n alt�nda olan derslerin her bir hocaya g�re vize ortalamalar�n�n y�zde 10 fazlas�n� listeleyin.Ve viz ortalamalar� 30 dan k���k olanlar� getirin */
/* g�re kelimesine dikkat et gruplamada bu fonksiyonlara dikkat et grupland�rma k�me gelsin akl�na .*/

select 
you.Hoca_tKullanicilarID,Avg(Vize) +Avg(Vize) * 0.1 as 'Vizenin y�zde 10 fazlas�'
from tYazOkuluUcretleri AS you
Where you.Vize < 40 and you.Final < 60
group by you.Hoca_tKullanicilarID
Having avg(Vize) < 30;

/* 2000 y�l� �ncesinde do�an ki�ilerden Cinsiyetlerine g�re ya�� en k���k ve en b�y�k ki�inin dogum tarihlerini de�erini */

select * from tKullanicilar;

set dateformat dmy
select
k.Cinsiyet, Min(k.DogumTarihi) AS 'Yas� En Kucuk', 
Max(k.DogumTarihi) As 'Yas� En Buyuk'
from tKullanicilar as k
where k.DogumTarihi < '01.01.2000'
group by k.Cinsiyet


select concat('Merhaba ',ID,',',DogumTarihi) from tKullanicilar;
/* s�tunlar� birle�tirir ve metne d�n��t�r�r string de�il int da birle�tirir.*/
/*ya da sabit metinleri de metno d�n��t�r�r.*/

select Trim(Adi),
ltrim('    Sakarya  '),
rtrim('    Sakarya  ')
from tKullanicilar; 
/*Bo�luklar silmede kullan�l�r ltrim soldan ltrim sa�dan silme i�lemi yapt�r�r.
trim ise hem sa� hem soldan gelen bo�luklar� siler.*/

select Trim(Adi),
ltrim('    Sakarya  '),
rtrim('    Sakarya  '),
upper('sakarya �niversitesi'),lower('Sakarya �niversitesi')
from tKullanicilar; 

/* upper hepsi b�y�k t�m karakterler.*/
/* lower hepsi k���k t�m karakterler.*/

select charindex('a','Sakarya �niversitesi')
/*�stenilen ilk karaketere rastlad���nda onun indeksini d�n��t�r�r.*/

select charindex('b','bursa')
select charindex(' ', '')
/* ilk 1 den ba�lar indeks saymaya belirtilen karakter yok ise o zaman s�f�r d�nd�r�r.*/

/*Kullan�c�lardan eposta adresini do�ru yazmayan ki�ileri listeleyin*/
/*i�in @ olmayanlar,i�inde .com ge�meyeneler i�inde - olanlar*/

select
*
from tKullanicilar as k
where charindex('@','k.Eposta') = 0
and charindex('.com','k.Eposta') = 0
and charindex('-','k.Eposta') != 0

select SUBSTRING(Adi,1,1) from tKullanicilar;
/*o dan ba�lamaz 1. karakterden ba�layarak 1 tane karakter al�n. 0 dan de�il */

select Adi ,substring(Adi,1,1) as '�slem1' , SUBSTRING(Adi,2,3) as 'Islem2' from tKullanicilar ;


Select Adi,left(Adi,3) as 'Soldan uc Karaketer',right(Adi,3) as 'Sagdan 3 Karakter'
from tKullanicilar;

/*Sa�dan ba�layarak ilk �� karakter right da soldan ba�layarak ilk �� karakter left de sa�dan ba�larken sondan ilk karakter 1. indeksin oluyor */

select Adi,Soyadi, len(Adi) as 'Karakter Uzunlugu',reverse(Adi) as 'Tersten Yazd�rma',replace(Adi,'a','b') AS 'Degisim1',replace(Soyadi,'ceng','abc') as 'Degisim2' from tKullanicilar
/*Soyad�nda olamayanlar� ayn� b�rak�r.*/

SELECT value
FROM STRING_SPLIT('a-b-c', '-');

SELECT value
FROM STRING_SPLIT('Sakarya �niversitesi', ' ');

/* virg�lden sonraki bo�lu�a dikkat et .*/

Select abs(-1),sqrt(4),SQUARE(5);

/*ABS mutla��na al�r. Sqrt karek�k�ne al�r ,Square de karesine al�r.*/

Select abs(-10),sqrt(16),SQUARE(36);

select rand();
/*sadece 0 ve 1 aras�nda de�er �retir.*/
/* 0 dahil 1 dahil de�il buna tekrar bak ve emin ol*/
select rand(10);

select rand(11),rand();

select cast(rand()*19 as int); /* 0 ile 19 aras�nda rastgele  tam say� �retir.*/

select concat(y.ID,' G�zel say� ',y.Vize)  from tYazOkuluUcretleri as y
/*Bo�lu�u stringin i�inden ver akl�nda bulunsun kendi yazd���m �al��ma sorum*/

select rand() /* 0 ile 1 aras�nda.*/
select cast(rand()*19 as int) /* 0 ile 19 aras�nda de�er �retir.*/
select cast(rand()*19+3 as int) /*3 ile 22 aras�nda de�er �retir.*/
select cast(rand()*16+3 as int) /*3 ile 19 aras�nda de�er �retir.*/

Select power(3,3),ceiling(5.3),ceiling(5.5),ceiling(5.9),ceiling(-5.9),-- �st tam
floor(5.3),floor(5.5),floor(5.9),floor(-5.9), --alt tam
round(5.343545566,2)
--0-5 asa�� 6-9 yukar� virg�lden sonraki ilk 2 basama�� al�r.

set language turkish
select DogumTarihi,
day(DogumTarihi) as 'G�n',month(DogumTarihi) as 'Ay',year(DogumTarihi) as 'Y�l',
datepart(minute,getdate()) as 'Suan Dakika',datepart(hour,getdate()) as 'Suan Saat',
datepart(DAYOFYEAR,getdate()) as 'Y�l�n Kac�nc� G�n�',datepart(Weekday,getdate()) as 'Haftan�n G�n �ndeksi',
datepart(w,getdate()) as 'Haftan�n g�n indeksi 'from tKullanicilar;
/*Y�l�n kac�nc� g�n�*/
/*datepart tarihleri par�alamak i�in kullan�l�r saat dakika saniye baz�nda */
/* tarihlerde ay,y�l,g�n baz�nda datepart kullan�lmaz*/

select 
k.DogumTarihi,
datepart(minute,getdate()) AS 'Tarih dakika ',
datepart(hour,getdate()) As 'tarih saat',
day(k.DogumTarihi) as 'Tarih G�n',
datepart(w,getdate()),
datediff(Year,DogumTarihi,getdate()),
datepart(dayofyear,k.DogumTarihi)
from tKullanicilar as k
/*kendi �al�smam*/
/* datediff iki tarih aras�ndaki fark� alma*/
/*ilki fark t�r� ikincisi baslang�c tarihi,digeri ise sona kalan*/

/*Kisileri kan gruplarina g�re en y�ksek say�da olandan en d���k say�da olana g�re listeleyin.*/

select * from tKullanicilar;

select 
KanGrubu_tKanGruplariID, Count(KanGrubu_tKanGruplariID) as 'Kisilerin Say�s�'
from tKullanicilar
group by KanGrubu_tKanGruplariID
order by count(KanGrubu_tKanGruplariID) desc

/*19 yas �st� kullan�c�lar�n yaslar�na(tam y�l) g�re gruplayarak 100 den fazla say�da olan yaslar� b�y�kten k�c��e do�ru s�ralay�n */

select
datediff(Year,DogumTarihi,getdate()) as 'Tam_Yas' ,count(ID) as 'Sayisi'
from tKullanicilar
where datediff(Year,DogumTarihi,getdate()) > 19  
group by datediff(Year,DogumTarihi,getdate()) 
having count(ID) > 100
order by count(ID) desc

/*Kullan�c�lar i�in bir kullan�c� ad� olu�turulmak isteniyor.
Bu kullan�c� ad� ki�ilerin adlar�n�n ilk 3 karakterinin b�y�k harfle yaz�m� ,
sonras�nda nokta i�areti ve soyad�n�n son 2 karakteri birle�tirilerek olu�turulacak.
Kullan�c�lar tablosunda KullaniciAdi adl� bir s�tun oldu�unu varsayarak bu kullan�c� adlar�n� g�ncelleyerek olu�turun.*/

update tKullanicilar
set
KullaniciAdi = concat ((Upper(left(Adi,3)) + ' . ' +  right(Soyadi,2)) )


/*Kullan�c�lar�n ad�ndan rastgele bir harf se�ip g�sterin */

select 
Adi,len(Adi),
rand()*(Len(Adi)-1)+1,
cast(rand()*(Len(Adi)-1)+1 as int),
substring(Adi,cast(rand()*(Len(Adi)-1)+1 as int),1)
from tKullanicilar

/*10.11.2024 �eklinde g�sterilecek 2000 ile 2025 y�llar� aras�nda rastgele tarih �retim*/

select
'2000-01-01','2025-12-31',
datediff(day,'2000-01-01','2025-12-31'),
rand()*datediff(day,'2000-01-01','2025-12-31'),
case(rand()*datediff(day,'2000-01-01','2025-12-31')-1)+1 as 
dateadd(day,datediff(day,'2000-01-01','2025-12-31')




