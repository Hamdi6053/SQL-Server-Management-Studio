/*Kullanici adlarý , soyadlarý ve Vize ile Final ortalamsýnýn 50 nin altýnda olanlarýnýn
altýnda , üstünde olanlanrýnýn üstünde olarak yazýldýðý sütun ile listeleyin.*/
/*Bilgisayar Mühendisliði bölümündeki Matematik dersinin 
geçme notu en yðksek 10 kiþiyi listeleyin*/


/*Birden fazla isimli ve birden fazal soyisimli kiþileri listeleyin.*/

select K.Adi,K.Soyadi from tKullanicilar as k
where (K.Adi like '% %' ) AND (K.Soyadi like '% %')

/*Parametre olarak kan gruplarýnýn adlarýný aralarýnda virgül olacak þekilþde alýp 
o kan gruplarýndan herhangi birine eþit olan kayýtlar varsa cep telefonu numaralarýný ekrana listeleyen 
procedure yazýn.*/

/*Kiþilerin adlarýnýn baþ harflerine göre*/

select SUBSTRING(K.Adi,1,1) as 'Baþ Harfi',Avg(LEN(k.Adi)) as 'Ortalama Uzunluk' from tKullanicilar as K
group by  SUBSTRING(K.Adi,1,1)
order by SUBSTRING(K.Adi,1,1)
