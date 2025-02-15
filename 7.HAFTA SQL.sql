
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
Min(Vize) as 'En Kücük Vize Notu',
Max(Vize) as 'En Büyük Vize Notu',
Count(Vize) as 'Satýr sayýsý ',
stdev(Vize) as 'Vizenin Standart Sapmasý',
Sum(Vize) as 'Vize Toplam'
from tYazOkuluUcretleri as you

select 
you.Ders_tDerslerID , avg(Vize) as 'Vize Ortalamalarý' 
from tYazOkuluUcretleri as you
Group by you.Ders_tDerslerID;
/* Group byýn içine yazdýðým her þeyi select sorgusunda getirmeliyim çünkü bir þeyleri kümeliyorum kümelediðim þeye göre hesaplamalar vs yapabilirim
avg sum stdev max min  bunlarda aklýnda bulunsun mutlaka group by*/

select 
you.Ders_tDerslerID , avg(Vize) as 'Vize Ortalamalarý' ,Hoca_tKullanicilarID
from tYazOkuluUcretleri as you
Group by you.Ders_tDerslerID,Hoca_tKullanicilarID;
/*Önce derslere göre gruplayacak daha sonra hocaya göre gruplayacak */

/*Vizesi 40 ýn ve Finali 60 ýn altýnda olan derslerin her bir hocaya göre vize ortalamalarýnýn yüzde 10 fazlasýný listeleyin. */
select * from tYazOkuluUcretleri;

select 
you.Hoca_tKullanicilarID,Avg(Vize) +Avg(Vize) * 0.1 as 'Vizenin yüzde 10 fazlasý'
from tYazOkuluUcretleri AS you
Where you.Vize < 40 and you.Final < 60
group by you.Hoca_tKullanicilarID;

/* listeyi belirledikten sonra istenenden dolayý kuýllanýlan group bydan sonra sadece group by ile þart koþmak having ile mümkün týpki where gibidir.*/


/*Vizesi 40 ýn ve Finali 60 ýn altýnda olan derslerin her bir hocaya göre vize ortalamalarýnýn yüzde 10 fazlasýný listeleyin.Ve viz ortalamalarý 30 dan küçük olanlarý getirin */
/* göre kelimesine dikkat et gruplamada bu fonksiyonlara dikkat et gruplandýrma küme gelsin aklýna .*/

select 
you.Hoca_tKullanicilarID,Avg(Vize) +Avg(Vize) * 0.1 as 'Vizenin yüzde 10 fazlasý'
from tYazOkuluUcretleri AS you
Where you.Vize < 40 and you.Final < 60
group by you.Hoca_tKullanicilarID
Having avg(Vize) < 30;

/* 2000 yýlý öncesinde doðan kiþilerden Cinsiyetlerine göre yaþý en küçük ve en büyük kiþinin dogum tarihlerini deðerini */

select * from tKullanicilar;

set dateformat dmy
select
k.Cinsiyet, Min(k.DogumTarihi) AS 'Yasý En Kucuk', 
Max(k.DogumTarihi) As 'Yasý En Buyuk'
from tKullanicilar as k
where k.DogumTarihi < '01.01.2000'
group by k.Cinsiyet


select concat('Merhaba ',ID,',',DogumTarihi) from tKullanicilar;
/* sütunlarý birleþtirir ve metne dönüþtürür string deðil int da birleþtirir.*/
/*ya da sabit metinleri de metno dönüþtürür.*/

select Trim(Adi),
ltrim('    Sakarya  '),
rtrim('    Sakarya  ')
from tKullanicilar; 
/*Boþluklar silmede kullanýlýr ltrim soldan ltrim saðdan silme iþlemi yaptýrýr.
trim ise hem sað hem soldan gelen boþluklarý siler.*/

select Trim(Adi),
ltrim('    Sakarya  '),
rtrim('    Sakarya  '),
upper('sakarya üniversitesi'),lower('Sakarya üniversitesi')
from tKullanicilar; 

/* upper hepsi büyük tüm karakterler.*/
/* lower hepsi küçük tüm karakterler.*/

select charindex('a','Sakarya üniversitesi')
/*Ýstenilen ilk karaketere rastladýðýnda onun indeksini dönüþtürür.*/

select charindex('b','bursa')
select charindex(' ', '')
/* ilk 1 den baþlar indeks saymaya belirtilen karakter yok ise o zaman sýfýr döndürür.*/

/*Kullanýcýlardan eposta adresini doðru yazmayan kiþileri listeleyin*/
/*için @ olmayanlar,içinde .com geçmeyeneler içinde - olanlar*/

select
*
from tKullanicilar as k
where charindex('@','k.Eposta') = 0
and charindex('.com','k.Eposta') = 0
and charindex('-','k.Eposta') != 0

select SUBSTRING(Adi,1,1) from tKullanicilar;
/*o dan baþlamaz 1. karakterden baþlayarak 1 tane karakter alýn. 0 dan deðil */

select Adi ,substring(Adi,1,1) as 'Ýslem1' , SUBSTRING(Adi,2,3) as 'Islem2' from tKullanicilar ;


Select Adi,left(Adi,3) as 'Soldan uc Karaketer',right(Adi,3) as 'Sagdan 3 Karakter'
from tKullanicilar;

/*Saðdan baþlayarak ilk üç karakter right da soldan baþlayarak ilk üç karakter left de saðdan baþlarken sondan ilk karakter 1. indeksin oluyor */

select Adi,Soyadi, len(Adi) as 'Karakter Uzunlugu',reverse(Adi) as 'Tersten Yazdýrma',replace(Adi,'a','b') AS 'Degisim1',replace(Soyadi,'ceng','abc') as 'Degisim2' from tKullanicilar
/*Soyadýnda olamayanlarý ayný býrakýr.*/

SELECT value
FROM STRING_SPLIT('a-b-c', '-');

SELECT value
FROM STRING_SPLIT('Sakarya Üniversitesi', ' ');

/* virgülden sonraki boþluða dikkat et .*/

Select abs(-1),sqrt(4),SQUARE(5);

/*ABS mutlaðýna alýr. Sqrt kareköküne alýr ,Square de karesine alýr.*/

Select abs(-10),sqrt(16),SQUARE(36);

select rand();
/*sadece 0 ve 1 arasýnda deðer üretir.*/
/* 0 dahil 1 dahil deðil buna tekrar bak ve emin ol*/
select rand(10);

select rand(11),rand();

select cast(rand()*19 as int); /* 0 ile 19 arasýnda rastgele  tam sayý üretir.*/

select concat(y.ID,' Güzel sayý ',y.Vize)  from tYazOkuluUcretleri as y
/*Boþluðu stringin içinden ver aklýnda bulunsun kendi yazdýðým çalýþma sorum*/

select rand() /* 0 ile 1 arasýnda.*/
select cast(rand()*19 as int) /* 0 ile 19 arasýnda deðer üretir.*/
select cast(rand()*19+3 as int) /*3 ile 22 arasýnda deðer üretir.*/
select cast(rand()*16+3 as int) /*3 ile 19 arasýnda deðer üretir.*/

Select power(3,3),ceiling(5.3),ceiling(5.5),ceiling(5.9),ceiling(-5.9),-- üst tam
floor(5.3),floor(5.5),floor(5.9),floor(-5.9), --alt tam
round(5.343545566,2)
--0-5 asaðý 6-9 yukarý virgülden sonraki ilk 2 basamaðý alýr.

set language turkish
select DogumTarihi,
day(DogumTarihi) as 'Gün',month(DogumTarihi) as 'Ay',year(DogumTarihi) as 'Yýl',
datepart(minute,getdate()) as 'Suan Dakika',datepart(hour,getdate()) as 'Suan Saat',
datepart(DAYOFYEAR,getdate()) as 'Yýlýn Kacýncý Günü',datepart(Weekday,getdate()) as 'Haftanýn Gün Ýndeksi',
datepart(w,getdate()) as 'Haftanýn gün indeksi 'from tKullanicilar;
/*Yýlýn kacýncý günü*/
/*datepart tarihleri parçalamak için kullanýlýr saat dakika saniye bazýnda */
/* tarihlerde ay,yýl,gün bazýnda datepart kullanýlmaz*/

select 
k.DogumTarihi,
datepart(minute,getdate()) AS 'Tarih dakika ',
datepart(hour,getdate()) As 'tarih saat',
day(k.DogumTarihi) as 'Tarih Gün',
datepart(w,getdate()),
datediff(Year,DogumTarihi,getdate()),
datepart(dayofyear,k.DogumTarihi)
from tKullanicilar as k
/*kendi çalýsmam*/
/* datediff iki tarih arasýndaki farký alma*/
/*ilki fark türü ikincisi baslangýc tarihi,digeri ise sona kalan*/

/*Kisileri kan gruplarina göre en yüksek sayýda olandan en düþük sayýda olana göre listeleyin.*/

select * from tKullanicilar;

select 
KanGrubu_tKanGruplariID, Count(KanGrubu_tKanGruplariID) as 'Kisilerin Sayýsý'
from tKullanicilar
group by KanGrubu_tKanGruplariID
order by count(KanGrubu_tKanGruplariID) desc

/*19 yas üstü kullanýcýlarýn yaslarýna(tam yýl) göre gruplayarak 100 den fazla sayýda olan yaslarý büyükten kücüðe doðru sýralayýn */

select
datediff(Year,DogumTarihi,getdate()) as 'Tam_Yas' ,count(ID) as 'Sayisi'
from tKullanicilar
where datediff(Year,DogumTarihi,getdate()) > 19  
group by datediff(Year,DogumTarihi,getdate()) 
having count(ID) > 100
order by count(ID) desc

/*Kullanýcýlar için bir kullanýcý adý oluþturulmak isteniyor.
Bu kullanýcý adý kiþilerin adlarýnýn ilk 3 karakterinin büyük harfle yazýmý ,
sonrasýnda nokta iþareti ve soyadýnýn son 2 karakteri birleþtirilerek oluþturulacak.
Kullanýcýlar tablosunda KullaniciAdi adlý bir sütun olduðunu varsayarak bu kullanýcý adlarýný güncelleyerek oluþturun.*/

update tKullanicilar
set
KullaniciAdi = concat ((Upper(left(Adi,3)) + ' . ' +  right(Soyadi,2)) )


/*Kullanýcýlarýn adýndan rastgele bir harf seçip gösterin */

select 
Adi,len(Adi),
rand()*(Len(Adi)-1)+1,
cast(rand()*(Len(Adi)-1)+1 as int),
substring(Adi,cast(rand()*(Len(Adi)-1)+1 as int),1)
from tKullanicilar

/*10.11.2024 þeklinde gösterilecek 2000 ile 2025 yýllarý arasýnda rastgele tarih üretim*/

select
'2000-01-01','2025-12-31',
datediff(day,'2000-01-01','2025-12-31'),
rand()*datediff(day,'2000-01-01','2025-12-31'),
case(rand()*datediff(day,'2000-01-01','2025-12-31')-1)+1 as 
dateadd(day,datediff(day,'2000-01-01','2025-12-31')




